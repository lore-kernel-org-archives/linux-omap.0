From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH v2 0/2] OMAP: Overo: Add gpio-leds and gpio-keys support
Date: Wed,  9 Mar 2011 16:08:04 -0800
Message-ID: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:65211 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1CJAIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 19:08:15 -0500
Received: by vws12 with SMTP id 12so1043567vws.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 16:08:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

Overo COMs and expansion boards have three LEDS and 2 push button switches
connected to GPIO pins.  This patch series adds support for utilizing
them with gpio-keys and gpio-leds.

Changes from version 1: Guard gpio_leds assignment with CONFIG_LEDS_GPIO check

Steve Sakoman (2):
  OMAP: Add gpio-leds support for Overo
  OMAP: Add gpio-keys support for Overo

 arch/arm/mach-omap2/board-overo.c |   95 +++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)

