From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: L-O master branch broken ?
Date: Thu, 18 Jun 2009 08:31:33 -0700
Message-ID: <87tz2dsgmi.fsf@deeprootsystems.com>
References: <00eb01c9eff8$13dba760$LocalHost@wipultra793>
	<20090618075257.GF8482@atomide.com>
	<011e01c9f000$fc86f8e0$LocalHost@wipultra793>
	<20090618102237.GI8482@atomide.com>
	<006701c9f023$aa55a170$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:23005 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbZFRPbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 11:31:53 -0400
Received: by wf-out-1314.google.com with SMTP id 26so574348wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 08:31:55 -0700 (PDT)
In-Reply-To: <006701c9f023$aa55a170$LocalHost@wipultra793> (Hemanth V.'s message of "Thu\, 18 Jun 2009 20\:17\:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Tony Lindgren" <tony@atomide.com>
> To: "Hemanth V" <hemanthv@ti.com>
> Cc: "Kevin Hilman" <khilman@deeprootsystems.com>;
> <linux-omap@vger.kernel.org>
> Sent: Thursday, June 18, 2009 3:52 PM
> Subject: Re: L-O master branch broken ?
>
>
>>* Hemanth V <hemanthv@ti.com> [090618 13:39]:
>>> ----- Original Message ----- From: "Tony Lindgren" <tony@atomide.com>
>>>
>>>
>>>>> I get the below error while compiling 3430SDP. I see below commit
>>>>> as the
>>>>> latest one.
>>>
>>>>
>>>> Thanks, pushing a fix right now with the missing brace missing from
>>>> Kevin's
>>>> sram.c patch. Also moved around the defines so sram.c build for omap1.
>>>>
>>>
>>> Booting still seems to have problems. Its hung after start kernel
>>>
>>>
>>> Bytes transferred = 2480664 (25da18 hex)
>>> ## Booting image at 80000000 ...
>>>   Image Name:   Linux-2.6.30-omap1-06022-g6f4712
>>>   Image Type:   ARM Linux Kernel Image (uncompressed)
>>>   Data Size:    2480600 Bytes =  2.4 MB
>>>   Load Address: 80008000
>>>   Entry Point:  80008000
>>>   Verifying Checksum ... OK
>>> OK
>>>
>>> Starting kernel ...
>>>
>>
>> Can you see what happens with DEBUG_LL enabled?
>
> Doesn't seem to show any additional messages even with
> DEBUG_LL enabled 

Since you don't even see 'Uncompressing Linux....', I'm guessing you
have CONFIG_OMAP_LL_DEBUG_UART3=y in your .config

Try setting this to UART1.

Kevin


