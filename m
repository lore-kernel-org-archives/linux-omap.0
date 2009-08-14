From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCHv3 14/20] OMAP: McBSP: Let element DMA mode hit retention
 also
Date: Thu, 13 Aug 2009 22:19:17 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620396DFE19D@dlee02.ent.ti.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbZHNDTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 23:19:24 -0400
In-Reply-To: <1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin

> The device no longer hits retention if element DMA
> mode is taken for at least the duration of the
> serial console timeout. Force element DMA mode to
> shut down through smartidle.

Probably this behaves as you say but it seems possible that the bug is somewhere else in device handling.

The generic hope is you can set smart-idle + wakeups at init time and never need to touch them again.  There are a few known cases where the hardware IP does have some bug which force you to dynamically play with bits.

Clockactivity settings are usually static also, but depending on how you configure your device (slave or master clocking) you will need to dynamically set these.

It most you don't need all this dynamic twiddling of the idle protocol handshake bits.  Doing it once at pm_init is what should be necessary.

One example which comes to mind is MMC with DMA mode.  Early drivers were finding RET was gated once the driver was active. In the first pass port to 3430 the writer toggled smart/no/forced idle and the system went happily back to sleep.  However, after some profiling it was seen that this method of putting the device down ended up causing the clock disable to the device to take a very long time.  Another level of digging into documents was done and it was found that it was necessary to reset some command line as part of a clean shut down.  Doing it this way allowed the system to idle, and the time to shut down clocks was just a few nS instead of uS.  As I recall some status was not cleared until the reset of the line.  It did happen that toggling through handshakes had a side effect of al
 so clearing it, but not in the intended way.

Regards,
Richard W.
