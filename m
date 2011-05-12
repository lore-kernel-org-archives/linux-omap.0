From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/13] clocksource: add common mmio clocksource
Date: Thu, 12 May 2011 00:43:26 -0700
Message-ID: <20110512074325.GE31483@atomide.com>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
 <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
 <20110510083841.GF30963@pengutronix.de>
 <20110510084648.GA31122@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:12138 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751475Ab1ELHnq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 03:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20110510084648.GA31122@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, John Stultz <johnstul@us.ibm.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110510 01:44]:
> On Tue, May 10, 2011 at 10:38:41AM +0200, Sascha Hauer wrote:
> > You forgot to initialize cs->reg. With this:
> 
> Damnit.  Fixed.
> 
> > Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

With cs->reg initialization and CONFIG_OMAP_MPU_TIMER=y things
boot tested on omap1 osk:

Tested-by: Tony Lindgren <tony@atomide.com>
