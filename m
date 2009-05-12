From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Wed, 13 May 2009 00:22:31 +0300
Message-ID: <94a0d4530905121422q5ff8cdb2m900bccb031f1eb9b@mail.gmail.com>
References: <1242017713-25795-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1242017713-25795-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF668B1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:48950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZELVWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 17:22:32 -0400
Received: by fg-out-1718.google.com with SMTP id 16so84453fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 14:22:31 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AF668B1@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 12, 2009 at 2:21 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Felipe,
>
>>
>> IMHO the only sensible way to approach this is to create a new ioctl
>> for a special restrictive mapping where user-space specifies if the
>> memory area is read-only or write-only and the size must be the real
>> size. This also has advantage that it does not break legacy
>> applications.
>
> -- How are you planning to inform LCML about choosing this new ioctl as opposed to the regular one? Any ways, I think the ulMapAttr flag in DSPProcessor_Map function can be extended to provide the information about read-only or write-only. The only issue is with this we can enforce the checks on only the applications that set this check and it will not cover the buffer alignment issues with the applications that don't enforce this check.

Inform?

LCML can use the new ioctl by simply using it:
ioctl(handle, <new id>, <new arg>)

>>While we are at it, this new mapping could do
>> PROC_ReserveMemory at the same time so that the user-space application
>> doesn't get a chance to modify the pa.
>>
> -- What does PROC_ReserveMemory has to do with pa ?

Sorry, I don't know what kind of address PROC_ReserveMemory returns
(va?), but I don't see any point in having PROC_ReserveMemory and
PROC_Map as separate ioctls


-- 
Felipe Contreras
