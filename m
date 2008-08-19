From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: Re: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [1/2]
Date: Tue, 19 Aug 2008 18:11:45 -0300
Message-ID: <65e025470808191411j92ed0cbhc47ea4f2e707671c@mail.gmail.com>
References: <7B4574D56E4ADF438756313E9A172A870D5F0E58@dlee01.ent.ti.com>
	 <20080813135721.GC27446@atomide.com>
	 <20080814091329.bcb2755e.jarkko.nikula@nokia.com>
	 <7B4574D56E4ADF438756313E9A172A870D6651CF@dlee01.ent.ti.com>
	 <20080815111216.5dcf2a0d.jarkko.nikula@nokia.com>
	 <7B4574D56E4ADF438756313E9A172A870D6E0641@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:37077 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYHSVLr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 17:11:47 -0400
Received: by rn-out-0910.google.com with SMTP id k40so115596rnd.17
        for <linux-omap@vger.kernel.org>; Tue, 19 Aug 2008 14:11:46 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A870D6E0641@dlee01.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Jon,

I applied both yours and Jarkko's patch here and can confirm that it's
working on the OSK5912. Compiled and running with no problems. Thanks
guys!

The AIC23 is detected fine, but I'm still having some issues with
underruns though, when trying to play an audio file. Don't know what
could be the problem. Always getting a choppy sound output.

root@DEA /opt/audios # aplay -Ll
default:CARD=AIC23
    OSK AIC23, omap alsa pcm
    Default Audio Device
null
    Discard all samples (playback) or generate zero samples (capture)
**** List of PLAYBACK Hardware Devices ****
card 0: AIC23 [OSK AIC23], device 0: OMAP PCM [omap alsa pcm]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

root@OSK5912 /opt/audios # aplay Front_Center.wav
Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Mono
underrun!!! (at least 0.366 ms long)

I'll test some more by tomorrow and inform you of any progress.

Cheers

---
Yuri Jaeger Monti
