From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq
Date: Thu, 21 Jan 2010 13:10:19 +0530
Message-ID: <4B5804E3.5030206@ti.com>
References: <1264025953-4620-1-git-send-email-nm@ti.com> <1264025953-4620-2-git-send-email-nm@ti.com> <4B58046F.5050802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58503 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab0AUHka (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jan 2010 02:40:30 -0500
In-Reply-To: <4B58046F.5050802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Romit Dasgupta wrote:
>> diff --git a/arch/arm/mach-omap2/dspbridge.c b/arch/arm/mach-omap2/dspbridge.c
>> +
>>  static int __init dspbridge_init(void)
>>  {
>>  	struct platform_device *pdev;
>> @@ -48,6 +65,10 @@ static int __init dspbridge_init(void)
>>  	if (!pdev)
>>  		goto err_out;
>>  
>> +	err = get_opp_table(pdata);
>> +	if (err)
>> +		goto err_out;
>> +
>>  	err = platform_device_add_data(pdev, pdata, sizeof(*pdata));
>>  	if (err)
>>  		goto err_out;
>> @@ -60,6 +81,10 @@ static int __init dspbridge_init(void)
>>  	return 0;
>>  
>>  err_out:
>> +	kfree(pdata->mpu_speeds);
>> +	kfree(pdata->dsp_freq_table);
> Are we sure that pdata->dsp_freq_table is NULL before initialization?
> Looking at your second part of the patch. You seem to invoke kfree for
> pdata->dsp_freq_table even if pdata->dsp_freq_table is not allocated.
> So my question is :
missed the last part of the mail. If pdata->dsp_freq_table is NULL to start
with. This is ok. Otherwise this needs to be changed.
