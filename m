From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 04/22] gpio/omap: fix pwrdm_post_transition call sequence
Date: Tue, 23 Aug 2011 18:17:48 +0530
Message-ID: <4E53A174.4060408@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54020 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656Ab1HWMr4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:47:56 -0400
Received: by mail-gw0-f51.google.com with SMTP id 17so43663gwj.10
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:47:55 -0700 (PDT)
In-Reply-To: <1312455893-14922-5-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> The context lost count is modified in omap_sram_idle() path when
> pwrdm_post_transition() is called. But pwrdm_post_transition() is called
> only after omap_gpio_resume_after_idle() is called. Correct this so that
> context lost count is modified before calling omap_gpio_resume_after_idle().
>
> This would be useful when OMAP GPIO save/restore context is called by
> the OMAP GPIO driver itself.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks good to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

regards
Santosh
