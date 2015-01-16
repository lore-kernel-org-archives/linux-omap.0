From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Fri, 16 Jan 2015 22:57:27 +0000
Message-ID: <20150116225727.GY11502@n2100.arm.linux.org.uk>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
 <20150115171924.GV11502@n2100.arm.linux.org.uk>
 <20150116162119.GK18552@atomide.com>
 <20150116163019.GW11502@n2100.arm.linux.org.uk>
 <20150116164105.GL18552@atomide.com>
 <20150116172223.GX11502@n2100.arm.linux.org.uk>
 <20150116172905.GM18552@atomide.com>
 <20150116225243.GN18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45817 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750934AbbAPW5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2015 17:57:36 -0500
Content-Disposition: inline
In-Reply-To: <20150116225243.GN18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jan 16, 2015 at 02:52:44PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150116 09:36]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150116 09:25]:
> > > So, the GPIO driver really needs fixing - and I'd suggest fixing it
> > > first, before fixing the DMA problem, because the DMA problem allows
> > > us to see the GPIO problem.
> > 
> > Yes we need to fix that.
> 
> Posted a minimal fix for that one as a separate thread:
> 
> [PATCH 1/1] gpio: omap: Fix bad device access with setup_irq()

Thanks, I'll throw that onto the build tree for tonights build.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
