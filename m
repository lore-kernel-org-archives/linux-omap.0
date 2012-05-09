From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv2] Input: omap-keypad: dynamically handle register offsets
Date: Wed, 9 May 2012 15:37:33 +0530
Message-ID: <CAKdam57xYtKw7iNJFd+5r-VS-6Mn8OG26xEFUR9SiMvk8gPW4A@mail.gmail.com>
References: <1335419677-24934-1-git-send-email-sourav.poddar@ti.com>
	<20120509051809.GA10514@core.coreip.homeip.net>
	<CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
	<20120509074539.GI10514@core.coreip.homeip.net>
	<CAKdam567nCNbMX8hW=bKS5bSQs_z9wP-GaM3sWsM2fjhmVQZMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175df238fa4ea504bf97ab7f
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CAKdam567nCNbMX8hW=bKS5bSQs_z9wP-GaM3sWsM2fjhmVQZMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

--0015175df238fa4ea504bf97ab7f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, May 9, 2012 at 3:14 PM, Poddar, Sourav <sourav.poddar@ti.com> wrote=
:
> Hi Dmitry,
>
> I did some minor fixes to the patch which you suggested above and
> the keypad is functional now.
>
> Changes:
> - Move "pm_runtime_enable" before using "pm_runtime_get_sync".
>
> Sending the patch inlined..(also attached).
>
> From: G, Manjunath Kondaiah <manjugk@ti.com>
> Date: Mon, 10 Oct 2011 20:52:05 +0530
> Subject: [PATCH] Input: omap-keypad: dynamically handle register offsets
>
> Keypad controller register offsets are different for omap4
> and omap5. Handle these offsets through static mapping and
> assign these mappings during run time.
>
> Tested on omap4430 sdp with 3.4-rc3.
> Tested on omap5430evm with 3.1-custom kernel.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0drivers/input/keyboard/omap4-keypad.c | =A0120 +++++++++++++++++++++++=
++-------
> =A02 files changed, 95 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> index f354813..33bbdee 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -512,9 +512,9 @@ config KEYBOARD_OMAP
> =A0 =A0 =A0 =A0 =A0module will be called omap-keypad.
>
> =A0config KEYBOARD_OMAP4
> - =A0 =A0 =A0 tristate "TI OMAP4 keypad support"
> + =A0 =A0 =A0 tristate "TI OMAP4+ keypad support"
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4 keypad.
> + =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4+ keypad.
>
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here: the
> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
> diff --git a/drivers/input/keyboard/omap4-keypad.c
> b/drivers/input/keyboard/omap4-keypad.c
> index e809ac0..d7102e8 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -68,19 +68,52 @@
>
> =A0#define OMAP4_MASK_IRQSTATUSDISABLE =A0 =A00xFFFF
>
> +enum {
> + =A0 =A0 =A0 KBD_REVISION_OMAP4 =3D 0,
> + =A0 =A0 =A0 KBD_REVISION_OMAP5,
> +};
> +
> =A0struct omap4_keypad {
> =A0 =A0 =A0 =A0struct input_dev *input;
>
> =A0 =A0 =A0 =A0void __iomem *base;
> - =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 unsigned int irq;
>
> =A0 =A0 =A0 =A0unsigned int rows;
> =A0 =A0 =A0 =A0unsigned int cols;
> + =A0 =A0 =A0 u32 reg_offset;
> + =A0 =A0 =A0 u32 irqreg_offset;
> =A0 =A0 =A0 =A0unsigned int row_shift;
> =A0 =A0 =A0 =A0unsigned char key_state[8];
> =A0 =A0 =A0 =A0unsigned short keymap[];
> =A0};
>
> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> +{
> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data=
->reg_offset + offset);
> +}
> +
> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u32=
 value)
