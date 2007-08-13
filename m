From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 52/52] musb_hdrc: Search and replace channelNum with chnum
Date: Mon, 13 Aug 2007 06:49:27 -0700
Message-ID: <11870131073851-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
	<1187013022688-git-send-email-tony@atomide.com>
	<1187013024836-git-send-email-tony@atomide.com>
	<11870130272865-git-send-email-tony@atomide.com>
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
	<11870130521115-git-send-email-tony@atomide.com>
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
	<1187013062890-git-send-email-tony@atomide.com>
	<11870130643220-git-send-email-tony@atomide.com>
	<1187013066263-git-send-email-tony@atomide.com>
	<11870130701028-git-send-email-tony@atomide.com>
	<1187013072449-git-send-email-tony@atomide.com>
	<11870130741506-git-send-email-tony@atomide.com>
	<11870130771666-git-send-email-tony@atomide.com>
	<11870130793168-git-send-email-tony@atomide.com>
	<11870130811602-git-send-email-tony@atomide.com>
	<1187013084570-git-send-email-tony@atomide.com>
	<11870130862981-git-send-email-tony@atomide.com>
	<11870130891386-git-send-email-tony@atomide.com>
	<11870130913983-git-send-email-tony@atomide.com>
	<11870130932989-git-send-email-tony@atomide.com>
	<11870130953685-git-send-email-tony@atomide.com>
	<118701309984-git-send-email-tony@atomide.com>
	<11870131023809-git-send-email-tony@atomide.com>
	<11870131044061-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870131044061-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace channelNum with chnum

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/davinci.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/musb/davinci.h
+++ b/drivers/usb/musb/davinci.h
@@ -64,10 +64,10 @@
 /* CPPI state RAM entries */
 #define DAVINCI_CPPI_STATERAM_BASE_OFFSET   0x100
 
-#define DAVINCI_TXCPPI_STATERAM_OFFSET(channelNum) \
-	(DAVINCI_CPPI_STATERAM_BASE_OFFSET +       ((channelNum)* 0x40))
-#define DAVINCI_RXCPPI_STATERAM_OFFSET(channelNum) \
-	(DAVINCI_CPPI_STATERAM_BASE_OFFSET + 0x20 +((channelNum)* 0x40))
+#define DAVINCI_TXCPPI_STATERAM_OFFSET(chnum) \
+	(DAVINCI_CPPI_STATERAM_BASE_OFFSET +       ((chnum)* 0x40))
+#define DAVINCI_RXCPPI_STATERAM_OFFSET(chnum) \
+	(DAVINCI_CPPI_STATERAM_BASE_OFFSET + 0x20 +((chnum)* 0x40))
 
 /* CPPI masks */
 #define DAVINCI_DMA_CTRL_ENABLE		1
-- 
1.5.2.3
