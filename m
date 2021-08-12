Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0DC4338F
	for <linux-omap@archiver.kernel.org>; Thu, 12 Aug 2021 06:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA9160F91
	for <linux-omap@archiver.kernel.org>; Thu, 12 Aug 2021 06:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhHLGc4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 12 Aug 2021 02:32:56 -0400
Received: from muru.com ([72.249.23.125]:42430 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhHLGcz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 12 Aug 2021 02:32:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5B5B780E7;
        Thu, 12 Aug 2021 06:32:50 +0000 (UTC)
Date:   Thu, 12 Aug 2021 09:32:28 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Woodruff, Richard" <r-woodruff2@ti.com>
Cc:     David Russell <david.russell73@gmail.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [EXTERNAL] OMAP2430 kernel hangs on ioremap of IVA2.1 addresses
Message-ID: <YRTAfDeGemh7Bt50@atomide.com>
References: <E26ACA77-0F54-41BC-BA45-29B641A6BEA9@gmail.com>
 <cb562f9f798d4431a09f19e8efd24727@ti.com>
 <YMBdt8dDdvySofuC@atomide.com>
 <2B1CE4CB-689F-4547-A64C-A7FB699F0730@gmail.com>
 <6616af990c3d4cc8b3ca51e1a6e9283e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6616af990c3d4cc8b3ca51e1a6e9283e@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [210811 14:18]:
> Probably a good minimal kernel with basic drivers can be made at multiple points.  I'm less sure about the state of open drivers with WL18xx.  I'd suggest exploring that a bit more to see if it ends up dominating.  For early WLAN, sometimes firmware and fragile DMA integrations were hard to work around.

The wl17xx wl18xx driver is behaving OK with various SoCs with the mainline
kernel at least as tested with SDIO.

For the Linux kernel, often the most recent long term kernel is used, that
is linux-5.10.y currently and might be linux-5.15.y at the end of the year.

If you just need basic SoC support and wl18xx, then I don't see issues
using current stable kernels. The SoC is fairly similar for peripherals
for various omap3 devices that are still being actively used :)

If you need to use out of tree hardware accelerators and and power
management, then things might get a bit trickier.

Regards,

Tony
