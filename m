From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
Date: Sat, 03 Mar 2012 19:09:13 +0400
Message-ID: <4F523419.3080100@ru.mvista.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com> <1330707024-23730-12-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:33011 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752781Ab2CCPKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 10:10:33 -0500
In-Reply-To: <1330707024-23730-12-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hello.

On 02-03-2012 20:50, Benoit Cousson wrote:

> Card detect IRQ from the TWL6030 used to be provided to the MMC

> controller code using a statically allocated IRQ scheme:
>
>    card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>
> This is no longer valid in a SPARSE_IRQ context since there is no more
> pre-defined TWL6030_IRQ_BASE.
>
> Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
> that will be called from the MMC controller.
>
> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> ---
>   drivers/mfd/twl6030-irq.c |    3 ++-

     Subject talks about twl4030-irq.

WBR, Sergei
