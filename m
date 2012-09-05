From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix array size for irq_target_cpu
Date: Wed, 5 Sep 2012 10:28:45 +0530
Message-ID: <CAMQu2gx5aojH1mzDV-QfqLFJsm3CTf=NLK0ZNVkjYAk6YBKYtQ@mail.gmail.com>
References: <20120905000309.GW1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60482 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897Ab2IEE7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 00:59:07 -0400
Received: by ied7 with SMTP id 7so508025ied.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 21:59:06 -0700 (PDT)
In-Reply-To: <20120905000309.GW1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, Sep 5, 2012 at 5:33 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> If NR_IRQS is less than MAX_IRQS, we end up writing past the
> irq_target_cpu array in omap_wakeupgen_init():
>
> /* Associate all the IRQs to boot CPU like GIC init does. */
> for (i = 0; i < max_irqs; i++)
>         irq_target_cpu[i] = boot_cpu;
>
> This can happen if SPARSE_IRQ is enabled as by default NR_IRQS is
> set to 16. Without this patch we're overwriting other data during
> the boot.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
