From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/5] gpio/omap: free irq domain in probe() failure paths
Date: Wed, 10 Apr 2013 21:33:16 +0200
Message-ID: <CACRpkdbGw8_eL2KbXU2FxSrDof=O_5tA+siZDLvTqERqa650wA@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
	<1365106576-31816-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:58327 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934758Ab3DJTdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 15:33:17 -0400
Received: by mail-ia0-f177.google.com with SMTP id w33so735144iag.22
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 12:33:16 -0700 (PDT)
In-Reply-To: <1365106576-31816-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> Currently the IRQ domain is not freed once allocated, in the case where
> omap_gpio_probe() fails. Therefore, ensure we free the domain if the
> probe does fail. Furthermore, the local variable "ret" is not needed
> and so remove this.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Hm Kevin is still listed as maintainer on this driver but on a mail
address that bounces, can you send a patch replacing him in MAINTAINERS
with yourself if you're willing to pick it up?

Anyway, patch applied.

Yours,
Linus Walleij
