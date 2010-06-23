From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5 v2] omap2/3/4: serial fixes
Date: Tue, 22 Jun 2010 23:17:49 -0500
Message-ID: <1277266674-5906-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39077 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab0FWESG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Jun 2010 00:18:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

V1:
http://marc.info/?l=linux-omap&m=127074926903371&w=2

The patch for Errata i202 went through a series of discussions
ending in
V3:
http://marc.info/?l=linux-omap&m=127109794814030&w=2

This series introduces an errata variable, does a few sparse cleanups
and provides fix for an new errata.

Deepak K (1):
  omap2/3/4: serial: errata i202: fix for MDR1 access

Govindraj R (1):
  omap3: serial: Add context save and restore for mcr

Nishanth Menon(3):
  omap2/3/4: serial: remove initialization sparse warnings
  omap2/3/4: serial: kill dev_attr_sleep_timeout sparse warn
  omap2/3/4: serial: introduce errata handling

 arch/arm/mach-omap2/serial.c |   80 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 11 deletions(-)

Regards,
Nishanth Menon

Cc: Deepak K <deepak.k@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
