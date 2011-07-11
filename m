From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/4] OMAP: PM: omap_device: update PM domain support for v3.1
Date: Mon, 11 Jul 2011 16:29:25 -0700
Message-ID: <1310426969-30306-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:47705 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753946Ab1GKX3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 19:29:34 -0400
Received: by mail-iw0-f182.google.com with SMTP id 19so7054833iwr.27
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 16:29:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org

For v3.1, the PM core has some changes that impact various assumptions
made (by me) during the design and implementation of the PM domain
support in the omap_device layer.

This series is needed to update our PM domain layer to behave properly
under the new rules of the PM core code which are planned to be merged
for v3.1 (see recent linux-pm discussions for the gory details.)

This series is based on the pm-domains branch of Rafael Wysocki's
suspend-2.6 tree, and also depends on the patch which adds
pm_runtime_status_suspended() helper function[1].

Rafael, because of the dependencies on your pm-domains branch (due to
the pwr_domain -> pm_domain rename), it might be easiest to merge
these via your tree.   Let me know if that's OK with you.

I've tested this series with all of the PM core changes planned for
v3.1 (Rafael's linux-next branch[2]) and have done various
suspend/resume testing (including off-mode) with individual devices
disabled via /sys/devices/.../power/control.

Kevin

[1] https://patchwork.kernel.org/patch/966732/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git

Kevin Hilman (4):
  OMAP: PM: omap_device: conditionally use PM domain runtime helpers
  OMAP: PM: omap_device: add system PM methods for PM domain handling
  OMAP: PM: omap_device: add API to disable idle on suspend
  OMAP: PM: disable idle on suspend for GPIO and UART

 arch/arm/mach-omap2/Kconfig                   |    4 +-
 arch/arm/mach-omap2/gpio.c                    |    2 +
 arch/arm/mach-omap2/serial.c                  |    1 +
 arch/arm/plat-omap/include/plat/omap_device.h |    9 +++++
 arch/arm/plat-omap/omap_device.c              |   49 +++++++++++++++++++++++--
 5 files changed, 60 insertions(+), 5 deletions(-)

-- 
1.7.6

