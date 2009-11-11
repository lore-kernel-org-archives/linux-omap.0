From: "Romero, Felipe" <felipe.romero@ti.com>
Subject: RE: [PATCH] Disable headset jack detection for SDP3430
Date: Wed, 11 Nov 2009 09:27:29 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A219B0@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E602A6A21602@dlee06.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE447FEB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60185 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbZKKP1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 10:27:18 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nABFRN2L011496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:27:23 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id nABFRNE3023425
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:27:23 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nABFRNfo014200
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 09:27:23 -0600 (CST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE447FEB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Wednesday, November 11, 2009 8:36 AM
> To: Romero, Felipe; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] Disable headset jack detection for SDP3430
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Romero, Felipe
>> Sent: Tuesday, November 10, 2009 11:24 PM
>> To: linux-omap@vger.kernel.org
>> Subject: [PATCH] Disable headset jack detection for SDP3430
>> 
>> From: Felipe Romero <felipe.romero@ti.com>
>> 
>> This patch Disable headset jack detection for SDP3430 boards,
>> to avoid CPU kernel utilization.
>
>[sp] I was wondering if you have measured savings in the
>     cpu utilization.
>
>Best regards,
>Sanjeev

I just measured with the Top tool but the percentage of cpu is consumed 
By the event[0] for more that 90%, and with the patch this factor is 
Totally reduced. 
   

>> ---
>>  sound/soc/omap/sdp3430.c |   11 ++++++-----
>>  1 files changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
>> index b719e5d..3ef489e 100644
>> --- a/sound/soc/omap/sdp3430.c
>> +++ b/sound/soc/omap/sdp3430.c
>> @@ -196,8 +196,8 @@ static int sdp3430_twl4030_init(struct 
>> snd_soc_codec *codec)
>>  	/* SDP3430 connected pins */
>>  	snd_soc_dapm_enable_pin(codec, "Ext Mic");
>>  	snd_soc_dapm_enable_pin(codec, "Ext Spk");
>> -	snd_soc_dapm_disable_pin(codec, "Headset Mic");
>> -	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
>> +	snd_soc_dapm_enable_pin(codec, "Headset Mic");
>> +	snd_soc_dapm_enable_pin(codec, "Headset Stereophone");
>>  
>>  	/* TWL4030 not connected pins */
>>  	snd_soc_dapm_nc_pin(codec, "AUXL");
>> @@ -217,7 +217,7 @@ static int sdp3430_twl4030_init(struct 
>> snd_soc_codec *codec)
>>  	ret = snd_soc_dapm_sync(codec);
>>  	if (ret)
>>  		return ret;
>> -
>> +#if 0
>>  	/* Headset jack detection */
>>  	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
>>  				SND_JACK_HEADSET, &hs_jack);
>> @@ -231,7 +231,7 @@ static int sdp3430_twl4030_init(struct 
>> snd_soc_codec *codec)
>>  
>>  	ret = snd_soc_jack_add_gpios(&hs_jack, 
>> ARRAY_SIZE(hs_jack_gpios),
>>  				hs_jack_gpios);
>> -
>> +#endif
>>  	return ret;
>>  }
>>  
>> @@ -328,9 +328,10 @@ module_init(sdp3430_soc_init);
>>  
>>  static void __exit sdp3430_soc_exit(void)
>>  {
>> +#if 0
>>  	snd_soc_jack_free_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
>>  				hs_jack_gpios);
>> -
>> +#endif
>>  	platform_device_unregister(sdp3430_snd_device);
>>  }
>>  module_exit(sdp3430_soc_exit);
>> -- 
>> 1.6.0.4
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
