From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Fri, 21 May 2010 09:14:20 +0300
Message-ID: <AANLkTimeUwfnmj5pcabFuqGKZ2ExEcf-GPopGDjeV-XB@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	 <AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	 <AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	 <AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	 <AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	 <AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	 <AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	 <AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
	 <AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59618 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243Ab0EUGWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 02:22:18 -0400
Received: by fxm5 with SMTP id 5so497267fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 23:22:16 -0700 (PDT)
In-Reply-To: <AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Fri, May 21, 2010 at 12:22 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, May 19, 2010 at 7:50 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> I don't know what VM_IO means, but essentially we don't want to go
>> find each and page when we know the memory is contiguous. Although the
>> fact that the memory is writecombine would help us avoid unnecessary
>> flushes as well :)
>
> Yes, I guess you can remove those calls from the application :)

Can't. From GStreamer point of view the decoder is independent of the
renderer, so we have no way to know that. Perhaps if the memory map
operation returned some information we can avoid those calls.

>> A few updates:
>> 1) libomxil-ti doesn't use the flush/inv ioctls at all... all buffers
>> are mapped/unmapped
>
> I'm not following libomxil-ti but I guess they count on the flushing
> that happens when the buffers are mapped (as part of the
> get_user_pages call)

Yes, initially they were doing flushes, and so was gst-dsp, but I
found that little trick (not sure if they copied the trick or found it
themselves, but I did suggest it). Unfortunately gst-dsp is a bit
smarter and doesn't do constant memory mapping for the control buffers
(very small), which means we do clean/inv. For the data buffers (big
ones) we have to rely on constant memory mapping due to GStreamer
design, so we rely on get_user_pages(), although writebacks are not
needed for output buffers, and neither inv for the input ones, but I'm
not sure how much would be the gain.

Cheers.

-- 
Felipe Contreras
