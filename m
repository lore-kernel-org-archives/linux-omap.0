From: Jan Kardell <jan.kardell@telliq.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
 for 1.35v ddr3
Date: Sun, 12 Oct 2014 15:08:24 +0200
Message-ID: <543A7D48.1080808@telliq.com>
References: <1412973219-3674-1-git-send-email-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:50206 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaJLNId (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Oct 2014 09:08:33 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so5483702lab.13
        for <linux-omap@vger.kernel.org>; Sun, 12 Oct 2014 06:08:31 -0700 (PDT)
In-Reply-To: <1412973219-3674-1-git-send-email-robertcnelson@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>, tony@atomide.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vagrant Cascadian <vagrant@debian.org>

Robert Nelson skrev:
> The TPS65217C used on the boneblack defaults to 1.5v on startup for d=
cdc1_reg.
> While 1.35v ddr3 memory is actually used. This was discovered by a us=
er during
> a schematic review of his beaglebone-black clone, a u-boot patch will=
 also also
> be submitted.
Isn't it dual voltage, 1,35 or 1,5 V?

And what happens when u-boot voltage does not match the kernel? Found t=
his:

If the SDRAM is powered up and initialized for the 1.5V operating=20
voltage range, voltage
can be reduced to the 1.35V operation range provided that:
=95 Just prior to reducing the 1.5V operating voltages, no further=20
commands are issued,
other than NOPs or COMMAND INHIBITs, and all banks are in the precharge=
=20
state.
=95 The 1.35V operating voltages are stable prior to issuing new comman=
ds,=20
other than
NOPs or COMMAND INHIBITs.
=95 The DLL is reset and relocked after the 1.35V operating voltages ar=
e=20
stable and prior to
any READ command.
=95 The ZQ calibration is performed. tZQinit must be satisfied after th=
e=20
1.35V operating
voltages are stable and prior to any READ command.

Actually I'm not sure what this means in practice, but maybe this is a=20
problem?

//Jan
>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Vagrant Cascadian <vagrant@debian.org>
> ---
>   arch/arm/boot/dts/am335x-boneblack.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/d=
ts/am335x-boneblack.dts
> index 901739f..e7c8999 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -15,6 +15,13 @@
>   	compatible =3D "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33x=
x";
>   };
>  =20
> +&dcdc1_reg {
> +	/* TPS65217C defaults to 1.5v on powerup while 1.35v DDR3 is used *=
/
> +	regulator-min-microvolt =3D <1350000>;
> +	regulator-max-microvolt =3D <1350000>;
> +	regulator-boot-on;
> +};
> +
>   &ldo3_reg {
>   	regulator-min-microvolt =3D <1800000>;
>   	regulator-max-microvolt =3D <1800000>;


--=20

"I have always wished for my computer to be as easy to use as my teleph=
one; my wish has come true because I can no longer figure out how to us=
e my telephone."
- Bjarne Stroustrup

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
