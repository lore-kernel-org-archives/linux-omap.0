From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/5] ASoC: omap-mcbsp: Place correct
 constraints for streams
Date: Tue, 1 Jun 2010 14:20:47 +0300
Message-ID: <20100601142047.c6a549a8.jhnikula@gmail.com>
References: <1275293810-31984-1-git-send-email-peter.ujfalusi@nokia.com>
	<201006011119.30651.peter.ujfalusi@nokia.com>
	<20100601122921.6d842ae8.jhnikula@gmail.com>
	<201006011330.11044.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:59503 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0FALSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 07:18:23 -0400
Received: by ewy8 with SMTP id 8so1181801ewy.28
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 04:18:22 -0700 (PDT)
In-Reply-To: <201006011330.11044.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Girdwood <lrg@slimlogic.co.uk>

On Tue, 1 Jun 2010 13:30:10 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Because, if you want to transfer in one SDMA burst more than the space free in 
> the McBSP FIFO, than where would the rest go?
> 
I would have expected peripheral to deassert the DMA request but I
haven't read the TRM so detail and experimenting with bigger period
sizes didn't work so some /dev/null effect was obviously happening :-)

> I guess it could be better than having 128 word long periods on McBSP1, 3, 4, 
> and 5. With small period size the applications also need to be woken up, but if 
> we silently handling the DMA IRQs, and the application is only woken up by every 
> 10. DMA IRQ, it might still save some power?
> 
This is worth to experiment. Probably more interrupts with or without
application wakeup reduction does not increase power as much as the
savings are from core clocks being more idle.


-- 
Jarkko
