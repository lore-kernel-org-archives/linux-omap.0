From: Nishanth Menon <nm@ti.com>
Subject: Re: Patches merged to split OMAP2_IO_ADDRESS
Date: Thu, 8 Oct 2009 18:19:09 -0500
Message-ID: <4ACE736D.6060504@ti.com>
References: <20091008002506.GF29320@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D268@dbde02.ent.ti.com> <20091008180801.GI7417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44426 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755994AbZJHXTs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Oct 2009 19:19:48 -0400
In-Reply-To: <20091008180801.GI7417@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Tony Lindgren had written, on 10/08/2009 01:08 PM, the following:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [091008 03:59]:
>> Tony,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Tony Lindgren
>>> Sent: Thursday, October 08, 2009 5:55 AM
>>> To: linux-omap@vger.kernel.org
>>> Cc: Paul Walmsley
>>> Subject: Patches merged to split OMAP2_IO_ADDRESS
>>>
>>> Hi all,
>>>
>>> I've pushed Santosh' patches to split OMAP2_IO_ADDRESS into
>>> *_L3_IO_ADDRESS
>>> and *_L4_IO_ADDRESS so we can claim more kernel address space and support
>>> over 512MB of memory instead of 256MB.
>>>
>>> Of course, our goal is to convert everything except the .S files to
>>> use ioremap() instead, but that can now be done parallel and in smaller
>>> chunks.
>>>
>>> Please everybody, please convert your code to use ioremap(), there are
>>> static mappings already in place so it should work out of the box.
>>>
>>> I also had add two quick patches to keep things compiling,
>>> Paul can you take a look at them? I could not really test them as all
>>> the code is not there yet. Will post them as a reply to this thread.
>> Thanks for the merge!!
>>
>> I have boot tested below platforms with latest LO master.
>>  
>> 1. OMAP3430 SDP board - BOOT OK
>> 2. OMAP3 BEAGLE 	- BOOT OK
>> 3. OMAP 4430 SDP - BOOT OK with variation of patch: http://patchwork.kernel.org/patch/50531/
> 
> Great. I guess we still have some issues on 24xx with the hwmod,
> but hopefully we'll get that working again soon.
> 
> Can somebody with 512MB memory on a board try the current l-o master
> and make sure things work?
http://pastebin.mozilla.org/675489
3630 board with SDPdefconfig +8250 hack (with 3430 OPP values + wrong 
GPIOs) -> boots up mostly fine..
Regards,
Nishanth Menon
