From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: sparse & PRCM fixes for v3.8-rc1
Date: Tue, 1 Jan 2013 10:18:02 -0800
Message-ID: <20130101181801.GC22106@atomide.com>
References: <alpine.DEB.2.00.1212281835450.27761@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19158 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752412Ab3AASSF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jan 2013 13:18:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212281835450.27761@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Paul Walmsley <paul@pwsan.com> [121228 10:39]:
> Hi Tony
> 
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-v3.8-rc
> 
> for you to fetch changes up to 0d541cf2b983758186c972479d4e9f916679dd7a:
> 
>   ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values (2012-12-28 02:10:44 -0700)
> 
> ----------------------------------------------------------------
> Some OMAP PRCM and sparse fixes against v3.8-rc1.  A basic set of test
> logs are available here:
> 
>    http://www.pwsan.com/omap/testlogs/prcm_fixes_b_3.8-rc/20121228032747/
> 
> (The 3730 Beagle XM here has an intermittent failure mounting SD root,
>  but the suspicion right now is that this is due to a failing SD card,
>  rather than any change introduced by these patches.)

Sorry for the delay, just noted few issues with the counter_32k.h and
sram.h patches that just replied to. For the plat-omap code it's OK to
include <plat/*.h> for multiplatform builds. Other than that looks
good to me.

Regards,

Tony
