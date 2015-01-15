From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/6] Fixes for davinci_emac
Date: Thu, 15 Jan 2015 14:45:08 -0800
Message-ID: <1421361914-4612-1-git-send-email-tony@atomide.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here's a repost of the fixes for davinci_emac with patches
updated for comments and acks collected.

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
 drivers/net/ethernet/ti/davinci_emac.c             | 96 +++++++++++++++++-----
 2 files changed, 77 insertions(+), 22 deletions(-)

-- 
2.1.4
