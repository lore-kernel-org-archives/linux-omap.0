From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH] SDRC: Remove SDRC_POWER register configuration from
 SDRC init.
Date: Thu, 18 Jun 2009 08:03:45 +0200
Message-ID: <62697B07E9803846BC582181BD6FB6B80D704A359D@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
 <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27057 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759699AbZFRGEx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 02:04:53 -0400
In-Reply-To: <alpine.DEB.2.00.0906171021120.3382@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dderrick@ti.com, r-woodruff2@ti.com, rnayak@ti.com, Artem.Bityutskiy@nokia.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com


Hi, 

Perhaps someone from TI could comment that. I'm not sure if I can share
errata information for public discussion.

Br,
Samu

>-----Original Message-----
>From: ext Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: 17 June, 2009 19:25
>To: Onkalo Samu.P (Nokia-D/Tampere); Bityutskiy Artem 
>(Nokia-D/Helsinki)
>Cc: linux-omap@vger.kernel.org; Tony Lindgren
>Subject: Re: [PATCH] SDRC: Remove SDRC_POWER register 
>configuration from SDRC init.
>
>Hello Samu, Artem,
>
>On Wed, 17 Jun 2009, Artem Bityutskiy wrote:
>
>> From: Samu Onkalo <samu.p.onkalo@nokia.com>
>> 
>> Bootloader must configure proper settings for SDRC before starting 
>> kernel from SDRAM. Furthermore, removed lines violated omap3430 and 
>> omap2420 SDRC errata (see errata 1.150)
>
>The 2420 and 3430 errata data here seems to be old; neither 
>one contains 1.150.  While I wait for a new version to arrive, 
>can you provide some more context on this errata?  Does it 
>imply any restrictions on programming SDRC_POWER from SRAM, 
>e.g., the CORE DVFS code?
>
>
>- Paul
>
>> 
>> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/sdrc.c |   10 ++--------
>>  1 files changed, 2 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c 
>> index 2045441..0874687 100644
>> --- a/arch/arm/mach-omap2/sdrc.c
>> +++ b/arch/arm/mach-omap2/sdrc.c
>> @@ -86,8 +86,8 @@ void __init omap2_set_globals_sdrc(struct 
>omap_globals *omap2_globals)
>>   * @sp: pointer to a null-terminated list of struct omap_sdrc_params
>>   *
>>   * Turn on smart idle modes for SDRAM scheduler and controller.
>> - * Program a known-good configuration for the SDRC to deal 
>with buggy
>> - * bootloaders.
>> + * Bootloaders should make proper configuration for SDRC 
>since kernel
>> + * is running from SDRAM.
>>   */
>>  void __init omap2_sdrc_init(struct omap_sdrc_params *sp)  { @@ 
>> -104,10 +104,4 @@ void __init omap2_sdrc_init(struct 
>omap_sdrc_params *sp)
>>  	sdrc_write_reg(l, SDRC_SYSCONFIG);
>>  
>>  	sdrc_init_params = sp;
>> -
>> -	/* XXX Enable SRFRONIDLEREQ here also? */
>> -	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
>> -		(1 << SDRC_POWER_PWDENA_SHIFT) |
>> -		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
>> -	sdrc_write_reg(l, SDRC_POWER);
>>  }
>> --
>> 1.6.0.6
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>> 
>
>
>- Paul
>