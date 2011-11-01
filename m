From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/2] OMAP2+: DMA: fix src/dst position reporting
Date: Tue, 01 Nov 2011 21:26:06 +0200
Message-ID: <4EB047CE.2010807@bitmer.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:52116 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223Ab1KAT0p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Nov 2011 15:26:45 -0400
In-Reply-To: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 10/31/2011 04:20 PM, Peter Ujfalusi wrote:
> Hello,
>
> If the user asks for the sDMA current position before the first
> data has been transmitted (before the first DMA request has been
> generated), the reported position is not valid:
> src position: CSAC is uninitialized
> dst position: CDAC is 0
>
> The return values in both case considered invalid.
> This sitation can be identified by checking if the CDAC register
> is 0 (it is initialized to 0 in omap_dam_start call).
> In this case return the programmed source/destination address.
>
> The affected omap_get_dma_src_pos/omap_get_dma_dst_pos functions
> are used by the audio stack mainly for checking the current position
> of the audio stream.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>    OMAP2+: DMA: Workaround for invalid source position
>    OMAP2+: DMA: Workaround for invalid destination position
>
>   arch/arm/plat-omap/dma.c |   25 ++++++++++++++++++++++---
>   1 files changed, 22 insertions(+), 3 deletions(-)
>
Both,

Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
