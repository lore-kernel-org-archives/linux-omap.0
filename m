From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: [PATCH] Make H2 board file compile without irda warning
Date: Tue, 21 Feb 2006 13:54:45 -0400
Message-ID: <9268368b0602210954x5b7bdd28p7b630fe83a52647b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11363_9470077.1140544485527"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_11363_9470077.1140544485527
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

The board file for H2 is generating a warning if compiled without
InfraRed selection.

This patch changes the location where the function h2_transceiver_mode
is assigned to structure h2_irda_data, thereby preventing the warning.

Signed-off-by Daniel Petrini <d.pensator_at_gmail.com>

Daniel Petrini
--
INdT - Manaus - Brazil

------=_Part_11363_9470077.1140544485527
Content-Type: text/x-patch; name=h2-irda-compile.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejydye5x
Content-Disposition: attachment; filename="h2-irda-compile.patch"

Index: linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c
===================================================================
--- linux-omap-2.6.git-q.orig/arch/arm/mach-omap1/board-h2.c	2006-02-21 10:11:01.000000000 -0400
+++ linux-omap-2.6.git-q/arch/arm/mach-omap1/board-h2.c	2006-02-21 11:28:18.000000000 -0400
@@ -252,6 +252,7 @@ static int h2_transceiver_mode(struct de
 
 static struct omap_irda_config h2_irda_data = {
 	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.transceiver_mode	= h2_transceiver_mode,
 };
 
 static struct resource h2_irda_resources[] = {
@@ -377,10 +378,8 @@ static void __init h2_init(void)
 	/* Irda */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
-	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
+	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN)))
 		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
-		h2_irda_data.transceiver_mode = h2_transceiver_mode;
-	}
 #endif
 
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));




------=_Part_11363_9470077.1140544485527
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_11363_9470077.1140544485527--
