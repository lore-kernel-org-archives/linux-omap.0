From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/7] dt-bindings: gpu: pvrsgx: add initial bindings
Date: Mon, 21 Oct 2019 17:45:06 +0200
Message-ID: <CEA29A3B-4116-4FE3-8E18-0C97353688DC@goldelico.com>
References: <cover.1571424390.git.hns@goldelico.com> <f0fb68dc7bc027e5e911721852f6bc6fa2d77a63.1571424390.git.hns@goldelico.com> <CAL_Jsq+obsTSU3iP1wm_3-FsAJ4Mxiz0NbMY1_h5NeFn67Sj+A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+obsTSU3iP1wm_3-FsAJ4Mxiz0NbMY1_h5NeFn67Sj+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dri-devel <dri-devel@lists.freedesktop.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi Rob,

> Am 21.10.2019 um 17:07 schrieb Rob Herring <robh+dt@kernel.org>:
>=20
> On Fri, Oct 18, 2019 at 1:46 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> The Imagination PVR/SGX GPU is part of several SoC from
>> multiple vendors, e.g. TI OMAP, Ingenic JZ4780, Intel Poulsbo
>> and others.
>>=20
>> Here we describe how the SGX processor is interfaced to
>> the SoC (registers, interrupt etc.).
>>=20
>> Clock, Reset and power management should be handled
>> by the parent node.
>=20
> That's TI specific.

Ok. Would this be better:

Clock, Reset and power management is not handled by this binding
and can e.g. be described by the parent node.

>=20
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/gpu/img,pvrsgx.txt    | 76 =
+++++++++++++++++++
>> 1 file changed, 76 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
>=20
> Please make this DT schema format.

Is there a tutorial or a tool to convert?
I have only seen that a new format exists but zero experience.

>=20
>> diff --git a/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt =
b/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
>> new file mode 100644
>> index 000000000000..4ad87c075791
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpu/img,pvrsgx.txt
>> @@ -0,0 +1,76 @@
>> +Imagination PVR/SGX GPU
>> +
>> +Only the Imagination SGX530, SGX540 and SGX544 GPUs are currently =
covered by this binding.
>> +
>> +Required properties:
>> +- compatible:  Should be one of
>> +               "img,sgx530-121", "img,sgx530", =
"ti,omap-omap3-sgx530-121";
>> +                 - BeagleBoard ABC, OpenPandora 600MHz
>> +               "img,sgx530-125", "img,sgx530", =
"ti,omap-omap3-sgx530-125";
>> +                 - BeagleBoard XM, GTA04, OpenPandora 1GHz
>> +               "img,sgx530-125", "img,sgx530", =
"ti,omap-am3517-sgx530-125";
>> +               "img,sgx530-125", "img,sgx530", =
"ti,omap-am335x-sgx530-125";
>> +                 - BeagleBone Black
>> +               "img,sgx540-120", "img,sgx540", =
"ti,omap-omap4-sgx540-120";
>> +                 - Pandaboard (ES)
>> +               "img,sgx544-112", "img,sgx544", =
"ti,omap-omap4-sgx544-112";
>> +               "img,sgx544-116", "img,sgx544", =
"ti,omap-omap5-sgx544-116";
>> +                 - OMAP5 UEVM, Pyra Handheld
>> +               "img,sgx544-116", "img,sgx544", =
"ti,omap-dra7-sgx544-116";
>=20
> The order here is wrong. Should be most specific first.
>=20
> Drop 'omap-' from the compatible.

Ok, yes. Seems to be redundant since omap is from ti only...

>=20
>> +
>> +               For further study:
>> +                       "ti,omap-am3517-sgx530-?"
>> +                       "ti,omap-am43xx-sgx530-?"
>> +                       "ti,ti43xx-sgx"
>> +                       "ti,ti81xx-sgx"
>> +                       "img,jz4780-sgx5??-?"
>> +                       "intel,poulsbo-sgx?"
>> +                       "intel,cedarview-sgx?"
>> +                       "sunxi,sgx-544-?" - Banana-Pi-M3 (Allwinner =
A83T)
>=20
> Just drop these.

Well, the driver code package we have seems to support them and the idea =
(dream?)
is to make it a generic driver compatible to all of them.

So we could leave it out and add later (in the hope that it does not get
forgotten).

