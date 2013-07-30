From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: hwmod fixes for v3.11-rc
Date: Tue, 30 Jul 2013 06:33:36 -0700
Message-ID: <20130730133336.GL7656@atomide.com>
References: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43530 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab3G3Ndk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 09:33:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Arnd & Olof,

Can you please take this pull request directly? Other than the
omap5 regulator dts changes I just posted I don't yet have
anything else queued up right now.

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [130730 04:53]:
> 
> Hi Tony
> 
> The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:
> 
>   Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.11-rc/omap-fixes-b
> 
> for you to fetch changes up to 50c2a3a1518befe992f868fc1fd867bdad9776ad:
> 
>   ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space (2013-07-30 05:13:37 -0600)
> 
> ----------------------------------------------------------------
> Some OMAP hwmod fixes for v3.11-rc.  Mostly intended to fix an earlyprintk
> regression and an AM33xx cpgmac power management regression.
> 
> Basic build, boot, and PM tests are available here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod_fixes_a_v3.11-rc/20130730042132/
> 
> The tests include temporary fixes for the unrelated 2430SDP and OMAP3
> boot regressions, which are not part of this signed tag.
> 
> ----------------------------------------------------------------
> Afzal Mohammed (2):
>       ARM: OMAP2+: hwmod: rt address space index for DT
>       ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space
> 
> Rajendra Nayak (3):
>       ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with DEBUG_LL
>       ARM: OMAP2+: Avoid idling memory controllers with no drivers
>       ARM: OMAP2+: Sync hwmod state with the pm_runtime and omap_device state
> 
>  arch/arm/mach-omap2/omap_device.c                  | 18 ++++++++
>  arch/arm/mach-omap2/omap_hwmod.c                   |  2 +-
>  arch/arm/mach-omap2/omap_hwmod.h                   | 50 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  6 +--
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  3 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  9 ++--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  5 +--
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  3 +-
>  arch/arm/mach-omap2/serial.c                       | 11 -----
>  9 files changed, 83 insertions(+), 24 deletions(-)