> +{
> + =A0 =A0 =A0 __raw_writel(value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_data-=
>reg_offset + offset);
> +}
> +
> +static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 offset)
> +{
> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data=
->irqreg_offset + offset);
> +}
> +
> +static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 offset, u32 =
value)
> +{
> + =A0 =A0 =A0 __raw_writel(value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_data-=
>irqreg_offset + offset);
> +}
> +
> +
> =A0/* Interrupt handler */
> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
> =A0{
> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int
> irq, void *dev_id)
> =A0 =A0 =A0 =A0u32 *new_state =3D (u32 *) key_state;
>
> =A0 =A0 =A0 =A0/* Disable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_IR=
QENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE);
>
> - =A0 =A0 =A0 *new_state =3D __raw_readl(keypad_data->base + OMAP4_KBD_FU=
LLCODE31_0);
> - =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
> + =A0 =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_=
0);
> + =A0 =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULLC=
ODE63_32);
>
> =A0 =A0 =A0 =A0for (row =3D 0; row < keypad_data->rows; row++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0changed =3D key_state[row] ^ keypad_data->=
key_state[row];
> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int
> irq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQS=
TATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keypad_d=
ata, OMAP4_KBD_IRQSTATUS));
>
> =A0 =A0 =A0 =A0/* enable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENA=
BLE_LONGKEY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_I=
RQENABLE_LONGKEY);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev *inpu=
t)
>
> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_CTRL);
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_DEBOUNCINGTIME);
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_IRQSTATUS);
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENA=
BLE_LONGKEY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_IRQENABLE);
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_K=
EY_ENA,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_WAKEUPENABLE);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCFG);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTIME);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_I=
RQENABLE_LONGKEY);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_ENA | O=
MAP4_DEF_WUP_LONG_KEY_ENA);
>
> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>
> @@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_dev *in=
put)
> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>
> =A0 =A0 =A0 =A0/* Disable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_IR=
QENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE);
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQS=
TATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_K=
BD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keypad_d=
ata, OMAP4_KBD_IRQSTATUS));
>
> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>
> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0resource_size_t size;
> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
> + =A0 =A0 =A0 int rev;
> =A0 =A0 =A0 =A0int irq;
> =A0 =A0 =A0 =A0int error;
>
> @@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 * Enable clocks for the keypad module so that we can read
> + =A0 =A0 =A0 * revision register.
> + =A0 =A0 =A0 */
> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
> + =A0 =A0 =A0 error =3D pm_runtime_get_sync(&pdev->dev);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pm_runtime_get_sync() =
failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REVISION)=
;
> + =A0 =A0 =A0 rev &=3D 0x03 << 30;
> + =A0 =A0 =A0 rev >>=3D 30;
> + =A0 =A0 =A0 switch (rev) {
> + =A0 =A0 =A0 case KBD_REVISION_OMAP4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case KBD_REVISION_OMAP5:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x0c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Keypad reports unsupported=
 revision %d", rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* input device allocation */
> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_device=
();
> =A0 =A0 =A0 =A0if (!input_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0input_dev->name =3D pdev->name;
> @@ -273,14 +337,14 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_dev->keycode, input_=
dev->keybit);
>
> =A0 =A0 =A0 =A0error =3D request_irq(keypad_data->irq, omap4_keypad_inter=
rupt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_TRIGGER_RIS=
ING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED | IRQ=
F_TRIGGER_RISING,
Sorry, " IRQF_DISABLED" got included by mistake.
Removing this stray change and sending it again.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "omap4-keypad", k=
eypad_data);
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to register in=
terrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_input;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>
> =A0 =A0 =A0 =A0error =3D input_register_device(keypad_data->input);
> =A0 =A0 =A0 =A0if (error < 0) {
> @@ -296,6 +360,8 @@ err_pm_disable:
> =A0 =A0 =A0 =A0free_irq(keypad_data->irq, keypad_data);
> =A0err_free_input:
> =A0 =A0 =A0 =A0input_free_device(input_dev);
> +err_pm_put_sync:
> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
> =A0err_unmap:
> =A0 =A0 =A0 =A0iounmap(keypad_data->base);
> =A0err_release_mem:
>
>
> ~Sourav
>
> On Wed, May 9, 2012 at 1:15 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>> Hi Dmitry ,
>>>
>>>
>>> On Wed, May 9, 2012 at 10:48 AM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > Ho Sourav,
>>> >
>>> > On Thu, Apr 26, 2012 at 11:24:37AM +0530, Sourav Poddar wrote:
>>> >>
>>> >> -config KEYBOARD_OMAP4
>>> >> - =A0 =A0 tristate "TI OMAP4 keypad support"
>>> >> +config KEYBOARD_OMAP4+
>>> >
>>> > I think this works purely by accident - '+' sign getting dropped by
>>> > parser...
>>> >
>>> >> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input_dev =
*input)
>>> >>
>>> >> =A0 =A0 =A0 disable_irq(keypad_data->irq);
>>> >>
>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_CTRL);
>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_DEBOUNCINGTIME);
>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>>> >> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQEN=
ABLE_LONGKEY,
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>>> >> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_=
KEY_ENA,
>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_WAKEUPENABLE);
>>> >> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data,
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
>>> >> + =A0 =A0 switch (keypad_data->revision) {
>>> >> + =A0 =A0 case 1:
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQST=
ATUS + 0x0c;
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQEN=
ABLE + 0x0c;
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> >
>>> > This should be done in probe().
>>> >
>>> Dont we then require "pm_runtime_put_sync" in probe, since we are tryin=
g
>>> to read the keypad revision register.?
>>
>> Ah, indeed, but I think not pm_runtime_get_sync() but
>> pm_runtime_set_active().
>>
>> Not sure if this will fix the crash...
>>
>> --
>> Dmitry
>>
>>
>> Input: omap-keypad - dynamically handle register offsets
>>
>> From: G, Manjunath Kondaiah <manjugk@ti.com>
>>
>> Keypad controller register offsets are different for omap4
>> and omap5. Handle these offsets through static mapping and
>> assign these mappings during run time.
>>
>> Tested on omap4430 sdp with 3.4-rc3.
>> Tested on omap5430evm with 3.1-custom kernel.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>>
>> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
>> =A0drivers/input/keyboard/omap4-keypad.c | =A0117 ++++++++++++++++++++++=
++++-------
>> =A02 files changed, 94 insertions(+), 27 deletions(-)
>>
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kco=
nfig
>> index 20a3753..84ee155 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -531,9 +531,9 @@ config KEYBOARD_OMAP
>> =A0 =A0 =A0 =A0 =A0module will be called omap-keypad.
>>
>> =A0config KEYBOARD_OMAP4
>> - =A0 =A0 =A0 tristate "TI OMAP4 keypad support"
>> + =A0 =A0 =A0 tristate "TI OMAP4+ keypad support"
>> =A0 =A0 =A0 =A0help
>> - =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4 keypad.
>> + =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4+ keypad.
>>
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here: th=
e
>> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
>> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keybo=
ard/omap4-keypad.c
>> index e809ac0..c9fd0df 100644
>> --- a/drivers/input/keyboard/omap4-keypad.c
>> +++ b/drivers/input/keyboard/omap4-keypad.c
>> @@ -68,19 +68,52 @@
>>
>> =A0#define OMAP4_MASK_IRQSTATUSDISABLE =A0 =A00xFFFF
>>
>> +enum {
>> + =A0 =A0 =A0 KBD_REVISION_OMAP4 =3D 0,
>> + =A0 =A0 =A0 KBD_REVISION_OMAP5,
>> +};
>> +
>> =A0struct omap4_keypad {
>> =A0 =A0 =A0 =A0struct input_dev *input;
>>
>> =A0 =A0 =A0 =A0void __iomem *base;
>> - =A0 =A0 =A0 int irq;
>> + =A0 =A0 =A0 unsigned int irq;
>>
>> =A0 =A0 =A0 =A0unsigned int rows;
>> =A0 =A0 =A0 =A0unsigned int cols;
>> + =A0 =A0 =A0 u32 reg_offset;
>> + =A0 =A0 =A0 u32 irqreg_offset;
>> =A0 =A0 =A0 =A0unsigned int row_shift;
>> =A0 =A0 =A0 =A0unsigned char key_state[8];
>> =A0 =A0 =A0 =A0unsigned short keymap[];
>> =A0};
>>
>> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
>> +{
>> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_dat=
a->reg_offset + offset);
>> +}
>> +
>> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u3=
2 value)
>> +{
>> + =A0 =A0 =A0 __raw_writel(value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_data=
->reg_offset + offset);
>> +}
>> +
>> +static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 offset=
)
>> +{
>> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_dat=
a->irqreg_offset + offset);
>> +}
>> +
>> +static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 offset, u32=
 value)
