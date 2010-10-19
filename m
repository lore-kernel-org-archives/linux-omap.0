From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
Date: Tue, 19 Oct 2010 11:28:16 +0200
Message-ID: <20101019092816.GD11713@pengutronix.de>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com> <1286315819-5906-4-git-send-email-manjugk@ti.com> <20101019090613.GA2736@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52319 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663Ab0JSJ2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 05:28:24 -0400
Content-Disposition: inline
In-Reply-To: <20101019090613.GA2736@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 19, 2010 at 11:06:14AM +0200, Samuel Ortiz wrote:
> Hi Manjunath,
>=20
> On Wed, Oct 06, 2010 at 03:26:59AM +0530, G, Manjunath Kondaiah wrote=
:
> > Fixes following sparse warnings for twl4030 and twl6030 irq files.
> >=20
> > drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq'=
 was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq'=
 was not declared. Should it be static?
> > drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip=
_irq' was not declared. Should it be static?
> >=20
> > drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq'=
 was not declared. Should it be static?
> > drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq'=
 was not declared. Should it be static?
> >
> Patch applied, thanks.
I didn't get the original patch, so I just now noticed the typo in the
Subject.  You might want to do s/fucntion/function/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
