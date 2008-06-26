From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP3: fix powerdomain hardware save-and-restore support
Date: Wed, 25 Jun 2008 18:09:34 -0600
Message-ID: <20080626000415.18779.25924.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36912 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFZAQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 20:16:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com, r-woodruff2@ti.com

This series revises the support for automatic hardware-controlled
powerdomain context save-and-restore (SAR).  Previously, this was
partially handled through the clock framework; but handling it via the
powerdomain framework is a better solution.

The patches:

- add functions to the powerdomain code to enable and disable
  automatic SAR,

- move the USBHOST SAR support from the clock fw to the powerdomain
  layer,

- add support for USBTLL SAR,

- enable SAR for all powerdomains that support it upon powerdomain
  initialization.

Boot-tested on 3430SDP ES2.

Signed-off-by: Paul Walmsley <paul@pwsan.com> 

---

size:
   text    data     bss     dec     hex filename
3391246  156920  107144 3655310  37c68e vmlinux.3430sdp.orig
3391422  156872  107144 3655438  37c70e vmlinux.3430sdp.patched

 arch/arm/mach-omap2/clock34xx.h         |   12 -----
 arch/arm/mach-omap2/pm34xx.c            |    4 ++
 arch/arm/mach-omap2/powerdomain.c       |   68 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains.h      |    3 +
 arch/arm/mach-omap2/powerdomains34xx.h  |   24 ++++++++++-
 include/asm-arm/arch-omap/powerdomain.h |   11 +++++
 6 files changed, 107 insertions(+), 15 deletions(-)

