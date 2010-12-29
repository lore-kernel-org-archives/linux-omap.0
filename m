From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 13:59:24 +0200
Message-ID: <20101229115924.GA2222@legolas.emea.dhcp.ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
 <1293623571.3451.51.camel@odin>
 <20101229115628.GB3017@opensource.wolfsonmicro.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50787 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab0L2L7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 06:59:30 -0500
Received: by eyf6 with SMTP id 6so4502321eyf.41
        for <linux-omap@vger.kernel.org>; Wed, 29 Dec 2010 03:59:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101229115628.GB3017@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, balbi@ti.com, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Wed, Dec 29, 2010 at 11:56:28AM +0000, Mark Brown wrote:
>> In this case though the other McBSP user afaik is DaVinci, so in this
>> case it does make sense to make this driver support both.
>
>The other thing with McBSP is that it's a generic programmable serial
>port and so need not be tied to audio use (though as I understand it
>other uses are very rare).

So why is it still tied to OMAP-only ? There's no abstraction layer
around McBSP so OMAP McBSP driver has to export a whole bunch of symbols
for its users:

$ git grep -e EXPORT_SYMBOL arch/arm/*omap*/*mcbsp*.c
arch/arm/mach-omap2/mcbsp.c:EXPORT_SYMBOL(omap2_mcbsp1_mux_clkr_src);
arch/arm/mach-omap2/mcbsp.c:EXPORT_SYMBOL(omap2_mcbsp1_mux_fsr_src);
arch/arm/mach-omap2/mcbsp.c:EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_config);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_st_set_chgain);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_st_get_chgain);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_st_enable);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_st_disable);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_st_is_enabled);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_max_tx_threshold);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_tx_delay);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_rx_delay);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_set_io_type);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_request);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_free);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_start);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_stop);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_pollwrite);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_pollread);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_xmit_word);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_recv_word);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_spi_master_xmit_word_poll);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_spi_master_recv_word_poll);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_xmit_buffer);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_recv_buffer);
arch/arm/plat-omap/mcbsp.c:EXPORT_SYMBOL(omap_mcbsp_set_spi_mode);

-- 
balbi
