From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Fri, 16 Apr 2010 08:06:48 +0300
Message-ID: <20100416050648.GA26263@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "ext Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Apr 14, 2010 at 03:10:48AM +0200, ext Arce, Abraham wrote:
>+#include <linux/module.h>
>+#include <linux/init.h>
>+#include <linux/interrupt.h>
>+#include <linux/platform_device.h>
>+#include <linux/errno.h>
>+#include <linux/io.h>
>+#include <linux/input.h>
>+#include <linux/input/matrix_keypad.h>
>+#include <plat/omap_hwmod.h>
>+#include <plat/omap_device.h>

should the platform_driver know about hwmod and omap_device ? Paul ? 
Kevin ?

>+struct omap_keypad {
>+

unnecessary blank line.

>+       struct platform_device *pdev;

generaly we save the struct device *.

>+       struct omap_hwmod *oh;
>+       const struct matrix_keypad_platform_data *pdata;

you should not save the platform_data here. Generaly you should only use 
that to initialize fields on your structure. Remember that a 
platform_data will be declared as __initdata.

>+/* Interrupt thread primary handler, called in hard interrupt context */
>+
>+static irqreturn_t omap_keypad_interrupt(int irq, void *dev_id)
>+{
>+       struct omap_keypad *keypad_data = dev_id;
>+
>+       /* disable interrupts */
>+       __raw_writel(OMAP4_DEF_IRQDISABLE, keypad_data->base +
>+                               OMAP4_KBD_IRQENABLE);
>+
>+       /* wake up handler thread */
>+       return IRQ_WAKE_THREAD;
>+
>+}
>+
>+/* Interrupt thread handler thread */
>+
>+static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
>+{
>+       struct omap_keypad *keypad_data = dev_id;
>+       struct input_dev *input = keypad_data->input;
>+       unsigned char key_state[8];
>+       int col, row, code;
>+       u32 *new_state = (u32 *) key_state;
>+
>+       *new_state       = __raw_readl(keypad_data->base +
>+                       OMAP4_KBD_FULLCODE31_0);
>+       *(new_state + 1) = __raw_readl(keypad_data->base +
>+                       OMAP4_KBD_FULLCODE63_32);
>+
>+       for (col = 0; col < keypad_data->cols; col++) {
>+               for (row = 0; row < keypad_data->rows; row++) {
>+                       code = MATRIX_SCAN_CODE(row, col,
>+                                       keypad_data->row_shift);
>+                       if (code < 0) {
>+                               printk(KERN_INFO "Spurious key %d-%d\n",
>+                                               col, row);

use dev_dbg()

>+                               continue;
>+                       }
>+                       input_report_key(input, keypad_data->keycodes[code],
>+                                       key_state[col] & (1 << row));

missing input_sync()

>+static int __devinit omap_keypad_probe(struct platform_device *pdev)
>+{

[..]

>+       length = snprintf(oh_name, hw_mod_name_len, "keyboard");
>+       WARN(length >= hw_mod_name_len,
>+               "String buffer overflow in keyboard device setup\n");

you're using snprintf() this WARN() shouldn't happen even, remove it.

>+
>+       oh = omap_hwmod_lookup(oh_name);
>+       if (!oh)
>+               pr_err("Could not look up %s\n", oh_name);

I think omap_hwmod and omap_device shouldn't be here, but at least use 
dev_err();

>+
>+       pdata = kzalloc(sizeof(struct matrix_keypad_platform_data),
>+                               GFP_KERNEL);

this should come from platform code.

>+
>+       od = omap_device_build(name, id, oh, pdata,
>+                               sizeof(struct matrix_keypad_platform_data),
>+                               omap_keyboard_latency,
>+                               ARRAY_SIZE(omap_keyboard_latency), 1);
>+       WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
>+               name, oh_name);

this too.

>+       status = input_register_device(keypad_data->input);
>+       if (status < 0) {
>+               dev_err(&pdev->dev, "failed to register input device\n");
>+               goto failed_free_device;
>+       }
>+
>+       omap_keypad_config(keypad_data);

registering and configuring should be done before requesting the irq.

-- 
balbi
