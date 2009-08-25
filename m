From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: SDP support seems broken in LO
Date: Tue, 25 Aug 2009 14:21:32 +0300
Message-ID: <4A93C93C.3000303@nokia.com>
References: <ce9ab5790908180519t644723cbw6876901066f1f213@mail.gmail.com> 	<EAF47CD23C76F840A9E7FCE10091EFAB02B9DCC60E@dbde02.ent.ti.com> 	<ce9ab5790908180558m184fd48euece1093575160c0c@mail.gmail.com> 	<5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C0A@dbde02.ent.ti.com> <ce9ab5790908180610l20ebdb5bw458616c409ddba94@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49338 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbZHYLVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Aug 2009 07:21:54 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309BD5C1F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: vimal singh <vimal.newwork@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Gadiyar, Anand wrote:
> <snip>
> 
>> Here is the log after enabling 'CONFIG_DEBUG_LL':
>>
>> ## Booting image at 80000000 ...
>>    Image Name:   Linux-2.6.31-rc5-omap1-05896-ge0
>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>    Data Size:    2303384 Bytes =  2.2 MB
>>    Load Address: 80008000
>>    Entry Point:  80008000
>>    Verifying Checksum ... OK
>> OK
>>
>> Starting kernel ...
>>
>> Uncompressing Linux.........................................................
>> ...........................................................................................
>> done, booting the kernel.
>> <5>Linux version 2.6.31-rc5-omap1-05896-ge087f6f-dirty
>> (x0094262@omaplinux2) (gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #7 Tue Aug 18 18:38:47 IST 2009
> 
> And here's the problem - you're using CodeSourcery's 2007q3 toolchain.
> This has been discussed in the past on this list. I don't know exactly
> what causes the problem or what fixes this.

To know more about this see the discussion in this thread
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12363.html

> 
> Move to 2008q3 or 2009q1 as a workaround.
> 
> - Anand
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

