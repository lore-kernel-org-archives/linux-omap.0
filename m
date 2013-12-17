From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 12/41] CLK: TI: add omap4 clock init file
Date: Tue, 17 Dec 2013 09:30:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312170923440.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-13-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54192 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab3LQJaT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:30:19 -0500
In-Reply-To: <1385453182-24421-13-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> clk-44xx.c now contains the clock init functionality for omap4, including
> DT clock registration and adding of static clkdev entries.

...

> diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
> new file mode 100644
> index 0000000..3e2090b
> --- /dev/null
> +++ b/drivers/clk/ti/clk-44xx.c
> @@ -0,0 +1,328 @@
> +/*
> + * OMAP4 Clock data
> + *
> + * Copyright (C) 2009-2012 Texas Instruments, Inc.
> + * Copyright (C) 2009-2010 Nokia Corporation
> + *
> + * Paul Walmsley (paul@pwsan.com)

Please remove my name and E-mail address from this file.


- Paul
