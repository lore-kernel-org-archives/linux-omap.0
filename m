From: "Simon Braunschmidt" <sbraunschmidt.linuxlists@googlemail.com>
Subject: Re: framebuffer on 2430sdp, configuration and bug [RESOLVED]
Date: Fri, 25 Apr 2008 11:30:03 +0200
Message-ID: <1ee641e10804250230q4e4a348dia5fe70652c25b5b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:44189 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759150AbYDYJaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 05:30:04 -0400
Received: by an-out-0708.google.com with SMTP id d31so926933and.103
        for <linux-omap@vger.kernel.org>; Fri, 25 Apr 2008 02:30:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: linux-omap@vger.kernel.org, Ronny.Lampert@teleca.com, arthur.mielimonka@teleca.com

Hi Arun, all

I just switched to 2.6.23-omap1, which is booting with framebuffer.
Which recent kernel version would you recommend to get down and dirty
with Android on the 2430sdp?

btw 2.6.24-omap1 is booting for me on 2430sdp, but with not
framebuffer, though framebuffer gets registered according to kernel
bootlog and is now also usable with my testprogramm, just nothing on
the lcd

The bug we were seeing:

SYNCLOST .... something in dispc.c irq handler

disappeared, looking backwards this may be also related to our recent
switch to git for maintaining kernel sources. Maybe our selfhosted
sources got tainted by our half-baked patching  approaches, so sorry
for the noise...

Greetings, Gruessla
Simon

2008/4/25, arun c <arun.edarath@gmail.com>:
> On Fri, Apr 25, 2008 at 12:35 PM, Simon Braunschmidt
>  <sbraunschmidt.linuxlists@googlemail.com> wrote:
>  > >
>  >  >
>  >  > It's wrapped and you need to add some spaces before %s in all of them
>  >  >  :-p
>  >  >
>  >  >  In any case, this is only for testing purpose, i think it shouldn't be
>  >  >  applied. I don't have lcd working on 3430sdp as well but never look at
>  >  >  it.
>  >  >
>  >  >
>  >
>  >  Ya i have seen its wrapped, stupid google webmailer wrapping my precious code!
>  >  Anyways, patch is just to get the extra debug output, that is actually
>  >  bothering me.
>  >
>  >
>
> > --
>  >  To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>  >  the body of a message to majordomo@vger.kernel.org
>  >  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  >
>
>  Hi,
>
>  For me also v2.6.24-omap1 is not booting on 2430SDP
>  In my case it fails in the panel enable
>       r = fbdev->panel->enable(fbdev->panel);
>
>  Due to some twl4030 related issue r gets -ve return
>  value and fb initialization fails.
>
>  twl4030 keypad also not working..
>
>  I have checked the hardware with the 2.6.14 kernel
>  from ti site.
>
>  I think problem is with twl2430 driver
>
>  Regards,
>
> Arun c
>
