From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 14:57:39 +0300
Message-ID: <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	<AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	<AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	<AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	<AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	<AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	<AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	<AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48403 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab0ERL6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:58:00 -0400
Received: by gyg13 with SMTP id 13so2723742gyg.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 04:57:59 -0700 (PDT)
In-Reply-To: <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 2:43 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, May 18, 2010 at 2:14 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>>> Unfortunately I don't have a setup right now to test this, but the code
>>>> seems to be ok for our needs, don't you think ?
>>>
>>> But yeah, actually that fits our needs; calling the dma_map only,
>>> while still wrong, will give us the same behavior we have right now
>>> (v2.6.33).
>>
>> Great, so are you ok with this patchset proposal ?
>
> I thought you were going to add separate ioctls, one for dma_map, and
> another for dma_unmap that receive direction as an argument. Then, map
> the current PROC_FLUSH/INVALIDATE to those without changing their
> semantics, but marking them as deprecated.

Yes, I am (this and a few other small stuff we mentioned in the
threads) - I was just asking generally about the move to dma_(un)map_*
API.

Anyway, I'll prepare a v2 and resubmit.

>
>> I'll just add support for the VM_IO path you mentioned.
>
> Cool. I actually tried your patches to render to the framebuffer, and
> everything seemed to work fine. I didn't check for error codes or
> anything, so I'm not sure what's going on.

How is the framebuffer mmap'ed ?

Can you please tell me more about this scenario ?
(applications + drivers involved).

How do I test this scenario ? using the tools you sent me ?
Do I have to have a beagle board or will ZOOM do ?

Thanks,
Ohad.


>
> --
> Felipe Contreras
>
