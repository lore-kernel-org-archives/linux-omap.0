From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] TWL4030:TWL5030:TPS659x0: add keypad support
Date: Mon, 20 Jul 2009 12:36:47 +0530
Message-ID: <5d5443650907200006h29b75a94kfab151a900f00fd@mail.gmail.com>
References: <1247876000-4457-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1247876000-4457-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Vikram,

> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/twl4030.h>
> +#include <mach/keypad.h>

One empty line between above two headers.

I hope you are aware of earlier comments posted for this driver when
it was submitted few months back and had long discussion on threaded
irq stuff.

> +
> +/*
> + * The TWL4030 family chips include a keypad controller that support=
s
> + * up to an 8x8 switch matrix. =A0The controller can issue system wa=
keup
> + * events, since it uses only the always-on 32KiHz oscillator, and h=
as
> + * an internal state machine that decodes pressed keys, including
> + * multi-key combinations.
> + *
> + * This driver lets boards define what keycodes they wish to report =
for
> + * which scancodes, as part of the "struct twl4030_keypad_data" used=
 in
> + * the probe() routine.
> + *
> + * See the TPS65950 documentation; that's the general availability
> + * version of the TWL5030 second generation part.
> + */
> +#define MAX_ROWS =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 =A0 =A0 =A0 /* TWL403=
0 hard limit */
> +
> +struct twl4030_keypad {
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0*keymap;
> + =A0 =A0 =A0 unsigned int =A0 =A0keymapsize;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 kp_state[MAX_ROWS];
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0n_rows;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0n_cols;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0irq;
> +
> + =A0 =A0 =A0 struct device =A0 *dbg_dev;
> + =A0 =A0 =A0 struct input_dev *input;
> +};
> +
> +#define ROWCOL_MASK =A0 =A0KEY(0xf, 0xf, 0)
> +
> +/*------------------------------------------------------------------=
----*/
> +
> +/* arbitrary prescaler value 0..7 */
> +#define PTV_PRESCALER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04
> +
> +/* Register Offsets */
> +#define KEYP_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
> +#define KEYP_DEB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01
> +#define KEYP_LONG_KEY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02
> +#define KEYP_LK_PTV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03
> +#define KEYP_TIMEOUT_L =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x04
> +#define KEYP_TIMEOUT_H =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x05
> +#define KEYP_KBC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x06
> +#define KEYP_KBR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x07
> +#define KEYP_SMS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x08
> +#define KEYP_FULL_CODE_7_0 =A0 =A0 =A0 =A0 =A0 =A0 0x09 =A0 =A0/* ro=
w 0 column status */
> +#define KEYP_FULL_CODE_15_8 =A0 =A0 =A0 =A0 =A0 =A00x0a =A0 =A0/* ..=
=2E row 1 ... */
> +#define KEYP_FULL_CODE_23_16 =A0 =A0 =A0 =A0 =A0 0x0b
> +#define KEYP_FULL_CODE_31_24 =A0 =A0 =A0 =A0 =A0 0x0c
> +#define KEYP_FULL_CODE_39_32 =A0 =A0 =A0 =A0 =A0 0x0d
> +#define KEYP_FULL_CODE_47_40 =A0 =A0 =A0 =A0 =A0 0x0e
> +#define KEYP_FULL_CODE_55_48 =A0 =A0 =A0 =A0 =A0 0x0f
> +#define KEYP_FULL_CODE_63_56 =A0 =A0 =A0 =A0 =A0 0x10
> +#define KEYP_ISR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x11
> +#define KEYP_IMR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x12
> +#define KEYP_ISR2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x13
> +#define KEYP_IMR2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x14
> +#define KEYP_SIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x15
> +#define KEYP_EDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x16 =A0=
 =A0/* edge triggers */
