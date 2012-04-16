From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: dmtimer: Use devm_ API and do some cleanup
 in probe()
Date: Mon, 16 Apr 2012 20:32:07 +0530
Message-ID: <4F8C346F.9020200@ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com> <1334579125-15566-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56449 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214Ab2DPPCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 11:02:18 -0400
Received: by obbef5 with SMTP id ef5so7364641obb.10
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 08:02:17 -0700 (PDT)
In-Reply-To: <1334579125-15566-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On Monday 16 April 2012 05:55 PM, Tarun Kanti DebBarma wrote:
> Replace the regular kzalloc and ioremap with the devm_ equivalent
> to simplify error handling. We don't need kree() anymore in
> omap_dm_timer_remove().
>
> Also added *dev* pointer to reference pdev->dev which makes the
> usage shorter in code.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>
<snip>
> -	timer->io_base = ioremap(mem->start, resource_size(mem));
> +	timer->io_base = devm_ioremap(dev, mem->start, resource_size(mem));
>  	if (!timer->io_base) {
Could we use  devm_request_and_ioremap here?

