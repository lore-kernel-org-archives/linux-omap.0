Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBFBC004D4
	for <linux-omap@archiver.kernel.org>; Thu, 19 Jan 2023 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjASIf1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASIfZ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2023 03:35:25 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12CA4BC;
        Thu, 19 Jan 2023 00:35:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5F34780F1;
        Thu, 19 Jan 2023 08:35:23 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:35:22 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: gta04a5: cleanup i2c node names
Message-ID: <Y8kAyl5jKB+utBXb@atomide.com>
References: <20230117223059.2609390-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117223059.2609390-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230118 00:31]:
> Use generic node names.

Applying into omap-for-v6.3/dt thanks.

Tony
