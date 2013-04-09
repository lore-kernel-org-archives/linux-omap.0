From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter for
 debugSS module control
Date: Tue, 9 Apr 2013 08:07:37 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC47BB2@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1362396957-30113-4-git-send-email-hvaibhav@ti.com>
 <20130408172936.GQ10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44563 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935595Ab3DIIHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 04:07:50 -0400
In-Reply-To: <20130408172936.GQ10155@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, April 08, 2013 11:00 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; khilman@linaro.org; paul@pwsan.com;
> Nayak, Rajendra; linux-arm-kernel@lists.infradead.org
> Subject: Re: [RFC PATCH 3/3] ARM: OMAP2+: Add command line parameter
> for debugSS module control
>=20
> Hi,
>=20
> * hvaibhav@ti.com <hvaibhav@ti.com> [130304 03:40]:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Currently there is no clean mechanism to control debugSS module and
> > you have to always keep clocks enabled, either,
> >
> >     - By enabling it during boot as part of clk_init function.
> >     Or
> >     - By having HWMOD_INIT_NO_IDLE flag in hwmod data.
> >
> > Based on the discussion,
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg81771.htm=
l
> >
> > This patch introduces new kernel parameter "omap_debugss_en",
> > which will allow user to control debugSS module enable/disable
> > part during boot-time.
>=20
> I suggest you just make this part into a standard DT only
> device driver. That way the command line parsing and clock
> enabling can happen the normal way.
>=20

That=92s good idea, as we are moving towards DT only boot support.
Also, are you suggesting to have both command-line param and DT
Property for this?


> Is there any reason why this could not be a loadable module?
>=20

Because we want to keep it enabled before late_initcall. As part of lat=
e_initcall
Clock/hwmod framework will start disabling unused modules, which will i=
mpact the
Debugs as well. Consider the case where this debugss is loaded as a mod=
ule, the user
Will loose the JTAG connection until the module is loaded; and once mod=
ule is
Loaded, he has to again re-connect to the debugss.


With only DT option the code will look like below, is this what you als=
o have in your mind -

arch/arm/boot/dts/am33xx.dtsi:

	debugss: debugss@4b000000 {
		compatible =3D "ti,debugss";
		ti,hwmods =3D "debugss";
		reg =3D <0x4b000000 1000000>;
		status =3D "disabled";	/* User need to enable it if he need JTAG conn=
ectivity*/
	};


arch/arm/mach-omap2/debugss.c:

	static int __init _omap2_debugss_enable(void)
	{
		struct device_node *np;
=09
		np =3D of_find_matching_node(oh_name);
		if (!node || ! of_device_is_available()) {
			pr_err("debugss device is not found\n");
			return -ENODEV;
		}
		...
		hwmod lookup./setup/enable along with optional clock enable.
		...

	}
	device_initcall(_omap2_debugss_enable);

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
