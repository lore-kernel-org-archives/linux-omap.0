Return-Path: <SRS0=HJjW=AY=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD8C433F2
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 18:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65CB2075D
	for <linux-omap@archiver.kernel.org>; Mon, 13 Jul 2020 18:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMSHi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:07:38 -0400
Received: from muru.com ([72.249.23.125]:36710 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgGMSHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 13 Jul 2020 14:07:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CAB0A8106;
        Mon, 13 Jul 2020 18:07:35 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:07:35 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: handle pin config bias flags
Message-ID: <20200713180735.GO5849@atomide.com>
References: <20200709223401.780051-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709223401.780051-1-drew@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Drew Fustini <drew@beagleboard.org> [200709 22:35]:
> Modify omap_gpio_set_config() to handle pin config bias flags by calling
> gpiochip_generic_config().
> 
> The pin group for the gpio line must have the corresponding pinconf
> properties:
> 
> PIN_CONFIG_BIAS_PULL_UP requires "pinctrl-single,bias-pullup"
> PIN_CONFIG_BIAS_PULL_DOWN requires "pinctrl-single,bias-pulldown"
> 
> This is necessary for pcs_pinconf_set() to find the requested bias
> parameter in the PIN_MAP_TYPE_CONFIGS_GROUP pinctrl map.

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
