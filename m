From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: L-O master branch broken ?
Date: Thu, 18 Jun 2009 20:17:10 +0530
Message-ID: <006701c9f023$aa55a170$LocalHost@wipultra793>
References: <00eb01c9eff8$13dba760$LocalHost@wipultra793> <20090618075257.GF8482@atomide.com> <011e01c9f000$fc86f8e0$LocalHost@wipultra793> <20090618102237.GI8482@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40325 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbZFROrV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2009 10:47:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Hemanth V" <hemanthv@ti.com>
Cc: "Kevin Hilman" <khilman@deeprootsystems.com>; 
<linux-omap@vger.kernel.org>
Sent: Thursday, June 18, 2009 3:52 PM
Subject: Re: L-O master branch broken ?


>* Hemanth V <hemanthv@ti.com> [090618 13:39]:
>> ----- Original Message ----- From: "Tony Lindgren" <tony@atomide.com>
>>
>>
>>>> I get the below error while compiling 3430SDP. I see below commit  as 
>>>> the
>>>> latest one.
>>
>>>
>>> Thanks, pushing a fix right now with the missing brace missing from
>>> Kevin's
>>> sram.c patch. Also moved around the defines so sram.c build for omap1.
>>>
>>
>> Booting still seems to have problems. Its hung after start kernel
>>
>>
>> Bytes transferred = 2480664 (25da18 hex)
>> ## Booting image at 80000000 ...
>>   Image Name:   Linux-2.6.30-omap1-06022-g6f4712
>>   Image Type:   ARM Linux Kernel Image (uncompressed)
>>   Data Size:    2480600 Bytes =  2.4 MB
>>   Load Address: 80008000
>>   Entry Point:  80008000
>>   Verifying Checksum ... OK
>> OK
>>
>> Starting kernel ...
>>
>
> Can you see what happens with DEBUG_LL enabled?

Doesn't seem to show any additional messages even with
DEBUG_LL enabled 

