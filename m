From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [HELP] Audio on BeagleBoard xM can't work
Date: Tue, 15 Mar 2011 11:53:15 +0200
Message-ID: <20110315115315.bcd2451b.jhnikula@gmail.com>
References: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60275 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1COJvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 05:51:09 -0400
Received: by ewy4 with SMTP id 4so113465ewy.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 02:51:08 -0700 (PDT)
In-Reply-To: <AANLkTikMCttrVTS==b2j9VyvSSz+WzoBg8dZ-nb4QUaN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lars@metafoo.de, paul@pwsan.com, peter.ujfalusi@nokia.com

On Tue, 15 Mar 2011 11:12:17 +0800
Bob Liu <lliubbo@gmail.com> wrote:

> It seems that the code in sound/soc/omap/omap-mcbsp.c uses the function
> "cpu-is-omap343x()" which fails and returns ENODEV.
> 
> But I have enabled "OMAP3430 support" in "System Type" / "TI OMAP2/3/4
> Specific Features",
> why it still return ENODEV? (Attached my kernel config).
> 
> And after I changed that check to "cpu-is-omap34xx()", there was no
> error message but neither any audio output,
> I can't hear any sound.
> ----------------------------

Is the DMA running after you change the cpu_is_omap34xx and try to play
e.g. "aplay /dev/urandom"? If audio is running you should see DMA
interrupt count increasing with "grep DMA /proc/interrupts".

If that is working then issue could be in codec side. I don't have a
beagle at the moment to verify but IRCC something like ~10 TWL4030 ALSA
controls must be adjusted in order to route audio from DAC to outputs
at proper volume.

-- 
Jarkko
