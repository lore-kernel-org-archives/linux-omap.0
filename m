Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE4C76195
	for <linux-omap@archiver.kernel.org>; Tue, 28 Mar 2023 05:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC1Fln (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 28 Mar 2023 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjC1Fln (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 28 Mar 2023 01:41:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB742D4C;
        Mon, 27 Mar 2023 22:41:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 004588108;
        Tue, 28 Mar 2023 05:41:27 +0000 (UTC)
Date:   Tue, 28 Mar 2023 08:41:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap2: remove obsolete config OMAP3_SDRC_AC_TIMING
Message-ID: <20230328054125.GJ7501@atomide.com>
References: <20230320083806.9545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320083806.9545-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [230320 10:38]:
> Commit d42f265a5d7a ("ARM: OMAP3: clock: remove un-used core dpll
> re-program code") removes arch/arm/mach-omap2/sram34xx.S, which
> implemented the effect of the config OMAP3_SDRC_AC_TIMING. Since then, the
> OMAP3_SDRC_AC_TIMING config was hanging around without effect.
> 
> Remove this obsolete config.

Thanks applying into omap-for-v6.4/cleanup.

Tony