>> +{
>> + =A0 =A0 =A0 __raw_writel(value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_data=
->irqreg_offset + offset);
>> +}
>> +
>> +
>> =A0/* Interrupt handler */
>> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>> =A0{
>> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int irq, =
void *dev_id)
>> =A0 =A0 =A0 =A0u32 *new_state =3D (u32 *) key_state;
>>
>> =A0 =A0 =A0 =A0/* Disable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_I=
RQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE);
>>
>> - =A0 =A0 =A0 *new_state =3D __raw_readl(keypad_data->base + OMAP4_KBD_F=
ULLCODE31_0);
>> - =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
>> + =A0 =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31=
_0);
>> + =A0 =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULL=
CODE63_32);
>>
>> =A0 =A0 =A0 =A0for (row =3D 0; row < keypad_data->rows; row++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0changed =3D key_state[row] ^ keypad_data-=
>key_state[row];
>> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int irq,=
 void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>>
>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQ=
STATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keypad_=
data, OMAP4_KBD_IRQSTATUS));
>>
>> =A0 =A0 =A0 =A0/* enable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQEN=
ABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_=
IRQENABLE_LONGKEY);
>>
>> =A0 =A0 =A0 =A0return IRQ_HANDLED;
>> =A0}
>> @@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev *inp=
ut)
>>
>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_CTRL);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_DEBOUNCINGTIME);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQEN=
ABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_=
KEY_ENA,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_WAKEUPENABLE);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCFG);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTIME);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTE=
N |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_=
IRQENABLE_LONGKEY);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_ENA | =
OMAP4_DEF_WUP_LONG_KEY_ENA);
>>
>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>
>> @@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_dev *i=
nput)
>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>
>> =A0 =A0 =A0 =A0/* Disable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_I=
RQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE);
>>
>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQ=
STATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keypad_=
data, OMAP4_KBD_IRQSTATUS));
>>
>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>
>> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct platf=
orm_device *pdev)
>> =A0 =A0 =A0 =A0struct resource *res;
>> =A0 =A0 =A0 =A0resource_size_t size;
>> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
>> + =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 =A0int irq;
>> =A0 =A0 =A0 =A0int error;
>>
>> @@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struct pla=
tform_device *pdev)
>> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
>> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>>
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Mark device as active (and wake up its parent) so we =
can read
>> + =A0 =A0 =A0 =A0* revision register.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 error =3D pm_runtime_set_active(&pdev->dev);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pm_runtime_set_active=
() failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REVISION=
);
>> + =A0 =A0 =A0 rev &=3D 0x03 << 30;
>> + =A0 =A0 =A0 rev >>=3D 30;
>> + =A0 =A0 =A0 switch (rev) {
>> + =A0 =A0 =A0 case KBD_REVISION_OMAP4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x00;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x00;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case KBD_REVISION_OMAP5:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x0c;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Keypad reports unsupporte=
d revision %d", rev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_suspended;
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0/* input device allocation */
>> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_devic=
e();
>> =A0 =A0 =A0 =A0if (!input_dev) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_suspended;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0input_dev->name =3D pdev->name;
>> @@ -281,6 +345,7 @@ static int __devinit omap4_keypad_probe(struct platf=
orm_device *pdev)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>>
>> =A0 =A0 =A0 =A0error =3D input_register_device(keypad_data->input);
>> =A0 =A0 =A0 =A0if (error < 0) {
>> @@ -296,6 +361,8 @@ err_pm_disable:
>> =A0 =A0 =A0 =A0free_irq(keypad_data->irq, keypad_data);
>> =A0err_free_input:
>> =A0 =A0 =A0 =A0input_free_device(input_dev);
>> +err_pm_suspended:
>> + =A0 =A0 =A0 pm_runtime_set_suspended(&pdev->dev);
>> =A0err_unmap:
>> =A0 =A0 =A0 =A0iounmap(keypad_data->base);
>> =A0err_release_mem:

From: G, Manjunath Kondaiah <manjugk@ti.com>
Date: Mon, 10 Oct 2011 20:52:05 +0530
Subject: [PATCH] Input: omap-keypad: dynamically handle register offsets

Keypad controller register offsets are different for omap4
and omap5. Handle these offsets through static mapping and
assign these mappings during run time.

Tested on omap4430 sdp with 3.4-rc3.
Tested on omap5430evm with 3.1-custom kernel.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/Kconfig        |    4 +-
 drivers/input/keyboard/omap4-keypad.c |  118 +++++++++++++++++++++++++----=
---
 2 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfi=
g
index f354813..33bbdee 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -512,9 +512,9 @@ config KEYBOARD_OMAP
 	  module will be called omap-keypad.

 config KEYBOARD_OMAP4
-	tristate "TI OMAP4 keypad support"
+	tristate "TI OMAP4+ keypad support"
 	help
-	  Say Y here if you want to use the OMAP4 keypad.
+	  Say Y here if you want to use the OMAP4+ keypad.

 	  To compile this driver as a module, choose M here: the
 	  module will be called omap4-keypad.
diff --git a/drivers/input/keyboard/omap4-keypad.c
b/drivers/input/keyboard/omap4-keypad.c
index e809ac0..28da0e4 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -68,19 +68,52 @@

 #define OMAP4_MASK_IRQSTATUSDISABLE	0xFFFF

+enum {
+	KBD_REVISION_OMAP4 =3D 0,
+	KBD_REVISION_OMAP5,
+};
+
 struct omap4_keypad {
 	struct input_dev *input;

 	void __iomem *base;
-	int irq;
+	unsigned int irq;

 	unsigned int rows;
 	unsigned int cols;
+	u32 reg_offset;
+	u32 irqreg_offset;
 	unsigned int row_shift;
 	unsigned char key_state[8];
 	unsigned short keymap[];
 };

+static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
+{
+	return __raw_readl(keypad_data->base +
+				keypad_data->reg_offset + offset);
+}
+
+static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset, u32 v=
alue)
+{
+	__raw_writel(value,
+		     keypad_data->base + keypad_data->reg_offset + offset);
+}
+
+static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 offset)
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
@@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int
irq, void *dev_id)
 	u32 *new_state =3D (u32 *) key_state;

 	/* Disable interrupts */
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+			 OMAP4_VAL_IRQDISABLE);

