From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
Date: Tue, 19 Oct 2010 12:33:45 +0200
Message-ID: <20101019103344.GL2736@sortiz-mobl>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
 <1286315819-5906-4-git-send-email-manjugk@ti.com>
 <20101019090613.GA2736@sortiz-mobl>
 <20101019092816.GD11713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57926 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933717Ab0JSKds (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 06:33:48 -0400
Content-Disposition: inline
In-Reply-To: <20101019092816.GD11713@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Tue, Oct 19, 2010 at 11:28:16AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Oct 19, 2010 at 11:06:14AM +0200, Samuel Ortiz wrote:
> > Hi Manjunath,
> >=20
> > On Wed, Oct 06, 2010 at 03:26:59AM +0530, G, Manjunath Kondaiah wro=
te:
> > > Fixes following sparse warnings for twl4030 and twl6030 irq files=
=2E
> > >=20
> > > drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_ir=
q' was not declared. Should it be static?
> > > drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_ir=
q' was not declared. Should it be static?
> > > drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_ch=
ip_irq' was not declared. Should it be static?
> > >=20
> > > drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_ir=
q' was not declared. Should it be static?
> > > drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_ir=
q' was not declared. Should it be static?
> > >
> > Patch applied, thanks.
> I didn't get the original patch, so I just now noticed the typo in th=
e
> Subject.  You might want to do s/fucntion/function/
Yes, I noticed as well and fixed it, thanks.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
