From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [net-next][PATCH 0/4] davinci_emac: read the MAC address from nvmem
Date: Fri, 30 Nov 2018 09:20:56 +0100
Message-ID: <20181130082100.6241-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series is part of a bigger series that aims at removing the platform
data structure from the at24 EEPROM driver[1].

We provide a generalized version of of_get_nvmem_mac_address(), switch the
only user of the of_ variant to using it, remove the previous
implementation and use the new routine in the davinci_emac driver.

[1] https://lkml.org/lkml/2018/11/13/884

Bartosz Golaszewski (4):
  net: ethernet: provide nvmem_get_mac_address()
  net: cadence: switch to using nvmem_get_mac_address()
  of: net: kill of_get_nvmem_mac_address()
  net: davinci_emac: use nvmem_get_mac_address()

 drivers/net/ethernet/cadence/macb_main.c |  2 +-
 drivers/net/ethernet/ti/davinci_emac.c   | 14 ++++++---
 drivers/of/of_net.c                      | 39 ------------------------
 include/linux/etherdevice.h              |  1 +
 include/linux/of_net.h                   |  6 ----
 net/ethernet/eth.c                       | 38 +++++++++++++++++++++++
 6 files changed, 49 insertions(+), 51 deletions(-)

-- 
2.19.1
