From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Tue, 5 May 2015 16:53:24 +0300
Message-ID: <5548CB54.1040302@ti.com>
References: <20150504064323.GU15254@pengutronix.de> <20150504141103.GD24469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992755AbbEENyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 09:54:13 -0400
In-Reply-To: <20150504141103.GD24469@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Robert Schwebel <r.schwebel@pengutronix.de>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/04/2015 05:11 PM, Tony Lindgren wrote:
> Hi,
>=20
> Adding Peter to Cc as well.
>=20
> * Robert Schwebel <r.schwebel@pengutronix.de> [150503 23:44]:
>> Hi,
>>
>> since 5e863c561, I get this warning for an AM335x board:
>>
>>   omap_hwmod: tptc0 using broken dt data from edma
>>   omap_hwmod: tptc1 using broken dt data from edma
>>   omap_hwmod: tptc2 using broken dt data from edma
>>
>> It seems like the code in arch/arm/mach-omap2/omap_hwmod.c expects t=
he oftree
>> entry to look differently than what we currently have in
>> arch/arm/boot/dts/am33xx.dtsi:
>>
>>   edma: edma@49000000 {
>>           compatible =3D "ti,edma3";
>>           ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";    <=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>           reg =3D   <0x49000000 0x10000>,
>>                   <0x44e10f90 0x40>;
>>           interrupts =3D <12 13 14>;
>>           #dma-cells =3D <1>;
>>   };
>>
>> The patch description says the device should be split into more devi=
ces instead
>> of specifying several ti,hwmods entries, but unfortunately the Docum=
entation
>> still suggests the above format in Documentation/devicetree/bindings=
/dma/ti-edma.txt.
>>
>> How would a correct entry look like?
>=20
> Each tptc instance has it's own sysconfig register. This means each
> one of them can be clocked and idled independently. They should be
> treated as separate device instances. I believe the interrupts all
> belong to the tpcc, which should be also treated as a separate
> device instance.
>=20
> In order to get rid of the ti,hwmods property, we want to have a
> 1-1-1 mapping of the compatible property, ti,hwmod property, and
> the device entry.
>=20
> Looking at the TRM "Table 2-1. L3 Memory Map", these all are on
> the L3, so they should be like this for now (assuming the
> interrupts all belong to tpcc):
>=20
> ocp {
> 	...
>=20
> 	edma: tpcc@49000000 {
> 		compatible =3D "ti,edma3";
> 		ti,hwmods =3D "tpcc";=20
> 		reg =3D <0x49000000 0x10000>;
> 		interrupts =3D <12 13 14>;
> 		#dma-cells =3D <1>;
> 	};
>=20
> 	tptc0: tptc@49800000 {
> 		compatible =3D "ti,tptc3";
> 		ti,hwmods =3D "tptc0";
> 		reg =3D <0x49800000 0x10000>;
> 	};
>=20
> 	tptc1: tptc@49900000 {
> 		compatible =3D "ti,tptc3";
> 		ti,hwmods =3D "tptc1";
> 		reg =3D <0x49900000 0x10000>;
> 	};
>=20
> 	tptc2: tptc@49a00000 {
> 		compatible =3D "ti,tptc3";
> 		ti,hwmods =3D "tptc2";
> 		reg =3D <0x49a00000 0x10000>;
> 	};
> 	...
> };

It is not that simple ;)
eDMA consists of Channel Controller(s) and Transfer Controllers. In AM3=
35x we
have 1 CC and 3 TC. TC is mostly a box for us, we do not need to config=
ure
anything within so the eDMA driver stack just does that: do not touch a=
nything
TC related in TC address space, we only deal with the CC.
But in order to be able to move data around we need both CC and the TCs
enabled and this is why we have the multiple hwmod. with pm_runtime we =
manage
both CC and TCs at the same time.
But from the SW point of view the TC does not really exists. As I said =
we only
touch CC registers, paRAM entries.

And yes, both TC and CCs can generate interrupts.

So it is not straight forward to separate the TC from the CC driver (ed=
ma3).


>=20
> Then eventually we can deprecate the ti,hwmods property and just
> leave it out.
>=20
> Changing thing this way means each tptc instance should register
> itself separately with tpcc when probed. Other than that, I think
> that's pretty much the only changes needed here to fix up things.
>=20
> Regards,
>=20
> Tony
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
