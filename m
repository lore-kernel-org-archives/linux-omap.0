From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Fri, 07 Jan 2011 08:04:13 -0600
Message-ID: <4D271D5D.4080702@ti.com>
References: <1294405659-25662-1-git-send-email-premi@ti.com> <4D27162E.6070203@ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930248202128@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36751 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751233Ab1AGOET (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 09:04:19 -0500
Received: by mail-gy0-f170.google.com with SMTP id 2so10321143gyf.15
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 06:04:18 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930248202128@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote, on 01/07/2011 07:50 AM:
>> -----Original Message-----
>> From: Menon, Nishanth
>> Sent: Friday, January 07, 2011 7:04 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
>>
>> Sanjeev Premi wrote, on 01/07/2011 07:07 AM:
>>> +		if (omap3_has_720mhz()) {
>>> +			pr_info("Enabled OPP corresponding to
>> 720MHz\n");
>>> +
>>> +			omap34xx_opp_def_list[INDEX_MPU_720MHZ]
>>> +				.default_available = true;
>>> +			omap34xx_opp_def_list[INDEX_IVA_720MHZ]
>>> +				.default_available = true;
>> for many reasons, I dont like this indexing - I am ok with
>> most part of
>> the patch otherwise - how about opp_enable(dev, freq) instead?
>
> I had thought about it, but opp_enable would have to be done after
> omap_init_opp_table(). Two factors led me to current implementation:
>
> 1) Numer of lines of code required to get same thing done one the
>     opp table has been initialized.
>
> 2) The index definition and usage are localized in same file.

right - i will leave it to kevin to comment - IMHO both will work, 
though (1) might be a little more elgant and resistant to future changes 
to the table (I am not sure if there would be any, but what the heck.)

-- 
Regards,
Nishanth Menon
