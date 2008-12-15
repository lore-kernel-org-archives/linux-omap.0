From: Tony Lindgren <tony@atomide.com>
Subject: Re: [REVIEW PATCH 14/14] OMAP34XX: CAM: Add Sensors Support
Date: Mon, 15 Dec 2008 09:56:45 -0800
Message-ID: <20081215175644.GW10664@atomide.com>
References: <20081215162338.GS10664@atomide.com> <A24693684029E5489D1D202277BE894415F3DAEB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56421 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYLOR4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 12:56:49 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894415F3DAEB@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, Sakari Ailus <sakari.ailus@nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [081215 09:02]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [081211 12:44]:
> > > +	case V4L2_POWER_OFF:
> > > +		/* Power Down Sequence */
> > > +#ifdef CONFIG_TWL4030_CORE
> > > +		twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> > > +				VAUX_DEV_GRP_NONE, TWL4030_VAUX2_DEV_GRP);
> > > +#else
> > > +#error "no power companion board defined!"
> > > +#endif
> > 
> > These checks look unecessary. How about just handle it with Kconfig?
> > 
> [Aguirre, Sergio] But how? Don't you think that if I do that, I'll tighten the sensor driver to this board only?
> 

See what we've done with arch/arm/mach-omap2/mmc-twl4030.c for example
in linux-omap tree. The twl and mmc patches are on their way to the mainline
kernel too hopfully this merge window.

Regards,

Tony
