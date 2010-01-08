From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 8/8] DSPBRIDGE: Use _IOxx macro to define ioctls
Date: Fri, 8 Jan 2010 12:45:10 -0600
Message-ID: <4B477D36.3010205@ti.com>
References: <1262912461-30151-1-git-send-email-omar.ramirez@ti.com> <4B469FA0.8000106@ti.com> <27F9C60D11D683428E133F85D2BB4A53042DC9529F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58780 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab0AHSpN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 13:45:13 -0500
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53042DC9529F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Ramirez Luna, Omar had written, on 01/08/2010 11:11 AM, the following:
>> From: Menon, Nishanth
>>
>> Ramirez Luna, Omar had written, on 01/07/2010 07:01 PM, the following:
>>> - Use standard convention to define ioctls.
>>> - Removed runtime check for ioctl matching table number.
>>> - Added __deprectaed marker to functions that are not used anymore.
>>>
>>> Currently 'DB' is used as identifier for dspbridge.
>>              ^^
>> include/asm-generic/ioctl.h
>> #define _IOC(dir,type,nr,size) \
>>         (((dir)  << _IOC_DIRSHIFT) | \
>>          ((type) << _IOC_TYPESHIFT) | \
>>          ((nr)   << _IOC_NRSHIFT) | \
>>          ((size) << _IOC_SIZESHIFT))
>>
>> define _IOWR(type,nr,size)
>> _IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
>> should'nt type be a single char?
> 
> Actually its meant to be 0xDB... I'll change this
ok..

> 
>>> Added TODOs for removing the function table and, deprecated
>>> and not implemented ioctls, this can be done when all the ioctls
>>> are accessed through a switch instead of a pointer to function.
>>>
>>> *** NOTE: An update in api ioctl definitions is required. ***
>> Overall strategy:
>> as an example:
>> MGR_ENUMNODE_INFO was offset 0,
>> so, WCD_cmdTable had entry to point it to this as a map to
>> MGRWRAP_EnumNode_Info
>> now,
>> WCD_cmdTable[0] = MGRWRAP_EnumNode_Info which is referenced off cmd
>> parameter in (*WCD_cmdTable[cmd].fxn) (args, pr_ctxt);
>>
>> IMHO, _IOWR -> to mark a ioctl, good idea. indexing off
>> WCD_cmdTable[cmd] to grab the caller - not exactly my fav idea. esp if
>> you need to introduce newer ioctls in the middle.
>>
>> Now that you are breaking IOCTL number compatibility altogether,
>>
>> a) why cant' we split the list into multiple ones? +
>> #define MGR_BASE 'M'
>> #define MGR_ENUMNODE_INFO      _IOWR(MGR_BASE, 0, unsigned long)
> 
> Documentation/ioctl/ioctl-number.txt, didn't have time to check if outdated
yep
> 
> 'M'     all     linux/soundcard.h
> 
>> ..
>> ..
>>
>> #define PROC_BASE 'P'
>> #define PROC_ATTACH            _IOWR(PROC_BASE, 0, unsigned long)
> 
> 'P'     all     linux/soundcard.h
> 
>> ..
>> ..
>>
>> #define NODE_BASE 'N'
>> #define NODE_ALLOCATE          _IOWR(NODE_BASE, 0, unsigned long)
> 
> 'N'     00-1F   drivers/usb/scanner.h
EB onwards to DD seems to be free.
alright.. Please try and use consequtive ones from 0xD0,D1,D2,D3 etc.. 
choose something if you dont like conflicts ;). I'd think that these are 
ioctls for /dev/DspBridge anyways.. shrug.. you could even add a patch 
in the series to create Documentation/arm/OMAP/DspBridge and Document 
info if you like :).

> 
>> and so on..
>> b) then, you can populate different arrays for each type with the handlers.
>> based on
>> switch(_IOC_TYPE())
>>       case NODE_BASE: cmd_array= node_base_cmd_array; break;
>> ..
>>
>> this will allow you to add to any of these without having to be worried
>> about causing backward incompatibility.
>>
>> I guess given the number of handler's we gotta live with an array
>> anyways.. but we can at least reduce it's impact.. just my 2cents..
> 
> Given the current shape of the driver, I don't know why we would want to add more ioctls, 
 >others than to simplify some of its operations (like combining reserve 
and map)...
 >and if so, then it wouldn't have a name like PROC_RESERVE_N_MAP nor 
fit in between.
that is the point -we are trying to improve it. We did not know few 
years back that you would be sending this patch right? flexibility is 
easy thing to have if you do what I mention here, adding/deprecating an 
IOCTL without impact to userspace is important.

[...]
-- 
Regards,
Nishanth Menon
