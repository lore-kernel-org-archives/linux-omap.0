From: "Simon Braunschmidt" <sbraunschmidt.linuxlists@googlemail.com>
Subject: Re: framebuffer on 2430sdp, configuration and bug [RESOLVED]
Date: Mon, 5 May 2008 16:52:02 +0200
Message-ID: <1ee641e10805050752t691d2393g138d8f6e5bb9571f@mail.gmail.com>
References: <1ee641e10804250230q4e4a348dia5fe70652c25b5b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:62527 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbYEEOwE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 10:52:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so550078and.103
        for <linux-omap@vger.kernel.org>; Mon, 05 May 2008 07:52:02 -0700 (PDT)
In-Reply-To: <1ee641e10804250230q4e4a348dia5fe70652c25b5b3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

Just a follow-up on the SYNCLOST problem we are seeing with the
framebuffer driver.

It seems as if we only get SYNCLOST signal in the display controller
interrupt handler when we activate the ADS7846 touchscreen which is
connected via SPI. Maybe signal integrity is to blame, since both LCD
and touchscreen signal go over the same flat cable.

Problem is seen on 2.6.23-omap1 with CONFIG_SPI_OMAP24XX,
CONFIG_TOUCHSCREEN_ADS7846 and CONFIG_FB_OMAP enabled, configured for
2430sdp.

Can anyone comment on this issue?


BR
Simon Braunschmidt
2008/4/25 Simon Braunschmidt <sbraunschmidt.linuxlists@googlemail.com>:
> Hi Arun, all
>
>  I just switched to 2.6.23-omap1, which is booting with framebuffer.
>  Which recent kernel version would you recommend to get down and dirty
>  with Android on the 2430sdp?
>
>  btw 2.6.24-omap1 is booting for me on 2430sdp, but with not
>  framebuffer, though framebuffer gets registered according to kernel
>  bootlog and is now also usable with my testprogramm, just nothing on
>  the lcd
>
>  The bug we were seeing:
>
>  SYNCLOST .... something in dispc.c irq handler
>
>  disappeared, looking backwards this may be also related to our recent
>  switch to git for maintaining kernel sources. Maybe our selfhosted
>  sources got tainted by our half-baked patching  approaches, so sorry
>  for the noise...
>
>  Greetings, Gruessla
>  Simon
