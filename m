From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: l3_noc: Remove references to static IRQ defines
Date: Fri, 24 Feb 2012 11:50:54 +0530
Message-ID: <CAMQu2gxUYoy1p=PMN3XJqTM839gonYEGDC+YpyseHk9BwPDENA@mail.gmail.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com> <1330035801-14937-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44190 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755255Ab2BXGVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 01:21:16 -0500
Received: by qcsg15 with SMTP id g15so341850qcs.13
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 22:21:14 -0800 (PST)
In-Reply-To: <1330035801-14937-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> The irq numbers are retrieved dynamically but the error logging
> is still referring to the OMAP44XX_IRQ_XXX defines instead of the
> irq number returned by platform_get_irq.
>
> Remove this reference to allow deletion of the irqs-44xx.h files.
> Clean the message and replace the pr_ macro by the dev_ equivalent.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Thanks Benoit. Patch looks good to me
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
