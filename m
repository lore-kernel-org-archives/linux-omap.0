From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] UART conversion to omap_device layer
Date: Tue, 24 Nov 2009 11:56:06 -0800
Message-ID: <1259092569-22352-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:56361 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216AbZKXT4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 14:56:06 -0500
Received: by pzk1 with SMTP id 1so5042409pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:56:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series converts the UART core and PM code to use the omap_device
layer based on the omap_hwmod layer.

This depends on the various omap_hwmod and omap_device updates from
Paul as well as omap_hwmod and omap_device patches I've sent to the
list.  The 'pm-wip/omap_device' branch in my linux-omap-pm git tree
has a collection of all these hwmod/omap_device changes.  This UART
series applies on top of the pm-wip/omap_device branch.

This series is also available in my git tree as branch 'pm-wip/uart'

Tested on 3430SDP only using 8250 driver and latest version of
omap-serial driver from Govindraj.

Govindraj R (1):
  OMAP: UART: remove 8520 assumptions from UART core

Kevin Hilman (2):
  OMAP3: add omap_hwmods for UART1,2,3
  OMAP: UART: convert to use omap_device layer

 arch/arm/mach-omap2/omap_hwmod_34xx.h |  188 +++++++++++++++
 arch/arm/mach-omap2/serial.c          |  418 ++++++++++++++++-----------------
 2 files changed, 389 insertions(+), 217 deletions(-)

