From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: CM/SCM: clean up direct register
 accesses
Date: Sun, 20 Oct 2013 09:36:09 -0700
Message-ID: <20131020163609.GX15154@atomide.com>
References: <alpine.DEB.2.02.1310191709220.11676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29970 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751231Ab3JTQgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Oct 2013 12:36:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1310191709220.11676@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131019 10:11]:
> Hi Tony,
> 
> The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:
> 
>   Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/cm-scm-cleanup-a
> 
> for you to fetch changes up to 49e03402327ab69a26f604398982ef14123900a2:
> 
>   ARM: OMAP3: control: add API for setting IVA bootmode (2013-10-19 10:11:52 -0600)
> 
> ----------------------------------------------------------------
> Move some of the OMAP2+ CM and System Control Module direct
> register accesses into CM- and System Control
> Module-specific "drivers" underneath arch/arm/mach-omap2/.  This
> is a prerequisite for moving this code out of arch/arm/mach-omap2/ into
> drivers/.
> 
> Basic test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/cm_scm_cleanup_a_v3.13/20131019101809/

Thanks, pulling into omap-for-v3.13/cm-scm-cleanup.

Tony
