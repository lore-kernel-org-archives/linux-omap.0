From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Fri, 21 May 2010 00:18:12 +0300
Message-ID: <AANLkTimnKJ9OQ51HDJJ3ctT10j1wk-wEYzrGE8vjHu_B@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	<r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	<AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.211.180]:38816 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab0ETVSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 17:18:33 -0400
Received: by ywh10 with SMTP id 10so190984ywh.1
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 14:18:32 -0700 (PDT)
In-Reply-To: <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Fri, May 14, 2010 at 10:27 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Also, I noticed an important problem. Your code assumes that we would
> always have a bunch of scattered pages,

Just a small note: the pages can be contiguous even in normal memory
allocation (not with framebuffer). That's perfectly ok and there's no
problem with that in the code.

> however you are not taking
> into account bridge_brd_mem_map() where vm_flags have VM_IO... in that
> case get_user_pages() is skipped completely. This code-path is
> important in order to mmap framebuffer memory, which is contiguous.
> So, in this case there are no pages too keep track at all.

I gave some thought to this, and I concluded that nothing needs to be
changed in the patches for this scenario.
You see, in this case, as you said, no pages were pinned in memory
using get_user_pages.
This is perfectly fine since the MM application writes to a physical
writecombine framebuffer memory which is not cached or swapped out.
If the MM application will try to begin a DMA operation on this memory
it will immediately fail because no related mapping will be found.
This should actually be the expected behavior in such case: there
really isn't a mapping to this buffer since there's no point to have
it in VM_IO memory, and applications should not even try to flush/inv
such memory: it's just redundant.

IOW, the support for this scenario is actually to have no support :
just return an error, which is what already happens.

Thanks,
Ohad.
