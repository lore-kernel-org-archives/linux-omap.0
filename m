From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 3/4] ARM: omap2plus_defconfig: enable support for TI CPTS
Date: Wed, 8 Jul 2015 20:57:36 +0530
Message-ID: <0947246c3e1cda5c8ef56b9f0d60fec4ce6a0026.1436368740.git.nsekhar@ti.com>
References: <cover.1436368740.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1436368740.git.nsekhar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

CPTS module of CPSW IP enables timestamp synchronization
using PTP. Enable CPTS feature of CPSW driver.

Available on AM335x, AM437x and DRA7x SoCs.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 294059d5ef80..4cb1c11d83ad 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -169,6 +169,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_TI_DAVINCI_EMAC=y
 CONFIG_TI_CPSW=y
+CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
-- 
2.4.4.408.g16da57c
