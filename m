From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 5/7] omap board changes for v3.11 merge window
Date: Thu, 20 Jun 2013 21:43:10 +0200
Message-ID: <201306202143.10985.arnd@arndb.de>
References: <0LvkNM-1UEdHD0O6e-0186su@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57622 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422752Ab3FTTnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jun 2013 15:43:43 -0400
In-Reply-To: <0LvkNM-1UEdHD0O6e-0186su@mx.kundenserver.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 18 June 2013, Tony Lindgren wrote:
> The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:
> 
>   Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/board-signed
> 
> for you to fetch changes up to 45853507c9362b0bd606b37e8c7c7e7551caa78b:
> 
>   ARM: omap2plus_defconfig: enable USB_PHY and NOP_USB_XCEIV (2013-06-18 03:19:07 -0700)
> 
> ----------------------------------------------------------------
> Minor board changes for v3.11 merge window. These are
> tapering down finally as we're getting closer to making
> omap2+ DT only.
> 
> ----------------------------------------------------------------
> Aaro Koskinen (1):
>       ARM: OMAP1: nokia770: enable Tahvo
> 
> Adrien Verg (1):
>       ARM: omap2plus_defconfig: enable USB_PHY and NOP_USB_XCEIV
> 
> Florian Vaussard (1):
>       arm: omap: board-overo: reset GPIO for SMSC911x
> 
> Lokesh Vutla (1):
>       ARM: OMAP3EVM: Marking omap3_evm_display_init() with CONFIG_BROKEN
> 
>  arch/arm/configs/omap2plus_defconfig |  2 ++
>  arch/arm/mach-omap1/board-nokia770.c | 10 ++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c |  4 ++++
>  arch/arm/mach-omap2/board-overo.c    |  3 ++-
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 

Pulled into next/boards, thanks!

	Arnd
