From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 2.6.27-rc9-omap] i2c-omap: timeouts begone
Date: Fri, 10 Oct 2008 05:36:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810100527190.13922@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <20081008183808.GA31385@atomide.com> <200810081236.48940.david-b@pacbell.net> <200810081436.06810.david-b@pacbell.net> <20081008215455.GA15087@frodo>
 <13B9B4C6EF24D648824FF11BE89671620365B589EC@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37175 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYJJLgn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:36:43 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620365B589EC@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Richard,

trying to fix this problem and have a few questions.

On Wed, 8 Oct 2008, Woodruff, Richard wrote:

> None of the module local OCP registers are being setup properly.  A 
> write of a 0x2 kills other settings.  If after this operation the SSYC 
> reg will say:
>         -Forced Idle
>         -Locally gate I+F clock on ocp-segment idle request
>         -wake up disabled
> 
> If it is left this way what can happen is when L4/L3 clock stop partial 
> idle is broadcast, this module will ack and gate its clocks.  This will 
> result in you dropping data. Or if the data was sent ok, but clock stop 
> happens, you won't be able to wake the system properly as you've cleared 
> the local wakeup generation.  The result will be a timeout.

Okay, so for OMAP3, the workarounds in the omapzoom tree to change the 
SYSC.CLOCKACTIVITY bits when the clocks are enabled and disabled are not 
necessary?

It sounds like the only thing that is needed on OMAP3 is to make sure that 
the SYSCONFIG register is set properly after a software reset? 

> On OMAP2 I2C wasn't hooked properly into PRCM for handshake so it needed 
> a workaround.  The same isn't true for OMAP3.  Treating the two as if 
> they are the same with respect to power is false.

Could you explain further about which workaround this is?  OMAP2 I2C does 
not appear to have any SYSC bits exposed other than SOFTRESET?

- Paul
