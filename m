From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: add img,pvrsgx.yaml for Imagination GPUs
Date: Sat, 21 Dec 2019 14:37:47 +0100
Message-ID: <FE3B09F2-D923-43E2-908B-C241E41F7031@goldelico.com>
References: <cover.1576605726.git.hns@goldelico.com> <aedc895985d966cf709d153d5b0bed07f59bdcfd.1576605726.git.hns@goldelico.com> <20191218211601.GA11411@bogus>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191218211601.GA11411@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 18.12.2019 um 22:16 schrieb Rob Herring <robh@kernel.org>:
>=20
> On Tue, Dec 17, 2019 at 07:01:59PM +0100, H. Nikolaus Schaller wrote:
>> The Imagination PVR/SGX GPU is part of several SoC from
>> multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
>> and others.
>>=20
>> With this binding, we describe how the SGX processor is
>> interfaced to the SoC (registers, interrupt etc.).
>>=20
>> In most cases, Clock, Reset and power management is handled
>> by a parent node or elsewhere.
>>=20
>> Tested by make dt_binding_check dtbs_check
>=20
> I'm surprised that worked... (Not for long if it did).

AFAIR, it did not fail but emit thousands of warnings for other areas
so I may have missed some warning but there was no error that did stop
compilation.

>=20
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/gpu/img,pvrsgx.yaml   | 80 =
+++++++++++++++++++
>> 1 file changed, 80 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
>>=20
>> diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml =
b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
>> new file mode 100644
>> index 000000000000..44799774e34d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpu/img,pvrsgx.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Imagination PVR/SGX GPU
>> +
>> +maintainers:
>> +  - H. Nikolaus Schaller <hns@goldelico.com>
>> +
>> +description: |+
>> +  This binding describes the Imagination SGX5 series of 3D =
accelerators which
>> +  are found in several different SoC like TI OMAP, Sitara, Ingenic =
JZ4780,
>> +  Allwinner A83, and Intel Poulsbo and CedarView and more.
>> +
>> +  For an almost complete list see: =
https://en.wikipedia.org/wiki/PowerVR#Implementations
>> + =20
>> +  Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently =
covered by
>> +  this binding but the extension of the pattern is straightforward.
>> + =20
>> +  The SGX node is usually a child node of some DT node belonging to =
the SoC
>> +  which handles clocks, reset and general address space mapping of =
the SGX
>> +  register area.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +    # Example: BeagleBoard A/B/C, OpenPandora 600MHz
>> +      - ti,omap3-sgx530-121, img,sgx530-121, img,sgx530
>=20
> Didn't I comment before this is not valid.

Not that I am aware of. Your comment was:

<<<
> +properties:
> +  compatible:
> +    enum:
> +    # BeagleBoard ABC, OpenPandora 600MHz

I'd expect compatibles to be per SoC, not per board.

> +      - ti,omap3-sgx530-121, img,sgx530-121, img,sgx530, img,sgx5

4 compatibles is probably a bit much. Are there not any version or=20
feature registers that some of this could be detected? If there are, I'd=20=

assume the middle 2 strings could be dropped. If not, drop the last one=20=

and just match on the 3rd string. It's not a long list.
>>>

So I interpreted your comment is about the # comment focussing too much
on boards instead of SoC and about dropping img,sgx5

> You are defining the=20
> compatible string is: 'ti,omap3-sgx530-121, img,sgx530-121, =
img,sgx530'

Yes.

>=20
> You need:
>=20
> compatible:
>  oneOf:
>    - description: BeagleBoard A/B/C, OpenPandora 600MHz
>      items:
>        - const: ti,omap3-sgx530-121
>        - const: img,sgx530-121
>        - const: img,sgx530
>=20
> And so on for each of the rest.

Hm. As far as I understand YAML, it has multiple ways to define the same
structure but this manifold nature has its drawbacks.

If it is wrong I have to admit that I still do not understand how to =
write
correct schemes... Why has it been made so difficult for us developers?=20=


