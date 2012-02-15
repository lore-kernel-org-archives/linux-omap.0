From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 3.3 v2] OMAP4: PRM: fix build breakage when CONFIG_OF is
 not defined
Date: Wed, 15 Feb 2012 09:20:02 +0200
Message-ID: <1329290402.19569.24.camel@cumari>
References: <1328699683-19357-1-git-send-email-coelho@ti.com>
	 <20120214203801.GU1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:36423 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295Ab2BOHUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 02:20:08 -0500
In-Reply-To: <20120214203801.GU1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Tony,

On Tue, 2012-02-14 at 12:38 -0800, Tony Lindgren wrote: 
> * Luciano Coelho <coelho@ti.com> [120208 02:43]:
> > Since 3.3-rc1, prm44xx.c build breaks if CONFIG_OF is not set:
> > 
> > arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> > make[1]: *** [arch/arm/mach-omap2/prm44xx.o] Error 1
> > 
> > This is because of a missing include, which is added indirectly if
> > CONFIG_OF is defined.  This problem was introduced in commit
> > 2f31b51 (ARM: OMAP4: PRM: use PRCM interrupt handler).
> > 
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> A similar patch should be already in mainline kernel queued by Russell.

Right, someone pointed this out to me after I sent the two patches.
Sorry for the trouble, I should have looked more carefully before
jumping in to fix this stuff. ;)

-- 
Cheers,
Luca.

