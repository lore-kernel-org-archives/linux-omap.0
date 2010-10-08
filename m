From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Fri, 8 Oct 2010 11:18:20 +0300
Message-ID: <AANLkTikRWdw8NQinHmco6dp+XtEr5mr_7H8OBU6+FcB0@mail.gmail.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<4CADFCEB.4030008@ti.com>
	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
	<4CAE1CA1.4050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41275 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0JHISV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 04:18:21 -0400
Received: by fxm14 with SMTP id 14so273689fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 01:18:20 -0700 (PDT)
In-Reply-To: <4CAE1CA1.4050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>

On Thu, Oct 7, 2010 at 10:16 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> On 10/7/2010 1:22 PM, Felipe Contreras wrote:
> ...
>>
>> Note that the "shared memory" described in the document you share has
>> nothing to do with the SHM pool. AFAIK that memory is used for other
>> things, like MMU PTEs, and storing the base image and socket-nodes,
>> thus it needs to be contiguous.
>
> hmmm, no. it is the same memory. i.e.: we propagate the current opp through
> the shared memory so the dsp can read it if it went to sleep, with the
> proper offset you can read that variable starting from the mempool base
> address.

The document mentions "shared memory" for buffer passing, normal
memory is used for that, scattered, even user-space memory, not the
SHM contiguous area.

>> I don't see any problem flushing the SHM area when needed, which
>> probably has performance implications when mmaping/unmapping buffers,
>> at which point you need to flush bigger memory areas anyway, so that's
>> not an issue.
>
> well, you would have to flush when loading the base image, or allocating a
> socket node, but also minor flushes for opp propagation, SHM messages to
> DSP, chnl params, those are the ones I can quickly think of.

All those happen when you send buffers to the DSP, and when you do
that you need to flush the buffer memory area, which is a much heavier
operation. Except maybe the opp propagation, but that would require at
most one page to be flushed, not a big deal I think, besides, it would
be better if that specific area is handled differently than the rest
of the SHM, so that we can allocate it with dma_alloc_coherent().

Cheers.

-- 
Felipe Contreras
