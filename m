From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: lessen amount of noisy messages
Date: Wed, 15 Apr 2009 09:22:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904150917520.3313@utopia.booyaka.com>
References: <1239288072.3390.8.camel@localhost.localdomain> <49E5D188.8060508@yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42682 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZDOPWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 11:22:53 -0400
In-Reply-To: <49E5D188.8060508@yandex.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind@yandex.ru>
Cc: dedekind@infradead.org, Tony Lindgen <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, 15 Apr 2009, Artem Bityutskiy wrote:

> Artem Bityutskiy wrote:
> > From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> > Date: Thu, 9 Apr 2009 17:15:47 +0300
> > Subject: [PATCH] OMAP3: lessen amount of noisy messages
> > 
> > On our system we see the following messages:
> > 
> > Disabling unused clock "gpt2_ick"
> > Disabling unused clock "gpt3_ick"
> > Disabling unused clock "gpt4_ick"
> > Disabling unused clock "gpt5_ick"
> > Disabling unused clock "gpt6_ick"
> > Disabling unused clock "gpt7_ick"
> > Disabling unused clock "gpt8_ick"
> > Disabling unused clock "gpt9_ick"
> > Disabling unused clock "gpio2_dbck"
> > Disabling unused clock "gpio3_dbck"
> > Disabling unused clock "gpio4_dbck"
> > Disabling unused clock "gpio5_dbck"
> > Disabling unused clock "gpio6_dbck"
> > Disabling unused clock "gpt9_fck"
> > Disabling unused clock "gpt8_fck"
> > Disabling unused clock "gpt7_fck"
> > Disabling unused clock "gpt6_fck"
> > Disabling unused clock "gpt5_fck"
> > Disabling unused clock "gpt4_fck"
> > Disabling unused clock "gpt3_fck"
> > Disabling unused clock "gpt2_fck"
> > Disabling unused clock "wdt2_ick"
> > Disabling unused clock "wdt2_fck"
> > Disabling unused clock "gpio1_dbck"
> > Disabling unused clock "rng_ick"
> > Disabling unused clock "ssi_ick"
> > Disabling unused clock "gpt10_ick"
> > Disabling unused clock "gpt11_ick"
> > Disabling unused clock "uart1_ick"
> > Disabling unused clock "uart2_ick"
> > Disabling unused clock "usbtll_ick"
> > Disabling unused clock "ssi_ssr_fck"
> > Disabling unused clock "uart1_fck"
> > Disabling unused clock "uart2_fck"
> > Disabling unused clock "usbtll_fck"
> > Disabling unused clock "ts_fck"
> > Disabling unused clock "cpefuse_fck"
> > Disabling unused clock "gpt11_fck"
> > Disabling unused clock "gpt10_fck"
> > Disabling unused clock "dpll5_ck"
> > Disabling unused clock "dpll4_m6x2_ck"
> > Disabling unused clock "dpll4_m5x2_ck"
> > Disabling unused clock "dpll3_m3x2_ck"
> > Disabling unused clock "sys_clkout1"
> > 
> > The messages have KERN_INFO level and if you have serial
> > console, they normally go there. I do not think it is good
> > idea to print that much stuff there. Moreover, messages
> > are not properly prefixed and for mortals it is not
> > immeadietly clear where they come from.
> > 
> > Let's give them debugging level instead.
> > 
> > Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> 
> Hi, what is the destiny of this patch?

Hello Artem,

stil thinking about it.  These messages have made it easy to catch bugs 
with the PM code in the past (e.g., sad2d).  Making them debug-level will 
require booting a kernel with clock debugging specifically 
compiled in.  So I wonder if there might be a better way to deal with 
these...


- Paul
