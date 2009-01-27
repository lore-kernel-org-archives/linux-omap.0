From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: 2.6.29-rc: remaining regression: n770_defconfig, omap_apollon_2420_defconfig
Date: Tue, 27 Jan 2009 22:50:00 +0000
Message-ID: <20090127225000.GC639@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35810 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbZA0WuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 17:50:08 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LRwkt-0002p8-8k
	for linux-omap@vger.kernel.org; Tue, 27 Jan 2009 22:50:03 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LRwkr-0001D7-8N
	for linux-omap@vger.kernel.org; Tue, 27 Jan 2009 22:50:01 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Now that the usb_port_suspend() build error is fixed in 2.6.29-rc1-git6,
n770_defconfig and omap_apollon_2420_defconfig now suffers from:

drivers/built-in.o: In function `ohci_omap_init':
hid-quirks.c:(.text+0x6c620): undefined reference to `otg_get_transceiver'
drivers/built-in.o: In function `omap_udc_probe':
hid-quirks.c:(.init.text+0x34c0): undefined reference to `otg_get_transceiver'
hid-quirks.c:(.init.text+0x3d40): undefined reference to `otg_put_transceiver'