-	*new_state =3D __raw_readl(keypad_data->base + OMAP4_KBD_FULLCODE31_0);
-	*(new_state + 1) =3D __raw_readl(keypad_data->base
-						+ OMAP4_KBD_FULLCODE63_32);
+	*new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31_0);
+	*(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE63_32);

 	for (row =3D 0; row < keypad_data->rows; row++) {
 		changed =3D key_state[row] ^ keypad_data->key_state[row];
@@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int
irq, void *dev_id)
 		sizeof(keypad_data->key_state));

 	/* clear pending interrupts */
-	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
+			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));

 	/* enable interrupts */
-	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
-			keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+		OMAP4_DEF_IRQENABLE_EVENTEN |
+				OMAP4_DEF_IRQENABLE_LONGKEY);

 	return IRQ_HANDLED;
 }
@@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev *input)

 	disable_irq(keypad_data->irq);

-	__raw_writel(OMAP4_VAL_FUNCTIONALCFG,
-			keypad_data->base + OMAP4_KBD_CTRL);
-	__raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
-			keypad_data->base + OMAP4_KBD_DEBOUNCINGTIME);
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
-	__raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQENABLE_LONGKEY,
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

 	enable_irq(keypad_data->irq);

@@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_dev *inpu=
t)
 	disable_irq(keypad_data->irq);

 	/* Disable interrupts */
-	__raw_writel(OMAP4_VAL_IRQDISABLE,
-		     keypad_data->base + OMAP4_KBD_IRQENABLE);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
+			 OMAP4_VAL_IRQDISABLE);

 	/* clear pending interrupts */
-	__raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQSTATUS),
-			keypad_data->base + OMAP4_KBD_IRQSTATUS);
+	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
+			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));

 	enable_irq(keypad_data->irq);

@@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct
platform_device *pdev)
 	struct resource *res;
 	resource_size_t size;
 	unsigned int row_shift, max_keys;
+	int rev;
 	int irq;
 	int error;

@@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struct
platform_device *pdev)
 	keypad_data->rows =3D pdata->rows;
 	keypad_data->cols =3D pdata->cols;

+	/*
+	* Enable clocks for the keypad module so that we can read
+	* revision register.
+	*/
+	pm_runtime_enable(&pdev->dev);
+	error =3D pm_runtime_get_sync(&pdev->dev);
+	if (error) {
+		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
+		goto err_unmap;
+	}
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
+		goto err_pm_put_sync;
+	}
+
 	/* input device allocation */
 	keypad_data->input =3D input_dev =3D input_allocate_device();
 	if (!input_dev) {
 		error =3D -ENOMEM;
-		goto err_unmap;
+		goto err_pm_put_sync;
 	}

 	input_dev->name =3D pdev->name;
@@ -280,7 +344,7 @@ static int __devinit omap4_keypad_probe(struct
platform_device *pdev)
 		goto err_free_input;
 	}

