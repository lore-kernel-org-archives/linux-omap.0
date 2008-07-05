From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Sat, 05 Jul 2008 09:25:42 +0200
Message-ID: <486F21F6.7020208@googlemail.com>
References: <486BDD2A.5070500@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com> <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:12043 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYGEHZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jul 2008 03:25:56 -0400
Received: by nf-out-0910.google.com with SMTP id d3so441446nfc.21
        for <linux-omap@vger.kernel.org>; Sat, 05 Jul 2008 00:25:54 -0700 (PDT)
In-Reply-To: <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>

Koen Kooi wrote:
> 
> Op 2 jul 2008, om 22:03 heeft Gadiyar, Anand het volgende geschreven:
> 
>>> At Beagle IRC there was some discussion [1] [2] today about kernel
>>> hang on OMAP3 based Beagle board. I'll try to summarize discussion  and
>>> Khasim's findings, maybe somebody here has an idea.
>>>
>>> Latest OMAP git kernel seems to hang on beagle board after some time.
>>> You don't see any crash, but after a while typing, anything doesn't
>>> work. SD stops as well, so you can only do stuff that's in ram, any  IO
>>> will block. It can take >1 day to get there, but mostly it's ~30  
>>> minutes.
>>>
>>> Khasim found that it seems disabling RTC will remove the hang. When
>>> booting the git kernel after some time there are no timer or PRCM
>>> interrupts and the control resides in cpu_idle. We don't know where
>>> exactly the problem in RTC is, but while browsing the history of  files
>>> related to RTC Khasim found that some changes were done to the files
>>> to handle T2 interrupts in a centralized way for USB, Battery and  RTC.
>>> It seems even Battery broke with this patch set
>>>
>>> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=68d7477caca19c0b52b5d4e85700cd3e6115577f 
>>>
>>>
>>> May be this is the change that is affecting RTC. But it's unclear why
>>> it is affecting GP timer and PRCM interrupts.
>>>
>>> Any idea?
>>>
>>> Thanks and please correct if something is wrong in the summary
>>>
>>> Dirk
>>
>>
>> Khasim also found that T2 RTC is not enabled by default in 3430sdp
>> defconfig, but it appears to be enabled in the beagleboard defconfig.
>> Maybe you can get by by simply disabling T2 RTC in menuconfig for now?
> 
> 
> Tried that and I get the same hang, so I don't think the RTC is to  blame.

Short update just in case anybody has an idea:

Gadiyar spent some time with git-bisect (thanks!):

It seems that the bad commit is probably between:
# good: [3ffec4e18484c34838fa341de3848306c29ecd5d] 24XX: PM: Move pm.c 
to pm24xx.c
and sleep.S to sleep24xx.S
and # bad: [458776cfe389ff03bd6c56c47e059df0778cdfca] OMAP3430SDP: 
Enable config
options CONFIG_OMAP_RESET_CLOCKS and CONFIG_SUSPEND

This is a 9-patch series by Jouni Hogander related to suspend and 
power-management.

Dirk


