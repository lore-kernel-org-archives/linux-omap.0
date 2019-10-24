From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v5 net-next 12/12] arm: omap2plus_defconfig: enable new cpsw switchdev driver
Date: Thu, 24 Oct 2019 13:09:14 +0300
Message-ID: <20191024100914.16840-13-grygorii.strashko@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191024100914.16840-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add CONFIG_TI_CPSW_SWITCHDEV option to enable new cpsw switchdev driver

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d3f50971e451..c271d409b610 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -554,3 +554,4 @@ CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SCHEDSTATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_TI_CPSW_SWITCHDEV=y
-- 
2.17.1
