From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC 00/15] Device Tree schemas and validation
Date: Tue, 01 Oct 2013 17:06:35 +0200
Message-ID: <524AE4FB.4080906@baylibre.com>
References: <1380041541-17529-1-git-send-email-bcousson@baylibre.com> <524A8289.3050107@baylibre.com> <524ACB76.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524ACB76.1010001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On 01/10/2013 15:17, Rob Herring wrote:
> On 10/01/2013 03:06 AM, Benoit Cousson wrote:
>> + more DT maintainers folks
>>
>> Hi all,
>>
>> I know this is mostly boring user space code, but I was expecting a
>> little bit of comments about at least the bindings syntax:-(
>>
>> I'd like to know if this is the right direction and if it worth pursuing
>> in that direction.
>>
>> The idea was to have at least some base for further discussion during
>> ARM KS 2013.
>>
>> I feel alone :-(
>>
>> If you have any comment, go ahead!
>
> Thanks for taking this on!
>
> This is interesting approach using the dts syntax,

Well, this was discussed a little bit on the list, and it has the big 
advantage of re-using the parser already included in DTC for free.
In term or readability, it avoids to re-defining a brand new syntax for 
people who are already familiar with the DTS one.

> but I worry that the
> validation will only be as good as the schema written and the review of
> the schema.

Well, sure, but unfortunately, that will always be the case :-(
The bindings definition being quite open, there is no easy way to ensure 
proper schema / bindings without careful review of the schema. There is 
no such thing as a free beer... Unfortunately :-)

> I think the schema needs to define the binding rather than
> define the checks. Then the schema can feed the validation checks.

> This format does not seem to me as easily being able to generate
> documentation from the schema which I believe is one of the goals.

Indeed, but I think is it easy to generate any kind of readable format 
for the documentation purpose if needed from the actual format.
Otherwise, we should consider a schema format based on kerneldoc type of 
syntax to improve readability. I'm just afraid it will become harder 
then to define complex schema.

BTW, what kind of documentation are you expecting here? Is is a text 
that can be added on top of each schema?

> I for
> one don't care to review the documentation and the schema for every binding.
>
> I would like to ensure we can start with the basics and have some
> generic rules. Some examples:
>
> - flag compatible strings in dts files that are not documented

This is almost done with the last patch of the series. Nodes are already 
checked, properties are missing.

> - check required properties

Done as well.

> - check properties against cell sizes

Yeah, that one is still to be done.

> - a node with reg property must have a unit address

Easy to add.

> - flag properties with "_"

Easy to add as well.

> - check properties are the correct data type

Already done for a couple of data type.

Thanks for your comments. Being the very first one, you might get a free 
beer... meaning there might be such thing as a free beer :-)

Thanks,
Benoit


>> Thanks,
>> Benoit
>>
>> On 24/09/2013 18:52, Benoit Cousson wrote:
>>> Hi All,
>>>
>>> Following the discussion that happened during LCE-2013 and the email
>>> thread started by Tomasz few months ago [1], here is a first attempt
>>> to introduce:
>>> - a schema language to define the bindings accurately
>>> - DTS validation during device tree compilation in DTC itself
>>>
>>> [1] http://www.spinics.net/lists/arm-kernel/msg262224.html
>>>
>>>
>>> === What it does? ===
>>>
>>> For now device-tree bindings are defined in a not standardized
>>> text-based format and thus any one can write the documentation for a
>>> binding as he wish. In addition to this there is no automated way to
>>> check if a dts is conform to the available bindings.
>>>
>>> The goal of this series of patch is to fix this situation by adding a
>>> well defined way to write bindings in a human-readable format. These
>>> bindings will be written through files called "schemas".
>>>
>>>
>>> === What is a schema? ===
>>>
>>> A schema is a file describing the constraints that one or several nodes
>>> of a dts must conform to. Schemas must use the file extension ".schema".
>>> A schema can check that:
>>>      - A node has a given property
>>>      - An array has a valid size
>>>      - A node contains the required children.
>>>      - A property has the correct type.
>>>      - A property has the correct value.
>>>
>>> A schema can as well recursively check the constraints for parent nodes.
>>>
>>> The syntax for a schema is the same as the one for dts. This choice has
>>> been made to simplify its development, to maximize the code reuse and
>>> finally because the format is human-readable.
>>>
>>>
>>> === How to defined a schema? ===
>>>
>>> A binding directory has been added at the root of repository. Users can
>>> add schema files anywhere in it but a nice way would be to keep the same
>>> structure as the binding directory in the documentation.
>>>
>>> To demonstrate how to write a schema and its capability I will use the
>>> OMAP DTS schemas when applicable.
>>>
>>> How to:
>>>    * Associate a schema to one or several nodes
>>>
>>> As said earlier a schema can be used to validate one or several nodes
>>> from a dts. To do this the "compatible" properties from the nodes which
>>> should be validated must be present in the schema.
>>>
>>>      timer1: timer@4a318000 {
>>>          compatible = "ti,omap3430-timer";
>>>          reg = <0x4a318000 0x80>;
>>>          interrupts = <0x0 0x25 0x4>;
>>>          ti,hwmods = "timer1";
>>>          ti,timer-alwon;
>>>      };
>>>
>>> To write a schema which will validate OMAP Timers like the one above,
>>> one may write the following schema:
>>>
>>>      /dts-v1/;
>>>      / {
>>>          compatible = "ti,omap[0-9]+-timer";
>>>          ...
>>>      };
>>>
>>> The schema above will be used to validate every node in a dts which has
>>> a compatible matching the following regular expression:
>>> "ti,omap[0-9]+-timer".
>>>
>>> It is possible to specify multiple compatible inside a schema using this
>>> syntax:
>>>      compatible = "ti,omap[0-9]+-timer", "ti,am[0-9]+-timer";
>>>
>>> This time the schema will be application for both OMAP Timers and AM
>>> Timers.
>>>
>>>
>>>    * Define constraints on properties
>>>
>>> To define constraints on a property one has to create a node in a schema
>>> which has as name the name of the property that one want to validate.
>>>
>>> To specify constraints on the property "ti,hwmods" of OMAP Timers one
>>> can write this schema:
>>>
>>>      /dts-v1/;
>>>      / {
>>>          compatible = "ti,omap[0-9]+-timer";
>>>          ti,hwmods {
>>>              ...
>>>          };
>>>      };
>>>
>>> If one want to use a regular as property name one can write this schema:
>>>
>>>      /dts-v1/;
>>>      / {
>>>          compatible = "abc";
>>>          def {
>>>              name = "def[0-9]";
>>>              ...
>>>          };
>>>      };
>>>
>>> Above one can see that the "name" property override the node name.
>>>
>>>
>>>    * Require the presence of a property
>>>
>>> One can require the presence of a property by using the "is-required"
>>> constraint.
>>>
>>>      /dts-v1/;
>>>      / {
>>>          compatible = "ti,omap[0-9]+-timer";
>>>          ti,hwmods {
>>>              is-required;
>>>          };
>>>      };
>>>
>>> The "ti,hwmods" property above is set as required and its presence will
>>> be checked in every OMAP timer.
>>>
>>>
>>>    * Require the presence of a property inside a node or inside one of its
>>> parents
>>>
>>> Sometimes a property required is not directly present inside a node but
>>> is present in one of its parents. To check this, one can use
>>> "can-be-inherited" in addition to "is-required".
>>>
>>> twl {
>>>       interrupt-controller;
>>>
>>>       rtc {
>>>           compatible = "ti,twl4030-rtc";
>>>           interrupts = <0xc>;
>>>       };
>>> }
>>>
>>> In the case of the rtc above the interrupt-controller is not present,
>>> but it is present in its parent. If inheriting the property from the
>>> parent makes senses like here one can specify in the schema that
>>> interrupt-controller is required in the rtc node and that the property
>>> can be inherited from a parent.
>>>
>>> /dts-v1/;
>>> / {
>>>       compatible = "ti,twl[0-9]+-rtc";
>>>       interrupt-controller {
>>>           is-required;
>>>           can-be-inherited;
>>>       };
>>> };
>>>
>>>
>>>    * Require a node to contains a given list of children
>>>
>>> One may want to check if a node has some required children nodes.
>>>
>>> node {
>>>       compatible = "comp";
>>>
>>>       subnode1 {
>>>       };
>>>
>>>       subnode2 {
>>>       };
>>>
>>>       abc {
>>>       };
>>> };
>>>
>>> One can check if 'node' has the following subnode 'subnode1', 'subnode2',
>>> and 'abc' with the schema below:
>>>
>>> /dts-v1/;
>>> / {
>>>       compatible = "comp";
>>>       children = "abc", "subnode[0-9]";
>>> };
>>>
>>>
>>>    * Constraints on array size
>>>
>>> One can specify the following constraints on array size:
>>>    - length: specify the exact length that an array must have.
>>>    - min-length: specify the minimum number of elements an array must
>>> have.
>>>    - max-length: specify the maximum number of elements an array must
>>> have.
>>>
>>> Usage example:
>>> node {
>>>       compatible = "array_size";
>>>       myarray = <0 1 2 3 4>;
>>> };
>>>
>>> Schema:
>>> /dts-v1/;
>>> / {
>>>       compatible = "array_size";
>>>
>>>       myarray {
>>>           length = <5>;
>>>       };
>>> };
>>>
>>>
>>>    * Count limit on nodes
>>>
>>> One can specify a count limit for the nodes matching the schema:
>>>    - count: if there is a match between a dts and a schema then there must
>>>      be exactly X match between the dts and the schema at the end of the
>>>      validation process.
>>>    - max-count: if there is a match between a dts and a schema then there
>>>      must be at most X match between the dts and the schema at the end of
>>>      the validation process.
>>> This can be used to check if a specific node appears the right amount of
>>> time in the dts.
>>>
>>> / {
>>>       timer1 {
>>>           compatible = "ti,omap-4430-timer";
>>>           ...
>>>       };
>>>
>>>       timer2 {
>>>           compatible = "ti,omap-4430-timer";
>>>           ...
>>>       };
>>> };
>>>
>>> If in the above dts there must be exactly two timer one can check this
>>> constraints with the following schema:
>>>
>>> / {
>>>       compatible = "ti,omap-4430-timer";
>>>       count = <2>;
>>> };
>>>
>>>
>>>    * Check that a property has the right type
>>>
>>> One can check if a property has the correct type. Right now dtc only
>>> handles the two trivial types: integer array, string array. Since at the
>>> end everything is an array of byte which may or may not be terminated by
>>> a null byte this was enough.
>>>
>>> / {
>>>       compatible = "abc";
>>>
>>>       abc = <0xa 0xb 0xc>;
>>>       def = "def", gef;
>>> };
>>>
>>> To check that the property abc is an integer array and that the property
>>> def is a string array for the dts above one can use the following schema:
>>>
>>> / {
>>>       compatible = "abc";
>>>
>>>
>>>       abc {
>>>           type = "integer";
>>>       };
>>>
>>>       def {
>>>           type = "string";
>>>       };
>>> };
>>>
>>>
>>>    * Check the value of properties
>>>
>>> It is possible to check if a property has the expected value through the
>>> "value" constraint.
>>>
>>> abc {
>>>      prop1 = <0 1 2 3>;
>>>      prop2 = "value0", "value1", "value3";
>>> };
>>>
>>> To check whether an integer array contains value from a given range
>>> use the following constraint:
>>>       prop1 {
>>>           type = "integer";
>>>           value = <0x0 0xF>;
>>>       };
>>>
>>> To check whether a string array contains value that match a given
>>> pattern use the following constraint:
>>>       prop2 {
>>>           type = "string";
>>>           value = "value[0-9]";
>>>       };
>>>
>>> To check whether a particular element of an array has the correct value
>>> one can use the following constraint:
>>>       prop1 {
>>>           type = "integer";
>>>           value@2 = <2>;
>>>       };
>>>
>>> or
>>>
>>>       prop2 {
>>>           type = "string";
>>>           value@1 = "value1";
>>>       };
>>>
>>>
>>>    * Check constraints on a parent node
>>>
>>> It is possible to set constraints on parents of a node.
>>>
>>> node {
>>>       compatible = "abcomp";
>>>       abc = "abc";
>>>
>>>       subnode {
>>>           compatible = "comp";
>>>           abc = "def";
>>>       };
>>> };
>>>
>>> The schema below tests whether 'subnode' has a parent named 'node' and
>>> whether it has a compatible property equal to "abcomp" and a 'abc'
>>> property equal to "abc". In the case of the node above the constraints
>>> couldn't be check by inheriting the properties via 'can-be-inherited'
>>> since they are overwritten by the node 'subnode'.
>>>
>>> /dts-v1/;
>>> / {
>>>       compatible = "comp";
>>>
>>>       parents {
>>>           node {
>>>               compatible {
>>>                   type = "string";
>>>                   value = "abcomp";
>>>               };
>>>
>>>               abc {
>>>                   type = "string";
>>>                   value = "abc";
>>>               };
>>>           };
>>>       };
>>> };
>>>
>>> It is possible to set conditional constraints on parents of the
>>> following form:
>>>       if (node_compatible == "compat1")
>>>           check_this_parent_constraints();
>>>       else if (node_compatible == "compat2")
>>>           check_that_parent_constraints();
>>>
>>> To do this one should put the parent constraints at the same place as
>>> the compatible definition in a schema file.
>>>
>>> /dts-v1/;
>>> / {
>>>       compatible {
>>>           value@0 {
>>>               value = "compat1";
>>>               parents {
>>>                   node {
>>>                       myprop {
>>>                           type = "int";
>>>                           value@0 = <0xf>;
>>>                       };
>>>                   };
>>>               };
>>>           };
>>>
>>>           value@1 {
>>>               value = "compat2";
>>>               parents {
>>>                   node {
>>>                       myprop {
>>>                           type = "int";
>>>                           value@0 = <0xa>;
>>>                       };
>>>                   };
>>>               };
>>>           };
>>>       };
>>> };
>>>
>>> This schema will check that if the compatible of a node is "compat1"
>>> then it must have a parent node "node" which has an integer array
>>> property "myprop" which has as first element the value 0xf, otherwise
>>> if the node has the
>>> compatible "compat2" then the first element of the same property must
>>> have the value 0xa.
>>>
>>>
>>> === How is it working? ===
>>>
>>> When a user will try to compile a dts, dtc will parse the device-tree
>>> and will try to find schemas that will help to check the correctness of
>>> the dts. In order to accomplish that dtc maintain a small index of all
>>> the schemas available.
>>> Once dtc finds a schema which can be used to validate a particular node,
>>> it will loads it and starts performing all the check defined by it.
>>>
>>> A set of unit-tests has been added to test that each feature is working
>>> properly.
>>>
>>>
>>> === Usage ===
>>>
>>> Two extra options are added to handle validation into DTC:
>>>    -M <schema-path> : path of the directoy containing the schemas
>>>    -B <verbose-level> : Level of verbosity from the schema validation
>>>
>>>    dtc -M ./bindings -B 1 file.dts
>>>
>>>
>>> === What could be done next? ===
>>>
>>>    * Save the schema index to avoid to recompute it everytime.
>>>    * The constraints capabilities for parents and children of a node is
>>>      not equal right now. A nice thing would be to bring the same feature
>>>      available for constraints on a parent for children nodes.
>>>    * The type systems uses only the most trivial types. A nice thing would
>>>      be to bring higher level types.
>>>    * May be add conditional constraints based on property values.
>>>    * Need more? Feel free to add any item :-)
>>>
>>> Dependency: Please note that libpcre *must* be installed in order to
>>> add the regular expression support into the schema validation process.
>>> I'm not sure how such dependency should be handled, since the scripts
>>> directory does not contain any dependency like that for the moment.
>>>
>>> The series, based on 3.12-rc2, is available here:
>>> http://git.baylibre.com/pub/bcousson/linux-omap dts_schema
>>>
>>> Regards,
>>> Fabien & Benoit
>>>
>>> ---
>>>
>>> Fabien Parent (15):
>>>     scripts/dtc: fix most memory leaks in dtc
>>>     scripts/dtc: build schema index for dts validation
>>>     scripts/dtc: validate each nodes and properties
>>>     scripts/dtc: add procedure to handle dts errors
>>>     scripts/dtc: check type on properties
>>>     scripts/dtc: check for required properties
>>>     scripts/dtc: can inherit properties
>>>     scripts/dtc: check array size
>>>     scripts/dtc: check value of properties
>>>     scripts/dtc: add count limit on nodes
>>>     scripts/dtc: check for children nodes
>>>     scripts/dtc: check constraints on parents
>>>     bindings: OMAP: add new schema files
>>>     scripts/dtc: validate dts against schema bindings
>>>     scripts/dtc: add verbose options
>>>
>>>    bindings/arm/omap/counter.schema                   |   28 +
>>>    bindings/arm/omap/dsp.schema                       |   18 +
>>>    bindings/arm/omap/intc.schema                      |   48 +
>>>    bindings/arm/omap/iva.schema                       |   38 +
>>>    bindings/arm/omap/l3-noc.schema                    |   38 +
>>>    bindings/arm/omap/mpu.schema                       |   19 +
>>>    bindings/arm/omap/omap.schema                      |   62 +
>>>    bindings/arm/omap/timer.schema                     |  124 ++
>>>    scripts/Makefile.lib                               |    1 +
>>>    scripts/dtc/.gitignore                             |    2 +-
>>>    scripts/dtc/Makefile                               |    9 +-
>>>    scripts/dtc/data.c                                 |   27 +-
>>>    scripts/dtc/dtc-lexer.l                            |    2 +-
>>>    scripts/dtc/dtc-lexer.lex.c_shipped                |    2 +-
>>>    scripts/dtc/dtc-parser.tab.c_shipped               |  595 ++++-----
>>>    scripts/dtc/dtc-parser.y                           |    9 +
>>>    scripts/dtc/dtc.c                                  |   29 +-
>>>    scripts/dtc/dtc.h                                  |   30 +
>>>    scripts/dtc/livetree.c                             |  108 +-
>>>    scripts/dtc/schema-test.c                          |  146 +++
>>>    scripts/dtc/schema.c                               | 1304
>>> ++++++++++++++++++++
>>>    scripts/dtc/tests/schemas/array-size-1.schema      |   13 +
>>>    scripts/dtc/tests/schemas/array-size-2.schema      |    8 +
>>>    scripts/dtc/tests/schemas/array-size-3.schema      |    8 +
>>>    scripts/dtc/tests/schemas/array-size-4.schema      |    8 +
>>>    scripts/dtc/tests/schemas/children-nodes-1.schema  |    5 +
>>>    scripts/dtc/tests/schemas/children-nodes-2.schema  |    5 +
>>>    scripts/dtc/tests/schemas/inheritence-1.schema     |    7 +
>>>    scripts/dtc/tests/schemas/inheritence-2.schema     |    8 +
>>>    scripts/dtc/tests/schemas/integer-array-1.schema   |   16 +
>>>    scripts/dtc/tests/schemas/integer-array-2.schema   |    9 +
>>>    scripts/dtc/tests/schemas/integer-array-3.schema   |    8 +
>>>    scripts/dtc/tests/schemas/nodes-count-1.schema     |    5 +
>>>    scripts/dtc/tests/schemas/nodes-count-2.schema     |    5 +
>>>    scripts/dtc/tests/schemas/nodes-count-3.schema     |    5 +
>>>    scripts/dtc/tests/schemas/nodes-count-4.schema     |    5 +
>>>    scripts/dtc/tests/schemas/parent-nodes-1.schema    |   23 +
>>>    scripts/dtc/tests/schemas/parent-nodes-2.schema    |   12 +
>>>    scripts/dtc/tests/schemas/parent-nodes-3.schema    |   14 +
>>>    scripts/dtc/tests/schemas/parent-nodes-4.schema    |   27 +
>>>    scripts/dtc/tests/schemas/parent-nodes-5.schema    |   15 +
>>>    scripts/dtc/tests/schemas/parent-nodes-6.schema    |   13 +
>>>    scripts/dtc/tests/schemas/parent-nodes-7.schema    |   13 +
>>>    .../dtc/tests/schemas/pattern-matching-1.schema    |   10 +
>>>    .../dtc/tests/schemas/pattern-matching-2.schema    |   10 +
>>>    .../dtc/tests/schemas/required-property-1.schema   |    7 +
>>>    .../dtc/tests/schemas/required-property-2.schema   |    7 +
>>>    scripts/dtc/tests/schemas/string-array-1.schema    |   20 +
>>>    scripts/dtc/tests/schemas/string-array-2.schema    |    9 +
>>>    scripts/dtc/tests/schemas/types-1.schema           |   12 +
>>>    scripts/dtc/tests/schemas/types-2.schema           |    7 +
>>>    scripts/dtc/tests/test1.dts                        |   22 +
>>>    52 files changed, 2619 insertions(+), 356 deletions(-)
>>>    create mode 100644 bindings/arm/omap/counter.schema
>>>    create mode 100644 bindings/arm/omap/dsp.schema
>>>    create mode 100644 bindings/arm/omap/intc.schema
>>>    create mode 100644 bindings/arm/omap/iva.schema
>>>    create mode 100644 bindings/arm/omap/l3-noc.schema
>>>    create mode 100644 bindings/arm/omap/mpu.schema
>>>    create mode 100644 bindings/arm/omap/omap.schema
>>>    create mode 100644 bindings/arm/omap/timer.schema
>>>    create mode 100644 scripts/dtc/schema-test.c
>>>    create mode 100644 scripts/dtc/schema.c
>>>    create mode 100644 scripts/dtc/tests/schemas/array-size-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/array-size-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/array-size-3.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/array-size-4.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/children-nodes-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/children-nodes-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/inheritence-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/inheritence-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/integer-array-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/integer-array-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/integer-array-3.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/nodes-count-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/nodes-count-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/nodes-count-3.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/nodes-count-4.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-3.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-4.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-5.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-6.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/parent-nodes-7.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/pattern-matching-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/pattern-matching-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/required-property-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/required-property-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/string-array-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/string-array-2.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/types-1.schema
>>>    create mode 100644 scripts/dtc/tests/schemas/types-2.schema
>>>    create mode 100644 scripts/dtc/tests/test1.dts
>>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
