From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv7 20/36] CLK: TI: DRA7: Add APLL support
Date: Mon, 07 Oct 2013 22:16:24 -0700
Message-ID: <20131008051624.7445.56807@quantum>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <1380098922-30340-21-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42723 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab3JHFQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 01:16:28 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so8063417pde.23
        for <linux-omap@vger.kernel.org>; Mon, 07 Oct 2013 22:16:28 -0700 (PDT)
In-Reply-To: <1380098922-30340-21-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>

Quoting Tero Kristo (2013-09-25 01:48:26)
> +
> +static const struct clk_ops apll_ck_ops = {
> +       .enable         = &dra7_apll_enable,
> +       .disable        = &dra7_apll_disable,

Looks like .is_enabled is missing?

Also have you thought about using .prepare or .unprepare for these PLLs
which might take some time to lock? The code there doesn't sleep or
schedule, but it does poll for some time while under a spinlock.
Something to think about for a future patch.

Regards,
Mike
