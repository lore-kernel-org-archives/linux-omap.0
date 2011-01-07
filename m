From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 05/10] cbus: retu: move to threaded IRQ and GENIRQ
Date: Thu, 6 Jan 2011 19:04:50 -0800
Message-ID: <20110107030449.GH7771@atomide.com>
References: <1294040988-21191-1-git-send-email-balbi@ti.com>
 <1294040988-21191-6-git-send-email-balbi@ti.com>
 <20110104014002.GV7771@atomide.com>
 <20110104065229.GB2367@legolas.emea.dhcp.ti.com>
 <20110104074615.GC2656@legolas.emea.dhcp.ti.com>
 <20110104074756.GD2656@legolas.emea.dhcp.ti.com>
 <20110104191359.GH7771@atomide.com>
 <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21982 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451Ab1AGDE5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 22:04:57 -0500
Content-Disposition: inline
In-Reply-To: <20110105063751.GB2458@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [110104 22:37]:
> Hi,
> 
> On Tue, Jan 04, 2011 at 11:14:00AM -0800, Tony Lindgren wrote:
> > I think there's been some patches related to this to get rid
> > of NR_IRQS? Might be worth taking a look at those first as it's
> > a generic solution.
> 
> Yeah, one way would be to use Sparse IRQ numbering scheme and define
> different bases for different IRQ chips. We could use for example,
> something like:
> 
> IRQ	|	Chip
> =====================
> 0-299	|	INTC
> 300-499	|	TWL4030
> 500-599	|	MENELAUS
> 600-799	|	RETU
> 800-999	|	TAHVO
> 
> and so on. But I'm not sure that's good enough (numbers are just from
> the top of my head, didn't really check how many IRQs each one have).
> 
> The only problem I see is with INTC, what happens if we give it an
> interval which ends up not being big enough for next OMAP versions ?

I think that's the way to go, but we should not allocate that
many irqs.. We can define the ranges like we already do in irqs.h
based on what gets compiled in. There are few more blocks though:

INTC
GPIO		
MPUIO
GIC
FPGA
RETU
TAHVO
MENELAUS
TWL4030

The numbers for INTC we know assuming new omaps will use GIC. The
external chips rarely have more than few interrupts.

Regards,

Tony
