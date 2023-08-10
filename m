Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D0C001DB
	for <linux-omap@archiver.kernel.org>; Thu, 10 Aug 2023 06:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjHJG1U (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 10 Aug 2023 02:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHJG1U (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 10 Aug 2023 02:27:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD7D8E3;
        Wed,  9 Aug 2023 23:27:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 35FC98105;
        Thu, 10 Aug 2023 06:27:19 +0000 (UTC)
Date:   Thu, 10 Aug 2023 09:27:17 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
Message-ID: <20230810062717.GI11676@atomide.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230809072846.GD11676@atomide.com>
 <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Shengyu Qu <wiagn233@outlook.com> [230809 11:33]:
> I think that's OK. What should I do?

Can you check if there is maybe some earlier Linux kernel commit
that this fixes?

If so we can have a Fixes tag and it will be applied automatically
to the stable kernels.

If it's adding new feature and no Fixes tag can be set, I can just
add Cc: stable for it.

Regards,

Tony
