From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 10:03:22 -0700
Message-ID: <878wkrpuzp.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:52962 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbZETRDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 13:03:23 -0400
Received: by wf-out-1314.google.com with SMTP id 26so187798wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 10:03:24 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030574190F@dbde02.ent.ti.com> (Anand Gadiyar's message of "Wed\, 20 May 2009 11\:44\:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "V, Hemanth" <hemanthv@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Gadiyar, Anand" <gadiyar@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Hemanth V
>> Sent: Wednesday, May 20, 2009 11:27 AM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH 2/2] McSPI Slave and DMA,FIFO support
>> 
>> This patch adds MUX changes for SPI2 and also adds an
>> option for test driver
>> 
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-3430sdp.c   |   26 ++++++++++++++++++++++++++
>>  arch/arm/mach-omap2/mux.c             |   11 +++++++++++
>>  arch/arm/plat-omap/include/mach/mux.h |    7 +++++++
>>  3 files changed, 44 insertions(+)
>> 
>> Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
>> ===================================================================
>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:02:34.000000000 +0530
>> +++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2009-05-20 11:05:22.000000000 +0530
>> @@ -228,6 +228,13 @@
>>  	.single_channel	= 1,	/* 0: slave, 1: master */
>>  };
>> 
>> +#ifdef CONFIG_SPI_DEBUG
>> +static struct omap2_mcspi_device_config dummy_mcspi_config = {
>> +	.turbo_mode	= 0,
>> +	.single_channel	= 1,  /* 0: slave, 1: master */
>> +};
>> +#endif
>> +
>>  static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
>>  	[0] = {
>>  		/*
>> @@ -242,6 +249,18 @@
>>  		.irq			= 0,
>>  		.platform_data		= &tsc2046_config,
>>  	},
>> +#ifdef CONFIG_SPI_DEBUG
>> +	[1] = {
>> +		/* SPI test driver attached to SPI2 controller by
>> +		 * default
>> +		 */
>> +		.modalias		= "spitst",
>> +		.bus_num		= 2,
>> +		.chip_select		= 0,
>> +		.max_speed_hz		= 1500000,
>> +		.controller_data	= &dummy_mcspi_config,
>> +	},
>> +#endif
>>  };
>> 
>>  static struct platform_device sdp3430_lcd_device = {
>> @@ -666,6 +685,13 @@
>> 
>>  static void __init omap_3430sdp_init(void)
>>  {
>> +
>> +	/* SPI2 Pin MUX */
>> +	omap_cfg_reg(AA3_3430_McSPI2_CLK);
>> +	omap_cfg_reg(Y2_3430_McSPI2_SIMO);
>> +	omap_cfg_reg(Y3_3430_McSPI2_SOMI);
>> +	omap_cfg_reg(Y4_3430_McSPI2_CS0);
>> +
>
> This will still change the padconf for this port unconditionally.
>
> How do we handle the case where the same platform (SDP in this case)
> could have different configurations McSPI2 vs USBHOST2, etc? Is there
> a clean way, or do we have no option but to use a CONFIG option?

What about building both as modules and doing the muxing on module
load with a warning if it's taking the pins away from antother
feature.

Longer term, we need a more dynamic way to request pins when there are
conflicts like this.

Kevin

