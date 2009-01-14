From: Tony Lindgren <tony@atomide.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Wed, 14 Jan 2009 17:28:07 +0200
Message-ID: <20090114152806.GP29324@atomide.com>
References: <1231921649.13843.171.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54399 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbZANP2H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 10:28:07 -0500
Content-Disposition: inline
In-Reply-To: <1231921649.13843.171.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Eero Nurkkala <ext-eero.nurkkala@nokia.com> [090114 12:05]:
> > >> - According to Jarkko Nikula, ASoC does not currently work because
> > >>  of some recent clock changes.
> 
> I would like to note, that currently there's no counterpart for this
> commit:
> 
> 3456ef483b5322ba4a7647f024e2c5b7846cd7e3
> 
> ARM: OMAP3: Enable writing to XCCR and RCCR McBSP registers for OMAP
> 2430/34xx
> 
> 
> You need to have the counterpart (in /sound/soc/omap/omap-mcbsp.c) for
> that patch, othwerwise there's no chance to hear any DMA transferred
> audio.

Jarkko, can you post the patch queued up for alsa? We might want to
have that in linux-omap too.

Tony
