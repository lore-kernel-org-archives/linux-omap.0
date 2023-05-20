Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A46C77B7A
	for <linux-omap@archiver.kernel.org>; Sat, 20 May 2023 09:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjETJof (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 20 May 2023 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjETJof (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 20 May 2023 05:44:35 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1CDD2
        for <linux-omap@vger.kernel.org>; Sat, 20 May 2023 02:44:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id e5b76b35-f6f2-11ed-abf4-005056bdd08f;
        Sat, 20 May 2023 12:44:22 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 20 May 2023 12:44:21 +0300
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jerome Neanne <jneanne@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <ZGiWdQcR6Zq6Aw65@surfacebook>
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Mon, May 15, 2023 at 05:36:46PM +0200, Bartosz Golaszewski kirjoitti:
> On Thu, May 11, 2023 at 4:09 PM Jerome Neanne <jneanne@baylibre.com> wrote:

...

> > +       gpio->gpio_chip = tps65219_gpio_chip;
> 
> Aren't you getting any warnings here about dropping the 'const' from
> the global structure?

But this is a copy of the contents and not the simple pointer.

-- 
With Best Regards,
Andy Shevchenko


