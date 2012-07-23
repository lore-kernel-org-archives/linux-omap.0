From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: omap: omap_mux_init_gpio() for gpio_0
Date: Mon, 23 Jul 2012 16:00:22 +0200
Message-ID: <500D58F6.40807@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:48552 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2GWOAh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 10:00:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>

I've i2c gpio expander (pca953x) IRQ attached to pin SYS_NIRQ/GPIO_0 (am3517). How can I declare this pin as GPIO and later as IRQ?

 	if (!gpio)
                return -EINVAL;

        list_for_each_entry(e, muxmodes, node) {
                struct omap_mux *m = &e->mux;
                if (gpio == m->gpio) {
                        gpio_mux = m;
                        found++;
                }
        }

        if (found == 0) {
                pr_err("%s: Could not set gpio%i\n", __func__, gpio);
                return -ENODEV;
        }

        if (found > 1) {
                pr_info("%s: Multiple gpio paths (%d) for gpio%i\n", __func__,
                        found, gpio);
                return -EINVAL;
        }

with this semantic in arch/arm/mach-omap2/mux.c it is not possible and if I comment the first constraint I get "Multiple gpio paths" error, because found == 5.

Yegor
