From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2] Input: omap-keypad: dynamically handle register offsets
Date: Thu, 19 Apr 2012 16:57:34 +0530
Message-ID: <CAKdam577T_rmvq4S4=yEu7m8_84hj81mS+ibWGSBRvvzmYrsgg@mail.gmail.com>
References: <1334216338-29977-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1334216338-29977-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: sourav.poddar@ti.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

Any comments on this?

~Sourav

On Thu, Apr 12, 2012 at 1:08 PM, Sourav Poddar <sourav.poddar@ti.com> w=
rote:
> From: G, Manjunath Kondaiah <manjugk@ti.com>
>
> Keypad controller register offsets are different for omap4
> and omap5. Handle these offsets through static mapping and
> assign these mappings during run time.
>
> Tested on omap4430 sdp with 3.4-rc2.
> Tested on omap5430evm with 3.1-custom kernel.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> Changes since v1:
> - Fix Felipe's comment about getting rid
> =A0of one argument from irqstatus/irqenable api
> - Fix Dmitry's comment:
> =A0- get rid of revision check in readl/writel
> =A0- Relace ENODEV with proper macro.
> =A0- Use switch statement
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A06 +-
> =A0drivers/input/keyboard/omap4-keypad.c | =A0115 +++++++++++++++++++=
+++++++-------
> =A02 files changed, 95 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index f354813..9a0e1a9 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -511,10 +511,10 @@ config KEYBOARD_OMAP
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called omap-keypad.
>
> -config KEYBOARD_OMAP4
> - =A0 =A0 =A0 tristate "TI OMAP4 keypad support"
> +config KEYBOARD_OMAP4+
> + =A0 =A0 =A0 tristate "TI OMAP4+ keypad support"
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4 keypad.
> + =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4+ keypad.
>
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/ke=
yboard/omap4-keypad.c
> index e809ac0..8e46563 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -68,6 +68,11 @@
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
> @@ -76,11 +81,61 @@ struct omap4_keypad {
>
> =A0 =A0 =A0 =A0unsigned int rows;
> =A0 =A0 =A0 =A0unsigned int cols;
> + =A0 =A0 =A0 unsigned int revision;
> + =A0 =A0 =A0 u32 irqstatus;
> + =A0 =A0 =A0 u32 irqenable;
> + =A0 =A0 =A0 u32 reg_offset;
> =A0 =A0 =A0 =A0unsigned int row_shift;
> =A0 =A0 =A0 =A0unsigned char key_state[8];
> =A0 =A0 =A0 =A0unsigned short keymap[];
> =A0};
>
> +static int kbd_read_irqstatus(struct omap4_keypad *keypad_data, u32 =
offset)
> +{
> + =A0 =A0 =A0 return __raw_readl(keypad_data->base + offset);
> +}
> +
> +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 u32 value)
> +{
> + =A0 =A0 =A0 return __raw_writel(value, keypad_data->base + keypad_d=
ata->irqstatus);
> +}
> +
> +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 u32 value)
> +{
> + =A0 =A0 =A0 return __raw_writel(value, keypad_data->base + keypad_d=
ata->irqenable);
> +}
> +
> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
> +{
> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset=
 + offset);
> +}
> +
> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset,=
 u32 value)
> +{
> + =A0 =A0 =A0 __raw_writel(value, keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset=
 + offset);
> +}
> +
> +static int kbd_read_revision(struct omap4_keypad *keypad_data, u32 o=
ffset)
> +{
> + =A0 =A0 =A0 int reg;
> + =A0 =A0 =A0 reg =3D __raw_readl(keypad_data->base + offset);
> + =A0 =A0 =A0 reg &=3D 0x03 << 30;
> + =A0 =A0 =A0 reg >>=3D 30;
> +
> + =A0 =A0 =A0 switch (reg) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return KBD_REVISION_OMAP5;
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return KBD_REVISION_OMAP4;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +}
> +
> =A0/* Interrupt handler */
> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
> =A0{
> @@ -91,12 +146,10 @@ static irqreturn_t omap4_keypad_interrupt(int ir=
q, void *dev_id)
> =A0 =A0 =A0 =A0u32 *new_state =3D (u32 *) key_state;
>
> =A0 =A0 =A0 =A0/* Disable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KB=
D_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqenable(keypad_data, OMAP4_VAL_IRQDISABLE);
>
> - =A0 =A0 =A0 *new_state =3D __raw_readl(keypad_data->base + OMAP4_KB=
D_FULLCODE31_0);
> - =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
> + =A0 =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCOD=
E31_0);
> + =A0 =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_F=
ULLCODE63_32);
>
> =A0 =A0 =A0 =A0for (row =3D 0; row < keypad_data->rows; row++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0changed =3D key_state[row] ^ keypad_da=
ta->key_state[row];
> @@ -121,12 +174,12 @@ static irqreturn_t omap4_keypad_interrupt(int i=
rq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_=
IRQSTATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqstatus(keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kbd_read_irqstatus(keypad_data, keypad_=
data->irqstatus));
>
> =A0 =A0 =A0 =A0/* enable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IR=
QENABLE_LONGKEY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqenable(keypad_data, OMAP4_DEF_IRQENABLE_EV=
ENTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_LON=
GKEY);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input_dev *=
input)
>
> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_CTRL);
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_DEBOUNCINGTIME);
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQSTATUS);
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IR=
QENABLE_LONGKEY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQENABLE);
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LO=
NG_KEY_ENA,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_WAKEUPENABLE);
> + =A0 =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
> + =A0 =A0 =A0 switch (keypad_data->revision) {
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IR=
QSTATUS + 0x0c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IR=
QENABLE + 0x0c;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IR=
QSTATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IR=
QENABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x00;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Omap keypad not found\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCFG=
);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTIM=
E);
> + =A0 =A0 =A0 kbd_write_irqstatus(keypad_data, OMAP4_VAL_IRQDISABLE);
> + =A0 =A0 =A0 kbd_write_irqenable(keypad_data, OMAP4_DEF_IRQENABLE_EV=
ENTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_D=
EF_IRQENABLE_LONGKEY);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_ENA=
 | OMAP4_DEF_WUP_LONG_KEY_ENA);
>
> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>
> @@ -162,12 +232,11 @@ static void omap4_keypad_close(struct input_dev=
 *input)
> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>
> =A0 =A0 =A0 =A0/* Disable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KB=
D_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqenable(keypad_data, OMAP4_VAL_IRQDISABLE);
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_=
IRQSTATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqstatus(keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kbd_read_irqstatus(keypad_data, keypad_=
data->irqstatus));
>
> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>
> --
> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
