From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] misc omap fixes for 3.5
Date: Thu, 17 May 2012 17:00:55 -0700
Message-ID: <20120518000055.GI17852@atomide.com>
References: <CAK=Wgbb8rXxGaSuk1VyoXz60Faek0Hd0=9EpqAAGKTt6V0FWQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41708 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933549Ab2ERAA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 20:00:58 -0400
Content-Disposition: inline
In-Reply-To: <CAK=Wgbb8rXxGaSuk1VyoXz60Faek0Hd0=9EpqAAGKTt6V0FWQQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, "Gutierrez, Juan" <jgutierrez@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [120516 02:58]:
> Hi Tony,
> 
> Two important fixes from Juan that are necessary to utilize the DSP on
> OMAP4, and a trivial hwspinlock cleanup.
> 
> I tried to keep things as simple as possible, but please tell me if
> you want this pull request anyway differently (e.g. split to two
> separate fixes/cleanups requests, use an annotated signed tag, etc..).

In general, yes fixes, cleanup, and devel should be all separate.

These all look like valid -rc1 fixes for me though, so pulling into
fixes-omap4-dsp branch and merging into l-o master for testing.

Regards,

Tony
 
> The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:
> 
>   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/ohad/linux.git for-tony
> 
> Juan Gutierrez (2):
>       ARM: OMAP: enable mailbox irq per instance
>       ARM: OMAP4: fix irq and clock name for dsp-iommu
> 
> Ohad Ben-Cohen (1):
>       ARM: OMAP4: hwspinlocks_init() should be static
> 
>  arch/arm/mach-omap2/hwspinlock.c |    2 +-
>  arch/arm/mach-omap2/mailbox.c    |    2 --
>  arch/arm/mach-omap2/omap-iommu.c |    6 ++----
>  arch/arm/plat-omap/mailbox.c     |   13 +++++++++----
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> Thanks,
> Ohad.
