Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20FDE936FB
	for <linux-omap@archiver.kernel.org>; Sat,  7 Oct 2023 07:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjJGHAT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 7 Oct 2023 03:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbjJGHAS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 7 Oct 2023 03:00:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42174BF;
        Sat,  7 Oct 2023 00:00:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AE4DD809E;
        Sat,  7 Oct 2023 07:00:16 +0000 (UTC)
Date:   Sat, 7 Oct 2023 10:00:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: omap4-embt2ws: Add Bluetooth
Message-ID: <20231007070015.GS34982@atomide.com>
References: <20231004070309.2408745-1-andreas@kemnade.info>
 <6b4968d9-80d3-4a5a-b42e-3982825e45e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4968d9-80d3-4a5a-b42e-3982825e45e9@linaro.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [231005 08:47]:
> On 04/10/2023 09:03, Andreas Kemnade wrote:
> > Since the required clock is now available, add bluetooth.
> > 
> > Note: Firmware (bts file) from device vendor reroutes tx for some time
> > during initialisation and later put it back, producing timeouts in
> > bluetooth initialisation but ignoring that command leads to proper
> > initialisation.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applying into omap-for-v6.7/dt thanks.

Tony
