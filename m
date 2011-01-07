From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Fri, 7 Jan 2011 21:15:38 +0200
Message-ID: <20110107191538.GC2272@legolas.emea.dhcp.ti.com>
References: <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
 <20110104191359.GH7771@atomide.com>
 <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
 <20110107030449.GH7771@atomide.com>
 <20110107074814.GC3230@legolas.emea.dhcp.ti.com>
 <20110107170455.GE880@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38735 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752470Ab1AGTPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:15:43 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so7513348ewy.33
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 11:15:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107170455.GE880@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Jan 07, 2011 at 09:04:55AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110106 23:47]:
> > 
> > The main point of using Sparse IRQ numbering is exactly avoiding
> > pre-processor branches. Instead of defining ranges only when a device is
> > compile, we can always keep the range allocated no matter if the device
> > probes or not. So, I suggest dropping the ifdeffery on <plat/irqs.h> and
> > move that to something like below:
> 
> This is fine as long as we we don't run out of allocated IRQs before
> switching over to sparse IRQ. The original reason for the ifdeffery
> was to keep NR_IRQS below 256 when possible as it optimizes the interrupt
> handling in that case. See NR_IRQS in arch/arm/include/asm/hardirq.h
> for more info.

I've sent patches (you're in Cc) enabling SPARSE_IRQ on OMAP. I boot
tested on panda and overo and it was working fine.

-- 
balbi
