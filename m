From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Wed, 18 Jul 2012 03:53:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207180341001.16772@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com> <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com> <20120714085257.GB6522@atomide.com> <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com> <20120716083609.GG6522@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46334 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2GRJxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jul 2012 05:53:10 -0400
In-Reply-To: <20120716083609.GG6522@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Mon, 16 Jul 2012, Tony Lindgren wrote:

> Hmm well it seems that we should apply this fix into arm-soc next/cleanup
> branch if that's where the mismerge happened? It seems the same mismerge
> is there even without 16e5e2c4?

The arm-soc next/cleanup copy of mach-omap2/clockdomains3xxx_data.c is 
correct.  The problem that my patch was designed to fix doesn't exist in 
that version of the file (868c157df9721675c19729eed2c96bac6c3f1d01).

> You patch applies into arm-soc next/cleanup with fuzz:
> 
> patching file arch/arm/mach-omap2/clockdomain.c
> patching file arch/arm/mach-omap2/clockdomain.h
> Hunk #1 succeeded at 82 (offset -4 lines).
> patching file arch/arm/mach-omap2/clockdomains3xxx_data.c
> Hunk #1 succeeded at 347 with fuzz 2 (offset -107 lines).
> 
> So that's why I'm wondering if it needs some changes.

OK, I understand why you're asking.  

I went back and researched it.  The patch that I sent is only needed 
because the conflict resolution in merge commit 
3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag 
'omap-cleanup-for-v3.6' into tmp-merge") adds &mpu_3xxx_clkdm back into 
the clockdomains_common list.  The previous commit on that file 
16e5e2c471ab889f838bfe1c44032d0481c115e1 removed &mpu_3xxx_clkdm from the 
common list, because the AM35xx chips needed to use a different MPU 
clockdomain structure from the OMAP3xxx chips.

Or, put differently: Before 16e5e2c471ab889f838bfe1c44032d0481c115e1, it 
was correct to have &mpu_3xxx_clkdm in the common list.  That's 
what's in arm-soc next/cleanup and that data is correct.

After 16e5e2c471ab889f838bfe1c44032d0481c115e1, it's incorrect to have 
&mpu_3xxx_clkdm in the common list.

Hope this isn't even more confusing :-)


- Paul
