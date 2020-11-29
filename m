Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167EC3E8C5
	for <linux-omap@archiver.kernel.org>; Sun, 29 Nov 2020 11:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E89D206E3
	for <linux-omap@archiver.kernel.org>; Sun, 29 Nov 2020 11:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2L6d (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 29 Nov 2020 06:58:33 -0500
Received: from fgw23-4.mail.saunalahti.fi ([62.142.5.110]:23253 "EHLO
        fgw23-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgK2L6c (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Sun, 29 Nov 2020 06:58:32 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-71-224-nat.elisa-mobile.fi [85.76.71.224])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 19abebeb-323a-11eb-8ccd-005056bdfda7;
        Sun, 29 Nov 2020 13:57:49 +0200 (EET)
Date:   Sun, 29 Nov 2020 13:57:48 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] Broken USB/GPIO on OMAP1 OSK
Message-ID: <20201129115748.GG551434@darkstar.musicnaut.iki.fi>
References: <20201128235154.GF551434@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128235154.GF551434@darkstar.musicnaut.iki.fi>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

On Sun, Nov 29, 2020 at 01:51:54AM +0200, Aaro Koskinen wrote:
> I tried to upgrade my OMAP1 OSK board to v5.9, but the rootfs cannot
> be accessed anymore due to broken USB. It fails to probe with the
> following logs:
> 
> [    9.219940] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
> [    9.250366] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
> [    9.731445] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
> [   10.342102] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
> [   10.966430] ohci ohci: cannot find GPIO chip i2c-tps65010, deferring
> 
> Bisected to:
> 
> commit 15d157e874437e381643c37a10922388d6e55b29
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Mon Jul 20 15:55:24 2020 +0200
> 
>     usb: ohci-omap: Convert to use GPIO descriptors
> 
> I suspect one of the issues is the name "i2c-tps65010" vs "tps65010":
> 
> # cat /sys/devices/platform/omap_i2c.1/i2c-1/i2c-tps65010/gpio/gpiochip208/label
> tps65010
> 
> However changing that in the lookup table still doesn't help much; I got rid
> of the "deferring" message but the USB still doesn't work. So far the only
> workaround I have is to revert the whole commit.

GPIO numbering goes wrong... It's now trying to poke GPIO2.

Also gpiod_set_value_cansleep() probably should be used as tps65010
can sleep.

A.
