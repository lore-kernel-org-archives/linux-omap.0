From: Vivek Gautam <gautam.vivek@samsung.com>
Subject: [PATCH 1/2] phy: Move ULPI phy header out of driver to includes path
Date: Wed, 06 Apr 2016 19:37:44 +0530
Message-ID: <1459951665-28708-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: vireshk@kernel.org, shiraz.linux.kernel@gmail.com, kishon@ti.com, heiko@sntech.de, maxime.ripard@free-electrons.com, wens@csie.org, k.kozlowski@samsung.com
Cc: linux@arm.linux.org.uk, gautam.vivek@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, cpgs@samsung.com
List-Id: linux-omap@vger.kernel.org

Although ULPI phy is currently being used by tusb1210,
there can be other consumers too in future. So move this
to the includes path for phy.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 {drivers => include/linux}/phy/ulpi_phy.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {drivers => include/linux}/phy/ulpi_phy.h (100%)

diff --git a/drivers/phy/ulpi_phy.h b/include/linux/phy/ulpi_phy.h
similarity index 100%
rename from drivers/phy/ulpi_phy.h
rename to include/linux/phy/ulpi_phy.h
-- 
1.9.1
