Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33231C4708B
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176A3613E2
	for <linux-omap@archiver.kernel.org>; Thu, 27 May 2021 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhE0ME3 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 May 2021 08:04:29 -0400
Received: from muru.com ([72.249.23.125]:32800 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234725AbhE0ME1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 May 2021 08:04:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 959CA80A8;
        Thu, 27 May 2021 12:02:58 +0000 (UTC)
Date:   Thu, 27 May 2021 15:02:49 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Jan Tuerk <jan.tuerk@emtrion.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: dra7x-evm: Align GPIO hog names with
 dt-schema
Message-ID: <YK+KaXbh2F/CroX7@atomide.com>
References: <cover.1621583562.git.geert+renesas@glider.be>
 <e8350ea542c92465020f03481d76943168df2935.1621583562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8350ea542c92465020f03481d76943168df2935.1621583562.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [210521 10:54]:
> The dt-schema for nxp,pcf8575 expects GPIO hogs node names to end with a
> 'hog' suffix.

Picking up this patch into omap-for-v5.14/dt thanks.

Tony
