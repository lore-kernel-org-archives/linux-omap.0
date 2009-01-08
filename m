From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: Enable writing to XCCR and RCCR McBSP
	registers for OMAP 2430/34xx
Date: Thu, 8 Jan 2009 11:43:33 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A496D1E0@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705A484AAD4@dlee07.ent.ti.com>
 <20090108155718.GX27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41183 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbZAHRnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 12:43:46 -0500
In-Reply-To: <20090108155718.GX27566@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

> * Lopez Cruz, Misael <x0052729@ti.com> [081219 04:53]:
> > This patch enables writing to McBSP Transmit Configuration Control 
> > Register (XCCR) and Receive Configuration Control Register 
> (RCCR) for 
> > 2430/34xx platforms. It also adds XCCR, RCCR entries in 
> McBSP register 
> > configuration structure and bit definitions for both registers.
>
> Pushing to l-o. Can you briefly describe what happens with 
> ASoC if these registers are not used? We may be able to send 
> this as a fix to mainline during the -rc cycle.

If we enable the writing to those registers for 2430/34xx and don't set the default values (setting 0 as a consequence) in ASoC driver, the Transmit/Receive DMA mode gets disabled and the the transmission/reception doesn't happen, ending with a "write error: Input/Output error" when playing with 'aplay'.

-Misa