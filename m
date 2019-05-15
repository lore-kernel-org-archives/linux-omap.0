From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/3] mfd: lp87565: Add support for 4-phase lp87561 combination
Date: Wed, 15 May 2019 15:38:45 +0530
Message-ID: <20190515100848.19560-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Add support for 4-phase lp87561 combination.

Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf

Keerthy (3):
  dt-bindings: mfd: lp87565: Add lp87561 configuration
  mfd: lp87565: Add support for 4-phase lp87561 combination
  regulator: lp87565: Add 4-phase lp87561 regulator support

 .../devicetree/bindings/mfd/lp87565.txt       | 36 +++++++++++++++++++
 drivers/mfd/lp87565.c                         |  4 +++
 drivers/regulator/lp87565-regulator.c         |  9 +++++
 include/linux/mfd/lp87565.h                   |  2 ++
 4 files changed, 51 insertions(+)

-- 
2.17.1
