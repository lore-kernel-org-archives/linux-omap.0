From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 21:19:25 +0100
Message-ID: <20110415201925.GK4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <20110415201107.GO31990@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57935 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1DOUTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 16:19:46 -0400
Content-Disposition: inline
In-Reply-To: <20110415201107.GO31990@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 10:11:07PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wr=
ote:
> > This is work in progress.
> >=20
> > We have two SoCs using SRAM, both with their own allocation systems=
,
> > and both with their own ways of copying functions into the SRAM.
> I havn't checked the details, but maybe the code in
> arch/arm/plat-mxc/iram_alloc.c could be migrated to your approach, to=
o?

Its already in there now that I have replies from Nguyen Dinh.  It
looks like this presently:

 arch/arm/plat-mxc/Kconfig                   |    2 +-
 arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
 arch/arm/plat-mxc/iram_alloc.c              |   50 +++++--------------=
-

and if we get rid of the iram_alloc/iram_free wrappers around the
sram_pool (now pv_pool) alloc/free in iram.h, in the same way I've
done for Davinci, then we get less new additions too.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
