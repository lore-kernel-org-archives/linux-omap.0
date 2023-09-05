Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0656CC83F2C
	for <linux-omap@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjIEP7O (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353556AbjIEGma (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 5 Sep 2023 02:42:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393A91B4;
        Mon,  4 Sep 2023 23:42:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A712D809E;
        Tue,  5 Sep 2023 06:42:25 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:42:24 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: convert twl-family.tx to
 json-schema
Message-ID: <20230905064224.GA11676@atomide.com>
References: <20230830182038.878265-1-andreas@kemnade.info>
 <20230830182038.878265-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830182038.878265-2-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230830 18:20]:
> +title: Texas Instruments TWL family
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>

s/me/you/ above please :)

Regards,

Tony
