From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Tue, 9 Apr 2013 09:34:59 -0700
Message-ID: <20130409163459.GJ10155@atomide.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33196 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936963Ab3DIQfE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:35:04 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130409 01:12]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> >=20
> > I suggest you just make this part into a standard DT only
> > device driver. That way the command line parsing and clock
> > enabling can happen the normal way.
> >=20
>=20
> That=E2=80=99s good idea, as we are moving towards DT only boot suppo=
rt.
> Also, are you suggesting to have both command-line param and DT
> Property for this?
>=20
>=20
> > Is there any reason why this could not be a loadable module?
> >=20
>=20
> Because we want to keep it enabled before late_initcall. As part of l=
ate_initcall
> Clock/hwmod framework will start disabling unused modules, which will=
 impact the
> Debugs as well. Consider the case where this debugss is loaded as a m=
odule, the user
> Will loose the JTAG connection until the module is loaded; and once m=
odule is
> Loaded, he has to again re-connect to the debugss.

It will get run before late_initcall if compiled in. Sounds
like there are no issues also make it work as a loadable module
as needed.
=20
> With only DT option the code will look like below, is this what you a=
lso have in your mind -
>=20
> arch/arm/boot/dts/am33xx.dtsi:
>=20
> 	debugss: debugss@4b000000 {
> 		compatible =3D "ti,debugss";
> 		ti,hwmods =3D "debugss";
> 		reg =3D <0x4b000000 1000000>;
> 		status =3D "disabled";	/* User need to enable it if he need JTAG co=
nnectivity*/
> 	};
>
>
> arch/arm/mach-omap2/debugss.c:
>=20
> 	static int __init _omap2_debugss_enable(void)
> 	{
> 		struct device_node *np;
> =09
> 		np =3D of_find_matching_node(oh_name);
> 		if (!node || ! of_device_is_available()) {
> 			pr_err("debugss device is not found\n");
> 			return -ENODEV;
> 		}
> 		...
> 		hwmod lookup./setup/enable along with optional clock enable.
> 		...
>=20
> 	}
> 	device_initcall(_omap2_debugss_enable);

It should be all standard device driver stuff. I'd make it just
regular module_platform_driver and only initialize it earlier if
compiled in.

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
