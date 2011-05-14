From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 13 May 2011 19:47:33 -0700
Message-ID: <BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
	<201105121401.44607.peter.ujfalusi@ti.com>
	<4DCC2A48.7070602@gmail.com>
	<201105130859.12477.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55584 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab1ENCrf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 22:47:35 -0400
Received: by fxm17 with SMTP id 17so2112275fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 19:47:33 -0700 (PDT)
In-Reply-To: <201105130859.12477.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On Thu, May 12, 2011 at 10:59 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On Thursday 12 May 2011 21:43:20 Steve Calfee wrote:
>> Since it is set to 0xF0F, doesn't this set it as master?
>
> Sorry, that is correct, McBSP is configured as msater.
>
>> Also, spelunking the kernel sources, I cannot seem to find the source
>> for mcbsp_data->regs -- do you know where it gets set initially?
>
> They configured within sound/soc/omap/omap-pcm.c
>
> Have you configured the clk source, and divider correctly for McBSP port from
> the machine driver (with snd_soc_dai_set_sysclk)?
>

Hi, Thanks for the suggestions.

I think I have it correct. I was able to load the original
sound/soc/beagleboard.c and the codec/twl4030 and play a wav file. I
have been copying that to try and get my new codec driver to work. One
immediate difference is that the system sets up the twl4030 as the
master i2s device on the bus. So I changed my codec over to do that
too. Now the mcbsp register dump matches the working setup.

I put in a few debug statements. It appears that my DMA never gets
started. I know it can work with a different machine and codec driver,
but not mine. I don't see any explicit DMA init, but that must be the
problem.  Any more ideas?

Thanks, Steve
