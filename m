From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 1/6] ARM: OMAP3: PRM: move prcm interrupt handlers to PRM
 driver code
Date: Mon, 16 Jul 2012 14:41:06 +0300
Message-ID: <1342438866.4672.62.camel@sokoban>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
	 <1342197459-7920-2-git-send-email-t-kristo@ti.com>
	 <5003FA61.2050003@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40714 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2GPLlP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jul 2012 07:41:15 -0400
In-Reply-To: <5003FA61.2050003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 2012-07-16 at 16:56 +0530, Rajendra Nayak wrote:
> On Friday 13 July 2012 10:07 PM, Tero Kristo wrote:
> > PM code doesn't really care about the PRCM wakeup + io interrupts on
> > OMAP3, as these are used only for acking PRCM internal events, and the
> > IO chain handler is taken care of by hwmod code. Thus move the interrupt
> > handling logic from pm34xx.c to prm2xxx_3xxx.c file. This patch also
> > includes a minor cleanup for removing the priority handling and replacing
> > it with a mechanism for acking pending events. This gets rid of the need
> > for registering the shared interrupt handlers in specific order.
> 
> It would be easier to review if you were to split this into 2 patches,
> one which moves functions around as-is and another which does the
> cleanup/optimization. Having both in one is kinda hard to review.

The code was like that originally, however it was broken without the
cleanup / optimization. Simply moving the code around caused a problem
with idle: the sequencing of the interrupt handlers for IO event were
reversed and thus IO chain events for UARTs were never detected (they
were acked before parsing the chain.) Having these two things in
separate patches would introduce a bisect breakage for idle.

-Tero


