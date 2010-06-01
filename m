From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH v3 1/4] OMAP4: Keyboard controller support
Date: Mon, 31 May 2010 23:09:54 -0700
Message-ID: <20100601060954.GB7391@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F73@dlee03.ent.ti.com>
 <20100601044318.GA13883@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100601044318.GA13883@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 01, 2010 at 07:43:19AM +0300, Felipe Balbi wrote:
> On Mon, May 31, 2010 at 11:44:02PM +0200, ext Arce, Abraham wrote:
> >diff --git a/arch/arm/plat-omap/include/plat/omap4-keypad.h b/arch/arm/plat-omap/include/plat/omap4-keypad.h
> >new file mode 100644
> >index 0000000..7a6ce70
> >--- /dev/null
> >+++ b/arch/arm/plat-omap/include/plat/omap4-keypad.h
> >@@ -0,0 +1,23 @@
> >+#ifndef ARCH_ARM_PLAT_OMAP4_KEYPAD_H
> >+#define ARCH_ARM_PLAT_OMAP4_KEYPAD_H
> >+
> >+#include <linux/input/matrix_keypad.h>
> >+
> >+struct omap4_keypad_platform_data {
> >+       const struct matrix_keymap_data *keymap_data;
> >+
> >+       u8 rows;
> >+       u8 cols;
> 
> rows and cols should be passed by struct matryx_keymap_data
> 

There isn't such member in matrix_keymap_data, it only contains length
of the keymap.

> >+       u16 irq;
> >+       void __iomem *base;
> 
> base and irq are to be passed by struct resource
> 
> >+       int (*device_enable) (struct platform_device *pdev);
> >+       int (*device_shutdown) (struct platform_device *pdev);
> >+       int (*device_idle) (struct platform_device *pdev);
> 
> why are you passing these three here ?? I would expect those to be
> driver specific not board specific.

Except that driver does not seem t be using them... I am not quite sure
why they are needed.

> 
> >+       error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> >+                            IRQF_TRIGGER_FALLING,
> >+                            "omap4-keypad", keypad_data);
> >+       if (error) {
> >+               dev_err(&pdev->dev, "failed to register interrupt\n");
> >+               goto err_free_input;
> >+       }
> >+
> >+       error = input_register_device(keypad_data->input);
> 
> register the input device before enabling the irq line please, you
> might end up with 'spurious' irqs happening during probe otherwise.
> 

It is OK to register input device after registering IRQ. As soon as
input device is allocated with input_alloc_device() it can accept
events (although they will not go anywhere).

-- 
Dmitry
