From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 0/3] GPIO OMAP driver changes for v3.17
Date: Fri, 27 Jun 2014 22:17:34 +0200
Message-ID: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:43706 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbaF0UR5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 16:17:57 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so5799076wes.7
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2014 13:17:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <jmartinez@softcrates.net>

Hi Linus,

This is a small series with trivial changes to the gpio-omap driver.

There are no functional changes. Patches 1 and 2 removes code that it's
not necessary anymore now that the driver has been converted to use the
gpiolib irqchip and Patch 3 adds an "omap" prefix to all driver functions,
something that you suggested me to do before if I remember correctly.

The patch-set is composed of the following patches:

Javier Martinez Canillas (3):
  gpio: omap: Remove unnecessary lockdep class
  gpio: omap: Remove unneeded include
  gpio: omap: Add an omap prefix to all functions

 drivers/gpio/gpio-omap.c | 275 +++++++++++++++++++++++------------------------
 1 file changed, 137 insertions(+), 138 deletions(-)

Best regards,
Javier
