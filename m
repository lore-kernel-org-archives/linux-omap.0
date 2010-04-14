From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 14 Apr 2010 13:04:40 +0530
Message-ID: <i2x5d5443651004140034mdd11969cg72d4306c77f2bd0f@mail.gmail.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Abraham,

On Wed, Apr 14, 2010 at 6:40 AM, Arce, Abraham <x0066660@ti.com> wrote:
> Keyboard controller for OMAP4 with built-in scanning algorithm.
> The following implementations are used:
>
> =A0- matrix_keypac.c logic
> =A0- hwmod framework

Do we have hwmod framework mainlined in the kernel?

>
> +config KEYBOARD_OMAP4
> + =A0 =A0 =A0 =A0tristate "TI OMAP4 keypad support"
> + =A0 =A0 =A0 =A0depends on (ARCH_OMAP4)

No need of brackets.

Could you please provide "default y/n" option too?

> + * linux/drivers/input/keyboard/omap4-keypad.c

Better not to include file paths.

> +
> +struct omap_device_pm_latency omap_keyboard_latency[] =3D {

static?

> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enab=
le_hwmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJ=
UST,
> + =A0 =A0 =A0 },
> +};
> +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct omap_keypad *keypad_data =3D dev_id;
> + =A0 =A0 =A0 struct input_dev *input =3D keypad_data->input;
> + =A0 =A0 =A0 unsigned char key_state[8];
> + =A0 =A0 =A0 int col, row, code;
> + =A0 =A0 =A0 u32 *new_state =3D (u32 *) key_state;
> +
> + =A0 =A0 =A0 *new_state =A0 =A0 =A0 =3D __raw_readl(keypad_data->bas=
e +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_FULLCODE31_0)=
;
> + =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_FULLCODE63_32=
);
> +
> + =A0 =A0 =A0 for (col =3D 0; col < keypad_data->cols; col++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (row =3D 0; row < keypad_data->rows=
; row++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D MATRIX_SCAN_CO=
DE(row, col,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad_data->row_shift);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (code < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_INFO "Spurious key %d-%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 col, row);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 keypad_data->keycodes[code],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 key_state[col] & (1 << row));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }

where is input_sync(..)?

> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(struct matrix_keypad_platform_=
data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);

Please check error return here, because kzalloc can fail.

> +
> + =A0 =A0 =A0 od =3D omap_device_build(name, id, oh, pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct matrix_keypad_platform_data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_ke=
yboard_latency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_S=
IZE(omap_keyboard_latency), 1);
> + =A0 =A0 =A0 WARN(IS_ERR(od), "Could not build omap_device for %s %s=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, oh_name);
> +
> + =A0 =A0 =A0 /* platform data */
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data d=
efined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* keymap data */
> + =A0 =A0 =A0 keymap_data =3D pdata->keymap_data;
> + =A0 =A0 =A0 if (!keymap_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no keymap data def=
ined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(keymap_data);

not freeing kfree(pdata)? Please check error return path again in this =
driver.

> +
> + =A0 =A0 =A0 __set_bit(EV_REP, input_dev->evbit);
> + =A0 =A0 =A0 __set_bit(KEY_OK, input_dev->keybit);
> + =A0 =A0 =A0 __set_bit(EV_KEY, input_dev->evbit);

> +
> + =A0 =A0 =A0 input_set_capability(input_dev, EV_MSC, MSC_SCAN);
> + =A0 =A0 =A0 input_set_drvdata(input_dev, keypad_data);
> +
> + =A0 =A0 =A0 status =3D input_register_device(keypad_data->input);
> + =A0 =A0 =A0 if (status < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to register=
 input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto failed_free_device;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_keypad_config(keypad_data);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, keypad_data);
> +
> + =A0 =A0 =A0 return 0;
> +
> +failed_free_device:
> + =A0 =A0 =A0 input_unregister_device(keypad_data->input);

add keypad_data->input =3D NULL.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
