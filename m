From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND/PATCHv2] Input: omap-keypad: dynamically handle register
 offsets
Date: Wed, 9 May 2012 00:45:39 -0700
Message-ID: <20120509074539.GI10514@core.coreip.homeip.net>
References: <1335419677-24934-1-git-send-email-sourav.poddar@ti.com>
 <20120509051809.GA10514@core.coreip.homeip.net>
 <CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48013 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2EIHpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 03:45:44 -0400
Content-Disposition: inline
In-Reply-To: <CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, akpm@linux-foundation.org

> Hi Dmitry ,
>=20
>=20
> On Wed, May 9, 2012 at 10:48 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Ho Sourav,
> >
> > On Thu, Apr 26, 2012 at 11:24:37AM +0530, Sourav Poddar wrote:
> >>
> >> -config KEYBOARD_OMAP4
> >> - =A0 =A0 tristate "TI OMAP4 keypad support"
> >> +config KEYBOARD_OMAP4+
> >
> > I think this works purely by accident - '+' sign getting dropped by
> > parser...
> >
> >> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input_de=
v *input)
> >>
> >> =A0 =A0 =A0 disable_irq(keypad_data->irq);
> >>
> >> - =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP=
4_KBD_CTRL);
> >> - =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP=
4_KBD_DEBOUNCINGTIME);
> >> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP=
4_KBD_IRQSTATUS);
> >> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQ=
ENABLE_LONGKEY,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP=
4_KBD_IRQENABLE);
> >> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LON=
G_KEY_ENA,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP=
4_KBD_WAKEUPENABLE);
> >> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
> >> + =A0 =A0 switch (keypad_data->revision) {
> >> + =A0 =A0 case 1:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQ=
STATUS + 0x0c;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQ=
ENABLE + 0x0c;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >
> > This should be done in probe().
> >
> Dont we then require "pm_runtime_put_sync" in probe, since we are try=
ing
> to read the keypad revision register.?

Ah, indeed, but I think not pm_runtime_get_sync() but
pm_runtime_set_active().

Not sure if this will fix the crash...

--=20
Dmitry


Input: omap-keypad - dynamically handle register offsets

=46rom: G, Manjunath Kondaiah <manjugk@ti.com>

Keypad controller register offsets are different for omap4
and omap5. Handle these offsets through static mapping and
assign these mappings during run time.

Tested on omap4430 sdp with 3.4-rc3.
Tested on omap5430evm with 3.1-custom kernel.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Kconfig        |    4 +
 drivers/input/keyboard/omap4-keypad.c |  117 +++++++++++++++++++++++++=
+-------
 2 files changed, 94 insertions(+), 27 deletions(-)


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
index 20a3753..84ee155 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -531,9 +531,9 @@ config KEYBOARD_OMAP
 	  module will be called omap-keypad.
=20
 config KEYBOARD_OMAP4
-	tristate "TI OMAP4 keypad support"
+	tristate "TI OMAP4+ keypad support"
 	help
-	  Say Y here if you want to use the OMAP4 keypad.
+	  Say Y here if you want to use the OMAP4+ keypad.
=20
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap4-keypad.
diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyb=
oard/omap4-keypad.c
index e809ac0..c9fd0df 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -68,19 +68,52 @@
=20
 #define OMAP4_MASK_IRQSTATUSDISABLE	0xFFFF
=20
+enum {
+	KBD_REVISION_OMAP4 =3D 0,
+	KBD_REVISION_OMAP5,
+};
+
 struct omap4_keypad {
 	struct input_dev *input;
=20
 	void __iomem *base;
-	int irq;
+	unsigned int irq;
=20
 	unsigned int rows;
 	unsigned int cols;
+	u32 reg_offset;
+	u32 irqreg_offset;
 	unsigned int row_shift;
 	unsigned char key_state[8];
 	unsigned short keymap[];
 };
=20
+static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
+{
+	return __raw_readl(keypad_data->base +
+				keypad_data->reg_offset + offset);
+}
+
+static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u=
32 value)
+{
+	__raw_writel(value,
+		     keypad_data->base + keypad_data->reg_offset + offset);
+}
+
+static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 offse=
t)
+{
+	return __raw_readl(keypad_data->base +
+				keypad_data->irqreg_offset + offset);
+}
+
+static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
+			     u32 offset, u32 value)
+{
+	__raw_writel(value,
+		     keypad_data->base + keypad_data->irqreg_offset + offset);
+}
+
+
 /* Interrupt handler */
 static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
 {
@@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int irq,=
 void *dev_id)
 	u32 *new_state =3D (u32 *) key_state;
