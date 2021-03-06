package fugue.regula

# Test that resource_view gives us the right shape.
test_resource_view {
  rv = resource_view with input as {
    "planned_values": {
      "root_module": {
        "resources": [
          {
            "address": "aws_ebs_volume.bad",
            "mode": "managed",
            "type": "aws_ebs_volume",
            "name": "bad",
            "provider_name": "aws",
            "schema_version": 0,
            "values": {
              "availability_zone": "us-west-2a",
              "size": 8,
              "tags": null
            }
          }
        ]
      }
    }
  }
  rv == {
    "aws_ebs_volume.bad": {
      "id": "aws_ebs_volume.bad",
      "_type": "aws_ebs_volume",
      "availability_zone": "us-west-2a",
      "size": 8,
      "tags": null
    }
  }
}

# Simple resource used for testing.
testutil_resource = {
  "id": "testutil_resource",
  "_type": "aws_elb_volume"
}

test_judgement_from_allow_denies_01 {
  j = judgement_from_allow_denies(testutil_resource, [true], [])
  j.valid
}

test_judgement_from_allow_denies_02 {
  j = judgement_from_allow_denies(testutil_resource, [false], [])
  not j.valid
}

test_judgement_from_allow_denies_03 {
  j = judgement_from_allow_denies(testutil_resource, [], [false])
  j.valid
}

test_judgement_from_allow_denies_04 {
  j = judgement_from_allow_denies(testutil_resource, [], [true])
  not j.valid
}

test_judgement_from_allow_denies_05 {
  j = judgement_from_allow_denies(testutil_resource, [true], [false])
  j.valid
}

test_judgement_from_allow_denies_06 {
  j = judgement_from_allow_denies(testutil_resource, [true], [true])
  not j.valid
}

test_judgement_from_allow_denies_07 {
  j = judgement_from_allow_denies(testutil_resource, [false], [false])
  not j.valid
}

test_judgement_from_allow_denies_08 {
  j = judgement_from_allow_denies(testutil_resource, [false], [true])
  not j.valid
}
