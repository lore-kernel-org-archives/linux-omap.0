From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: first set of PRM/CM cleanups for 3.8
Date: Wed, 24 Oct 2012 17:03:35 -0700
Message-ID: <20121025000334.GF11928@atomide.com>
References: <alpine.DEB.2.00.1210211912410.26128@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10072 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756001Ab2JYADi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 20:03:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210211912410.26128@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121021 12:15]:
> Hi Tony
> 
> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-a-for-3.8
> 
> for you to fetch changes up to 2bb2a5d30abb0dc99d074877bfad2056142c730b:
> 
>   ARM: OMAP2+: PRM: create PRM reset source API for the watchdog timer driver (2012-10-21 01:01:13 -0600)
> 
> ----------------------------------------------------------------
> The first set of OMAP PRM/CM-related cleanup patches for 3.8.
> Prepares for the future move of the PRM/CM code to drivers/.  Also
> includes some prcm.[ch] cleanup patches from the WDTIMER cleanup
> series that don't need external acks.
> 
> Basic test logs for this branch on top of v3.7-rc2 are here:
> 
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_a_3.8/20121021123719/
> 
> But due to the number of unrelated regressions present in v3.7-rc[12],
> it's not particularly usable as a testing base.  With reverts, fixes,
> and workarounds applied as documented in:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/README.txt
> 
> the following test logs were obtained:
> 
> http://www.pwsan.com/omap/testlogs/prcm_cleanup_a_3.8/20121020231757/
> 
> which indicate that the series tests cleanly.

Thanks pulling into omap-for-v3.8/cleanup-prcm.

Regards,

Tony
