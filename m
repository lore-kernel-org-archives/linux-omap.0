From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS
	entry
Date: Tue, 4 Jan 2011 17:33:01 +0000
Message-ID: <20110104173301.GA25976@n2100.arm.linux.org.uk>
References: <1294142577-28772-1-git-send-email-balbi@ti.com> <1294142577-28772-3-git-send-email-balbi@ti.com> <20110104140031.GE25121@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53636 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1ADRdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 12:33:37 -0500
Content-Disposition: inline
In-Reply-To: <20110104140031.GE25121@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 03:00:31PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Jan 04, 2011 at 02:02:55PM +0200, Felipe Balbi wrote:
> > GENERIC_HARDIRQS is defined under kernel/irq/Kconfig,
> > so it's safe to drop the duplicated entry and simply
> > select HAVE_GENERIC_HARDIRQS.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/Kconfig |    8 +-------
> >  1 files changed, 1 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d56d21c0..e6f0f8b 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -15,6 +15,7 @@ config ARM
> >  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> >  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
> >  	select HAVE_GENERIC_DMA_COHERENT
> > +	select HAVE_GENERIC_HARDIRQS
> >  	select HAVE_KERNEL_GZIP
> >  	select HAVE_KERNEL_LZO
> >  	select HAVE_KERNEL_LZMA
> > @@ -88,10 +89,6 @@ config MCA
> >  	  <file:Documentation/mca.txt> (and especially the web page given
> >  	  there) before attempting to build an MCA bus kernel.
> > =20
> > -config GENERIC_HARDIRQS
> > -	bool
> > -	default y
> > -
> >  config STACKTRACE_SUPPORT
> >  	bool
> >  	default y
> > @@ -171,9 +168,6 @@ config FIQ
> >  config ARCH_MTD_XIP
> >  	bool
> > =20
> > -config GENERIC_HARDIRQS_NO__DO_IRQ
> > -	def_bool y
> > -
> You didn't mention this change in the commit log.  Is this duplicated=
,
> too or did it just slip through?

If you look at kernel/irq/Kconfig (as I did with the original patch)
you'd notice kernel/irq/Kconfig defines both of these symbols being
removed when HAVE_GENERIC_HARDIRQS is enabled.

If you read the discussion in the previous version of this patch set,
you'd notice that the removal of this was specifically requested.

It's very tiresome to have to re-explain these things.  Please take
some more time to research the points you bring up, rather than
impulse-replying.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
