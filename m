From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Work around hardcoded interrupts
Date: Thu, 15 Jan 2015 10:45:11 -0600
Message-ID: <20150115164511.GA21656@kahuna>
References: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbbAOQqP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 11:46:15 -0500
Content-Disposition: inline
In-Reply-To: <1421335212-4115-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On 15:20-20150115, Marc Zyngier wrote:
> Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
nit-picking.... which Tony can handle I think..
checkpatch --strict seems picky and recommends using " " as follows:
Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain.")

Otherwise,
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
