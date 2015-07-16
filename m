From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ARM: OMAP2: Delete unnecessary checks before three function calls
Date: Thu, 16 Jul 2015 08:40:30 +0200
Message-ID: <55A751DE.5080301@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54705EC3.90708@users.sourceforge.net>
 <55928739.5040809@users.sourceforge.net>
 <alpine.DEB.2.02.1507160548040.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1507160548040.32764@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

> I have to say, I am a bit leery about applying the omap_device.c and
> omap_hwmod.c changes, since the called functions -- omap_device_delete()
> and clk_disable() -- don't explicitly document that NULLs are allowed
> to be passed in.

How are the chances to improve documentation around such implementation details?


> So there's no explicit contract that callers can rely upon, to (at least
> in theory) prevent those internal NULL pointer checks from being removed.

Are there any additional variations to consider for source files from different
processor architectures?


> So I would suggest that those two functions' kerneldoc be patched first to 
> explicitly state that passing in a NULL pointer is allowed.

Should my static source code analysis approach help you any more to clarify
further open issues?


> So I'll apply that change now for v4.3, touching up the commit message accordingly.

Thanks for your constructive feedback.


>>  arch/arm/mach-omap2/omap_device.c | 3 +--
>>  arch/arm/mach-omap2/omap_hwmod.c  | 5 +----
>>  arch/arm/mach-omap2/timer.c       | 3 +--

Did Tony Lindgren pick a similar update suggestion up, too?
https://lkml.org/lkml/2015/7/15/112

Regards,
Markus
