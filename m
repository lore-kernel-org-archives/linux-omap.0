From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 01/48] usb: gadget: encapsulate endpoint claiming mechanism
Date: Tue, 14 Jul 2015 11:38:49 +0200
Message-ID: <1436866776-5004-2-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

So far it was necessary for usb functions to set ep->driver_data in
endpoint obtained from autoconfig to non-null value, to indicate that
endpoint is claimed by function (in autoconfig it was checked if endpoint
has set this field to non-null value, and if it has, it was assumed that
it is claimed). It could cause bugs becouse if some function doesn't
set this field autoconfig could return the same endpoint more than one
time.

To help to avoid such bugs this patch adds claimed flag to struct usb_ep,
and  encapsulates endpoint claiming mechanism inside usb_ep_autoconfig_ss()
and usb_ep_autoconfig_reset(), so now usb functions doesn't need to perform
any additional actions to mark endpoint obtained from autoconfig as claimed.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 11 ++++++-----
 include/linux/usb/gadget.h      |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 919cdfd..8e00ca7 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -53,7 +53,7 @@ ep_matches (
 	int		num_req_streams = 0;
 
 	/* endpoint already claimed? */
-	if (NULL != ep->driver_data)
+	if (ep->claimed)
 		return 0;
 
 	/* only support ep0 for portable CONTROL traffic */
@@ -240,7 +240,7 @@ find_ep (struct usb_gadget *gadget, const char *name)
  * updated with the assigned number of streams if it is
  * different from the original value. To prevent the endpoint
  * from being returned by a later autoconfig call, claim it by
- * assigning ep->driver_data to some non-null value.
+ * assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -323,6 +323,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 found_ep:
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
+	ep->claimed = true;
 	return ep;
 }
 EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
@@ -354,7 +355,7 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
  * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
  * is initialized as if the endpoint were used at full speed.  To prevent
  * the endpoint from being returned by a later autoconfig call, claim it
- * by assigning ep->driver_data to some non-null value.
+ * by assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -373,7 +374,7 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
  *
  * Use this for devices where one configuration may need to assign
  * endpoint resources very differently from the next one.  It clears
- * state such as ep->driver_data and the record of assigned endpoints
+ * state such as ep->claimed and the record of assigned endpoints
  * used by usb_ep_autoconfig().
  */
 void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
@@ -381,7 +382,7 @@ void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 	struct usb_ep	*ep;
 
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		ep->driver_data = NULL;
+		ep->claimed = false;
 	}
 	gadget->in_epnum = 0;
 	gadget->out_epnum = 0;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 4f3dfb7..fcb0a4e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -173,6 +173,7 @@ struct usb_ep {
 	const char		*name;
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
+	bool			claimed;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
 	unsigned		max_streams:16;
-- 
1.9.1
