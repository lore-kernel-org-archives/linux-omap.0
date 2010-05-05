From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 5 May 2010 18:17:08 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEC0FA@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <20100416050648.GA26263@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51346 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009Ab0EEXRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 19:17:14 -0400
In-Reply-To: <20100416050648.GA26263@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe,

Thanks for your comments...

[..]

> >+#include <plat/omap_hwmod.h>
> >+#include <plat/omap_device.h>
> 
> should the platform_driver know about hwmod and omap_device ? Paul ?
> Kevin ?

Working on these changes...

> 
> >+struct omap_keypad {
> >+
> 
> unnecessary blank line.

Removed

> 
> >+       struct platform_device *pdev;
> 
> generaly we save the struct device *.
> 
> >+       struct omap_hwmod *oh;
> >+       const struct matrix_keypad_platform_data *pdata;
> 
> you should not save the platform_data here. Generaly you should only use
> that to initialize fields on your structure. Remember that a
> platform_data will be declared as __initdata.

Removed

> 
> >+/* Interrupt thread primary handler, called in hard interrupt context */
> >+
> >+static irqreturn_t omap_keypad_interrupt(int irq, void *dev_id)
> >+{
> >+       struct omap_keypad *keypad_data = dev_id;
> >+
> >+       /* disable interrupts */
> >+       __raw_writel(OMAP4_DEF_IRQDISABLE, keypad_data->base +
> >+                               OMAP4_KBD_IRQENABLE);
> >+
> >+       /* wake up handler thread */
> >+       return IRQ_WAKE_THREAD;
> >+
> >+}
> >+
> >+/* Interrupt thread handler thread */
> >+
> >+static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> >+{
> >+       struct omap_keypad *keypad_data = dev_id;
> >+       struct input_dev *input = keypad_data->input;
> >+       unsigned char key_state[8];
> >+       int col, row, code;
> >+       u32 *new_state = (u32 *) key_state;
> >+
> >+       *new_state       = __raw_readl(keypad_data->base +
> >+                       OMAP4_KBD_FULLCODE31_0);
> >+       *(new_state + 1) = __raw_readl(keypad_data->base +
> >+                       OMAP4_KBD_FULLCODE63_32);
> >+
> >+       for (col = 0; col < keypad_data->cols; col++) {
> >+               for (row = 0; row < keypad_data->rows; row++) {
> >+                       code = MATRIX_SCAN_CODE(row, col,
> >+                                       keypad_data->row_shift);
> >+                       if (code < 0) {
> >+                               printk(KERN_INFO "Spurious key %d-%d\n",
> >+                                               col, row);
> 
> use dev_dbg()

Added

> 
> >+                               continue;
> >+                       }
> >+                       input_report_key(input, keypad_data->keycodes[code],
> >+                                       key_state[col] & (1 << row));
> 
> missing input_sync()

Added

> 
> >+static int __devinit omap_keypad_probe(struct platform_device *pdev)
> >+{
> 
> [..]
> 
> >+       length = snprintf(oh_name, hw_mod_name_len, "keyboard");
> >+       WARN(length >= hw_mod_name_len,
> >+               "String buffer overflow in keyboard device setup\n");
> 
> you're using snprintf() this WARN() shouldn't happen even, remove it.

Code now in board file, removed

> 
> >+
> >+       oh = omap_hwmod_lookup(oh_name);
> >+       if (!oh)
> >+               pr_err("Could not look up %s\n", oh_name);
> 
> I think omap_hwmod and omap_device shouldn't be here, but at least use
> dev_err();

Moving to board file...

> 
> >+
> >+       pdata = kzalloc(sizeof(struct matrix_keypad_platform_data),
> >+                               GFP_KERNEL);
> 
> this should come from platform code.

Working on these changes...


I'll have a function in 4430sdp board file that will setup hwmod and omap device called

  sdp4430_keypad_init() {
     ...
     omap_hwmod_lookup(oh_name);
     kzalloc(sizeof(struct matrix_keypad_platform_data), GFP_KERNEL);
     omap_device_build(name, id, oh, pdata,
     ...
  }

and then called within

  omap_4430sdp_init()

> 
> >+
> >+       od = omap_device_build(name, id, oh, pdata,
> >+                               sizeof(struct matrix_keypad_platform_data),
> >+                               omap_keyboard_latency,
> >+                               ARRAY_SIZE(omap_keyboard_latency), 1);
> >+       WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
> >+               name, oh_name);
> 
> this too.

Moving to board file...

> 
> >+       status = input_register_device(keypad_data->input);
> >+       if (status < 0) {
> >+               dev_err(&pdev->dev, "failed to register input device\n");
> >+               goto failed_free_device;
> >+       }
> >+
> >+       omap_keypad_config(keypad_data);
> 
> registering and configuring should be done before requesting the irq.

Changed


Best Regards
Abraham
