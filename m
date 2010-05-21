From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Fri, 21 May 2010 12:42:55 +0300
Message-ID: <AANLkTim9HXNk-9P_lGtGy32lLQrVl2bfN-qKTY5Qm9xR@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	 <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	 <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	 <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	 <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	 <AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
	 <AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
	 <AANLkTimeUwfnmj5pcabFuqGKZ2ExEcf-GPopGDjeV-XB@mail.gmail.com>
	 <AANLkTimAZLGNQsOCqHsk5QbbquIoDIYCtIW2NJqVcoup@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43971 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab0EUJn5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 05:43:57 -0400
Received: by bwz7 with SMTP id 7so71588bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 02:43:55 -0700 (PDT)
In-Reply-To: <AANLkTimAZLGNQsOCqHsk5QbbquIoDIYCtIW2NJqVcoup@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Fri, May 21, 2010 at 11:22 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, May 21, 2010 at 9:14 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, May 21, 2010 at 12:22 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> On Wed, May 19, 2010 at 7:50 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> I don't know what VM_IO means, but essentially we don't want to go
>>>> find each and page when we know the memory is contiguous. Although the
>>>> fact that the memory is writecombine would help us avoid unnecessary
>>>> flushes as well :)
>>>
>>> Yes, I guess you can remove those calls from the application :)
>>
>> Can't. From GStreamer point of view the decoder is independent of the
>> renderer, so we have no way to know that.
>
> Can you please elaborate on this a little ?

GStreamer has a plug-in architecture. So one plug-in (libgstdsp.so)
issues a request for a zero-copy buffer (gst_pad_alloc_buffer()) to
the next element in the chain. We don't know who that is, nor care,
and there might be elements in the middle that pass the buffer along.

The memory could be part of the framebuffer, or randomly allocated by
user-space. One element (omapxvimagesink) might always return memory
from omapfb, another one (omapfbsink), might allocate a separate
buffer if all the omapfb memory is being used currently.

In the end, the decoder element has no idea about that. Just the
GstBuffer which has a data pointer, and a size, and that's it.

There are even more complicated use-cases like video recording
directly on the framebuffer. Other pluggable MM frameworks like
OpenMAX IL would have similar problems.

>> Perhaps if the memory map
>> operation returned some information we can avoid those calls.
>
> I don't think it should; relying on the map call to tell us what type
> of buffer we just gave it smells like a bad interface. After all, it
> is the application who originally called mmap() to get access to that
> buffer, so it already knows if it's a framebuffer of not.

Well, requesting DMA operations from user-space is already bad
interface. It's the job of the driver to do that.

Due to bad design of the driver we'll have to do them, but if there's
a way to know if such operations are redundant or not, it would have
to be returned through map call, otherwise we'll be wasting ioctl
calls.

> Anyway it's not that an important optimization to do: the ioctl will
> just fail. The negative side is that the application will have no way
> to know if this is really a failure (did I just give a wrong buffer
> address to dspbridge ?) or not (oh it's the framebuffer, there's no
> mapping for that).

Exactly; we will not know when operations fail. But also, ioctl()
calls would be wasted.

> Performance-wise, it's better than the previous implementation which
> would have executed redundant cache operation on the buffer.

Indeed.

Although I'm still worried that VM_IO != write-combine, but I guess
it's a safe assumption to do for now.

Cheers.

-- 
Felipe Contreras
