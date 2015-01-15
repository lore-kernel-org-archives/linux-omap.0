From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 17:19:24 +0000
Message-ID: <20150115171924.GV11502@n2100.arm.linux.org.uk>
References: <20150114221407.GS2419@atomide.com>
 <20150115105035.GU11502@n2100.arm.linux.org.uk>
 <20150115152838.GB18552@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:42717 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752574AbbAORTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 12:19:37 -0500
Content-Disposition: inline
In-Reply-To: <20150115152838.GB18552@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jan 15, 2015 at 07:28:39AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150115 02:53]:
> > I don't think we've proven a link there.  While you're right that it
> > causes the wrong interrupt to be claimed, I have two kernels here,
> > both claim the same interrupt, one which is multi-platform and issues
> > that strange warning, and one which targets only OMAP4 which doesn't.
> > 
> > There's something else going on which causes the bus errors which we
> > haven't found.
> 
> I think it gets triggered if you enable PREEMPT.

That's something which we can try to prove... build running now with
CONFIG_PREEMPT=y

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
