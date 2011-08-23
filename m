From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v5 06/22] gpio/omap: make non-wakeup GPIO part of pdata
Date: Tue, 23 Aug 2011 18:24:59 +0530
Message-ID: <4E53A323.6070401@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com> <1312455893-14922-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34718 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605Ab1HWMzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:55:11 -0400
Received: by gwb17 with SMTP id 17so103144gwb.1
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:55:06 -0700 (PDT)
In-Reply-To: <1312455893-14922-7-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Non-wakeup GPIOs are available only in OMAP2. Avoid cpu_is checks by making
> non_wakeup_gpios as part of pdata.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---

Nice !!
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
