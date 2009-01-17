From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP
 registers for OMAP 2430/34xx
Date: Sat, 17 Jan 2009 00:09:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901170006140.5091@utopia.booyaka.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com> <20090108155718.GX27566@atomide.com> <2C7D3DF36ADFFC479B44490D912B616705A496D1E0@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46784 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZAQHJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 02:09:33 -0500
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A496D1E0@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, sakoman@gmail.com

On Thu, 8 Jan 2009, Lopez Cruz, Misael wrote:

> > * Lopez Cruz, Misael <x0052729@ti.com> [081219 04:53]:
> > > This patch enables writing to McBSP Transmit Configuration Control 
> > > Register (XCCR) and Receive Configuration Control Register 
> > (RCCR) for 
> > > 2430/34xx platforms. It also adds XCCR, RCCR entries in 
> > McBSP register 
> > > configuration structure and bit definitions for both registers.
> >
> > Pushing to l-o. Can you briefly describe what happens with 
> > ASoC if these registers are not used? We may be able to send 
> > this as a fix to mainline during the -rc cycle.
> 
> If we enable the writing to those registers for 2430/34xx and don't set the default values (setting 0 as a consequence) in ASoC driver, the Transmit/Receive DMA mode gets disabled and the the transmission/reception doesn't happen, ending with a "write error: Input/Output error" when playing with 'aplay'.
> 
> -Misa--

Something is wrong with this patch, at least on Beagle.  When 
starting audio playback, there is a 
several second pause, then a console message:

ALSA sound/core/pcm_native.c:1493: playback drain error (DMA or IRQ 
trouble?)

No audio emerges from the board.

With this patch reverted, a very basic audio test here seems to work.


- Paul
