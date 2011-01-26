From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Wed, 26 Jan 2011 10:31:07 +0000
Message-ID: <20110126103107.GA4232@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk> <20110126084613.GD1147@pengutronix.de> <20110126085240.GA2698@n2100.arm.linux.org.uk> <20110126091103.GE1147@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32975 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1AZKb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 05:31:27 -0500
Content-Disposition: inline
In-Reply-To: <20110126091103.GE1147@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 26, 2011 at 10:11:03AM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Jan 26, 2011 at 08:52:40AM +0000, Russell King - ARM Linux wr=
ote:
> > On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K=F6nig wrote:
> > > Will you care for imx (mach-{mx*,imx}), too, or should I fix them=
 up?
> >=20
> > Does mx stuff do non-irq setup or non-map_io stuff in those callbac=
ks?
> the map_io callbacks (e.g. mx27_map_io) setup the infrastructure for
> cpu_is_xyz and arch_reset.

In which case yes please.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
