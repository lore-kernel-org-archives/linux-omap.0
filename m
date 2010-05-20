From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Fri, 21 May 2010 00:22:37 +0300
Message-ID: <AANLkTikamXrz9kwL6OhO2-llzU51WpGSn91UZOnlkBki@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	<AANLkTilMrSeEv1pzlGwdLg4mFADzkUX9LgV8Co4QIm7V@mail.gmail.com>
	<AANLkTimwAMbz8kSSW5OvQHvfskvM9auqYRq13GO2hBv_@mail.gmail.com>
	<AANLkTingzOiLETDW9gCNK1W6OVrWZx0ltREJVDYXFcMt@mail.gmail.com>
	<AANLkTil9tD1EAn-8ldMmMpLU8osiiwaGf1hF19VO0Q7R@mail.gmail.com>
	<AANLkTil7Mfi15ADpjK7XQn5vDaihjv8fjU2AMzO9swET@mail.gmail.com>
	<AANLkTin9Fe4qWoxUKlZvQ7RuTRDTka9QmcP_ATe-jgVa@mail.gmail.com>
	<AANLkTimmvjlsgRmjn7NokL4RnXU8nRA-D2pbCJwJ3axk@mail.gmail.com>
	<AANLkTiktBVZx5ZFbU49w0IsfuUbdWD5XDsHVgmBpE9Fv@mail.gmail.com>
	<AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42192 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab0ETVW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 17:22:58 -0400
Received: by gwaa20 with SMTP id a20so156371gwa.19
        for <linux-omap@vger.kernel.org>; Thu, 20 May 2010 14:22:57 -0700 (PDT)
In-Reply-To: <AANLkTil-R_R66WxbLRjFp7uHBtQ6-FNLgifqyka0NIQh@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Hi Felipe,

On Wed, May 19, 2010 at 7:50 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I don't know what VM_IO means, but essentially we don't want to go
> find each and page when we know the memory is contiguous. Although the
> fact that the memory is writecombine would help us avoid unnecessary
> flushes as well :)

Yes, I guess you can remove those calls from the application :)

>
> A few updates:
> 1) libomxil-ti doesn't use the flush/inv ioctls at all... all buffers
> are mapped/unmapped

I'm not following libomxil-ti but I guess they count on the flushing
that happens when the buffers are mapped (as part of the
get_user_pages call)

> 2) I said only 4 buffers are mapped at a time. Actually, it's more
> like 8 * 3 + 1. Most of these are 4K, although only a few bytes are
> used.

Ok, thanks for the update. This still sounds like a small number that
doesn't require overkill data structures.

> 4) I'm already doing the changes needed in gst-dsp.

Great! I briefly looked at the patches and they seem very nice.

Thanks a lot,
Ohad.


>
> Cheers.
>
> --
> Felipe Contreras
>
