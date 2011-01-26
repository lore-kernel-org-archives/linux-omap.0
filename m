From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Wed, 26 Jan 2011 08:52:40 +0000
Message-ID: <20110126085240.GA2698@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk> <20110126084613.GD1147@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60958 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1AZIxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 03:53:11 -0500
Content-Disposition: inline
In-Reply-To: <20110126084613.GD1147@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 26, 2011 at 09:46:13AM +0100, Uwe Kleine-K=F6nig wrote:
> Will you care for imx (mach-{mx*,imx}), too, or should I fix them up?

Does mx stuff do non-irq setup or non-map_io stuff in those callbacks?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
