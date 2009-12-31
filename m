From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v3 0/2] ARM : OMAP patches
Date: Thu, 31 Dec 2009 18:51:41 +0530
Message-ID: <1262265701-17550-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41908 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZLaNVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Dec 2009 08:21:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>

Hi,

Felipe,

Here is the Version 3 of the 2 patch series based on top of 
your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Please note that this series depends on the patches 
that remove if-def's from code found at [2].

[2] http://marc.info/?l=linux-omap&m=126226514430984&w=2

Maulik Mankad (2):
ARM : OMAP: MUSB : Pass board specific data using a structure.
ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file

The patches are compile tested and do not report
any checkpatch warnings.

The patch set addresses comments received for Version 2.

Thanks,
Maulik

