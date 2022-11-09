Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA09C4332F
	for <linux-omap@archiver.kernel.org>; Wed,  9 Nov 2022 08:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiKIIdF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKIIcs (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2022 03:32:48 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 786F765ED;
        Wed,  9 Nov 2022 00:31:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B74A180FB;
        Wed,  9 Nov 2022 08:21:39 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:31:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] AM57x EVM Device Tree Overlays
Message-ID: <Y2tlXVA6CH/aSzeK@atomide.com>
References: <20221101221110.17885-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101221110.17885-1-afd@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Andrew & Rob,

* Andrew Davis <afd@ti.com> [221102 00:01]:
> Hello all,
> 
> These is an uncontroversial (hopefully) DT Overlay to support the
> TI AM57x EVM. More complex cases are staged and ready to follow but
> wanted to test the water with this one.
> 
> For some reason dtbs_check does not get run on overlays, this
> will need further investigation to fix in kbuild. For now I ran
> it through manually but am not 100% sure it actually checked it,
> so double checks here very welcome.
> 
> Series depends on https://www.spinics.net/lists/kernel/msg4548509.html

Looks like we now have commit 26c9134a370a ("Merge branch 'dt/dtbo-rename'
into dt/next") in Linux next.

Can these two patches now be applied if I merge in the commit above?

Regards,

Tony
