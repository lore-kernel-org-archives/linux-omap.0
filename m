From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: DRA72x/DRA74x basic support
Date: Thu, 28 Aug 2014 10:02:58 -0700
Message-ID: <20140828170258.GH16006@atomide.com>
References: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63630 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaH1RDF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2014 13:03:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Arnd & Olof,

Can you please pick this one up for the -rc cycle so the TI guys
can boot test dra7 with mainline properly?

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [140827 23:18]:
> Hi Tony,
> 
> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
> 
>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17-rc/omap-dra72x-d74x-support-a
> 
> for you to fetch changes up to f7f7a29bf0cf25af23f37e5b5bf1368b85705286:
> 
>   ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists (2014-08-27 19:38:23 -0600)
> 
> ----------------------------------------------------------------
> Add basic subarchitecture support for the DRA72x and DRA74x.  These
> are OMAP2+ derivative SoCs.  This should be low-risk to existing OMAP
> platforms.
> 
> Basic build, boot, and PM test logs are available here:
> 
> http://www.pwsan.com/omap/testlogs/hwmod-a-early-v3.17-rc/20140827194314/
> 
> ----------------------------------------------------------------
> Rajendra Nayak (2):
>       ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() variants
>       ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists
> 
>  arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
>  arch/arm/mach-omap2/soc.h                 |  6 ++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
