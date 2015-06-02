From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod code and data changes for v4.2
Date: Tue, 2 Jun 2015 07:54:14 -0700
Message-ID: <20150602145413.GK30984@atomide.com>
References: <alpine.DEB.2.02.1506020321510.14902@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55368 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756353AbbFBOyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 10:54:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1506020321510.14902@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150601 20:24]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Tony,
> 
> The following changes since commit e26081808edadfd257c6c9d81014e3b25e9a6118:
> 
>   Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.2/omap-hwmod-a
> 
> for you to fetch changes up to a55a744582e0dc106537ba5e508c340c39cfe454:
> 
>   ARM: OMAP3: Fix crypto support for HS devices (2015-06-01 19:23:04 -0600)
> 
> The branch contains a AM43xx hwmod data change, and thus is based on
> v4.1-rc4 to avoid merge conflicts.
> 
> - ----------------------------------------------------------------
> ARM: OMAP2+: hwmod code and data changes for v4.2
> 
> Several OMAP2+ hwmod changes for v4.2.  One patch cleans up a nasty
> interaction between the OMAP GPMC and the hwmod code when debugging is
> enabled.  IP block integration data has been added for the AM43xx EMIF
> RAM controller.  There's also a fix for the omap-aes driver when used in
> QEMU.  And finally, some changes to the OMAP3 hwmod code to support the
> use of the security IP blocks (AES and SHA) on GP devices, or when they've
> specifically been enabled in the DT data.
> 
> Basic build, boot, and power management test results are here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.2/20150601192349/

Thanks pulling into omap-for-v4.2/soc.

Tony
