Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D7C48BD1
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 05:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34853613B4
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 05:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFKFfw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Jun 2021 01:35:52 -0400
Received: from muru.com ([72.249.23.125]:41638 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhFKFfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 11 Jun 2021 01:35:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E0391818C;
        Fri, 11 Jun 2021 05:34:01 +0000 (UTC)
Date:   Fri, 11 Jun 2021 08:33:50 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Gowtham Tammana <g-tammana@ti.com>, Suman Anna <s-anna@ti.com>,
        bcousson@baylibre.com, robh+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nisanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] ARM: dts: dra7: Fix duplicate USB4 target module node
Message-ID: <YML1vuROPftMR+j6@atomide.com>
References: <20210602220458.9728-1-g-tammana@ti.com>
 <c140f39c-9fe1-f7e1-3da5-fc5fff604714@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c140f39c-9fe1-f7e1-3da5-fc5fff604714@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [210608 10:40]:
> On 03/06/2021 01:04, Gowtham Tammana wrote:
> > With [1] USB4 target-module node got defined in dra74x.dtsi file.
> > However, the earlier definition in [2] was not removed, and this
> > duplication of the target module is causing boot failure on dra74
> > variant boards - dra7-evm, dra76-evm.
> > 
> > USB4 is only present in DRA74x variants, so keeping the entry in
> > dra74x.dtsi and removing it from the top level interconnect hierarchy
> > dra7-l4.dtsi file. This change makes the USB4 target module no longer
> > visible to AM5718, DRA71x and DRA72x so removing references to it in
> > their respective dts files.
> > 
> > [1]: commit c7b72abca61ec ("ARM: OMAP2+: Drop legacy platform data for
> > dra7 dwc3")
> > [2]: commit 549fce068a311 ("ARM: dts: dra7: Add l4 interconnect
> > hierarchy and ti-sysc data")
> > 
> > Fixes: c7b72abca61ec ("ARM: OMAP2+: Drop legacy platform data for dra7 dwc3")
> > Signed-off-by: Gowtham Tammana <g-tammana@ti.com>
...
> Thank you.
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Thanks applying into fixes.

Tony
