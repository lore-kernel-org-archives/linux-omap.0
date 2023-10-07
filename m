Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD0E9371B
	for <linux-omap@archiver.kernel.org>; Sat,  7 Oct 2023 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbjJGG5X (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 7 Oct 2023 02:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJGG5W (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 7 Oct 2023 02:57:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF5B5B9;
        Fri,  6 Oct 2023 23:57:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 29ACC809E;
        Sat,  7 Oct 2023 06:57:20 +0000 (UTC)
Date:   Sat, 7 Oct 2023 09:57:18 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, chenhuiz@axis.com,
        jean-baptiste.maneyrol@tdk.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: omap: omap4-embt2ws: Add IMU at control
 unit
Message-ID: <20231007065718.GQ34982@atomide.com>
References: <20230927173245.2151083-1-andreas@kemnade.info>
 <20230927173245.2151083-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927173245.2151083-4-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230927 17:32]:
> Add also the level-shifter flag to avoid probe failure in magnetometer
> probe.

Applying this patch into omap-for-v6.7/dt thanks.

Regards,

Tony
