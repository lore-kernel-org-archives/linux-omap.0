From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 09:29:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106270910210.460@utopia.booyaka.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com> <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com> <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
 <20110627101427.GH23145@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54322 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1F0P3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 11:29:52 -0400
In-Reply-To: <20110627101427.GH23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, 27 Jun 2011, Tony Lindgren wrote:

> This fix will cause bad dependency issues with sys_timer.
> 
> This patch has a dependency to omap3_beagle_init_rev, which depends on
> the mux framework and gpio framework. Not cool for init_early. We just
> want to initialize sys_timer early without any complicated dependencies.
> 
> The best way to fix this is to set a separate machine ID for the properly
> working beagle boards like xm, then just set the .timer entry to omap3_timer
> for working beagle boards and omap3_secure_timer for non-working beagle
> boards. The rest of the board-*.c file can be shared.

Sanjeev, want to take care of this?  Machine ID update info is in 
linux/arch/arm/tools/mach-types.  

This strategy will unfortunately involve patching bootloaders.  But if the 
default is to use GPT12, it should work out okay.

Hopefully we won't have to do the same thing for the other Beagle-derived 
boards, Devkit8000, Touchbook, etc. etc.  Then again, I suppose this will 
eventually just be another property passed in via DT, with a single 
machine ID.

> The above assumes the patches in devel-timer branch where we no longer
> have the non-standard timer interface, but use the sys_timer entries
> instead like we should.


- Paul
