From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] Fixes for davinci_emac
Date: Tue, 13 Jan 2015 11:29:22 -0800
Message-ID: <1421177368-19756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63097 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbAMTdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 14:33:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

Here are some fixes for davinci_emac for the issues I've noticed
recently.

Regards,

Tony

Tony Lindgren (6):
  net: davinci_emac: Fix hangs with interrupts
  net: davinci_emac: Fix runtime pm calls for davinci_emac
  net: davinci_emac: Free clock after checking the frequency
  net: davinci_emac: Fix incomplete code for getting the phy from device
    tree
  net: davinci_emac: Fix ioremap for devices with MDIO within the EMAC
    address space
  net: davinci_emac: Add support for emac on dm816x

 .../devicetree/bindings/net/davinci_emac.txt       |  3 +-
 drivers/net/ethernet/ti/davinci_emac.c             | 77 ++++++++++++++++------
 2 files changed, 58 insertions(+), 22 deletions(-)

-- 
2.1.4

