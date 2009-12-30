From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 0/2] ARM : OMAP patches
Date: Wed, 30 Dec 2009 19:51:33 +0530
Message-ID: <1262182893-14305-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49095 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbZL3OWK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Dec 2009 09:22:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>

Hi,

Felipe,

Here is the Version 2 of the 2 patch series based on top of 
your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Maulik Mankad (2):
ARM : OMAP: MUSB : Pass board specific data using a structure.
ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file

The patches are compile tested and do not report
any checkpatch warnings.

The patch set addresses comments received for Version 1.

Thanks,
Maulik

