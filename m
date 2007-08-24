From: Tony Lindgren <tony@atomide.com>
Subject: musb_hdrc: Fix OPT A error "B-OPT Did not detect reset after
	connecting"
Date: Fri, 24 Aug 2007 06:49:11 -0700
Message-ID: <20070824134911.GP30522@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Sr1nOIr3CvdE5hEN"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This seems to fix some random OPT failures.

Tony


--Sr1nOIr3CvdE5hEN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-td.6.4-did-not-receive-reset.patch"

From: Tony Lindgren <tony@atomide.com>
Subject: musb_hdrc: Fix OPT A error "B-OPT Did not detect reset after connecting"

Fix OPT A error "B-OPT Did not detect reset after connecting"

hub 1-0:1.0: hub_suspend
usb usb1: suspend fail, err -16
usb usb1: 'global' suspend -16
hub 1-0:1.0: activate --> -108

Signed-off-by: Tony Lindgren <tony@atomide.com>

Index: linux-selene/drivers/usb/musb/musb_core.c
===================================================================
--- linux-selene.orig/drivers/usb/musb/musb_core.c	2007-08-24 05:18:55.000000000 -0700
+++ linux-selene/drivers/usb/musb/musb_core.c	2007-08-24 06:29:37.000000000 -0700
@@ -341,6 +341,14 @@ void musb_hnp_stop(struct musb *musb)
 		DBG(1, "HNP: Stopping in unknown state %s\n",
 			otg_state_string(musb));
 	}
+
+	/*
+	 * When returning to A state after HNP, avoid hub_port_rebounce(),
+	 * which cause occasional OPT A "Did not receive reset after connect"
+	 * errors.
+	 */
+	musb->port1_status &=
+		~(1 << USB_PORT_FEAT_C_CONNECTION);
 }
 
 #endif

--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN--
