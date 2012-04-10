From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: omap-hsmmc build broken with OF enabled in latest kernel
Date: Tue, 10 Apr 2012 10:54:44 +0100
Message-ID: <20120410095444.GO24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35340 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2DJJzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 05:55:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Rob Herring <rob.herring@calxeda.com>, Chris Ball <cjb@laptop.org>, linux-omap@vger.kernel.org

This commit:

commit 46856a68dcb5f67c779d211fd6bcb5d7a2a7f19b
Author: Rajendra Nayak <rnayak@ti.com>
Date:   Mon Mar 12 20:32:37 2012 +0530

    mmc: omap_hsmmc: Convert hsmmc driver to use device tree

    Define dt bindings for the ti-omap-hsmmc, and adapt the driver to extract
    data (which was earlier passed as platform_data) from device tree.

    Signed-off-by: Rajendra Nayak <rnayak@ti.com>
    Acked-by: Rob Herring <rob.herring@calxeda.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>

breaks omap-hsmmc compilation:

drivers/mmc/host/omap_hsmmc.c:1745: error: expected ',' or ';' before 'extern'

+#ifdef CONFIG_OF
+static u16 omap4_reg_offset = 0x100;
+
+static const struct of_device_id omap_mmc_of_match[] = {
...
+}
+MODULE_DEVICE_TABLE(of, omap_mmc_of_match);

There should be a ';' after the }.
