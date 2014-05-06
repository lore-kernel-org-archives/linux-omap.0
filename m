From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] irqchip/dra7: crossbar bug fixes
Date: Mon, 5 May 2014 17:48:33 -0700
Message-ID: <20140506004833.GP25949@atomide.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19668 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbaEFAsj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 20:48:39 -0400
Content-Disposition: inline
In-Reply-To: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com

* Sricharan R <r.sricharan@ti.com> [140505 07:20]:
> These are fixes for the crossbar to handle two interrupts getting
> mapped twice to same crossbar and to skip some interrupts being used
> due to hardware bugs.
> 
> Nishanth Menon (5):
>   irqchip: crossbar: dont use '0' to mark reserved interrupts
>   irqchip: crossbar: check for premapped crossbar before allocating
>   irqchip: crossbar: Skip some irqs from getting mapped to crossbar
>   irqchip: crossbar: Initialise the crossbar with a safe value
>   irqchip: crossbar: Change allocation logic by reversing search for
>     free irqs
> 
>  drivers/irqchip/irq-crossbar.c |   82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)

Thanks applying all into omap-for-v3.16/crossbar.

Tony
