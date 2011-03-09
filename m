From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH 0/2] OMAP: Overo: Add gpio-leds and gpio-keys support
Date: Wed,  9 Mar 2011 12:20:53 -0800
Message-ID: <1299702055-12480-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45276 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1CIUVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 15:21:07 -0500
Received: by fxm17 with SMTP id 17so872047fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 12:21:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

Overo COMs and expansion boards have three LEDS and 2 push button switches
connected to GPIO pins.  This patch series adds support for utilizing
them with gpio-keys and gpio-leds.

Steve Sakoman (2):
  OMAP: Add gpio-leds support for Overo
  OMAP: Add gpio-keys support for Overo

 arch/arm/mach-omap2/board-overo.c |   93 +++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

