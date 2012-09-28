From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP2+: Round of the carve out memory requested
 to section_size
Date: Fri, 28 Sep 2012 12:03:34 +0530
Message-ID: <CAMQu2gwuQ6uht0iHtPuhFU4B9P+zgNHYazK+BqE-rnBfnhL2cg@mail.gmail.com>
References: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:38922 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750995Ab2I1Gd4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 02:33:56 -0400
Received: by vcbfo13 with SMTP id fo13so2967554vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 23:33:55 -0700 (PDT)
In-Reply-To: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>, Tony <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Sep 12, 2012 at 12:44 PM, R Sricharan <r.sricharan@ti.com> wrote:
> memblock_steal tries to reserve physical memory during boot.
> When the requested size is not aligned on the section size
> then, the remaining memory available for lowmem becomes
> unaligned on the section boundary. There is a issue with this,
> which is discussed in the thread below.
>
> https://lkml.org/lkml/2012/6/28/112
>
> The final conclusion from the thread seems to
> be align the memblock_steal calls on the SECTION boundary.
> The issue comes out when LPAE is enabled, where the
> section size is 2MB.
>
> Boot tested this on OMAP5 evm with and without LPAE.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> ---
>  [V2] Corrected the subject and added one more description line.
>
Looks good.
Acked-by : Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,
Can you take this into your next "fixes-noncritical" queue please ?

Regards,
Santosh
