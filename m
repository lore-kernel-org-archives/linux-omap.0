From: Pantelis Antoniou <pantelis.antoniou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: linux 3.6-rc2, undefined reference to omap_musb_mailbox
Date: Wed, 5 Sep 2012 17:31:38 +0300
Message-ID: <3EFBA4B2-C202-4DD0-A0A9-24182FD25AE0@gmail.com>
References: <alpine.DEB.2.01.1208181741450.32497@pmeerw.net> <CAAe_U6+dFuX9fSX_epnPzX_3Zx3XBWAxE6kHDCTeuPwtn-ZQNw@mail.gmail.com> <20120820095421.GL17455@arwen.pp.htv.fi> <CAAe_U6+x+gxp2PMzuTyT=2Ox=HJtYw3DXGZLmaczi+q2oTM6TQ@mail.gmail.com> <20120820102641.GM17455@arwen.pp.htv.fi> <CAAe_U6JsPJ0b3HszOuCcu1LqEkXnC=LTQG00qwQzdB6pBnpryA@mail.gmail.com> <20120820113624.GP17455@arwen.pp.htv.fi> <alpine.DEB.2.01.1208232235200.15831@pmeerw.net> <20120824072702.GD3334@arwen.pp.htv.fi>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120824072702.GD3334-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Felipe,

That seems like what this patch of mine fixes (was about to send it when
I saw this on my mailbox).

It is not enough to just do a dependency; the patch fixes it by having
a helper that's always resident, and also making sure we don't drop
events.

Regards

-- Pantelis

On Aug 24, 2012, at 10:27 AM, Felipe Balbi wrote:

> On Thu, Aug 23, 2012 at 10:38:59PM +0200, Peter Meerwald wrote:
>> On Mon, 20 Aug 2012, Felipe Balbi wrote:
>> 
>>> On Mon, Aug 20, 2012 at 04:37:28PM +0530, ABRAHAM, KISHON VIJAY wrote:
>>>> Hi,
>>>> 
>>>> On Mon, Aug 20, 2012 at 3:56 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>>>>> On Mon, Aug 20, 2012 at 03:46:07PM +0530, ABRAHAM, KISHON VIJAY wrote:
>>>>>> Hi,
>>>>>> 
>>>>>> On Mon, Aug 20, 2012 at 3:24 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>>>>>>> On Mon, Aug 20, 2012 at 11:06:34AM +0530, ABRAHAM, KISHON VIJAY wrote:
>>>>>>>> Hi,
>>>>>>>> 
>>>>>>>> On Sat, Aug 18, 2012 at 9:34 PM, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org> wrote:
>>>>>>>>> 
>>>>>>>>> 3.6-rc2 fails to compile with
>>>>>>>>> CONFIG_USB_MUSB_HDRC=m
>>>>>>>>> CONFIG_USB_MUSB_OMAP2PLUS=m
>>>>>>>>> 
>>>>>>>>>  LD      init/built-in.o
>>>>>>>>> drivers/built-in.o: In function `twl4030_usb_irq':
>>>>>>>>> /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:518: undefined reference to `omap_musb_mailbox'
>>>>>>>>> drivers/built-in.o: In function `twl4030_usb_phy_init':
>>>>>>>>> /home/pmeerw/linux-3.6-rc2/drivers/usb/otg/twl4030-usb.c:540: undefined reference to `omap_musb_mailbox'
>>>>>>>> 
>>>>>>>> Having TWL4030_USB as a module will get rid of this.
>>>>>>>> I'll see how this can be resolved when some modules are *built-in* and
>>>>>>>> some are made as *modules*.
>>>>>>> 
>>>>>>> EXPORT_SYMBOL_GPL() should sort that out, right ?
>>>>>> 
>>>>>> No :-( I already have EXPORT_SYMBOL_GPL() in omap2430.c.
>>>>> 
>>>>> I see you're missing an "extern" on the function prototype (on the
>>>>> header). Not sure how modules.dep is generated, but maybe it needs the
>>>>> "extern" there. Can you check it out ?
>>>> 
>>>> That isn't helping either.
>>> 
>>> oh, ok... twl4030-usb is built-in... now that makes sense. Since
>>> twl4030-usb uses a symbol from omap2430, then it should depend on it,
>>> otherwise this will always happen.
>> 
>> so add USB_MUSB_OMAP2PLUS to the depends of TWL4030_USB in 
>> drivers/usb/otg/Kconfig?
> 
> correct ;-)
> 
> -- 
> balbi

commit e191e7226099d90ba077719313d4964cf42834ca
Author: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Date:   Fri Aug 10 13:07:43 2012 +0000

    musb: Introduce mailbox helper
    
    When MUSB_OMAP2 is compiled as a module while the musb mailbox callers are
    not build fails. Introduce a helper to get around the problem.

diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index f5ed3d7..6a868bc 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_USB_ATM)		+= atm/
 obj-$(CONFIG_USB_SPEEDTOUCH)	+= atm/
 
 obj-$(CONFIG_USB_MUSB_HDRC)	+= musb/
+obj-$(CONFIG_USB_MUSB_OMAP2PLUS_MBOX_HELPER)	+= musb/
 obj-$(CONFIG_USB_CHIPIDEA)	+= chipidea/
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
 obj-$(CONFIG_USB_GADGET)	+= gadget/
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 6259f0d..9201c3e 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -50,6 +50,7 @@ config USB_MUSB_TUSB6010
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
 	depends on ARCH_OMAP2PLUS
+	select USB_MUSB_OMAP2PLUS_MBOX_HELPER
 
 config USB_MUSB_AM35X
 	tristate "AM35x"
