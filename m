From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 10/11] omap hsmmc: fix the hsmmc driver for am3517.
Date: Tue, 13 Apr 2010 16:06:02 +0300
Message-ID: <4BC46C3A.2010708@nokia.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com> <1271151270-13038-2-git-send-email-stanley.miao@windriver.com> <4BC46B9B.3070207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61508 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab0DMNGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 09:06:18 -0400
In-Reply-To: <4BC46B9B.3070207@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "madhu.cr@ti.com" <madhu.cr@ti.com>

Adrian Hunter wrote:
> Stanley.Miao wrote:
>> am3517 don't have the register OMAP343X_CONTROL_PBIAS_LITE and the regulators
>> like "vmmc", so we don't need set "set_power" function for it.

<snip>

>> @@ -216,6 +216,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>>  		 */
>>  		mmc->slots[0].ocr_mask = c->ocr_mask;
>>  
>> +#ifndef CONFIG_MACH_OMAP3517EVM
> 
> ifdef CONFIG_MACH_OMAP3517EVM
> 
> 
> 
> 

That "ifdef CONFIG_MACH_OMAP3517EVM" was an accident, sorry.  Please ignore.


