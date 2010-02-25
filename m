From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH 0/4] USB MUSB patches for OMAP4
Date: Thu, 25 Feb 2010 12:03:44 +0530
Message-ID: <1267079624-14144-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0BYGdt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 01:33:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Greg,

Here is a series of driver patches that enable MUSB 
driver support for OMAP4.

Maulik Mankad(4)

[PATCH 1/4] USB: MUSB: Set transceiver interface type
[PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
[PATCH 3/4] USB: MUSB: Add OMAP4 support in MUSB driver
[PATCH 4/4] OMAP: MUSB: Enable Mentor USB options in 4430 defconfig

The patches are based on top of mainline + 
gregkh-07-usb-2.6.33-rc8.patch.

Also these patches depend on the board / arch patch
series available at [1]. 

These board specific patches are queued up
by Tony at [2] i.e linux-omap master.

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg23201.html
[2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git

The patches are tested on OMAP4430 SDP for MUSB peripheral
mode.

Thanks,
Maulik
