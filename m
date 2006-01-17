From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Fix AUDIO_MCBSP_DATAREAD/WRITE undefined for OMAP16xx
Date: Tue, 17 Jan 2006 19:44:15 +0100
Message-ID: <43CD3AFF.9080802@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010808060205000009020106"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808060205000009020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Define AUDIO_MCBSP_DATAREAD/WRITE for OMAP16xx as well

Fix error

sound/oss/omap-audio-dma-intfc.c:715: error: `AUDIO_MCBSP_DATAWRITE'
undeclared (first use in this function)
sound/oss/omap-audio-dma-intfc.c:745: error: `AUDIO_MCBSP_DATAREAD'
undeclared (first use in this function)

Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>


--------------010808060205000009020106
Content-Type: text/plain;
 name="audio_mcbsp_readwrite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audio_mcbsp_readwrite.patch"

--- ./include/asm-arm/arch-omap/mcbsp.h_orig	2006-01-17 18:34:46.000000000 +0100
+++ ./include/asm-arm/arch-omap/mcbsp.h	2006-01-17 18:37:11.720163080 +0100
@@ -80,6 +80,9 @@
 #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
 #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
 
+#define AUDIO_MCBSP_DATAWRITE	(0)
+#define AUDIO_MCBSP_DATAREAD	(0)
+
 #elif defined(CONFIG_ARCH_OMAP24XX)
 
 #define OMAP_MCBSP_REG_DRR2	0x00


--------------010808060205000009020106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010808060205000009020106--
