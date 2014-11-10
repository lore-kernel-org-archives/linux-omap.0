From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/2] bus: omap_l3_noc: Add resume hook to restore mask
 registers
Date: Mon, 10 Nov 2014 09:29:25 -0600
Message-ID: <5460D9D5.2040108@ti.com>
References: <1415595784-5646-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37416 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbaKJP3a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 10:29:30 -0500
In-Reply-To: <1415595784-5646-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com

On 11/09/2014 11:03 PM, Keerthy wrote:
> l3_noc module loses context during both DS0 and RTC+DDR in self refresh modes.
> This causes the previously masked l3 interrupts to trigger and the software
> book keeping assumes the interrupts are masked and does nothing to mask.
> This software/hardware out of sync leads to back to back l3 interrupts
> and eventually causes a hang. Hence adding resume hook to restore the
> mask registers based on the book keeping variables
> 
> Keerthy (2):
>   bus: omap_l3_noc: Add resume hook to restore context
minor comment on this patch,

>   bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally in
>     the irq handler
> 
>  drivers/bus/omap_l3_noc.c |   63 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
Otherwise:
Acked-by: Nishanth Menon <nm@ti.com>

yep, AM437x did bring out some interesting surprises :(... thanks for
catching them.

-- 
Regards,
Nishanth Menon
