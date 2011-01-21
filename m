From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
 speed-up boot
Date: Fri, 21 Jan 2011 15:23:17 +0100
Message-ID: <AANLkTi=ymmg6siqwxFJyh33VwAy7ZaURcTmUZyOWEz2r@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
	<c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54819 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1AUOXR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 09:23:17 -0500
Received: by pxi15 with SMTP id 15so296122pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 06:23:17 -0800 (PST)
In-Reply-To: <c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

2011/1/21 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> How about below approach?
>
> -----------------------------------------------------
> [PATCH] ARM: smp: Skip secondary cpu calibration to speed-up boot

Hey this looks like a good way to do it,
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
