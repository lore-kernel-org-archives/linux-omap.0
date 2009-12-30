From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH 0/2] ARM : OMAP patches
Date: Wed, 30 Dec 2009 16:13:56 +0530
Message-ID: <1262169836-31147-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53934 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbZL3KoN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Dec 2009 05:44:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>

Hi,

Felipe,

Here is the 2 patch series based on top of 
your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Maulik Mankad (2):
ARM : OMAP: MUSB : Pass board specific data using a structure.
ARM : OMAP4 : MUSB : Add USB support to 4430 SDP board file

The patches are compile tested and do not report
any checkpatch warnings.

The rest of the OMAP4 driver patches shall go through Greg.

Please comment.

Thanks,
Maulik

