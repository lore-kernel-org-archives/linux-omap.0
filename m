From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] drivers: cleanup Kconfig stuff
Date: Tue, 2 Nov 2010 10:39:50 -0400
Message-ID: <20101102143949.GH21476@opensource.wolfsonmicro.com>
References: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com>
 <1288656853-4625-3-git-send-email-felipe.contreras@gmail.com>
 <20101102131146.GA21476@opensource.wolfsonmicro.com>
 <AANLkTim6E+e=D88C8g+YDVwS1D5JPeXvVRw-JVoVxh2i@mail.gmail.com>
 <20101102141208.GU31158@pengutronix.de>
 <AANLkTikwGBij05h1GgW0dpvcJedmcOQ1HWCaxaBdhZta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56279 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751555Ab0KBOjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 10:39:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikwGBij05h1GgW0dpvcJedmcOQ1HWCaxaBdhZta@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-usb <linux-usb@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Greg KH <greg@kroah.com>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, Hao Wu <hao.wu@intel.com>, Alan Cox <alan@linux.intel.com>, Mike Rapoport <mike@compulab.co.il>

On Tue, Nov 02, 2010 at 04:18:18PM +0200, Felipe Contreras wrote:
> 2010/11/2 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:

> > Well, all platforms that have TWL4030_CORE will get REGULATOR_TWL40=
30 by
> > default, too. =A0(TWL4030_CORE doesn't depend on something omapish.=
)

> Yes, I think TWL4030_CORE should depend on OMAP3, but I think some
> people might not like that. That's why I wanted to make that a
> separate patch.

It did originally but that dependency was removed to allow build
coverage for non-OMAP users.

>=20
> > For me this looks OK. =A0It would be still better if it removed
> > CONFIG_REGULATOR_TWL4030=3Dy from arch/arm/configs/omap2plus_defcon=
fig.
>=20
> Yes, but I want to run 'make savedefconfig'; there's many changes
> lingering like that.
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
