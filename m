Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FBC433E0
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C7261A07
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhCXOQL (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:16:11 -0400
Received: from muru.com ([72.249.23.125]:46654 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236023AbhCXOQK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 24 Mar 2021 10:16:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EC19D8057;
        Wed, 24 Mar 2021 14:17:06 +0000 (UTC)
Date:   Wed, 24 Mar 2021 16:16:06 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] ARM: dts: Fix swapped mmc order for omap3
Message-ID: <YFtJphQJLv1u9NHp@atomide.com>
References: <20210324132442.41907-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324132442.41907-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210324 15:26]:
> Also some omap3 devices like n900 seem to have eMMC and micro-sd swapped
> around with commit 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for
> drivers that existed in v4.4").
> 
> Let's fix the issue with aliases as discussed on the mailing lists. While
> the mmc aliases should be board specific, let's first fix the issue with
> minimal changes.

Also, all the MMC device instances are there for sure for these SoCs if
used or not. So I don't know if moving the aliases to board specific files
helps in this case at all. I agree the aliases should be board specific
for devices that are not integrated into the SoCs though :)

Cheers,

Tony
