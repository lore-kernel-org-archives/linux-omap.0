From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 23/23] usb: host: ehci: add few comments and todo
Date: Mon, 23 Feb 2009 20:55:35 +0200
Message-ID: <1235415335-17408-24-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
 <1235415335-17408-19-git-send-email-me@felipebalbi.com>
 <1235415335-17408-20-git-send-email-me@felipebalbi.com>
 <1235415335-17408-21-git-send-email-me@felipebalbi.com>
 <1235415335-17408-22-git-send-email-me@felipebalbi.com>
 <1235415335-17408-23-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43154 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbZBWTAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 14:00:12 -0500
In-Reply-To: <1235415335-17408-23-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Still a few stuff to be done with this driver, so add TODO
for us to keep track of what has to be done still.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ebfed95..ad2a353 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -26,6 +26,14 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
+ * TODO (last updated Feb 23rd, 2009):
+ *	- add kernel-doc
+ *	- enable AUTOIDLE
+ *	- move DPLL5 programming to clock fw
+ *	- add suspend/resume
+ *	- move workarounds to board-files
+ *	- differentiate between ES2.x and ES3.x
+ *	- make it enumerate devices
  */
 
 #include <linux/platform_device.h>
@@ -145,6 +153,15 @@ struct ehci_hcd_omap {
 	struct clk		*usbtll_fck;
 	struct clk		*usbtll_ick;
 
+	/* FIXME the following two workarounds are
+	 * board specific not silicon-specific so these
+	 * should be moved to board-file instead.
+	 *
+	 * Maybe someone from TI will know better which
+	 * board is affected and needs the workarounds
+	 * to be applied
+	 */
+
 	/* gpio for resetting phy */
 	int			reset_gpio_port1;
 	int			reset_gpio_port2;
-- 
1.6.1.3

