Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF30C43217
	for <linux-omap@archiver.kernel.org>; Tue, 12 Apr 2022 10:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiDLKre (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357562AbiDLKqH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2022 06:46:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1FE829C8E;
        Tue, 12 Apr 2022 02:47:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3B17C8061;
        Tue, 12 Apr 2022 09:44:29 +0000 (UTC)
Date:   Tue, 12 Apr 2022 12:47:00 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] ARM: dts: am33xx-l4: Add missing touchscreen clock
 properties
Message-ID: <YlVKlIwYICzkmyAU@atomide.com>
References: <20220314163445.79807-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314163445.79807-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Miquel Raynal <miquel.raynal@bootlin.com> [220314 18:33]:
> The touchscreen bindings clearly state that the clocks/clock-names
> properties are mandatory, but they have been forgotten in one DTSI. This
> was probably not noticed in the first place because of the clock
> actually existing and the clk_get() call going through all the tree
> anyway.
> 
> Add the missing clock phandles in the am33xx touchscreen description.
> 
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Fixes: 235a96e92c16 ("mfd: ti_am335x_tscadc: Don't search the tree for our clock")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into fixes thanks.

Tony