>=20
>> +
>> +               The "ti,omap..." entries are needed temporarily to =
handle SoC
>> +               specific builds of the kernel module.
>> +
>> +               In the long run, only the "img,sgx..." entry should =
suffice
>> +               to match a generic driver for all architectures and =
driver
>> +               code can dynamically find out on which SoC it is =
running.
>=20
> Drop this. Which compatible an OS matches on is not relevant to the
> binding. And 'temporarily' is wrong as the SoC specific compatible
> strings are what are used for handling errata or other integration
> specific things.

The idea behind this is that a driver can finally find out by different
means which SoC it is connected to.

At the moment we have to build different pvrsrvkm.ko for each one since
there is no "generic" driver yet.

So in the long run only img,sgx... should be there. And even this might
be boiled down to img,sgx5 (assuming that even 530/540/544) is =
detectable.

But at the moment we are not able to create working code without the
mix of soc and sgx versioning.

Basically it boils down if we want a basis that works today and is =
prepared
for tomorrow, or if we have to decide for either today or future and =
can't
bridge between.

>=20
>> +
>> +
>> +- reg:         Physical base addresses and lengths of the register =
areas.
>=20
> How many?

I assume there is only one. At least it suffices to make the existing
driver work with it.

>=20
>> +- reg-names:   Names for the register areas.
>=20
> If only 1 as the example suggests, then you don't need this.

ok.

>=20
>> +- interrupts:  The interrupt numbers.
>> +
>> +Optional properties:
>> +- timer:       the timer to be used by the driver.
>=20
> Needs a better description and vendor prefix at least.

I am not yet sure if it is vendor specific or if all
SGX implementations need some timer.

>=20
> Why is this needed rather than using the OS's timers?

Because nobody understands the current (out of tree and
planned for staging) driver well enough what the timer
is doing. It is currently hard coded that some omap refer
to timer7 and others use timer11.

>=20
>> +- img,cores:   number of cores. Defaults to <1>.
>=20
> Not discoverable?

Not sure if it is. This is probably available in undocumented
registers of the sgx.

>=20
>> +
>> +/ {
>> +       ocp {
>> +               sgx_module: target-module@56000000 {
>=20
> This is TI specific and this binding covers other chips in theory at
> least. This part is outside the scope

Ok, it is the only example where we know that it works. So we do not
yet know how the GPU integration would have to look like for e.g. CI20
or BananaPi M3 (which are not that well converted to device tree like =
OMAP).
This project is quite at the beginning...

>=20
>> +                       compatible =3D "ti,sysc-omap4", "ti,sysc";
>> +                       reg =3D <0x5600fe00 0x4>,
>> +                             <0x5600fe10 0x4>;
>=20
> How does it work that these registers overlap the GPU registers?

Both drivers have access to these registers. Likely, the gpu driver
ignores them and does access other ranges.

>=20
>> +                       reg-names =3D "rev", "sysc";
>> +                       ti,sysc-midle =3D <SYSC_IDLE_FORCE>,
>> +                                       <SYSC_IDLE_NO>,
>> +                                       <SYSC_IDLE_SMART>;
>> +                       ti,sysc-sidle =3D <SYSC_IDLE_FORCE>,
>> +                                       <SYSC_IDLE_NO>,
>> +                                       <SYSC_IDLE_SMART>;
>> +                       clocks =3D <&gpu_clkctrl OMAP5_GPU_CLKCTRL =
0>;
>> +                       clock-names =3D "fck";
>> +                       #address-cells =3D <1>;
>> +                       #size-cells =3D <1>;
>> +                       ranges =3D <0 0x56000000 0x2000000>;
>> +
>> +                       sgx@fe00 {
>=20
> gpu@...

Yes, is better to name it according to the function.

>=20
>=20
>=20
>> +                               compatible =3D "img,sgx544-116", =
"img,sgx544", "ti,omap-omap5-sgx544-116";
>> +                               reg =3D <0xfe00 0x200>;
>> +                               reg-names =3D "sgx";
>> +                               interrupts =3D <GIC_SPI 21 =
IRQ_TYPE_LEVEL_HIGH>;
>> +                               timer =3D <&timer11>;
>> +                               img,cores =3D <2>;
>> +                       };
>> +               };
>> +       };
>> +};
>> --
>> 2.19.1

BR and thanks,
Nikolaus
