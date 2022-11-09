Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F066C4332F
	for <linux-omap@archiver.kernel.org>; Wed,  9 Nov 2022 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKIIgA (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKIIf6 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Nov 2022 03:35:58 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9258013DF5;
        Wed,  9 Nov 2022 00:35:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 02D7780FB;
        Wed,  9 Nov 2022 08:26:10 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:35:55 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Dominik Haller <d.haller@phytec.de>
Cc:     linux-omap@vger.kernel.org, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, upstream@phytec.de
Subject: Re: [PATCH] ARM: dts: am335x-pcm-953: Define fixed regulators in
 root node
Message-ID: <Y2tma81uGWYZjxVW@atomide.com>
References: <20221011143115.248003-1-d.haller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011143115.248003-1-d.haller@phytec.de>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dominik Haller <d.haller@phytec.de> [221011 17:22]:
> Remove the regulators node and define fixed regulators in the root node.
> Prevents the sdhci-omap driver from waiting in probe deferral forever
> because of the missing vmmc-supply and keeps am335x-pcm-953 consistent with
> the other Phytec AM335 boards.
> 
> Fixes: bb07a829ec38 ("ARM: dts: Add support for phyCORE-AM335x PCM-953 carrier board")
> Signed-off-by: Dominik Haller <d.haller@phytec.de>

Applying into omap-for-v6.1/dt thanks. With the fixes tag it will get
picked into the stable kernels too.

Regards,

Tony
