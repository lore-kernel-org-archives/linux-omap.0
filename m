Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D481C433F5
	for <linux-omap@archiver.kernel.org>; Fri, 29 Apr 2022 05:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiD2Faa (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 Apr 2022 01:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbiD2Fa3 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2022 01:30:29 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55AA686E32;
        Thu, 28 Apr 2022 22:27:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B041080C1;
        Fri, 29 Apr 2022 05:24:03 +0000 (UTC)
Date:   Fri, 29 Apr 2022 08:27:10 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jmkrzyszt@gmail.com, aaro.koskinen@iki.fi, vireshk@kernel.org,
        shiraz.linux.kernel@gmail.com, nsekhar@ti.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 4/6] ARM: omap: fix address space warnings from sparse
Message-ID: <Ymt3LnsB7zt+1l2X@atomide.com>
References: <20220428133210.990808-1-arnd@kernel.org>
 <20220428133210.990808-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428133210.990808-5-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220428 13:32]:
> mach-omap2/sram.c:78:17: warning: cast removes address space '__iomem' of expression
> mach-omap2/omap4-common.c:142:27: warning: incorrect type in assignment (different address spaces)
> mach-omap2/omap4-common.c:142:27:    expected void [noderef] __iomem *static [toplevel] sram_sync
> mach-omap2/omap4-common.c:142:27:    got void *
> mach-omap2/pm34xx.c:113:45: warning: incorrect type in argument 1 (different address spaces)
> mach-omap2/pm34xx.c:113:45:    expected void [noderef] __iomem *save_regs
> mach-omap2/pm34xx.c:113:45:    got void *extern [addressable] [toplevel] omap3_secure_ram_storage

These omap2 specific warnings seem to have been split out into a separate
patch, or maybe a patch hunk is missing here?

>  arch/arm/mach-omap1/board-ams-delta.c | 2 +-
>  arch/arm/mach-omap1/sram-init.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

As this touches only omap1 files. If this patch will be omap1 specific,
maybe update the subject line too?

Regards,

Tony
