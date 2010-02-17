From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] dspbridge: proc: fix a double-free on 2 error paths
Date: Wed, 17 Feb 2010 09:52:25 -0600
Message-ID: <4B7C10B9.3050103@ti.com>
References: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com> <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com> <4B7B3728.60105@ti.com> <20100217131245.GE463@pcarmody-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab0BQPwa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Feb 2010 10:52:30 -0500
In-Reply-To: <20100217131245.GE463@pcarmody-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/17/2010 7:12 AM, Phil Carmody wrote:
> On 17/02/10 01:24 +0100, ext Omar Ramirez Luna wrote:
>> On 2/12/2010 10:26 AM, Phil Carmody wrote:
>>> From: Phil Carmody<ext-phil.2.carmody@nokia.com>
>>>
>>> We free in the tail cleanup, so don't free before jumping there.
>>>
>>> Signed-off-by: Phil Carmody<ext-phil.2.carmody@nokia.com>
>>> ---
>>
>> [...]
>>>    	}
>>> +
>>> +	/* paranoid - must be able to kfree this on remaining error paths */
>>> +	pProcObject->g_pszLastCoff = NULL;
>>> +
>>
>> do we need this? afaik it should be NULL at this point, because of
>> kmalloc + memset (which btw should be replaced by kzalloc).
>
> I suspected it wasn't. I confess I was a little bit rushed when
> looking at that.
>
>> i.e:
>> MEM_AllocObject(pProcObject, struct PROC_OBJECT, PROC_SIGNATURE);
>> ->  MEM_Calloc(sizeof(Obj), MEM_NONPAGED);
>> ->	pMem = kmalloc(...)
>> 	if (pMem)
>> 		memset(pMem, 0, cBytes);
>
> i.e. kzalloc().
>
>>>    	/* Get the default executable for this board... */
>>>    	DEV_GetDevType(hDevObject, (u32 *)&devType);
>>>    	pProcObject->uProcessor = devType;
>> [...]
>>
>> Regards,
>
> I can resend without, if you like, whatever's simplest for you.
>

No worries, I'll remove from original.

Regards,

Omar

