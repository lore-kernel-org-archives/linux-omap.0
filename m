From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Mon, 27 Jun 2011 21:10:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D793501@dbde02.ent.ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
 <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
 <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
 <20110627101427.GH23145@atomide.com>
 <alpine.DEB.2.00.1106270910210.460@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab1F0PlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 11:41:08 -0400
In-Reply-To: <alpine.DEB.2.00.1106270910210.460@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Monday, June 27, 2011 9:00 PM
> To: Premi, Sanjeev; Tony Lindgren
> Cc: Koen Kooi; linux-omap@vger.kernel.org List; linux-arm-kernel
> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> 
> On Mon, 27 Jun 2011, Tony Lindgren wrote:
> 
> > This fix will cause bad dependency issues with sys_timer.
> > 
> > This patch has a dependency to omap3_beagle_init_rev, which 
> depends on
> > the mux framework and gpio framework. Not cool for 
> init_early. We just
> > want to initialize sys_timer early without any complicated 
> dependencies.
> > 
> > The best way to fix this is to set a separate machine ID 
> for the properly
> > working beagle boards like xm, then just set the .timer 
> entry to omap3_timer
> > for working beagle boards and omap3_secure_timer for 
> non-working beagle
> > boards. The rest of the board-*.c file can be shared.
> 
> Sanjeev, want to take care of this?  Machine ID update info is in 
> linux/arch/arm/tools/mach-types.  
> 
> This strategy will unfortunately involve patching 
> bootloaders.  But if the 
> default is to use GPT12, it should work out okay.

[sp] Just sent another query to Tony on this specific issue.
     But, if different mach-type is the way forward, then
     I will take it forward.

> 
> Hopefully we won't have to do the same thing for the other 
> Beagle-derived 
> boards, Devkit8000, Touchbook, etc. etc.  Then again, I 
> suppose this will 
> eventually just be another property passed in via DT, with a single 
> machine ID.

[sp] Can you look at my query to Tony? Will that be an acceptable
     workaround until DT. Going to two machine IDs and then unifying
     back again could cause confusion - esp. during transition times.

~sanjeev

> 
> > The above assumes the patches in devel-timer branch where 
> we no longer
> > have the non-standard timer interface, but use the sys_timer entries
> > instead like we should.
> 
> 
> - Paul
> 
