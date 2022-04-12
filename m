Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9EC433EF
	for <linux-omap@archiver.kernel.org>; Tue, 12 Apr 2022 10:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiDLK56 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356067AbiDLKpP (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2022 06:45:15 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6102282D13;
        Tue, 12 Apr 2022 02:40:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EEC848061;
        Tue, 12 Apr 2022 09:38:09 +0000 (UTC)
Date:   Tue, 12 Apr 2022 12:40:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: logicpd-som-lv: Fix wrong pinmuxing on
 OMAP35
Message-ID: <YlVJGYeT95eL7ZHt@atomide.com>
References: <20220303171818.11060-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303171818.11060-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [220303 19:17]:
> The pinout of the OMAP35 and DM37 variants of the SOM-LV are the
> same, but the macros which define the pinmuxing are different
> between OMAP3530 and DM3730.  The pinmuxing was correct for
> for the DM3730, but wrong for the OMAP3530.  Since the boot loader
> was correctly pin-muxing the pins, this was not obvious. As the
> bootloader not guaranteed to pinmux all the pins any more, this
> causes an issue, so the pinmux needs to be moved from a common
> file to their respective board files.
> 
> Fixes: f8a2e3ff7103 ("ARM: dts: Add minimal support for LogicPD OMAP35xx SOM-LV devkit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applying this too to fixes to avoid confusion with the bootloader
version.

Regards,

Tony
