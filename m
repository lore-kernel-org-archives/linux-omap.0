Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B3BC61DA4
	for <linux-omap@archiver.kernel.org>; Fri, 24 Feb 2023 12:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBXMS1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Feb 2023 07:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBXMS1 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2023 07:18:27 -0500
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE45DCE7
        for <linux-omap@vger.kernel.org>; Fri, 24 Feb 2023 04:18:25 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 54d54290-b43d-11ed-a2f4-005056bdd08f;
        Fri, 24 Feb 2023 14:18:23 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Fri, 24 Feb 2023 14:18:22 +0200
To:     andy.shevchenko@gmail.com
Cc:     Jerome Neanne <jneanne@baylibre.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, tony@atomide.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <Y/irDl8GuKv0EPK6@surfacebook>
References: <20230224113837.874264-1-jneanne@baylibre.com>
 <20230224113837.874264-2-jneanne@baylibre.com>
 <Y/iqhsEIvHgnZ+5l@surfacebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/iqhsEIvHgnZ+5l@surfacebook>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Fri, Feb 24, 2023 at 02:16:06PM +0200, andy.shevchenko@gmail.com kirjoitti:
> Fri, Feb 24, 2023 at 12:38:36PM +0100, Jerome Neanne kirjoitti:

...

> > +#include <linux/of.h>

Forgot to add that there is no user of this header.

-- 
With Best Regards,
Andy Shevchenko


