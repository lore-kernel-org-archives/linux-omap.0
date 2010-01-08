From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 8/8] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Fri, 8 Jan 2010 12:53:18 -0600
Message-ID: <4B477F1E.2010309@ti.com>
References: <1262912461-30151-1-git-send-email-omar.ramirez@ti.com> <4B469FA0.8000106@ti.com> <4B46A22D.1010507@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DC952BE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54541 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab0AHSx1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 13:53:27 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DC952BE@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/08/2010 11:19 AM, the following:
>> From: Menon, Nishanth
>>
>> Apologies on the spam, but a few points below for preventing a future
>> ioctl change:
>>
>> Menon, Nishanth had written, on 01/07/2010 08:59 PM, the following:
>>> Ramirez Luna, Omar had written, on 01/07/2010 07:01 PM, the following:
>>>> - Use standard convention to define ioctls.
>> please warn in the commit message that this will break compatibility.
>>
> 
> Will do
Thanks.
> 
>>>> - Removed runtime check for ioctl matching table number.
>>>> - Added __deprectaed marker to functions that are not used anymore.
>> generic idea:
>>  	if (cmd < ARRAY_SIZE(WCD_cmdTable)) {
>>  		/* make the fxn call via the cmd table */
>>  		*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
>> if you convert this into:
>>  	if (!WCD_cmdTable[cmd].fxn)
>> 		return -EINVAL;
>>  	/* make the fxn call via the cmd table */
>>  	*pResult = (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
>> you'd make deprecation of a previously defined ioctl easy -> just NULL
>> and remove the function  in the array and remove it and it's unused
>> helper functions.. :)..
> 
> Problem comes if you are expecting some status value from that function
-EINVAL is an error value. are there status values that match it?
Actually looking at
include/asm-generic/errno.h
-ENOSYS seems more apt :D.

if there are functions that are sending error values as valid return 
values, heh heh.. I guess we can expect more patches ;).

> 
>>
>> one generic question - I did not see an features/ioctls supported around
>> - having not dug enough, how does the userspace know if the bridge uses
>> the new ioctls/old ioctls?
> 
> Patch will be sent to userspace repository on dev.omapzoom.org... 
 >the idea is to support this set of ioctls from now on... overall I don't
 >think I got your question
Try 2:

lets say I want to write an gst-dsp which will run accross bridge that 
was there before and now - how do i do it? I need to know if I should 
use the new ioctl numbers OR the old ioctl numbers to dspbridge 
something like DSPBRIDGE_GET_REV or DSPBRIDGE_GET_CAPS

result of this tells userspace "aah here is a bridge rev "x" or bridge 
has capabilities "abc" - do I support it? hmm.. let me check.. well :( I 
dont.. print "sorry dude.. i dont support this rev of bridge.. tata"..

> 
> [snip]
> 
> - omar


-- 
Regards,
Nishanth Menon