=20
 	/* Disable interrupts */
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+			 OMAP4_VAL_IRQDISABLE);
=20
-	*new_state =3D __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE31_0=
);
-	*(new_state + 1) =3D __raw_readl(keypad_data->base
-						+ OMAP4_KBD_FULLCODE63_32);
+	*new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_0);
+	*(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE63_32);
=20
 	for (row =3D 0; row < keypad_data->rows; row++) {
 		changed =3D key_state[row] ^ keypad_data->key_state[row];
@@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int irq=
, void *dev_id)
 		sizeof(keypad_data->key_state));
=20
 	/* clear pending interrupts */
-	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
+			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
=20
 	/* enable interrupts */
-	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKE=
Y,
-			keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+		OMAP4_DEF_IRQENABLE_EVENTEN |
+				OMAP4_DEF_IRQENABLE_LONGKEY);
=20
 	return IRQ_HANDLED;
 }
@@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev *in=
put)
=20
 	disable_irq(keypad_data->irq);
=20
-	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
-			keypad_data->base + OMAP4_KBD_CTRL);
-	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
-			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
-	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKE=
Y,
-			keypad_data->base + OMAP4_KBD_IRQENABLE);
-	__raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA,
-			keypad_data->base + OMAP4_KBD_WAKEUPENABLE);
+	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
+			OMAP4_VAL_FUNCTIONALCFG);
+	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
+			OMAP4_VAL_DEBOUNCINGTIME);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
+			OMAP4_VAL_IRQDISABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+			OMAP4_DEF_IRQENABLE_EVENTEN |
+				OMAP4_DEF_IRQENABLE_LONGKEY);
+	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
+			OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA);
=20
 	enable_irq(keypad_data->irq);
=20
@@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_dev *=
input)
 	disable_irq(keypad_data->irq);
=20
 	/* Disable interrupts */
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+			 OMAP4_VAL_IRQDISABLE);
=20
 	/* clear pending interrupts */
-	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
+			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
=20
 	enable_irq(keypad_data->irq);
=20
@@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct plat=
form_device *pdev)
 	struct resource *res;
 	resource_size_t size;
 	unsigned int row_shift, max_keys;
+	int rev;
 	int irq;
 	int error;
=20
@@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struct pl=
atform_device *pdev)
 	keypad_data->rows =3D pdata->rows;
 	keypad_data->cols =3D pdata->cols;
=20
+	/*
+	 * Mark device as active (and wake up its parent) so we can read
+	 * revision register.
+	 */
+	error =3D pm_runtime_set_active(&pdev->dev);
+	if (error) {
+		dev_err(&pdev->dev, "pm_runtime_set_active() failed\n");
+		goto err_unmap;
+	}
+
+	rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REVISION);
+	rev &=3D 0x03 << 30;
+	rev >>=3D 30;
+	switch (rev) {
+	case KBD_REVISION_OMAP4:
+		keypad_data->reg_offset =3D 0x00;
+		keypad_data->irqreg_offset =3D 0x00;
+		break;
+	case KBD_REVISION_OMAP5:
+		keypad_data->reg_offset =3D 0x10;
+		keypad_data->irqreg_offset =3D 0x0c;
+		break;
+	default:
+		dev_err(&pdev->dev,
+			"Keypad reports unsupported revision %d", rev);
+		error =3D -EINVAL;
+		goto err_pm_suspended;
+	}
+
 	/* input device allocation */
 	keypad_data->input =3D input_dev =3D input_allocate_device();
 	if (!input_dev) {
 		error =3D -ENOMEM;
-		goto err_unmap;
+		goto err_pm_suspended;
 	}
=20
 	input_dev->name =3D pdev->name;
@@ -281,6 +345,7 @@ static int __devinit omap4_keypad_probe(struct plat=
form_device *pdev)
 	}
=20
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
=20
 	error =3D input_register_device(keypad_data->input);
 	if (error < 0) {
@@ -296,6 +361,8 @@ err_pm_disable:
 	free_irq(keypad_data->irq, keypad_data);
 err_free_input:
 	input_free_device(input_dev);
+err_pm_suspended:
+	pm_runtime_set_suspended(&pdev->dev);
 err_unmap:
 	iounmap(keypad_data->base);
 err_release_mem:
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
