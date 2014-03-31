From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/55]: ARM: OMAP2+: PRCM move to drivers
Date: Mon, 31 Mar 2014 18:15:39 +0300
Message-ID: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39071 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaCaPRP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

This set is continuation for the work started earlier to cleanup the CM/PRM
and attempt to make it a separate driver. This set depends on these
two sets:

CM/PRM cleanup set:
http://marc.info/?l=linux-omap&m=139395000918201&w=2

OMAP2 clock DT set:
http://comments.gmane.org/gmane.linux.ports.arm.omap/111257

This set is pretty huge but the patches can be applied in stages if need be.
Anyway, it would be good to get some feedback whether the driver folder
locations etc. are good, and whether the effort taken here will be enough
to actually move the driver. Clockdomain / powerdomain code can also be
moved easily under the drivers/power/omap folder (or someplace else if
requested) once this set is in. Also, clockdomain / powerdomain data
should be possible to convert to DT format or some sort of firmware
blob once this is done.

Patch #55 in this set is pretty massive as it moves all the C files at
the same time, this should probably be split up as multiple patches.

Testing branch pushed here (contains also the CM/PRM cleanup set and OMAP2
clock DT conversion):

tree: https://github.com/t-kristo/linux-pm.git
branch: 3.14-rc4-cm-prm-driver-v1

Testing done:
- am335x-bone: boot
- omap3-beagle: boot, suspend-resume (ret/off)
- omap4-panda-es: boot, suspend-resume (ret)
- omap5-uevm: boot

-Tero

