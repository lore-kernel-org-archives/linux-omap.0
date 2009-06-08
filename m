From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] RX51: Add support for SDRAM chip select 1
Date: Mon, 8 Jun 2009 15:39:45 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2054552C17F@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1244462603-12793-1-git-send-email-tero.kristo@nokia.com>
 <200906081505.49935.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63108 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbZFHNlA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 09:41:00 -0400
In-Reply-To: <200906081505.49935.jpihet@mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jpihet@mvista.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Jean Pihet [mailto:jpihet@mvista.com] 
>Sent: 08 June, 2009 16:06
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] RX51: Add support for SDRAM chip select 1
>
>Hi Tero,
>
>You should also ensure that the CKE signals mux settings are 
>correct cf. an example for Overo at 
>http://patchwork.kernel.org/patch/28598/.

Our bootloader configures the pads, I just double checked that it also changes CKE pads to proper config.

The patch looks good otherwise? I tested this on RX51 HW and it works ok.

-Tero


>
>Note: the config option CONFIG_OMAP_MUX must be set for the 
>omap_cfg* functions to have any effect.
>
>Regards,
>Jean
>
>On Monday 08 June 2009 14:03:23 Tero Kristo wrote:
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Applies on top of PM branch.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/board-rx51.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51.c
>> b/arch/arm/mach-omap2/board-rx51.c index 3e4b7f8..7ab8a74 100644
>> --- a/arch/arm/mach-omap2/board-rx51.c
>> +++ b/arch/arm/mach-omap2/board-rx51.c
>> @@ -61,7 +61,11 @@ static struct omap_bluetooth_config 
>rx51_bt_config 
>> = {
>>
>>  static void __init rx51_init_irq(void)  {
>> -	omap2_init_common_hw(rx51_get_sdram_timings(), NULL,
>> +	struct omap_sdrc_params *sdrc_params;
>> +
>> +	sdrc_params = rx51_get_sdram_timings();
>> +
>> +	omap2_init_common_hw(sdrc_params, sdrc_params,
>>  			     omap3_mpu_rate_table,
>>  			     omap3_dsp_rate_table,
>>  			     omap3_l3_rate_table);
>
>
>