From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] net: davinci_emac: Add support for emac on dm816x
Date: Tue, 13 Jan 2015 11:29:28 -0800
Message-ID: <1421177368-19756-7-git-send-email-tony@atomide.com>
References: <1421177368-19756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63861 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbbAMTdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 14:33:53 -0500
In-Reply-To: <1421177368-19756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>

On dm816x we have two emac controllers with separate memory
areas.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/net/davinci_emac.txt | 3 ++-
 drivers/net/ethernet/ti/davinci_emac.c                 | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/davinci_emac.txt b/Documentation/devicetree/bindings/net/davinci_emac.txt
index 0328088..24c5cda 100644
--- a/Documentation/devicetree/bindings/net/davinci_emac.txt
+++ b/Documentation/devicetree/bindings/net/davinci_emac.txt
@@ -4,7 +4,8 @@ This file provides information, what the device node
 for the davinci_emac interface contains.
 
 Required properties:
-- compatible: "ti,davinci-dm6467-emac" or "ti,am3517-emac"
+- compatible: "ti,davinci-dm6467-emac", "ti,am3517-emac" or
+  "ti,dm816-emac"
 - reg: Offset and length of the register set for the device
 - ti,davinci-ctrl-reg-offset: offset to control register
 - ti,davinci-ctrl-mod-reg-offset: offset to control module register
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 0342273..5caee66 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -2101,9 +2101,14 @@ static const struct emac_platform_data am3517_emac_data = {
 	.hw_ram_addr		= 0x01e20000,
 };
 
+static const struct emac_platform_data dm816_emac_data = {
+	.version		= EMAC_VERSION_2,
+};
+
 static const struct of_device_id davinci_emac_of_match[] = {
 	{.compatible = "ti,davinci-dm6467-emac", },
 	{.compatible = "ti,am3517-emac", .data = &am3517_emac_data, },
+	{.compatible = "ti,dm816-emac", .data = &dm816_emac_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, davinci_emac_of_match);
-- 
2.1.4

