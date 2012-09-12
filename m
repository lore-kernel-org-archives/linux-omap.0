From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [GIT PULL] ARM: OMAP2+: PRCM/hwmod: some fixes for 3.6-rc
Date: Wed, 12 Sep 2012 21:15:34 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB2AAB@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1209051613580.11516@utopia.booyaka.com>
 <50498170.3010600@ti.com>
 <alpine.DEB.2.00.1209121539360.17903@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EAB25C9@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1209122011590.17903@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36330 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab2ILVPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 17:15:45 -0400
In-Reply-To: <alpine.DEB.2.00.1209122011590.17903@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 13, 2012 at 01:44:33, Paul Walmsley wrote:
> On Wed, 12 Sep 2012, Hiremath, Vaibhav wrote:
> 
> > On Wed, Sep 12, 2012 at 21:35:04, Paul Walmsley wrote:
> >  
> > > http://marc.info/?l=linux-omap&m=134746561028888&w=2
> > 
> > Just for my understanding, is this pull request you created based on 
> > l-o/master? Or other baseline?
> 
> That information is in the pull request message:
> 
> --------------
> 
> The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> 
>   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> 

I saw your pull request after your response; somehow, I received email bit 
late.

> --------------
> 
> You can also look at the log or shortlog on the kernel.org gitweb:
> 
> http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=shortlog;h=refs/tags/omap-devel-a-for-3.7
> 

Paul,
I was so excited and desperate to see this pull request and see BeagleBone 
finally booting directly from v3.7 tag, and I didn't want to put any risk to 
this, so I started testing with

Linux-next/master : everything looks fine (with one minor change). Bone just 
simply booted up. 
Linux-omap/master : Was not booting, and getting stuck at " Calibrating 
delay loop...", leading to problem with interrupts.

So I couldn't stop myself till tomorrow and started debugging on this and 
found that, the failure is happening due to recent SPARSE_IRQ migration by 
the commit - 
9ddebc69b2 (ARM: OMAP2+: Remove hardcoded IRQs and enable SPARSE_IRQ)


It was certainly worth staying late in office today :)

Issue is pretty trivial and I have fixed this issue, below is the patch - 
I guess you have to give another pull request for this. I am sending the 
patches just immediately after this email.


>From 0dcebc312050248f432103d70e2457eb135fb5bb Mon Sep 17 00:00:00 2001
From: Vaibhav Hiremath <hvaibhav@ti.com>
Date: Thu, 13 Sep 2012 02:06:52 +0530
Subject: [PATCH 0/2] ARM: AM33XX: hwmod: Minor fixes for v3.7

Today Paul had given pull request for AM33XX hwmod data and related
patches, and I wanted to make sure that things are working fine
irrespective of merge window changes coming in. I without adding any
further delay I tried the pull request on linux-next/master (-rc6)
linux-omap/master (-rc4 + omap merges) and found that hwmod needs
minor changes required for both, build and to boot.

[1/2]: With recent mainline changes on gpio and mcspi drivers,
       platform specific header files (plat/gpio.h and plat/mcspi.h)
       have been removed, which results into build failure.
       Observed on linux-next/master checkout.

[2/2]: With recent migration of omap architectures to SPARSE_IRQ
       framework, it is important to add OMAP_INTC_START to all interrupt
       numbers which will be eventually requested by drivers.
       Observed on linux-omap/master checkout.

Both the patches have been varified for,
     - Build Test (omap2plus_defconfig)
     - Boot tested on Bone
     - Sparse check pass

Paul,
Request to review these patches and give another pull request for this.

Vaibhav Hiremath (2):
  ARM: AM33XX: hwmod: Remove platform specific header files
  ARM: AM33XX: hwmod: Add OMAP_INTC_START offset to all module int nos

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  174 ++++++++++++++--------------
 1 files changed, 88 insertions(+), 86 deletions(-)
