From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 8/9 v2] omap3: pm: introduce dynamic OPP
Date: Sun, 15 Nov 2009 08:20:07 -0600
Message-ID: <4B000E17.8070500@ti.com>
References: <1258092322-30833-1-git-send-email-nm@ti.com>	<1258092322-30833-2-git-send-email-nm@ti.com>	<1258092322-30833-3-git-send-email-nm@ti.com>	<1258092322-30833-4-git-send-email-nm@ti.com>	<1258092322-30833-5-git-send-email-nm@ti.com>	<1258092322-30833-6-git-send-email-nm@ti.com>	<1258092322-30833-7-git-send-email-nm@ti.com>	<1258092322-30833-8-git-send-email-nm@ti.com>	<1258092322-30833-9-git-send-email-nm@ti.com> <87hbsxnb7z.fsf@deeprootsystems.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:65087 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbZKOOUA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 09:20:00 -0500
Received: by ywh40 with SMTP id 40so2447759ywh.33
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 06:20:05 -0800 (PST)
In-Reply-To: <87hbsxnb7z.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jon-hunter@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, SuiLun Lam <s-lam@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Kevin Hilman said the following on 11/13/2009 07:31 PM:
[...]
>> +void __init omap3_pm_init_opp_table(void)
>> +{
>> +	/* Populate the base CPU rate tables here */
>> +	omap3_mpu_rate_table = kmalloc(sizeof(omap34xx_mpu_rate_table),
>> +			GFP_KERNEL);
>> +	omap3_dsp_rate_table = kmalloc(sizeof(omap34xx_dsp_rate_table),
>> +			GFP_KERNEL);
>> +	omap3_l3_rate_table = kmalloc(sizeof(omap34xx_l3_rate_table),
>> +			GFP_KERNEL);
>> +
>> +	BUG_ON(!omap3_mpu_rate_table || !omap3_dsp_rate_table ||
>> +		!omap3_l3_rate_table);
>> +
>> +	memcpy(omap3_mpu_rate_table, omap34xx_mpu_rate_table,
>> +			sizeof(omap34xx_mpu_rate_table));
>> +	memcpy(omap3_dsp_rate_table, omap34xx_dsp_rate_table,
>> +			sizeof(omap34xx_dsp_rate_table));
>> +	memcpy(omap3_l3_rate_table, omap34xx_l3_rate_table,
>> +			sizeof(omap34xx_l3_rate_table));
>> +}
>> +
>>     
>
> Minor issue, but FYI... rather than the kmalloc + memcpy, you can use
> kmemdup() to do the same thing
thanks.
Regards,
Nishanth Menon
