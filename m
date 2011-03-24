From: Andy Green <andy@warmcat.com>
Subject: [RFC PATCH 0/2] OMAP2+: PANDA: Provide unique-ish MAC addresses for
 Ethernet and WLAN interfaces
Date: Thu, 24 Mar 2011 21:27:20 +0000
Message-ID: <20110324211451.14936.39750.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56562 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab1CXV10 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 17:27:26 -0400
Received: by wwa36 with SMTP id 36so456497wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 14:27:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, nicolas.pitre@linaro.org, arnd@arndb.de, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

The following series solves a problem Panda suffers from where
because there is no local MAC address storage on the board, a
new random MAC address is applied to the onboard Ethernet
interface each time, and the wl12xx module's wlan0 interface is
always found with an unworkable 00:00:00:00:00:00 MAC.

The series adds an omap id-related API to generate a
6-byte Ethernet MAC address from "hashing" a little the CPU ID
registers.  It is understood from TI that these contain data
that at least in a subset of the 128 bits of the ID are unique per-CPU.

It then introduces code in the Panda board definition file to
watch network interface creation and if the device's path is on
a list, set its MAC address to the CPU ID-generated one, plus
two bits which differ according to which interface in the list
is being changed.  (This scheme was suggested by Alan Cox).

The device paths for the onboard Ethernet smsc95xx, and the
onboard WLAN wl12xx are listed, so both of these will get
assigned a consistent, unique-ish locally administered MAC
address with these patches.

It's beleived the current scheme for MAC generation from ID
data captures most of the entropy, but if there is a better scheme
more closely mapped to what the unique factory areas are advice
is welcome.

The patches are against linux-omap which already has a prerequisite
patch that fixes a problem with device ID capture on OMAP4.

---

Andy Green (2):
      OMAP2+: PANDA: Fix up random or missing MAC addresses for eth0 and wlan0
      OMAP2+: add cpu id register to MAC address helper


 arch/arm/mach-omap2/board-omap4panda.c |   91 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/id.c               |   39 ++++++++++++++
 arch/arm/mach-omap2/include/mach/id.h  |    1 
 3 files changed, 131 insertions(+), 0 deletions(-)

-- 
Signature
