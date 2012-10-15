From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Mon, 15 Oct 2012 18:08:05 +0200
Message-ID: <CAFqH_52fKOb1OAqK3O-PkT6j69OOeEF-8LoQg-U+u4dH51V82Q@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
	<5077F771.9080308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58720 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab2JOQIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 12:08:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4990558pad.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 09:08:05 -0700 (PDT)
In-Reply-To: <5077F771.9080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

Hi Tomi,

Thanks for your answer.

2012/10/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On 2012-10-11 18:58, Enric Balletbo Serra wrote:
>> Hi all,
>>
>> I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
>> tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
>> changes the panel driver used on some boards. I tested current
>> linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
>> following error (see http://pastebin.com/VjPGCQDt for full log) :
>>
>>    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>>    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be 0
>>    [   21.236236] omapfb omapfb: setup_plane failed
>>
>> Before checking what happens there is a known issue with this ?
>
> Works fine for me, although only with a quite minimal test environment.
>

I tried with a minimal environment (without X) and I don't see the
error, so looks you've reason and the problem is with my userspace
application (X). OTOH, I don't see the video output. I remember that
this worked before, but seems now is broken. I'll check mux and others
hints to try to solve the problem ..

> Looking at the log, it looks to me that your userspace is trying to
> configure the overlays, and that somehow leads to the driver getting
> zero as the fb address.
>
> I'm guessing that some wrong value is passed when configuring, or
> missing some step in configuring. However, It should be the omapfb that
> rejects configuration that would lead to paddr == 0, not omapdss, so
> there's definitely bug in the error handling of omapfb.
>
> Can you tell me more what's going on there? I presume the error happens
> when booting? What userspace component is using omapfb in your setup? X?

Yes, the error occurs while booting, and the rootfs tries to load X server.

>
> If you can, put some debug prints into omapfb-ioctl.c:omapfb_setup_plane
> to see what code path it takes, and where it goes wrong.
>

First I'll try to get video output without X, then, if you want I can
debug this problem if you think it's interesting.

Regards,
    Enric
