From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: omap2plus_defconfig: Update bluetooth options
Date: Mon, 16 Mar 2015 13:00:02 -0700
Message-ID: <1426536003-7077-3-git-send-email-tony@atomide.com>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426536003-7077-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Many omaps have bluetooth, so let's make it available
as modules.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index df41f2c..6c7722d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -91,13 +91,28 @@ CONFIG_CAN=m
 CONFIG_CAN_C_CAN=m
 CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_BT=m
+CONFIG_BT_RFCOMM=m
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=m
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=m
+CONFIG_BT_HCIBTUSB=m
+CONFIG_BT_HCIBTSDIO=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_BCSP=y
 CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
 CONFIG_BT_HCIBCM203X=m
 CONFIG_BT_HCIBPA10X=m
 CONFIG_CFG80211=m
+CONFIG_BT_HCIBFUSB=m
+CONFIG_BT_HCIVHCI=m
+CONFIG_BT_MRVL=m
+CONFIG_BT_MRVL_SDIO=m
+CONFIG_AF_RXRPC=m
+CONFIG_RXKAD=m
 CONFIG_MAC80211=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.1.4
