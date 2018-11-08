From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/3] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date: Thu, 8 Nov 2018 14:49:28 +0530
Message-ID: <20181108091931.3342-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Tony Lindgren <tony@atomide.com>
Cc: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Couple of patches to enable i2c-omap driver to be used with TI's new
AM654 platforms.

v3:
Rebase onto v4.20-rc1
Collect Reviewed-by's on v2
Add a patch to MAINTAINERS for i2c-omap.c

Vignesh R (3):
  dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
  i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
  MAINTAINERS: Add entry for i2c-omap driver

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 MAINTAINERS                                        | 8 ++++++++
 drivers/i2c/busses/Kconfig                         | 2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.19.1
