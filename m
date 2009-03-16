From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE Fix for auto image load updated
Date: Mon, 16 Mar 2009 16:27:54 +0200
Message-ID: <49BE61EA.8000206@nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A90DFDE6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32746 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZCPO1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 10:27:54 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A90DFDE6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ramesh" <grgupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Ramesh,

ext Gupta, Ramesh wrote:
> Ameya,
>  
> 
>>>  
>> Hi Ramesh,
>>
>> I am not clear about the issue which this patch fixes.
>> As I understand that:
>>
>> 1. You have increased the count for 
>> pdata->mpu_speed[i] = vdd1_rate_table_bridge[i].rate;
>>
>> 2. Moved driverContext = DSP_Init(&initStatus) after 
>> clk_notifier_register stuff.
> 
> These 2 changes fix the issue.
> 
>> 3. Coding Style cleanups.
> 
> This is to fix only the checkpatch warnings.
> 
>> I am not able to understand what this patch is fixing and how?
>> Some explanation about this will be helpful.
> 
> Clock registration is called after DSP_Init mistakenly , the image autoloading loads PROC_Load
> Inturn that calls for OPP boosting while loading the image , this fails as the clock registration is not called.
> 
> There was a typo in filling the platform data (5 instead of 6) because of that, the OPP5 frequency value is not updated, that causes WARN_ON()
> In the SRF.
> 
> Please let me know if you need any more information on these changes.
> 
> Thanks
> Ramesh Gupta G

Just by looking at the patch these things were not clear to me.
Thanks a lot for your quick reply :)

Cheers,
Ameya.
