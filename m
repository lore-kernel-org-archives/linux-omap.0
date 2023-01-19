Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05DC46467
	for <linux-omap@archiver.kernel.org>; Thu, 19 Jan 2023 08:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjASIfF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjASIfC (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jan 2023 03:35:02 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91ACABC;
        Thu, 19 Jan 2023 00:35:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E195880F1;
        Thu, 19 Jan 2023 08:35:00 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:34:59 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: omap: gta04: add BNO055 IMU chip
Message-ID: <Y8kAs1oaguxKJToi@atomide.com>
References: <20230117223002.2609301-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117223002.2609301-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230118 00:30]:
> There is finally a driver upstreamed, so add the
> device.

Applying into omap-for-v6.3/dt thanks.

Tony
