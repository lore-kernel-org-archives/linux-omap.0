From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP
	registers for OMAP 2430/34xx
Date: Fri, 9 Jan 2009 13:46:01 +0200
Message-ID: <20090109114557.GH2536@atomide.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com> <20090108155718.GX27566@atomide.com> <2C7D3DF36ADFFC479B44490D912B616705A496D1E0@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56847 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZAILqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 06:46:04 -0500
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705A496D1E0@dlee07.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

* Lopez Cruz, Misael <x0052729@ti.com> [090108 19:43]:
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

Thanks, I'll add that to the commit in the omap-fixes queue.

Tony
