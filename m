From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Tue, 18 May 2010 15:24:11 +0300
Message-ID: <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <AANLkTindMySAOe6UG_hRoCvjIuPZdyg2nNe-Gub9pwau@mail.gmail.com>
	 <AANLkTikLfEQB0mtbOXIrxTj68LoY9EcSn86su6OJW8ev@mail.gmail.com>
	 <AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	 <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	 <AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	 <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	 <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	 <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60109 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab0ERMYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:24:13 -0400
Received: by fxm10 with SMTP id 10so1020363fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 18 May 2010 05:24:11 -0700 (PDT)
In-Reply-To: <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Tue, May 18, 2010 at 2:57 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, May 18, 2010 at 2:43 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>> I'll just add support for the VM_IO path you mentioned.
>>
>> Cool. I actually tried your patches to render to the framebuffer, and
>> everything seemed to work fine. I didn't check for error codes or
>> anything, so I'm not sure what's going on.
>
> How is the framebuffer mmap'ed ?

mmap(NULL, self->mem_info.size, PROT_WRITE, MAP_SHARED, self->overlay_fd, 0);

> Can you please tell me more about this scenario ?
> (applications + drivers involved).

I use gst-omapfb[1], and then it's very easy with a gst-launch command
(part of GStreamer):

 gst-launch filesrc location=video.avi ! avidemux ! dspvdec ! omapfbsink

> How do I test this scenario ? using the tools you sent me ?
> Do I have to have a beagle board or will ZOOM do ?

I guess you would need to modify dsp-tools to use framebuffer memory.
Or you can do what I do and use gst-dsp + gst-omapfb.

I don't have a zoom, so I haven't tried, but gst-dsp should work on
any platform, and I have tried to make gst-omapfb the same, although
YMMV.

You could also try these binaries:
http://people.freedesktop.org/~felipec/dsp/gst-omap-test.tar.bz

Put on any system, on /opt/gst, and then PATH=/opt/gst/bin.

Cheers.

[1] http://github.com/felipec/gst-omapfb
[2] http://people.freedesktop.org/~felipec/beagle-2.6.32-rc3/

-- 
Felipe Contreras
