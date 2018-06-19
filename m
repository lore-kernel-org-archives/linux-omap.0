From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] net: davinci_emac: fix suspend/resume (both a regression and a common clk problem)
Date: Tue, 19 Jun 2018 18:09:47 +0200
Message-ID: <20180619160950.6283-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Earlier today I sent the first patch as a solution to a regression
introduced during the v4.16 merge window, but after testing David's
common clock series on top of 4.18-rc1 + this patch it turned out that
the problem persisted.

This is a follow-up containing the regression fix and two additional
patches that make suspend/resume work with David's changes.

Bartosz Golaszewski (3):
  net: ethernet: fix suspend/resume in davinci_emac
  net: phy: set the of_node in the mdiodev's struct device
  net: davinci_emac: match the mdio device against its compatible if
    possible

 drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
 drivers/net/phy/phy_device.c           |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1
