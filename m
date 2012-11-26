From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod/PRM changes for 3.8
Date: Mon, 26 Nov 2012 12:36:51 -0800
Message-ID: <20121126203651.GJ5279@atomide.com>
References: <alpine.DEB.2.00.1211220016160.32242@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16856 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756419Ab2KZUgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 15:36:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211220016160.32242@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121121 16:19]:
> Hi Tony
> 
> The following changes since commit 558a0780b0a04862a678f7823215424b4e5501f9:
> 
>   Merge tag 'omap-cleanup-c-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/clock (2012-11-13 13:32:24 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.8
> 
> for you to fetch changes up to c567b0584c352e7f97ced003be46bed8581ddd5b:
> 
>   ARM: OMAP2+: omap_device: Correct resource handling for DT boot (2012-11-21 16:15:18 -0700)
> 
> ----------------------------------------------------------------
> Some miscellaneous OMAP hwmod changes for 3.8, along with a PRM
> change needed for one of the hwmod patches to function.
> 
> Basic test logs for this branch on top of Tony's
> omap-for-v3.8/clock branch at commit
> 558a0780b0a04862a678f7823215424b4e5501f9 are here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod_devel_a_3.8/20121121161522/
> 
> However, omap-for-v3.8/clock at 558a0780 does not include some fixes
> that are needed for a successful test.  With several reverts,
> fixes, and workarounds applied, the following test logs were
> obtained:
> 
> http://www.pwsan.com/omap/testlogs/TEST_hwmod_devel_a_3.8/20121121162719/
> 
> which indicate that the series tests cleanly.

Thanks pulling into omap-for-v3.8/devel-prcm, let's see if
we can still get this and the clock changes in.

Regards,

Tony
