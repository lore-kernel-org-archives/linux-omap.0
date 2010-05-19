From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/4] OMAP: mcbsp - add omap_mcbsp_set_dma_op_mode()
Date: Wed, 19 May 2010 09:13:28 +0300
Message-ID: <20100519091328.2afd8a64.jhnikula@gmail.com>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	<1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42219 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab0ESGNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 02:13:31 -0400
Received: by ewy8 with SMTP id 8so2484170ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 23:13:29 -0700 (PDT)
In-Reply-To: <1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>

On Tue, 18 May 2010 21:13:11 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> This adds a method to set the MCBSP DMA OP mode.
> 
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  arch/arm/plat-omap/include/plat/mcbsp.h |    2 ++
>  arch/arm/plat-omap/mcbsp.c              |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
> index 1bd7021..f8823f4 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -476,6 +476,7 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
>  u16 omap_mcbsp_get_tx_delay(unsigned int id);
>  u16 omap_mcbsp_get_rx_delay(unsigned int id);
>  int omap_mcbsp_get_dma_op_mode(unsigned int id);
> +int omap_mcbsp_set_dma_op_mode(unsigned int id, unsigned int mode);

This should have been here even in private form when the get function
was introduced. Let's wait for Peter's comment about op mode sysfs
functionality will we go with patch 4/4 or convert it to use this
function.

But anyway this patch is good to have.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
