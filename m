From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: MMC/SD cards hotplug scenario
Date: Wed, 21 May 2008 11:42:04 +0530
Message-ID: <004e01c8bb09$989fac00$538918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:36121 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756289AbYEUGMq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2008 02:12:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Pierre Ossman' <drzeus@drzeus.cx>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi Pierre/All,

I have a query regarding one of the MMC/SD cards hotplug use case scenario and its expected behavior.

In the case where the MMC/SD card is removed physically from the slot during an active data transfer happening on the card, I notice
lot of
I/O errors being generated. The numbers of I/O errors seem to depend on the size of the file being copied(the errors semm to be a
mixture of FS + MMC core errors). After the end of the I/O errors I can umount the partition that was mounted and I reinsert the
card. It seem not to work very well consistently. I mean some times the card removal/insertion does seem to work that well. Whereas
card insertion/removal works perfectly fine if tested when no data transfer is happening.

Does MMC/SD core need to handle some things to support this scenario? Does MMC/SD core handle this scenario gracefully? Has anyone
tried something similar before?

As far as I understand this type of scenario can not be handled well in the controller drivers alone. Am I missing something here?

Regards,
Madhu

