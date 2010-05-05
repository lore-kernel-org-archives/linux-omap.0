From: Sebastien Jan <s-jan@ti.com>
Subject: [PATCH 0/4 v2] ks8851: support for read/write MAC address from eeprom
Date: Wed,  5 May 2010 20:45:51 +0200
Message-ID: <1273085155-1260-1-git-send-email-s-jan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42492 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889Ab0EESpI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 May 2010 14:45:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Ben Dooks <ben-linux@fluff.org>, Tristram.Ha@micrel.com, Sebastien Jan <s-jan@ti.com>

Provides the ability to update the ks8851 companion eeprom content (including the
MAC address) through ethtool or debugfs (for MAC address only).

Differences with v1:
 - added the support of eeprom access through ethtool
 - different patches split

Patch set tested on OMAP4-based test board. Build tested on net-2.6 head.

Applies on current net-2.6 head.

Sebastien Jan (4):
  ks8851: Add caching of CCR register
  ks8851: Low level functions for read/write to companion eeprom
  ks8851: companion eeprom access through ethtool
  ks8851: read/write MAC address on companion eeprom through debugfs

 drivers/net/ks8851.c |  570 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ks8851.h |   14 ++-
 2 files changed, 583 insertions(+), 1 deletions(-)

