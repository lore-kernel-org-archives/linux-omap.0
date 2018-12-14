From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Date: Fri, 14 Dec 2018 13:16:16 +0000
Message-ID: <20181214131616.GM9507@n2100.armlinux.org.uk>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
 <20181213155054.GK9507@n2100.armlinux.org.uk>
 <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f4961633-a151-145f-4337-dedbcafa64bd@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 14, 2018 at 03:08:09PM +0200, Peter Ujfalusi wrote:
> I certainly have the version of u-boot which can do only one tftp load
> (or dhcp request).

That'll be because of the buggy KS8851 driver.  This is the patch I
have on top of my 2014 version of Nishanth's tree.

diff --git a/drivers/net/ks8851.c b/drivers/net/ks8851.c
index 6467dde7ebf6..f888f43ad937 100644
--- a/drivers/net/ks8851.c
+++ b/drivers/net/ks8851.c
@@ -27,6 +27,27 @@
 
 #include "ks8851.h"
 #define KS8851_SNL		1
+#undef DEBUG
+
+static void dump_mem(const char *str, const void *base, unsigned orig, unsigned len)
+{
+#ifdef DEBUG
+	const unsigned char *p = base;
+	unsigned i, j;
+
+	printf("%s:", str);
+	
+	for (j = 0; j < len; j += 32) {
+		printf("\n%04x:", j);
+		for (i = j; i < j + 32 && i < len; i++)
+			printf("%s%s%02x",
+				(i == j + 16) ? " " : "",
+				i == orig ? "|" : " ",
+				p[i]);
+	}
+	printf("\n");
+#endif
+}
 
 /*
  * GET_KS8851SNL_RWWORD_CMD
@@ -324,6 +345,7 @@ void KS8851SNL_READ_BUFFER(void *pHardware,
 		pdw++;
 		*puReadLen = (u16)((*pdw) >> 16);
 		*ppOut = pIn + 8;
+dump_mem("RX", pMove, spiBurstLen + 8, spiBurstLen + 8);
 	}
 
 	if (spiBurstFlag != SPI_READ_BURST_ALL) {
@@ -626,6 +648,7 @@ static int ks8851_eth_recv(struct eth_device *dev)
 			printf("frame count = %d\n", rxFrameCount);
 #endif
 
+			pHardware->m_uCurFrameIndex = 0;
 			pHardware->m_uFramesRemained = rxFrameCount;
 
 			if (rxFrameCount == 0)
@@ -697,7 +720,7 @@ static int ks8851_eth_send(struct eth_device *dev,
 	uiPacketLength = length;
 	GET_DATA_ALIGNMENT(length, &uiPacketLength);
 	HW_WRITE_START(pHardware);
-
+dump_mem("TX", packet, length, uiPacketLength);
 #ifdef KS8851_SNL
 	KS8851SNL_DATA_WRITE((u8 *)packet, length, uiPacketLength, &fReturn);
 #else
@@ -722,12 +745,19 @@ static int ks8851_eth_send(struct eth_device *dev,
 	return 1;
 }
 
+static int ks8851_eth_init2(struct eth_device *dev, bd_t *bd)
+{
+	return 0;
+}
+
 static int ks8851_eth_init(struct eth_device *dev, bd_t *bd)
 {
 
 	u16 txCntl, rxCntl, w, intMask;
 	PHARDWARE pHardware = &gHardware;
 
+	dev->init = ks8851_eth_init2;
+
 	pHardware->m_uCurFrameIndex = 0;
 	pHardware->m_uFramesRemained = 0;
 	pHardware->m_uCurRecvFrams = MAX_RECV_FRAMES;
diff --git a/include/configs/omap4_sdp4430.h b/include/configs/omap4_sdp4430.h
index 0d9c16ea9f04..ae94dd852f3d 100644
--- a/include/configs/omap4_sdp4430.h
+++ b/include/configs/omap4_sdp4430.h
@@ -21,6 +21,9 @@
 
 #include <configs/omap4_common.h>
 
+#undef CONFIG_SYS_PROMPT
+#define CONFIG_SYS_PROMPT             "OMAP44XX SDP # "
+
 #ifndef CONFIG_SPL_BUILD
 /* Battery Charger */
 #define CONFIG_CMD_BAT			1


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
