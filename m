From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [PATCHv3 14/20] OMAP: McBSP: Let element DMA mode hit
 retention also
Date: Fri, 14 Aug 2009 07:40:50 +0300
Message-ID: <1250224850.16045.66.camel@eenurkka-desktop>
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
	 <13B9B4C6EF24D648824FF11BE89671620396DFE19D@dlee02.ent.ti.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58765 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZHNEkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 00:40:43 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620396DFE19D@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>

On Fri, 2009-08-14 at 05:19 +0200, ext Woodruff, Richard wrote:
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> 
> > The device no longer hits retention if element DMA
> > mode is taken for at least the duration of the
> > serial console timeout. Force element DMA mode to
> > shut down through smartidle.
> 
> Probably this behaves as you say but it seems possible that the bug is somewhere else in device handling.
> 

For some reason unknown to us, if NO_IDLE mode is taken,
and long enough of a arecord | aplay loop was tried (a minute or so),
then, and when closing the loop, the device never hit
retention anymore =) But after the fix, yes it does so.

> The generic hope is you can set smart-idle + wakeups at init time and never need to touch them again.  There are a few known cases where the hardware IP does have some bug which force you to dynamically play with bits.
> 

Right. I did try to set them initially at device init (that was one
of the first things I tried with McBSP), but things were not really
working as expected. (Well, having iclk and fclk on and putting those at
device init caused the whole HW device to jam).

Another thing is, that if the McBSP is a slave (external clocking),
then there will be unnecessary wakeups? If smart-idle + wakeups are
always set? (and the slave clocks the McBSP WCLK and BCLK). BTW, are
the wakeups active if McBSP is in reset state?

> Clockactivity settings are usually static also, but depending on how you configure your device (slave or master clocking) you will need to dynamically set these.

> It most you don't need all this dynamic twiddling of the idle protocol handshake bits.  Doing it once at pm_init is what should be necessary.

> One example which comes to mind is MMC with DMA mode.  Early drivers were finding RET was gated once the driver was active. In the first pass port to 3430 the writer toggled smart/no/forced idle and the system went happily back to sleep.  However, after some profiling it was seen that this method of putting the device down ended up causing the clock disable to the device to take a very long time.  Another level of digging into documents was done and it was found that it was necessary to reset some command line as part of a clean shut down.  Doing it this way allowed the system to idle, and the time to shut down clocks was just a few nS instead of uS.  As I recall some status was not cleared until the reset of the line.  It did happen that toggling through handshakes had a side effect of 
 also clearing it, but not in the intended way.

Whether a few uSec:s or nS:s, doesn't really matter in this case?
(if that even was the case).

> 
> Regards,
> Richard W.