@@ -69,6 +70,9 @@ config USB_MUSB_UX500
 
 endchoice
 
+config USB_MUSB_OMAP2PLUS_MBOX_HELPER
+	bool
+
 choice
 	prompt 'MUSB DMA mode'
 	default USB_UX500_DMA if USB_MUSB_UX500
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 3b85871..9126fa2 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -12,6 +12,7 @@ musb_hdrc-$(CONFIG_DEBUG_FS)			+= musb_debugfs.o
 
 # Hardware Glue Layer
 obj-$(CONFIG_USB_MUSB_OMAP2PLUS)		+= omap2430.o
+obj-$(CONFIG_USB_MUSB_OMAP2PLUS_MBOX_HELPER)	+= omap2430_mboxhelper.o
 obj-$(CONFIG_USB_MUSB_AM35X)			+= am35x.o
 obj-$(CONFIG_USB_MUSB_DSPS)			+= musb_dsps.o
 obj-$(CONFIG_USB_MUSB_TUSB6010)			+= tusb6010.o
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index d8c6aeb..920db04 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -228,7 +228,7 @@ static inline void omap2430_low_level_init(struct musb *musb)
 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
 }
 
-void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
+static void omap_musb_mailbox_actual(enum omap_musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
 	struct musb		*musb = glue_to_musb(glue);
@@ -241,7 +241,6 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 
 	schedule_work(&glue->omap_musb_mailbox_work);
 }
-EXPORT_SYMBOL_GPL(omap_musb_mailbox);
 
 static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 {
@@ -441,6 +440,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	struct platform_device		*musb;
 	struct omap2430_glue		*glue;
 	int				ret = -ENOMEM;
+	enum omap_musb_vbus_id_status	status;
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
@@ -495,6 +495,11 @@ static int omap2430_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* set callback and process last status */
+	status = omap_musb_mailbox_set_callback(omap_musb_mailbox_actual);
+	if (status != OMAP_MUSB_UNKNOWN)
+		omap_musb_mailbox_actual(status);
+
 	return 0;
 
 err1:
@@ -508,6 +513,7 @@ static int __devexit omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
+	omap_musb_mailbox_set_callback(NULL);
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
diff --git a/drivers/usb/musb/omap2430_mboxhelper.c b/drivers/usb/musb/omap2430_mboxhelper.c
new file mode 100644
index 0000000..0eb95a5
--- /dev/null
+++ b/drivers/usb/musb/omap2430_mboxhelper.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2012 Texas Instruments
+ *
+ * Helper file to make sure the musb mailbox helper callback
+ * works with any combination of modules/built-in configuration.
+ *
+ * This file is part of the Inventra Controller Driver for Linux.
+ *
+ * The Inventra Controller Driver for Linux is free software; you
+ * can redistribute it and/or modify it under the terms of the GNU
+ * General Public License version 2 as published by the Free Software
+ * Foundation.
+ *
+ * The Inventra Controller Driver for Linux is distributed in
+ * the hope that it will be useful, but WITHOUT ANY WARRANTY;
+ * without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
+ * License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with The Inventra Controller Driver for Linux ; if not,
+ * write to the Free Software Foundation, Inc., 59 Temple Place,
+ * Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/module.h>
+#include <linux/usb/musb-omap.h>
+
+static DEFINE_SPINLOCK(omap_musb_callback_lock);
+static void (*omap_musb_callback)(enum omap_musb_vbus_id_status status) = NULL;
+static enum omap_musb_vbus_id_status omap_musb_last_status = OMAP_MUSB_UNKNOWN;
+
+void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&omap_musb_callback_lock, flags);
+	if (omap_musb_callback != NULL)
+		(*omap_musb_callback)(status);
+	omap_musb_last_status = status;
+	spin_unlock_irqrestore(&omap_musb_callback_lock, flags);
+
+}
+EXPORT_SYMBOL_GPL(omap_musb_mailbox);
+
+/* returns last status */
+enum omap_musb_vbus_id_status omap_musb_mailbox_set_callback(
+		void (*func)(enum omap_musb_vbus_id_status))
+{
+	unsigned long flags;
+	enum omap_musb_vbus_id_status status;
+
+	spin_lock_irqsave(&omap_musb_callback_lock, flags);
+	omap_musb_callback = func;
+	status = omap_musb_last_status;
+	spin_unlock_irqrestore(&omap_musb_callback_lock, flags);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(omap_musb_mailbox_set_callback);
diff --git a/include/linux/usb/musb-omap.h b/include/linux/usb/musb-omap.h
index 7774c59..33cb28f 100644
--- a/include/linux/usb/musb-omap.h
+++ b/include/linux/usb/musb-omap.h
@@ -18,12 +18,22 @@ enum omap_musb_vbus_id_status {
 	OMAP_MUSB_VBUS_OFF,
 };
 
-#if (defined(CONFIG_USB_MUSB_OMAP2PLUS) || \
-				defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE))
+#ifdef CONFIG_USB_MUSB_OMAP2PLUS_MBOX_HELPER
 void omap_musb_mailbox(enum omap_musb_vbus_id_status status);
+enum omap_musb_vbus_id_status omap_musb_mailbox_set_callback(
+		void (*func)(enum omap_musb_vbus_id_status));
 #else
-static inline void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
+static inline void
+omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 {
+	/* nothing */
+}
+
+static inline enum omap_musb_vbus_id_status
+omap_musb_mailbox_set_callback(void (*func)(enum omap_musb_vbus_id_status))
+{
+	/* always return unknown */
+	return OMAP_MUSB_UNKNOWN;
 }
 #endif
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
