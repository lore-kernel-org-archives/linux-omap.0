From: David Anders <x0132446@ti.com>
Subject: [PATCH 0/4] omap4: pandaboard: machine cleanups
Date: Wed,  6 Oct 2010 16:12:46 -0500
Message-ID: <1286399570-853-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932838Ab0JFVNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 17:13:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.arm.linux.org.uk, jayabharath@ti.com
Cc: David Anders <x0132446@ti.com>

PandaBoard machine file related cleanups.

David Anders (4):
  omap4: pandaboard: remove unused hsmmc definition
  omap4: pandaboard: Fix the init if CONFIG_MMC_OMAP_HS is not set
  omap4: pandaboard: Adding card detect support for MMC1
  omap4: pandaboard: enable the ehci port on pandaboard

 arch/arm/mach-omap2/board-omap4panda.c |   76 +++++++++++++++++++++++++++++---
 1 files changed, 69 insertions(+), 7 deletions(-)

