From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: omap_apollon_2420_defconfig
Date: Mon, 9 Feb 2009 19:26:14 +0000
Message-ID: <20090209192614.GF19453@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33591 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZBIT0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 14:26:20 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1LWblo-0002JG-2J
	for linux-omap@vger.kernel.org; Mon, 09 Feb 2009 19:26:16 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1LWblm-00064d-Ia
	for linux-omap@vger.kernel.org; Mon, 09 Feb 2009 19:26:14 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

It would be nice to get the last OMAP defconfig in mainline working.
It's broken since 2.6.29-rc2-git3 due to this persistent problem:

drivers/built-in.o: In function `omap_udc_probe':
omap.c:(.init.text+0x30cc): undefined reference to `otg_get_transceiver'
omap.c:(.init.text+0x38a4): undefined reference to `otg_put_transceiver'
