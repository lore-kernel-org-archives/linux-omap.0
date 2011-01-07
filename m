From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Fri, 7 Jan 2011 09:04:55 -0800
Message-ID: <20110107170455.GE880@atomide.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
 <20110104191359.GH7771@atomide.com>
 <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
 <20110107030449.GH7771@atomide.com>
 <20110107074814.GC3230@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54484 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab1AGRFF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:05:05 -0500
Content-Disposition: inline
In-Reply-To: <20110107074814.GC3230@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110106 23:47]:
> 
> The main point of using Sparse IRQ numbering is exactly avoiding
> pre-processor branches. Instead of defining ranges only when a device is
> compile, we can always keep the range allocated no matter if the device
> probes or not. So, I suggest dropping the ifdeffery on <plat/irqs.h> and
> move that to something like below:

This is fine as long as we we don't run out of allocated IRQs before
switching over to sparse IRQ. The original reason for the ifdeffery
was to keep NR_IRQS below 256 when possible as it optimizes the interrupt
handling in that case. See NR_IRQS in arch/arm/include/asm/hardirq.h
for more info.

Regards,

Tony