-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);

 	error =3D input_register_device(keypad_data->input);
 	if (error < 0) {
@@ -296,6 +360,8 @@ err_pm_disable:
 	free_irq(keypad_data->irq, keypad_data);
 err_free_input:
 	input_free_device(input_dev);
+err_pm_put_sync:
+	pm_runtime_put_sync(&pdev->dev);
 err_unmap:
 	iounmap(keypad_data->base);
 err_release_mem:
--

--0015175df238fa4ea504bf97ab7f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-Input-omap-keypad-dynamically-handle-register-offset.patch"
Content-Disposition: attachment;
	filename="0001-Input-omap-keypad-dynamically-handle-register-offset.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h207q3et1

RnJvbSBlMTYzYTU3MGI4ZWU4MWMyMmM1YTcxYmIwOTJjMjA1ZjE0NmZlZTQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHLCBNYW5qdW5hdGggS29uZGFpYWggPG1hbmp1Z2tAdGkuY29t
PgpEYXRlOiBNb24sIDEwIE9jdCAyMDExIDIwOjUyOjA1ICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
SW5wdXQ6IG9tYXAta2V5cGFkOiBkeW5hbWljYWxseSBoYW5kbGUgcmVnaXN0ZXIgb2Zmc2V0cwoK
S2V5cGFkIGNvbnRyb2xsZXIgcmVnaXN0ZXIgb2Zmc2V0cyBhcmUgZGlmZmVyZW50IGZvciBvbWFw
NAphbmQgb21hcDUuIEhhbmRsZSB0aGVzZSBvZmZzZXRzIHRocm91Z2ggc3RhdGljIG1hcHBpbmcg
YW5kCmFzc2lnbiB0aGVzZSBtYXBwaW5ncyBkdXJpbmcgcnVuIHRpbWUuCgpUZXN0ZWQgb24gb21h
cDQ0MzAgc2RwIHdpdGggMy40LXJjMy4KVGVzdGVkIG9uIG9tYXA1NDMwZXZtIHdpdGggMy4xLWN1
c3RvbSBrZXJuZWwuCgpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zz4KU2lnbmVkLW9mZi1ieTogRmVsaXBlIEJhbGJpIDxiYWxiaUB0aS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEcsIE1hbmp1bmF0aCBLb25kYWlhaCA8bWFuanVna0B0aS5jb20+ClNpZ25lZC1vZmYtYnk6
IFNvdXJhdiBQb2RkYXIgPHNvdXJhdi5wb2RkYXJAdGkuY29tPgpTaWduZWQtb2ZmLWJ5OiBEbWl0
cnkgVG9yb2tob3YgPGR0b3JAbWFpbC5ydT4KLS0tCiBkcml2ZXJzL2lucHV0L2tleWJvYXJkL0tj
b25maWcgICAgICAgIHwgICAgNCArLQogZHJpdmVycy9pbnB1dC9rZXlib2FyZC9vbWFwNC1rZXlw
YWQuYyB8ICAxMTggKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgOTQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbnB1dC9rZXlib2FyZC9LY29uZmlnIGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9LY29u
ZmlnCmluZGV4IGYzNTQ4MTMuLjMzYmJkZWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQva2V5
Ym9hcmQvS2NvbmZpZworKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKQEAgLTUx
Miw5ICs1MTIsOSBAQCBjb25maWcgS0VZQk9BUkRfT01BUAogCSAgbW9kdWxlIHdpbGwgYmUgY2Fs
bGVkIG9tYXAta2V5cGFkLgogCiBjb25maWcgS0VZQk9BUkRfT01BUDQKLQl0cmlzdGF0ZSAiVEkg
T01BUDQga2V5cGFkIHN1cHBvcnQiCisJdHJpc3RhdGUgIlRJIE9NQVA0KyBrZXlwYWQgc3VwcG9y
dCIKIAloZWxwCi0JICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHRvIHVzZSB0aGUgT01BUDQga2V5
cGFkLgorCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0byB1c2UgdGhlIE9NQVA0KyBrZXlwYWQu
CiAKIAkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6
IHRoZQogCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIG9tYXA0LWtleXBhZC4KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvb21hcDQta2V5cGFkLmMgYi9kcml2ZXJzL2lucHV0L2tl
eWJvYXJkL29tYXA0LWtleXBhZC5jCmluZGV4IGU4MDlhYzAuLjI4ZGEwZTQgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvb21hcDQta2V5cGFkLmMKKysrIGIvZHJpdmVycy9pbnB1
dC9rZXlib2FyZC9vbWFwNC1rZXlwYWQuYwpAQCAtNjgsMTkgKzY4LDUyIEBACiAKICNkZWZpbmUg
T01BUDRfTUFTS19JUlFTVEFUVVNESVNBQkxFCTB4RkZGRgogCitlbnVtIHsKKwlLQkRfUkVWSVNJ
T05fT01BUDQgPSAwLAorCUtCRF9SRVZJU0lPTl9PTUFQNSwKK307CisKIHN0cnVjdCBvbWFwNF9r
ZXlwYWQgewogCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0OwogCiAJdm9pZCBfX2lvbWVtICpiYXNl
OwotCWludCBpcnE7CisJdW5zaWduZWQgaW50IGlycTsKIAogCXVuc2lnbmVkIGludCByb3dzOwog
CXVuc2lnbmVkIGludCBjb2xzOworCXUzMiByZWdfb2Zmc2V0OworCXUzMiBpcnFyZWdfb2Zmc2V0
OwogCXVuc2lnbmVkIGludCByb3dfc2hpZnQ7CiAJdW5zaWduZWQgY2hhciBrZXlfc3RhdGVbOF07
CiAJdW5zaWduZWQgc2hvcnQga2V5bWFwW107CiB9OwogCitzdGF0aWMgaW50IGtiZF9yZWFkbChz
dHJ1Y3Qgb21hcDRfa2V5cGFkICprZXlwYWRfZGF0YSwgdTMyIG9mZnNldCkKK3sKKwlyZXR1cm4g
X19yYXdfcmVhZGwoa2V5cGFkX2RhdGEtPmJhc2UgKworCQkJCWtleXBhZF9kYXRhLT5yZWdfb2Zm
c2V0ICsgb2Zmc2V0KTsKK30KKworc3RhdGljIHZvaWQga2JkX3dyaXRlbChzdHJ1Y3Qgb21hcDRf
a2V5cGFkICprZXlwYWRfZGF0YSwgdTMyIG9mZnNldCwgdTMyIHZhbHVlKQoreworCV9fcmF3X3dy
aXRlbCh2YWx1ZSwKKwkJICAgICBrZXlwYWRfZGF0YS0+YmFzZSArIGtleXBhZF9kYXRhLT5yZWdf
b2Zmc2V0ICsgb2Zmc2V0KTsKK30KKworc3RhdGljIGludCBrYmRfcmVhZF9pcnFyZWcoc3RydWN0
IG9tYXA0X2tleXBhZCAqa2V5cGFkX2RhdGEsIHUzMiBvZmZzZXQpCit7CisJcmV0dXJuIF9fcmF3
X3JlYWRsKGtleXBhZF9kYXRhLT5iYXNlICsKKwkJCQlrZXlwYWRfZGF0YS0+aXJxcmVnX29mZnNl
dCArIG9mZnNldCk7Cit9CisKK3N0YXRpYyB2b2lkIGtiZF93cml0ZV9pcnFyZWcoc3RydWN0IG9t
YXA0X2tleXBhZCAqa2V5cGFkX2RhdGEsCisJCQkgICAgIHUzMiBvZmZzZXQsIHUzMiB2YWx1ZSkK
K3sKKwlfX3Jhd193cml0ZWwodmFsdWUsCisJCSAgICAga2V5cGFkX2RhdGEtPmJhc2UgKyBrZXlw
YWRfZGF0YS0+aXJxcmVnX29mZnNldCArIG9mZnNldCk7Cit9CisKKwogLyogSW50ZXJydXB0IGhh
bmRsZXIgKi8KIHN0YXRpYyBpcnFyZXR1cm5fdCBvbWFwNF9rZXlwYWRfaW50ZXJydXB0KGludCBp
cnEsIHZvaWQgKmRldl9pZCkKIHsKQEAgLTkxLDEyICsxMjQsMTEgQEAgc3RhdGljIGlycXJldHVy
bl90IG9tYXA0X2tleXBhZF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQogCXUzMiAq
bmV3X3N0YXRlID0gKHUzMiAqKSBrZXlfc3RhdGU7CiAKIAkvKiBEaXNhYmxlIGludGVycnVwdHMg
Ki8KLQlfX3Jhd193cml0ZWwoT01BUDRfVkFMX0lSUURJU0FCTEUsCi0JCSAgICAga2V5cGFkX2Rh
dGEtPmJhc2UgKyBPTUFQNF9LQkRfSVJRRU5BQkxFKTsKKwlrYmRfd3JpdGVfaXJxcmVnKGtleXBh
ZF9kYXRhLCBPTUFQNF9LQkRfSVJRRU5BQkxFLAorCQkJIE9NQVA0X1ZBTF9JUlFESVNBQkxFKTsK
IAotCSpuZXdfc3RhdGUgPSBfX3Jhd19yZWFkbChrZXlwYWRfZGF0YS0+YmFzZSArIE9NQVA0X0tC
RF9GVUxMQ09ERTMxXzApOwotCSoobmV3X3N0YXRlICsgMSkgPSBfX3Jhd19yZWFkbChrZXlwYWRf
ZGF0YS0+YmFzZQotCQkJCQkJKyBPTUFQNF9LQkRfRlVMTENPREU2M18zMik7CisJKm5ld19zdGF0
ZSA9IGtiZF9yZWFkbChrZXlwYWRfZGF0YSwgT01BUDRfS0JEX0ZVTExDT0RFMzFfMCk7CisJKihu
ZXdfc3RhdGUgKyAxKSA9IGtiZF9yZWFkbChrZXlwYWRfZGF0YSwgT01BUDRfS0JEX0ZVTExDT0RF
NjNfMzIpOwogCiAJZm9yIChyb3cgPSAwOyByb3cgPCBrZXlwYWRfZGF0YS0+cm93czsgcm93Kysp
IHsKIAkJY2hhbmdlZCA9IGtleV9zdGF0ZVtyb3ddIF4ga2V5cGFkX2RhdGEtPmtleV9zdGF0ZVty
b3ddOwpAQCAtMTIxLDEyICsxNTMsMTMgQEAgc3RhdGljIGlycXJldHVybl90IG9tYXA0X2tleXBh
ZF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQogCQlzaXplb2Yoa2V5cGFkX2RhdGEt
PmtleV9zdGF0ZSkpOwogCiAJLyogY2xlYXIgcGVuZGluZyBpbnRlcnJ1cHRzICovCi0JX19yYXdf
d3JpdGVsKF9fcmF3X3JlYWRsKGtleXBhZF9kYXRhLT5iYXNlICsgT01BUDRfS0JEX0lSUVNUQVRV
UyksCi0JCQlrZXlwYWRfZGF0YS0+YmFzZSArIE9NQVA0X0tCRF9JUlFTVEFUVVMpOworCWtiZF93
cml0ZV9pcnFyZWcoa2V5cGFkX2RhdGEsIE9NQVA0X0tCRF9JUlFTVEFUVVMsCisJCQkga2JkX3Jl
YWRfaXJxcmVnKGtleXBhZF9kYXRhLCBPTUFQNF9LQkRfSVJRU1RBVFVTKSk7CiAKIAkvKiBlbmFi
bGUgaW50ZXJydXB0cyAqLwotCV9fcmF3X3dyaXRlbChPTUFQNF9ERUZfSVJRRU5BQkxFX0VWRU5U
RU4gfCBPTUFQNF9ERUZfSVJRRU5BQkxFX0xPTkdLRVksCi0JCQlrZXlwYWRfZGF0YS0+YmFzZSAr
IE9NQVA0X0tCRF9JUlFFTkFCTEUpOworCWtiZF93cml0ZV9pcnFyZWcoa2V5cGFkX2RhdGEsIE9N
QVA0X0tCRF9JUlFFTkFCTEUsCisJCU9NQVA0X0RFRl9JUlFFTkFCTEVfRVZFTlRFTiB8CisJCQkJ
T01BUDRfREVGX0lSUUVOQUJMRV9MT05HS0VZKTsKIAogCXJldHVybiBJUlFfSEFORExFRDsKIH0K
QEAgLTEzOSwxNiArMTcyLDE3IEBAIHN0YXRpYyBpbnQgb21hcDRfa2V5cGFkX29wZW4oc3RydWN0
IGlucHV0X2RldiAqaW5wdXQpCiAKIAlkaXNhYmxlX2lycShrZXlwYWRfZGF0YS0+aXJxKTsKIAot
CV9fcmF3X3dyaXRlbChPTUFQNF9WQUxfRlVOQ1RJT05BTENGRywKLQkJCWtleXBhZF9kYXRhLT5i
YXNlICsgT01BUDRfS0JEX0NUUkwpOwotCV9fcmF3X3dyaXRlbChPTUFQNF9WQUxfREVCT1VOQ0lO
R1RJTUUsCi0JCQlrZXlwYWRfZGF0YS0+YmFzZSArIE9NQVA0X0tCRF9ERUJPVU5DSU5HVElNRSk7
Ci0JX19yYXdfd3JpdGVsKE9NQVA0X1ZBTF9JUlFESVNBQkxFLAotCQkJa2V5cGFkX2RhdGEtPmJh
c2UgKyBPTUFQNF9LQkRfSVJRU1RBVFVTKTsKLQlfX3Jhd193cml0ZWwoT01BUDRfREVGX0lSUUVO
QUJMRV9FVkVOVEVOIHwgT01BUDRfREVGX0lSUUVOQUJMRV9MT05HS0VZLAotCQkJa2V5cGFkX2Rh
dGEtPmJhc2UgKyBPTUFQNF9LQkRfSVJRRU5BQkxFKTsKLQlfX3Jhd193cml0ZWwoT01BUDRfREVG
X1dVUF9FVkVOVF9FTkEgfCBPTUFQNF9ERUZfV1VQX0xPTkdfS0VZX0VOQSwKLQkJCWtleXBhZF9k
YXRhLT5iYXNlICsgT01BUDRfS0JEX1dBS0VVUEVOQUJMRSk7CisJa2JkX3dyaXRlbChrZXlwYWRf
ZGF0YSwgT01BUDRfS0JEX0NUUkwsCisJCQlPTUFQNF9WQUxfRlVOQ1RJT05BTENGRyk7CisJa2Jk
X3dyaXRlbChrZXlwYWRfZGF0YSwgT01BUDRfS0JEX0RFQk9VTkNJTkdUSU1FLAorCQkJT01BUDRf
VkFMX0RFQk9VTkNJTkdUSU1FKTsKKwlrYmRfd3JpdGVfaXJxcmVnKGtleXBhZF9kYXRhLCBPTUFQ
NF9LQkRfSVJRU1RBVFVTLAorCQkJT01BUDRfVkFMX0lSUURJU0FCTEUpOworCWtiZF93cml0ZV9p
cnFyZWcoa2V5cGFkX2RhdGEsIE9NQVA0X0tCRF9JUlFFTkFCTEUsCisJCQlPTUFQNF9ERUZfSVJR
RU5BQkxFX0VWRU5URU4gfAorCQkJCU9NQVA0X0RFRl9JUlFFTkFCTEVfTE9OR0tFWSk7CisJa2Jk
X3dyaXRlbChrZXlwYWRfZGF0YSwgT01BUDRfS0JEX1dBS0VVUEVOQUJMRSwKKwkJCU9NQVA0X0RF
Rl9XVVBfRVZFTlRfRU5BIHwgT01BUDRfREVGX1dVUF9MT05HX0tFWV9FTkEpOwogCiAJZW5hYmxl
X2lycShrZXlwYWRfZGF0YS0+aXJxKTsKIApAQCAtMTYyLDEyICsxOTYsMTIgQEAgc3RhdGljIHZv
aWQgb21hcDRfa2V5cGFkX2Nsb3NlKHN0cnVjdCBpbnB1dF9kZXYgKmlucHV0KQogCWRpc2FibGVf
aXJxKGtleXBhZF9kYXRhLT5pcnEpOwogCiAJLyogRGlzYWJsZSBpbnRlcnJ1cHRzICovCi0JX19y
YXdfd3JpdGVsKE9NQVA0X1ZBTF9JUlFESVNBQkxFLAotCQkgICAgIGtleXBhZF9kYXRhLT5iYXNl
ICsgT01BUDRfS0JEX0lSUUVOQUJMRSk7CisJa2JkX3dyaXRlX2lycXJlZyhrZXlwYWRfZGF0YSwg
T01BUDRfS0JEX0lSUUVOQUJMRSwKKwkJCSBPTUFQNF9WQUxfSVJRRElTQUJMRSk7CiAKIAkvKiBj
bGVhciBwZW5kaW5nIGludGVycnVwdHMgKi8KLQlfX3Jhd193cml0ZWwoX19yYXdfcmVhZGwoa2V5
cGFkX2RhdGEtPmJhc2UgKyBPTUFQNF9LQkRfSVJRU1RBVFVTKSwKLQkJCWtleXBhZF9kYXRhLT5i
YXNlICsgT01BUDRfS0JEX0lSUVNUQVRVUyk7CisJa2JkX3dyaXRlX2lycXJlZyhrZXlwYWRfZGF0
YSwgT01BUDRfS0JEX0lSUVNUQVRVUywKKwkJCSBrYmRfcmVhZF9pcnFyZWcoa2V5cGFkX2RhdGEs
IE9NQVA0X0tCRF9JUlFTVEFUVVMpKTsKIAogCWVuYWJsZV9pcnEoa2V5cGFkX2RhdGEtPmlycSk7
CiAKQEAgLTE4Miw2ICsyMTYsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBvbWFwNF9rZXlwYWRf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
czsKIAlyZXNvdXJjZV9zaXplX3Qgc2l6ZTsKIAl1bnNpZ25lZCBpbnQgcm93X3NoaWZ0LCBtYXhf
a2V5czsKKwlpbnQgcmV2OwogCWludCBpcnE7CiAJaW50IGVycm9yOwogCkBAIC0yNDEsMTEgKzI3
Niw0MCBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBvbWFwNF9rZXlwYWRfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAlrZXlwYWRfZGF0YS0+cm93cyA9IHBkYXRhLT5yb3dzOwog
CWtleXBhZF9kYXRhLT5jb2xzID0gcGRhdGEtPmNvbHM7CiAKKwkvKgorCSogRW5hYmxlIGNsb2Nr
cyBmb3IgdGhlIGtleXBhZCBtb2R1bGUgc28gdGhhdCB3ZSBjYW4gcmVhZAorCSogcmV2aXNpb24g
cmVnaXN0ZXIuCisJKi8KKwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsKKwllcnJvciA9
IHBtX3J1bnRpbWVfZ2V0X3N5bmMoJnBkZXYtPmRldik7CisJaWYgKGVycm9yKSB7CisJCWRldl9l
cnIoJnBkZXYtPmRldiwgInBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBmYWlsZWRcbiIpOworCQlnb3Rv
IGVycl91bm1hcDsKKwl9CisJcmV2ID0gX19yYXdfcmVhZGwoa2V5cGFkX2RhdGEtPmJhc2UgKyBP
TUFQNF9LQkRfUkVWSVNJT04pOworCXJldiAmPSAweDAzIDw8IDMwOworCXJldiA+Pj0gMzA7CisJ
c3dpdGNoIChyZXYpIHsKKwljYXNlIEtCRF9SRVZJU0lPTl9PTUFQNDoKKwkJa2V5cGFkX2RhdGEt
PnJlZ19vZmZzZXQgPSAweDAwOworCQlrZXlwYWRfZGF0YS0+aXJxcmVnX29mZnNldCA9IDB4MDA7
CisJCWJyZWFrOworCWNhc2UgS0JEX1JFVklTSU9OX09NQVA1OgorCQlrZXlwYWRfZGF0YS0+cmVn
X29mZnNldCA9IDB4MTA7CisJCWtleXBhZF9kYXRhLT5pcnFyZWdfb2Zmc2V0ID0gMHgwYzsKKwkJ
YnJlYWs7CisJZGVmYXVsdDoKKwkJZGV2X2VycigmcGRldi0+ZGV2LAorCQkJIktleXBhZCByZXBv
cnRzIHVuc3VwcG9ydGVkIHJldmlzaW9uICVkIiwgcmV2KTsKKwkJZXJyb3IgPSAtRUlOVkFMOwor
CQlnb3RvIGVycl9wbV9wdXRfc3luYzsKKwl9CisKIAkvKiBpbnB1dCBkZXZpY2UgYWxsb2NhdGlv
biAqLwogCWtleXBhZF9kYXRhLT5pbnB1dCA9IGlucHV0X2RldiA9IGlucHV0X2FsbG9jYXRlX2Rl
dmljZSgpOwogCWlmICghaW5wdXRfZGV2KSB7CiAJCWVycm9yID0gLUVOT01FTTsKLQkJZ290byBl
cnJfdW5tYXA7CisJCWdvdG8gZXJyX3BtX3B1dF9zeW5jOwogCX0KIAogCWlucHV0X2Rldi0+bmFt
ZSA9IHBkZXYtPm5hbWU7CkBAIC0yODAsNyArMzQ0LDcgQEAgc3RhdGljIGludCBfX2RldmluaXQg
b21hcDRfa2V5cGFkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCWdvdG8g
ZXJyX2ZyZWVfaW5wdXQ7CiAJfQogCi0JcG1fcnVudGltZV9lbmFibGUoJnBkZXYtPmRldik7CisJ
cG1fcnVudGltZV9wdXRfc3luYygmcGRldi0+ZGV2KTsKIAogCWVycm9yID0gaW5wdXRfcmVnaXN0
ZXJfZGV2aWNlKGtleXBhZF9kYXRhLT5pbnB1dCk7CiAJaWYgKGVycm9yIDwgMCkgewpAQCAtMjk2
LDYgKzM2MCw4IEBAIGVycl9wbV9kaXNhYmxlOgogCWZyZWVfaXJxKGtleXBhZF9kYXRhLT5pcnEs
IGtleXBhZF9kYXRhKTsKIGVycl9mcmVlX2lucHV0OgogCWlucHV0X2ZyZWVfZGV2aWNlKGlucHV0
X2Rldik7CitlcnJfcG1fcHV0X3N5bmM6CisJcG1fcnVudGltZV9wdXRfc3luYygmcGRldi0+ZGV2
KTsKIGVycl91bm1hcDoKIAlpb3VubWFwKGtleXBhZF9kYXRhLT5iYXNlKTsKIGVycl9yZWxlYXNl
X21lbToKLS0gCjEuNy4xCgo=
--0015175df238fa4ea504bf97ab7f--
