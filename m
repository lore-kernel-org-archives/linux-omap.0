From: x0070977@dbdmail.itg.ti.com
Subject: [RFC/PATCH 0/2] Triton Battery charger interface driver for
     OMAP3430
Date: Fri, 20 Jun 2008 17:32:41 +0530 (IST)
Message-ID: <60975.192.168.10.89.1213963361.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:44217 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYFTMCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jun 2008 08:02:47 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5KC2gQF032060
	for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2008 07:02:47 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m5KC2d1e001326
	for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2008 07:02:40 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Tony, All,

I will post a 2 patch series to support the Triton battery charger interface
driver. This will support charging the battery through AC and USB interface. It
also provides methods to monitor battery attributes like voltage, current,
capacity, charging source, status of charging etc..

The first patch will introduce the BCI driver.

The second patch will update the twl4030-usb driver to call in functionality
supported by the BCI driver to enable/disable USB charging upon cable
attach/detach.

The driver is tested through the standard power class sysfs interface.

Comments are welcome.

Regards,
Madhu

