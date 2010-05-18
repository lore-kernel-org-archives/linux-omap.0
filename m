From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 14:43:25 +0300
Message-ID: <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	 <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	 <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	 <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	 <AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	 <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:27685 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab0ERLnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 07:43:32 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1028598fge.1
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 04:43:26 -0700 (PDT)
In-Reply-To: <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 2:14 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> Unfortunately I don't have a setup right now to test this, but the code
>>> seems to be ok for our needs, don't you think ?
>>
>> But yeah, actually that fits our needs; calling the dma_map only,
>> while still wrong, will give us the same behavior we have right now
>> (v2.6.33).
>
> Great, so are you ok with this patchset proposal ?

I thought you were going to add separate ioctls, one for dma_map, and
another for dma_unmap that receive direction as an argument. Then, map
the current PROC_FLUSH/INVALIDATE to those without changing their
semantics, but marking them as deprecated.

> I'll just add support for the VM_IO path you mentioned.

Cool. I actually tried your patches to render to the framebuffer, and
everything seemed to work fine. I didn't check for error codes or
anything, so I'm not sure what's going on.

-- 
Felipe Contreras
