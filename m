From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 0/7] gpio: omap: rework and fixes
Date: Fri, 22 May 2015 17:35:47 +0300
Message-ID: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35439 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbbEVOgE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:36:04 -0400
Received: by lbbuc2 with SMTP id uc2so14317293lbb.2
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2015 07:36:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

Hi Tony,

As I promised in [1] I've prepared a new series for OMAP GPIO driver.

Patches 1-2 are bug fixes.

Patches 3-6 is attempt (RFC/RFT) to rework OMAP GPIO driver taking into account
that GPIO Chip and GPIO IRQ Chip functionality are mostly orthogonal.

Patch 7 is second attempt (RFC/RFT) to Runtime PM APIs without checking current
GPIO bank's state with BANK_USED() macro.

Based on top of:
 030bbdb Linux 4.1-rc3

Tested on
  dra7-evm, gpiosysfs, GPIO IRQ only

Refs:
[1] gpio: omap: Fix PM runtime issue and remove most BANK_USED macros 
    http://www.spinics.net/lists/linux-gpio/msg05308.html
[2] [RFC/RFT PATCH 2/2] gpio: omap: ensure that runtime pm will disable unused gpio banks
    http://marc.info/?l=linux-gpio&m=142567003515626&w=2

Grygorii Strashko (7):
  gpio: omap: fix omap_gpio_free to not clean up irq configuration
  gpio: omap: fix error handling in omap_gpio_irq_type
  gpio: omap: rework omap_x_irq_shutdown to touch only irqs specific registers
  gpio: omap: rework omap_gpio_request to touch only gpio specific registers
  gpio: omap: rework omap_gpio_irq_startup to handle current pin state properly
  gpio: omap: clean up omap_gpio_irq_type
  gpio: omap: ensure that runtime pm will disable unused gpio banks

 drivers/gpio/gpio-omap.c | 85 ++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

-- 
1.9.1

