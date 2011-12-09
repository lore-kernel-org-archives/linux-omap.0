From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 00/14] PRCM chain handler
Date: Fri, 9 Dec 2011 16:27:23 +0200
Message-ID: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab1LIO2E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

Hi,

Once more a new version, it was decided that the PRM driver will be
dropped for now, and we will have the chain handler support under
mach-omap2 directory. This will most likely be addressed in future.
Other than that, the code is pretty close to what was in version 9,
just location has changed from /drivers/mfd to /arch/arm/mach-omap2.

Tested with omap3 beagleboard, with dynamic idle and suspend, both
retention and off. omap4 should not be an issue seeing the code is
close to what was in version 9.

TEMP patches can be ignored, they are provided only for testing
purposes, and shall be replaced by uart runtime support.

-Tero

