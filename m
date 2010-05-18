From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 15:53:16 +0300
Message-ID: <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	<AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	<AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	<AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	<AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	<AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	<AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	<AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	<AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:39109 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0ERMxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:53:37 -0400
Received: by gxk27 with SMTP id 27so3347947gxk.1
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 05:53:36 -0700 (PDT)
In-Reply-To: <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 3:24 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>>> Cool. I actually tried your patches to render to the framebuffer, and
>>> everything seemed to work fine. I didn't check for error codes or
>>> anything, so I'm not sure what's going on.
>>
>> How is the framebuffer mmap'ed ?
>
> mmap(NULL, self->mem_info.size, PROT_WRITE, MAP_SHARED, self->overlay_fd, 0);
>
>> Can you please tell me more about this scenario ?
>> (applications + drivers involved).
>
> I use gst-omapfb[1], and then it's very easy with a gst-launch command

Ok, thanks. I think I know why it worked for you -
The framebuffer is mmap'ed as uncacheable on ARM (check out
fb_pgprotect in fbmem.c),
which makes the whole dspbridge cache manipulations on it redundant.
In our case the cache operations silently failed, but it didn't matter.

We can probably just return whenever a dspbridge DMA operation will be
requested on VM_IO buffers (unless there are other VM_IO dspbrdige use
cases which are different).
