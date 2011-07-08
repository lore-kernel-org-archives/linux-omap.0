From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
Date: Fri, 8 Jul 2011 04:55:21 -0700
Message-ID: <20110708115521.GA5783@atomide.com>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
 <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
 <4E16EECF.7030102@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752189Ab1GHLzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 07:55:25 -0400
Content-Disposition: inline
In-Reply-To: <4E16EECF.7030102@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jan Weitzel <j.weitzel@phytec.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [110708 04:45]:
> Hello.
> 
> On 08-07-2011 14:04, Jan Weitzel wrote:
> 
> >Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
> >---
> >  arch/arm/mach-omap2/Kconfig  |    5 +++++
> >  arch/arm/mach-omap2/Makefile |    4 ++++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> >diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> >index 19d5891..c6a2d43 100644
> >--- a/arch/arm/mach-omap2/Kconfig
> >+++ b/arch/arm/mach-omap2/Kconfig
> [...]
> >diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> >index b148077..e81b594 100644
> >--- a/arch/arm/mach-omap2/Makefile
> >+++ b/arch/arm/mach-omap2/Makefile
> >@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
> >  					   hsmmc.o \
> >  					   omap_phy_internal.o
> >
> >+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
> 
>    You need to first add board-omap4pcm049.c, and only then wire it
> to the Makefile. You could do both in onme patch though...

Yes looks like this should be just one patch for everything.

Regards,

Tony
