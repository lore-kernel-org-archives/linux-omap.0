From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Wed, 16 Feb 2011 17:41:22 +0530
Message-ID: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59092 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759024Ab1BPMLg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:11:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

This series fixes some hwmod api return values
and also adds some state checks.
The hwmod iterator functions are made to
continue and not break if one of the
callback functions ends up with an error.

Series applies on 2.6.38-rc4 and is boot
tested on OMAP3430SDP and OMAP4430SDP
platforms.

Rajendra Nayak (3):
  OMAP2+: hwmod: Avoid setup if clock lookup failed
  OMAP2+: hwmod: Fix what _init_clock returns
  OMAP2+: hwmod: Do not break iterator fn's if one fails

 arch/arm/mach-omap2/omap_hwmod.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

