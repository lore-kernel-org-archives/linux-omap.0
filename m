From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Put in supportframework for PR785 board.
Date: Thu, 4 Dec 2008 10:00:23 -0800
Message-ID: <200812041000.23522.david-b@pacbell.net>
References: <1228386206-13513-1-git-send-email-mani.pillai@ti.com> <19F8576C6E063C45BE387C64729E739403E90E7234@dbde02.ent.ti.com> <20081204113925.GP10209@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:36005 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753195AbYLDSAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 13:00:25 -0500
In-Reply-To: <20081204113925.GP10209@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com, "ext Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 04 December 2008, Felipe Balbi wrote:
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -61,6 +61,8 @@ config UCB1400_CORE
> > > =A0=A0=A0=A0 =A0To compile this driver as a module, choose M here=
: the
> > > =A0=A0=A0=A0 =A0module will be called ucb1400_core.
> > > =A0
> > > +menu "Texas Instruments Power board Support"
> > > +
> > > =A0config TWL4030_CORE
> > > =A0=A0=A0=A0bool "Texas Instruments TWL4030/TPS659x0 Support"
> > > =A0=A0=A0=A0depends on I2C=3Dy && GENERIC_HARDIRQS
> > > @@ -84,6 +86,18 @@ config TWL4030_POWER
> > > =A0=A0=A0=A0 =A0oscillators are switched off or on or reset when =
a sleep, wakeup
> > > =A0=A0=A0=A0 =A0or warm reset event occurs.
> > > =A0
> > > +config PR785
> > > +=A0=A0=A0bool "A Texas Instruments TPS6235X based Power Module"
> > > +=A0=A0=A0depends on I2C=3Dy && MACH_OMAP3EVM=3Dy && GENERIC_GPIO=
 && (ARCH_OMAP3)
> > > +=A0=A0=A0default n
> > > +=A0=A0=A0help
> > > +=A0=A0=A0Say yes here if you are using the TPS6235x based PR785 =
Power Module
> > > +=A0=A0=A0for the EVM boards. This core driver provides register =
access and IRQ
> > > +=A0=A0=A0handling facilities, and registers devices for the vari=
ous functions
> > > +=A0=A0=A0so that function-specific drivers can bind to them.
> > > +
> > > +endmenu
> >=20
> > where's the driver for it ??
> > [Pillai, Manikandan] The PATCH 2/2 contains the driver file. This h=
as only
> > the framework
>=20
> so the Kconfig for that driver should be together with the driver.

IMO it'd be better to have this Kconfig go in
the arch/arm/mach-omap2/Kconfig, a direct child
of the OMAP3EVM entry ... the menu tree should be

	... other boards
	omap3evm?
		choice of power boards:=20
			TWL4030/original
			PR785
	... other boards

That is, unless/until there's some way to detect
the type of board at runtime.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