> +#define KEYP_SIH_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x17
> +
> +/* KEYP_CTRL_REG Fields */
> +#define KEYP_CTRL_SOFT_NRST =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> +#define KEYP_CTRL_SOFTMODEN =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> +#define KEYP_CTRL_LK_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0BIT(2)
> +#define KEYP_CTRL_TOE_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> +#define KEYP_CTRL_TOLE_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> +#define KEYP_CTRL_RP_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0BIT(5)
> +#define KEYP_CTRL_KBD_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> +
> +/* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
> +#define KEYP_PERIOD_US(t, prescale) =A0 =A0((t) / (31 << (prescale +=
 1)) - 1)
> +
> +/* KEYP_LK_PTV_REG Fields */
> +#define KEYP_LK_PTV_PTV_SHIFT =A0 =A0 =A0 =A0 =A05
> +
> +/* KEYP_{IMR,ISR,SIR} Fields */
> +#define KEYP_IMR1_MIS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> +#define KEYP_IMR1_TO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(2)
> +#define KEYP_IMR1_LK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> +#define KEYP_IMR1_KP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> +
> +/* KEYP_EDR Fields */
> +#define KEYP_EDR_KP_FALLING =A0 =A0 =A0 =A0 =A0 =A00x01
> +#define KEYP_EDR_KP_RISING =A0 =A0 =A0 =A0 =A0 =A0 0x02
> +#define KEYP_EDR_KP_BOTH =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x03
> +#define KEYP_EDR_LK_FALLING =A0 =A0 =A0 =A0 =A0 =A00x04
> +#define KEYP_EDR_LK_RISING =A0 =A0 =A0 =A0 =A0 =A0 0x08
> +#define KEYP_EDR_TO_FALLING =A0 =A0 =A0 =A0 =A0 =A00x10
> +#define KEYP_EDR_TO_RISING =A0 =A0 =A0 =A0 =A0 =A0 0x20
> +#define KEYP_EDR_MIS_FALLING =A0 =A0 =A0 =A0 =A0 0x40
> +#define KEYP_EDR_MIS_RISING =A0 =A0 =A0 =A0 =A0 =A00x80
> +
> +
> +
> +static int twl4030_find_key(struct twl4030_keypad *kp, int col, int =
row)
> +{
> + =A0 =A0 =A0 int i, rc;
> +
> + =A0 =A0 =A0 rc =3D KEY(col, row, 0);
> + =A0 =A0 =A0 for (i =3D 0; i < kp->keymapsize; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((kp->keymap[i] & ROWCOL_MASK) =3D=3D=
 rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return kp->keymap[i] & =
(KEYNUM_MASK | KEY_PERSISTENT);

This is an overhead. You should follow model like matrix_keypad.c
Please check latest -rc for matrix keypad driver. Also check Dmitry's
comment on KEY_PERSISTENT and how to remove them on earlier e-mail
thread discussion of this driver.

> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static inline u16 twl4030_col_xlate(struct twl4030_keypad *kp, u8 co=
l)
> +{
> + =A0 =A0 =A0 /* If all bits in a row are active for all coloumns the=
n
> + =A0 =A0 =A0 =A0* we have that row line connected to gnd. Mark this
> + =A0 =A0 =A0 =A0* key on as if it was on matrix position n_cols (ie
> + =A0 =A0 =A0 =A0* one higher than the size of the matrix).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (col =3D=3D 0xFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1 << kp->n_cols;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return col & ((1 << kp->n_cols) - 1);
> +}
> +
> +static int twl4030_read_kp_matrix_state(struct twl4030_keypad *kp, u=
16 *state)
> +{
> + =A0 =A0 =A0 u8 new_state[MAX_ROWS];
> + =A0 =A0 =A0 int row;
> + =A0 =A0 =A0 int ret =3D twl4030_kpread(kp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_=
state, KEYP_FULL_CODE_7_0, kp->n_rows);
> + =A0 =A0 =A0 if (ret >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (row =3D 0; row < kp->n_rows; row++=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state[row] =3D twl4030_=
col_xlate(kp, new_state[row]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int twl4030_is_in_ghost_state(struct twl4030_keypad *kp, u16 =
*key_state)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u16 check =3D 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < kp->n_rows; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 col =3D key_state[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((col & check) && hweight16(col) > 1=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check |=3D col;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void twl4030_kp_scan(struct twl4030_keypad *kp, int release_a=
ll)
> +{
> + =A0 =A0 =A0 u16 new_state[MAX_ROWS];
> + =A0 =A0 =A0 int col, row;
> +
> + =A0 =A0 =A0 if (release_all)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(new_state, 0, sizeof(new_state))=
;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check for any changes */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D twl4030_read_kp_matrix_stat=
e(kp, new_state);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) =A0 =A0/* panic ... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (twl4030_is_in_ghost_state(kp, new_s=
tate))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* check for changes and print those */
> + =A0 =A0 =A0 for (row =3D 0; row < kp->n_rows; row++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int changed =3D new_state[row] ^ kp->kp=
_state[row];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!changed)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (col =3D 0; col < kp->n_cols; col++=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int key;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(changed & (1 << c=
ol)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(kp->dbg_dev, "k=
ey [%d:%d] %s\n", row, col,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (new_st=
ate[row] & (1 << col)) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "press"=
 : "release");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key =3D twl4030_find_ke=
y(kp, col, row);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (key < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(kp->dbg_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "Spurious key event %d-%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0col, row);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (key & KEY_PERS=
ISTENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_r=
eport_key(kp->input, key,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_state[row] & (1 << col));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->kp_state[row] =3D new_state[row];
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_sync(kp->input);
> +}
> +
> +/*
> + * Keypad interrupt handler
> + */
> +static irqreturn_t do_kp_irq(int irq, void *_kp)
> +{
> + =A0 =A0 =A0 struct twl4030_keypad *kp =3D _kp;
> + =A0 =A0 =A0 u8 reg;
> + =A0 =A0 =A0 int ret;
> +
> +#ifdef CONFIG_LOCKDEP
> + =A0 =A0 =A0 /* WORKAROUND for lockdep forcing IRQF_DISABLED on us, =
which
> + =A0 =A0 =A0 =A0* we don't want and can't tolerate. =A0Although it m=
ight be
> + =A0 =A0 =A0 =A0* friendlier not to borrow this thread context...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 local_irq_enable();
> +#endif


This should go away after request_threaded_irq integration in
mainline, isn't it?

> +
> + =A0 =A0 =A0 /* Read & Clear TWL4030 pending interrupt */
> + =A0 =A0 =A0 ret =3D twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
> +
> + =A0 =A0 =A0 /* Release all keys if I2C has gone bad or
> + =A0 =A0 =A0 =A0* the KEYP has gone to idle state */
> + =A0 =A0 =A0 if ((ret >=3D 0) && (reg & KEYP_IMR1_KP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_kp_scan(kp, 0);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_kp_scan(kp, 1);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/*
> + * Registers keypad device with input subsystem
> + * and configures TWL4030 keypad registers
> + */
> +static int __devinit twl4030_kp_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 u8 reg;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct twl4030_keypad *kp;
> + =A0 =A0 =A0 struct twl4030_keypad_data *pdata =3D pdev->dev.platfor=
m_data;
> +
> + =A0 =A0 =A0 if (!pdata || !pdata->rows || !pdata->cols || !pdata->k=
eymap
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || pdata->rows > 8 || p=
data->cols > 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Invalid platform_d=
ata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
> + =A0 =A0 =A0 if (!kp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, kp);
> +
> + =A0 =A0 =A0 /* Get the debug Device */
> + =A0 =A0 =A0 kp->dbg_dev =3D &pdev->dev;
> +
> + =A0 =A0 =A0 kp->input =3D input_allocate_device();
> + =A0 =A0 =A0 if (!kp->input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(kp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kp->keymap =3D pdata->keymap;
> + =A0 =A0 =A0 kp->keymapsize =3D pdata->keymapsize;
> + =A0 =A0 =A0 kp->n_rows =3D pdata->rows;
> + =A0 =A0 =A0 kp->n_cols =3D pdata->cols;
> + =A0 =A0 =A0 kp->irq =3D platform_get_irq(pdev, 0);
> +
> + =A0 =A0 =A0 /* setup input device */
> + =A0 =A0 =A0 __set_bit(EV_KEY, kp->input->evbit);
> +
> + =A0 =A0 =A0 /* Enable auto repeat feature of Linux input subsystem =
*/
> + =A0 =A0 =A0 if (pdata->rep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(EV_REP, kp->input->evbit);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < kp->keymapsize; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(kp->keymap[i] & KEYNUM_MASK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->inp=
ut->keybit);
> +
> + =A0 =A0 =A0 kp->input->name =A0 =A0 =A0 =A0 =3D "TWL4030 Keypad";
> + =A0 =A0 =A0 kp->input->phys =A0 =A0 =A0 =A0 =3D "twl4030_keypad/inp=
ut0";
> + =A0 =A0 =A0 kp->input->dev.parent =A0 =3D &pdev->dev;
> +
> + =A0 =A0 =A0 kp->input->id.bustype =A0 =3D BUS_HOST;
> + =A0 =A0 =A0 kp->input->id.vendor =A0 =A0=3D 0x0001;
> + =A0 =A0 =A0 kp->input->id.product =A0 =3D 0x0001;
> + =A0 =A0 =A0 kp->input->id.version =A0 =3D 0x0003;
> +
> + =A0 =A0 =A0 kp->input->keycode =A0 =A0 =A0=3D kp->keymap;
> + =A0 =A0 =A0 kp->input->keycodesize =A0=3D sizeof(unsigned int);
> + =A0 =A0 =A0 kp->input->keycodemax =A0 =3D kp->keymapsize;
> +
> + =A0 =A0 =A0 ret =3D input_register_device(kp->input);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(kp->dbg_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to register twl=
4030 keypad device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable controller, with hardware decoding but not au=
torepeat */
> + =A0 =A0 =A0 reg =3D KEYP_CTRL_SOFT_NRST | KEYP_CTRL_SOFTMODEN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | KEYP_CTRL_TOE_EN | KEYP_CTRL_KBD_ON;
> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_CTRL);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* NOTE: =A0we could use sih_setup() here to package ke=
ypad
> + =A0 =A0 =A0 =A0* event sources as four different IRQs ... but we do=
n't.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Enable TO rising and KP rising and falling edge dete=
ction */
> + =A0 =A0 =A0 reg =3D KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_EDR);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* Set PTV prescaler Field */
> + =A0 =A0 =A0 reg =3D (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_LK_PTV);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* Set key debounce time to 20 ms */
> + =A0 =A0 =A0 i =3D KEYP_PERIOD_US(20000, PTV_PRESCALER);

This should be flexible to be set by platform data and not hardcoded.

> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, i, KEYP_DEB);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* Set timeout period to 100 ms */
> + =A0 =A0 =A0 i =3D KEYP_PERIOD_US(200000, PTV_PRESCALER);
> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, (i & 0xFF), KEYP_TIMEOUT=
_L);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;

Ditto.

> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, (i >> 8), KEYP_TIMEOUT_H=
);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* Enable Clear-on-Read; disable remembering events tha=
t fire
> + =A0 =A0 =A0 =A0* after the IRQ but before our handler acks (reads) =
them,
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 reg =3D TWL4030_SIH_CTRL_COR_MASK | TWL4030_SIH_CTRL_PE=
NDDIS_MASK;
> + =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, reg, KEYP_SIH_CTRL);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /* initialize key state; irqs update it from here on */
> + =A0 =A0 =A0 ret =3D twl4030_read_kp_matrix_state(kp, kp->kp_state);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* This ISR will always execute in kernel thread cont=
ext because of
> + =A0 =A0 =A0 =A0* the need to access the TWL4030 over the I2C bus.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* NOTE: =A0we assume this host is wired to TWL4040 I=
NT1, not INT2 ...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D request_irq(kp->irq, do_kp_irq, 0, pdev->name, =
kp);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(kp->dbg_dev, "request_irq fail=
ed for irq no=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable KP and TO interrupts now. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D (u8) ~(KEYP_IMR1_KP | KEYP_IMR1=
_TO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl4030_kpwrite_u8(kp, reg, KEY=
P_IMR1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err5;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +err5:
> + =A0 =A0 =A0 /* mask all events - we don't care about the result */
> + =A0 =A0 =A0 (void) twl4030_kpwrite_u8(kp, 0xff, KEYP_IMR1);
> + =A0 =A0 =A0 free_irq(kp->irq, NULL);
> +err3:
> + =A0 =A0 =A0 input_unregister_device(kp->input);
> + =A0 =A0 =A0 kp->input =3D NULL;
> +err2:
> + =A0 =A0 =A0 input_free_device(kp->input);
> + =A0 =A0 =A0 kfree(kp);
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
