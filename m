Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E06C4338F
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808F6610D0
	for <linux-omap@archiver.kernel.org>; Tue, 27 Jul 2021 08:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhG0IAi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 27 Jul 2021 04:00:38 -0400
Received: from muru.com ([72.249.23.125]:55516 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhG0IAh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 27 Jul 2021 04:00:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5691780F0;
        Tue, 27 Jul 2021 08:00:54 +0000 (UTC)
Date:   Tue, 27 Jul 2021 11:00:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: dts: am43x-epos-evm: Reduce i2c0 bus speed for
 tps65218
Message-ID: <YP+87A0TSkpFGkI/@atomide.com>
References: <20210716160730.30547-1-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716160730.30547-1-khilman@baylibre.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@baylibre.com> [210716 19:07]:
> From: Dave Gerlach <d-gerlach@ti.com>
> Without this patch occasionally a voltage set operation from the kernel
> will appear to have worked but the actual voltage reflected on the PMIC
> will not have updated, causing problems especially with cpufreq that may
> update to a higher OPP without actually raising the voltage on DCDC2,
> leading to a hang.

Applying into fixes thanks.

Tony
