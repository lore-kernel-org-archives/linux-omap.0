Return-Path: <SRS0=JveC=7L=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E15DC433E0
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 17:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1904D21919
	for <linux-omap@archiver.kernel.org>; Fri, 29 May 2020 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2RVM (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 May 2020 13:21:12 -0400
Received: from muru.com ([72.249.23.125]:56186 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgE2RVM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 29 May 2020 13:21:12 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AD89D8030;
        Fri, 29 May 2020 17:22:01 +0000 (UTC)
Date:   Fri, 29 May 2020 10:21:08 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Subject: Re: [PATCH v2] arm: dts: am335x-boneblack: add gpio-line-names
Message-ID: <20200529172108.GS37466@atomide.com>
References: <20200521200926.GC429020@x1>
 <20200528131620.GA3126290@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528131620.GA3126290@x1>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Drew Fustini <drew@beagleboard.org> [200528 13:17]:
> FYI - Linus W. provided an Acked-by in related thread [0].
> 
> Anyone else have any review comments?

Looks good to me thanks. But as the merge window is about
to open, let's do fixes only at this point and leave this
for v5.9.

Regards,

Tony


> 
> [0] https://lore.kernel.org/linux-devicetree/CACRpkdZLRjcE0FGwVR-Q7a50aEmpB=xO4q6H8_EaV199fGr0OA@mail.gmail.com/
