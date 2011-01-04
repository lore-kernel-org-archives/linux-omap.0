From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] arm: Kconfig: remove duplicated GENERIC_HARDIRQS
	entry
Date: Tue, 4 Jan 2011 21:54:45 +0100
Message-ID: <20110104205445.GF25121@pengutronix.de>
References: <1294142577-28772-1-git-send-email-balbi@ti.com> <1294142577-28772-3-git-send-email-balbi@ti.com> <20110104140031.GE25121@pengutronix.de> <20110104173301.GA25976@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36554 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab1ADUyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 15:54:52 -0500
Content-Disposition: inline
In-Reply-To: <20110104173301.GA25976@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Russell,

On Tue, Jan 04, 2011 at 05:33:01PM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Jan 04, 2011 at 03:00:31PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 04, 2011 at 02:02:55PM +0200, Felipe Balbi wrote:
> > > @@ -171,9 +168,6 @@ config FIQ
> > >  config ARCH_MTD_XIP
> > >  	bool
> > > =20
> > > -config GENERIC_HARDIRQS_NO__DO_IRQ
> > > -	def_bool y
> > > -
> > You didn't mention this change in the commit log.  Is this duplicat=
ed,
> > too or did it just slip through?
>=20
> If you look at kernel/irq/Kconfig (as I did with the original patch)
> you'd notice kernel/irq/Kconfig defines both of these symbols being
> removed when HAVE_GENERIC_HARDIRQS is enabled.
>=20
> If you read the discussion in the previous version of this patch set,
> you'd notice that the removal of this was specifically requested.
>=20
> It's very tiresome to have to re-explain these things.  Please take
> some more time to research the points you bring up, rather than
I don't agree here 100%.  IMHO the commit log was not good enough for
the change introduced by the patch (and Felipe's reply suggests that he
agrees).  I could still research it, but:

 - it was not obvious for me there was a previous version (no "v2" or
   similar in the patch subject);
 - for me it would take say 5 minutes to check, the author knows
   the answer to my question immediately (at least he should);
 - after a research I could suggest a better wording, but I don't care
   much if it's me or Felipe who comes up with a better text.

So all in all I'm still confident that my mail was OK.

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
