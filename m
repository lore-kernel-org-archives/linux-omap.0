From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: Re: Does omap git have support for overo board.
Date: Tue, 08 Feb 2011 18:08:33 +0530
Message-ID: <4D513949.1010905@e-consystems.com>
References: <4D512702.9040708@e-consystems.com> <DC9EC8FD-4BE1-48DB-B97F-7CAF1AEAA333@mac.com> <4D51366B.9040000@e-consystems.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:45240 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286Ab1BHMik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:38:40 -0500
In-Reply-To: <4D51366B.9040000@e-consystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, balbi@ti.com
Cc: linux-omap@vger.kernel.org

It works!
Thanks.


> Hi Elvis and balbi
>
>
> On Tuesday 08 February 2011 05:34 PM, Elvis Dowson wrote:
>>
>>> Hi all,
>>>
>>> I have pull the latest git from 
>>> "http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary". 
>>> But couldn't find config file for overo . So I used 
>>> "omap2plus_defconfig" and made sure the overo board is selected.
>>>
>>> But the board didn't boot. It stopped after uncompressing kernel .
>>>
>>> Bytes transferred = 3011064 (2df1f8 hex)
>>> ## Booting kernel from Legacy Image at 82000000 ...
>>>    Image Name:   Linux-2.6.38-rc2-13606-g448e9a6-
>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>>    Data Size:    3011000 Bytes =  2.9 MB
>>>    Load Address: 80008000
>>>    Entry Point:  80008000
>>>    Verifying Checksum ... OK
>>>    Loading Kernel Image ... OK
>>> OK
>>>
>>> Starting kernel ...
>>>
>>> Uncompressing Linux... done, booting the kernel.<---- Hangs after this.
>>>
>>> Does the mainline has the support for overo board. Or am I missing 
>>> something.
>> You'll have to change the bootargs to reflect the change in serial 
>> ports from ttyS to ttyO, that's why it appears to hang. This change 
>> was made to linux-2.6.37 onwards.
>>
>> Apart from that you will have to change the /etc/inittab file as 
>> follows:
>>
>> O:2345:respawn:/sbin/getty 115200 ttyO2
>>
>> Best regards,
>>
>> Elvis Dowson
>> -- 
> Thanks for the help.. I will try that...
>
