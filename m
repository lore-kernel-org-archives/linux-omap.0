From: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Subject: [PATCH] ARM: dts: OMAP5: Add VGIC interrupts for KVM
Date: Tue, 17 Sep 2013 03:17:02 +0400
Message-ID: <1379373423-10486-1-git-send-email-alexander.tarasikov@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:52768 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3IPXRN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 19:17:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com

Hello,
this patch adds the interrupts definition to the Cortex A15
GIC description in the .dtsi the way it's done for most other
A15 cores. This makes KVM work in HYP mode on the OMAP5432 board.
