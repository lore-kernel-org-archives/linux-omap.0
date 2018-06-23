From: David Lechner <david@lechnology.com>
Subject: [PATCH 6/8] ARM: davinci_all_defconfig: enable PRU remoteproc module
Date: Sat, 23 Jun 2018 16:08:08 -0500
Message-ID: <20180623210810.21232-7-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This enabled the remoteproc module for the PRU on DA8xx-type devices.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a1b6e106b867..1bcc7c6a03ee 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -214,6 +214,8 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
+CONFIG_TI_PRU_REMOTEPROC=m
+CONFIG_RPMSG_VIRTIO=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
-- 
2.17.1
