From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/11] ARM: omap: move omapfb_reserve_sdram() to
	.init.text
Date: Fri, 23 Jul 2010 22:15:35 +0100
Message-ID: <20100723211535.GD750@n2100.arm.linux.org.uk>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de> <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39211 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab0GWVP6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 17:15:58 -0400
Content-Disposition: inline
In-Reply-To: <1279915120-4373-6-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

On Fri, Jul 23, 2010 at 09:58:29PM +0200, Uwe Kleine-K=F6nig wrote:
> omapfb_reserve_sdram() is only called by omap1_map_common_io() and
> _omap2_map_common_io() that both live in .init.text.  So this is save
> for omapfb_reserve_sdram(), too.

NAK.  This clashes with the memblock stuff.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
