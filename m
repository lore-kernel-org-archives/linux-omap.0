From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] rpmsg: compute number of buffers to allocate from vrings
Date: Tue, 12 Aug 2014 18:30:42 +0300
Message-ID: <CAK=WgbaRJNVXqbM+MyY+UtUYYCnR2t3CP5UdTXSpLJy=MTJKJQ@mail.gmail.com>
References: <1404420815-42108-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36801 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbaHLPbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2014 11:31:03 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so7129901igb.14
        for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2014 08:31:02 -0700 (PDT)
In-Reply-To: <1404420815-42108-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Suman,

On Thu, Jul 3, 2014 at 11:53 PM, Suman Anna <s-anna@ti.com> wrote:
> The buffers to be used for communication are allocated during
> the rpmsg virtio driver's probe, and the number of buffers is
> currently hard-coded to 512. Remove this hard-coded value, as
> this can vary from one platform to another or between different
> remote processors. Instead, rely on the number of buffers the
> virtqueue vring is setup with in the first place.

Is there a specific problem you bumped into which you are fixing with
this approach? Can you please describe it?

I'm concerned that coupling the vring size with coherent memory
allocated by rpmsg may not be safe. It'd also be an implicit side
effect that may surprise users, so let's consider our alternatives.

Thanks,
Ohad.