>=20
>> +    # Example: BeagleBoard XM, GTA04, OpenPandora 1GHz
>> +      - ti,omap3-sgx530-125, img,sgx530-125, img,sgx530
>> +    # Example: BeagleBone Black
>> +      - ti,am3352-sgx530-125, img,sgx530-125, img,sgx530
>=20
> These 2 could be combined using 'enum' for the first item. Basically,=20=

> you can group ones where the last 2 strings are the same.

Is this better readable?

IMHO, this would be a nice coding trick that would make this
even more unreadable and does not add any new information.

Generally, in my opinion, a bindings document should not only
satisfy the dtbs_check but should be human readable (and writeable!)
so that a DTS developer can still understand and ideally copy&paste
fragments. With such enum tricks and -items const: constructions
this IMHO becomes more difficult.

Therefore I think the linear list is better readable and
can be directly copied. If the test rig has problems with
that statement, I would suggest that the parser should be
modified to understand what we can easily write and read.

The same is for # comment vs. description: . The # comment
is for a human reader of this document to get a hint what
board the next line is intended for. It is not necessary
(and IMHO impossible) to automatically test it. So I do not
see any need to add a formal -description entry here.

>=20
>> +    # Example: Pandaboard, Pandaboard ES
>> +      - ti,omap4-sgx540-120, img,sgx540-120, img,sgx540
>> +      - ti,omap4-sgx544-112, img,sgx544-112, img,sgx544
>> +    # Example: OMAP5 UEVM, Pyra Handheld
>> +      - ti,omap5-sgx544-116, img,sgx544-116, img,sgx544
>> +      - ti,dra7-sgx544-116, img,sgx544-116, img,sgx544
>> +    # Example: CI20
>> +      - ingenic,jz4780-sgx540-120, img,sgx540-120, img,sgx540
>> +    # the following entries are not validated with real hardware
>=20
> What am I supposed to do with that? You're just defining some strings.=20=

> If you're not sure they are okay, then don't define them.

I have a broader audience in mind than 'make dtbs_check'. IMHO, this
document should help future developers to get an idea what to write for
those SoC. Yes, it might not be 100% correct, but it is easier to =
correct
a 99% correct definition than inventing it from scratch after dropping
partially correct information I already have.

For example, we know from data sheets and public information that the
allwinner a83 contains a sgx544 but it is not sure if it is the -116
variant. Or, the poulsbo has a GPU called gma500 which is an sgx535. It
is only that nobody has verified this so far by real hardware.

If we leave it out and someone starts to adapt this to the poulsbo
in let's say 2 years from now, that someone has to be lucky to find
our discussion here and take that as a hint.

I am not sure how you are developing contributions, but my first
place to start with is the existing code and not the archives of
LKML.

That is my motivation adding these records right here even if they
are not verified.

>=20
>> +    # more TI SoC
>> +      - ti,am3517-sgx530-125, img,sgx530-125, img,sgx530
>> +      - ti,am4-sgx530-125, img,sgx530-125, img,sgx530
>> +      - ti,ti81xx-sgx530-125, img,sgx530-125, img,sgx530
>> +    # Example: Banana-Pi-M3 (Allwinner A83T)
>> +      - allwinner,sun8i-a83t-sgx544-116, img,sgx544-116, img,sgx544
>> +    # Example: Atom Z5xx
>> +      - intel,poulsbo-gma500-sgx535, img,sgx535-116, img,sgx535
>> +    # Example: Atom Z24xx
>> +      - intel,medfield-gma-sgx540, img,sgx540-116, img,sgx540
>> +    # Example: Atom N2600, D2500
>> +      - intel,cedarview-gma3600-sgx545, img,sgx545-116, img,sgx545
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |+
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    gpu@fe00 {
>> +      compatible =3D "ti,omap-omap5-sgx544-116", "img,sgx544-116", =
"img,sgx544", "img,sgx5";
>=20
> Doesn't match the schema.

Ah, thanks. I missed that when reviewing the DTS patch set.
Queued for a v5.

>=20
>> +      reg =3D <0xfe00 0x200>;
>> +      interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> +
>> +...
>> --=20
>> 2.23.0
>>=20

BR and thanks,
Nikolaus
