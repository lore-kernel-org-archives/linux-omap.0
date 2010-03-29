From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for
 OMAP1510 to work correctly with recent ALSA PCM code
Date: Mon, 29 Mar 2010 11:54:59 +0300
Message-ID: <20100329115459.b44f0d1c.jhnikula@gmail.com>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:50538 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789Ab0C2Iw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Mar 2010 04:52:27 -0400
Received: by ewy22 with SMTP id 22so1740437ewy.37
        for <linux-omap@vger.kernel.org>; Mon, 29 Mar 2010 01:52:25 -0700 (PDT)
In-Reply-To: <201003282229.32922.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, 28 Mar 2010 22:29:29 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> With recent (2.6.34) chnages in PCM handling, capture stopped working on my 
> OMAP1510 based Amstrad Delta videophone.
> 
> Using 2.6.34-rc2, I was able to correct the problem in 3 different ways:
> 
> 1. reverting commit 7b3a177b0d4f92b3431b8dca777313a07533a710,
> 2. enabling additional jiffies check with
> 	echo 4 >/proc/asound/card0/pcm0c0/xrun_debug
> 3. applying the patch below.
> 
> Since I wasn't able to reproduce the problem on my i686 PC, I guess the 
> problem is probably machine specific.
> 
> The patch reuses the method for software emulation of missing hardware 
> pointer, already implemented for playback on OMAP1510. It's possible that 
> event if a hardware pointer is available for capture on this machine, its 
> behaviour may be not compatible with what upper layer expects.
> 
> If you think the problem may be more general and should be solved differently, 
> on a higher level, I can try to work more on it if you give me a hint.
> 
I don't have anything against this patch as it makes the
playback/capture code uniform on 1510 but I don't understand why the
capture broke now if it was working before.

What I was thinking if there has been always some overruns which were
not detected on 2.6.34-rc anymore and that caused somehow the capture
not working on 1510. Could you try does a patch below have any effect?

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/026487.html


-- 
Jarkko
