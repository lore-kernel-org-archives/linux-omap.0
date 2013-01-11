From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Fix the use of uninitialized dma_lch_count
Date: Fri, 11 Jan 2013 17:08:03 +0530
Message-ID: <50EFF99B.7040602@ti.com>
References: <50EE9815.2080402@asianux.com> <50EE9C87.6060407@ti.com> <50EFA586.5010508@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54959 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab3AKLhV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 06:37:21 -0500
In-Reply-To: <50EFA586.5010508@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>, tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 11 January 2013 11:09 AM, Chen Gang wrote:
>
>    'omap_dma_reserve_channels' when used is suppose to be from command.
>      so, it alreay has value before 1st call of omap_system_dma_probe.
>      and it will never be changed again during running (not from ioctl).
>
>    but 'dma_lch_count' is zero before 1st call of omap_system_dma_probe.
>      so it will be failed for omap_dma_reserve_channels, when 1st call.
>
>    so, need use 'd->lch_count' instead of 'dma_lch_count' for judging.
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Looks fine to me.

Tony,
If you are ok with the patch, can you pick this fix in your
non-critical fixes branch ?
