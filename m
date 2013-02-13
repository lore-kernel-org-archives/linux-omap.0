From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC 1/1] ARM: omap2: gpmc: Move binding documentation to memory-controller
Date: Wed, 13 Feb 2013 08:13:23 -0300
Message-ID: <1360754003-3988-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49961 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab3BMLNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 06:13:39 -0500
In-Reply-To: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

GPMC stands for General Purpose Memory Controller, and it's primarily
used to handle memories such as NOR, NAND, SRAM.
Note that this controller is also used to handle network controllers
such as smsc911x.

This patch moves the documentation binding to memory-controllers,
where it belongs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../ti-gpmc.txt => memory-controllers/ti/gpmc.txt} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/ti/gpmc.txt} (100%)

diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/bus/ti-gpmc.txt
rename to Documentation/devicetree/bindings/memory-controllers/ti/gpmc.txt
-- 
1.7.8.6

