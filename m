From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Wed, 19 May 2010 19:50:37 +0300
Message-ID: <AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	 <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	 <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	 <AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	 <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	 <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	 <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	 <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	 <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52464 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab0ESQuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 12:50:39 -0400
Received: by fxm10 with SMTP id 10so2570236fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 09:50:38 -0700 (PDT)
In-Reply-To: <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 3:53 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, May 18, 2010 at 3:24 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>>> Cool. I actually tried your patches to render to the framebuffer, and
>>>> everything seemed to work fine. I didn't check for error codes or
>>>> anything, so I'm not sure what's going on.
>>>
>>> How is the framebuffer mmap'ed ?
>>
>> mmap(NULL, self->mem_info.size, PROT_WRITE, MAP_SHARED, self->overlay_fd, 0);
>>
>>> Can you please tell me more about this scenario ?
>>> (applications + drivers involved).
>>
>> I use gst-omapfb[1], and then it's very easy with a gst-launch command
>
> Ok, thanks. I think I know why it worked for you -
> The framebuffer is mmap'ed as uncacheable on ARM (check out
> fb_pgprotect in fbmem.c),
> which makes the whole dspbridge cache manipulations on it redundant.
> In our case the cache operations silently failed, but it didn't matter.

Indeed, although it's not uncacheable, it's writecombine. That explains a lot.

> We can probably just return whenever a dspbridge DMA operation will be
> requested on VM_IO buffers (unless there are other VM_IO dspbrdige use
> cases which are different).

I don't know what VM_IO means, but essentially we don't want to go
find each and page when we know the memory is contiguous. Although the
fact that the memory is writecombine would help us avoid unnecessary
flushes as well :)

A few updates:
1) libomxil-ti doesn't use the flush/inv ioctls at all... all buffers
are mapped/unmapped
2) I said only 4 buffers are mapped at a time. Actually, it's more
like 8 * 3 + 1. Most of these are 4K, although only a few bytes are
used.
4) I'm already doing the changes needed in gst-dsp.

Cheers.

-- 
Felipe Contreras
