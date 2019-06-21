From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v4 net-next 11/11] arm: omap2plus_defconfig: enable CONFIG_TI_CPSW_SWITCHDEV
Date: Fri, 21 Jun 2019 21:13:14 +0300
Message-ID: <20190621181314.20778-12-grygorii.strashko@ti.com>
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190621181314.20778-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 927db1d022d2..ef70b5d537de 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -561,3 +561,4 @@ CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
+CONFIG_TI_CPSW_SWITCHDEV=y
-- 
2.17.1
