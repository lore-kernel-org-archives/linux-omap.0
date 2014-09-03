From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAP2+: GPMC: NAND fixes for 3.17
Date: Wed, 3 Sep 2014 14:40:45 -0700
Message-ID: <20140903214045.GK11766@atomide.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37762 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752553AbaICVkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2014 17:40:49 -0400
Content-Disposition: inline
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140902 06:57]:
> Hi Tony,
> 
> These are some of the issues I found while testing v3.17-rc3.
> 
> - Wrong ECC scheme used for am43x GP and EPOS evm. We need to use
> BCH16 instead of BCH8.
> 
> - Wrong read/write wait pin monitoring setting used for NAND
> resulting in "L3 application error" debug message on console.
> 
> - Pin conflict issue on am43x EPOS evm with QSPI and NAND.

Thanks applying into omap-for-v3.17/fixes-v2.

Tony
 
> Patches are available at
> git@github.com:rogerq/linux.git
> * [new branch]      for-v3.17/gpmc-fixes
> 
> cheers,
> -roger
> 
> Roger Quadros (6):
>   ARM: dts: am43x-epos-evm: Use BCH16 ECC scheme instead of BCH8
>   ARM: dts: am437x-gp-evm: Use BCH16 ECC scheme instead of BCH8
>   ARM: dts: am437x-gp-evm: Don't use read/write wait monitoring
>   ARM: dts: am43xx-epos-evm: Don't use read/write wait monitoring
>   ARM: OMAP2+: gpmc: Don't complain if wait pin is used without r/w
>     monitoring
>   ARM: dts: am43x-epos-evm: Disable QSPI to prevent conflict with
>     GPMC-NAND
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts  | 4 +---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 9 ++++-----
>  arch/arm/mach-omap2/gpmc.c           | 7 +++----
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> -- 
> 1.8.3.2
> 
