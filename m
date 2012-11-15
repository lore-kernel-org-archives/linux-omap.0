From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/13] MFD/rtc/gpio: twl: No need to allocate bigger
 buffer for write
Date: Thu, 15 Nov 2012 15:08:12 +0100
Message-ID: <CACRpkdYp_7Pe10Hj4mGGEEnS6xa45_UazLrz6J57Ch2KdLm8cg@mail.gmail.com>
References: <1352795334-7406-1-git-send-email-peter.ujfalusi@ti.com>
	<1352795334-7406-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60705 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767800Ab2KOOIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:08:14 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so980619eek.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Nov 2012 06:08:13 -0800 (PST)
In-Reply-To: <1352795334-7406-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Alessandro Zummo <a.zummo@towertech.it>

On Tue, Nov 13, 2012 at 9:28 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Since the twl-core has been converted to use regmap it is no longer needed
> to allocate bigger buffer for data when writing to twl.
>
> CC: Grant Likely <grant.likely@secretlab.ca>
> CC: Linus Walleij <linus.walleij@linaro.org>
> CC: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this will go through the MFD tree.

Yours,
Linus Walleij
