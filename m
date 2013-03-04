From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: standardize integration for AES &
 SHA/MD5 IP blocks for 3.9
Date: Mon, 4 Mar 2013 10:50:21 -0800
Message-ID: <20130304185019.GP11806@atomide.com>
References: <alpine.DEB.2.00.1302081752190.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11202 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757554Ab3CDSuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:50:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302081752190.28008@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130208 09:57]:
> Hi,
> 
> The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:
> 
>   Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.9
> 
> for you to fetch changes up to e6d231f899c1625a88dd369ab973dced4b49ee45:
> 
>   ARM: AM33XX: hwmod: Update and uncomment AES0 module data (2013-02-08 09:28:59 -0700)
> 
> ----------------------------------------------------------------
> For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
> code and data to use hwmod and omap_device.  This is a prerequisite for moving
> the hwmod code out of arch/arm.
> 
> Basic test logs are available at:
> 
>     http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.9/20130208093215/

Sorry looks like I totally missed this one somehow as discussed last
week. Anyways, let's get it queued early at -rc2 or so, let me know
if you want to update the branch or if I should just use this pull
request.

Regards,

Tony
 
> ----------------------------------------------------------------
> 
> vmlinux object size
> (delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
>    text     data      bss    total  kernel
>    +184     +904        0    +1088  am33xx_only
>    +184     +616        0     +800  n800_multi_omap2xxx
>    +184     +552        0     +736  n800_only_a
>       0        0        0        0  omap1_defconfig
>       0        0        0        0  omap1_defconfig_1510innovator_only
>       0        0        0        0  omap1_defconfig_5912osk_only
>    +196    +2176        0    +2372  omap2plus_defconfig
>    +184     +616        0     +800  omap2plus_defconfig_2430sdp_only
>    +196    +2168        0    +2364  omap2plus_defconfig_cpupm
>   +4292    +2176        0    +6468  omap2plus_defconfig_no_pm
>    +184     +616        0     +800  omap2plus_defconfig_omap2_4_only
>    +196    +1600        0    +1796  omap2plus_defconfig_omap3_4_only
>    +336    +1968     -128    +2176  rmk_omap3430_ldp_allnoconfig
>   +4276    +1512        0    +5788  rmk_omap3430_ldp_oldconfig
>    +336    +1968     -128    +2176  rmk_omap4430_sdp_allnoconfig
>    +168     +856        0    +1024  rmk_omap4430_sdp_oldconfig
> 
> Mark A. Greer (13):
>       ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
>       ARM: OMAP2xxx: hwmod: Add DMA support for SHAM module
>       ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
>       ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
>       ARM: OMAP2+: Only manually add hwmod data when DT not used.
>       ARM: AM33XX: Add sha0 crypto clock data
>       ARM: AM33XX: hwmod: Update and uncomment SHA0 module data
>       ARM: OMAP2xxx: hwmod: Convert AES crypto devcie data to hwmod
>       ARM: OMAP3xxx: hwmod: Convert AES crypto device data to hwmod
>       ARM: OMAP2+: Remove unnecessary message when no AES IP is present
>       ARM: OMAP2+: Only manually add hwmod data when DT not used.
>       ARM: AM33XX: Add aes0 crypto clock data
>       ARM: AM33XX: hwmod: Update and uncomment AES0 module data
> 
>  arch/arm/mach-omap2/cclock2430_data.c              |    4 +-
>  arch/arm/mach-omap2/cclock33xx_data.c              |   10 ++
>  arch/arm/mach-omap2/cclock3xxx_data.c              |    4 +-
>  arch/arm/mach-omap2/devices.c                      |  149 +++--------------
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +
>  .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   36 ++++
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   81 +++++++++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   92 +++++++++--
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  172 +++++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
>  11 files changed, 402 insertions(+), 154 deletions(-)
