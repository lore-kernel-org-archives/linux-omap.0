From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/1] arm :omap :DMA: fix a bug on reserving the omap SDMA
 channels
Date: Sun, 30 Dec 2012 11:54:42 +0530
Message-ID: <50DFDE2A.3070800@ti.com>
References: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab2L3GYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Dec 2012 01:24:36 -0500
In-Reply-To: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ahemaily@gmail.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

$subject
s/arm:omap/ARM: OMAP:

On Sunday 30 December 2012 02:13 AM, ahemaily@gmail.com wrote:
> From: ahemaily <ahemaily@gmail.com>
>
> The variable  dma_lch_count  used for comparison  (omap_dma_reserve_channels <= dma_lch_count)
> before it initialized to the value from omap_dma_dev_attr : d->lch_count.
s/it/it is

> I change the place of dma_lch_count initialization to be before the comparison.
>
s/I change the place of dma_lch_count initialization to be before the 
comparison./ Initialize dma_lch_count before it is being used for 
comparison.

> Signed-off-by: Abdelrahman Hemaily <ahemaily@gmail.com>
> ---
Change looks good to my eyes o.w

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

