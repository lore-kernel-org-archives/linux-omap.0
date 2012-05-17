From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv2] Input: omap-keypad: dynamically handle register offsets
Date: Thu, 17 May 2012 19:01:49 +0530
Message-ID: <CAKdam55EAHZvM6-r138UgVnqw5t_cE1=+t_Hwm=WmMk8nMwKuA@mail.gmail.com>
References: <1335419677-24934-1-git-send-email-sourav.poddar@ti.com>
	<20120509051809.GA10514@core.coreip.homeip.net>
	<CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
	<20120509074539.GI10514@core.coreip.homeip.net>
	<CAKdam567nCNbMX8hW=bKS5bSQs_z9wP-GaM3sWsM2fjhmVQZMg@mail.gmail.com>
	<CAKdam57xYtKw7iNJFd+5r-VS-6Mn8OG26xEFUR9SiMvk8gPW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CAKdam57xYtKw7iNJFd+5r-VS-6Mn8OG26xEFUR9SiMvk8gPW4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, akpm@linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

Gentle Ping on this..

~Sourav
On Wed, May 9, 2012 at 3:37 PM, Poddar, Sourav <sourav.poddar@ti.com> w=
rote:
> Hi Dmitry,
>
> On Wed, May 9, 2012 at 3:14 PM, Poddar, Sourav <sourav.poddar@ti.com>=
 wrote:
>> Hi Dmitry,
>>
>> I did some minor fixes to the patch which you suggested above and
>> the keypad is functional now.
>>
>> Changes:
>> - Move "pm_runtime_enable" before using "pm_runtime_get_sync".
>>
>> Sending the patch inlined..(also attached).
>>
>> From: G, Manjunath Kondaiah <manjugk@ti.com>
>> Date: Mon, 10 Oct 2011 20:52:05 +0530
>> Subject: [PATCH] Input: omap-keypad: dynamically handle register off=
sets
>>
>> Keypad controller register offsets are different for omap4
>> and omap5. Handle these offsets through static mapping and
>> assign these mappings during run time.
>>
>> Tested on omap4430 sdp with 3.4-rc3.
>> Tested on omap5430evm with 3.1-custom kernel.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +-
>> =A0drivers/input/keyboard/omap4-keypad.c | =A0120 ++++++++++++++++++=
+++++++-------
>> =A02 files changed, 95 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard=
/Kconfig
>> index f354813..33bbdee 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -512,9 +512,9 @@ config KEYBOARD_OMAP
>> =A0 =A0 =A0 =A0 =A0module will be called omap-keypad.
>>
>> =A0config KEYBOARD_OMAP4
>> - =A0 =A0 =A0 tristate "TI OMAP4 keypad support"
>> + =A0 =A0 =A0 tristate "TI OMAP4+ keypad support"
>> =A0 =A0 =A0 =A0help
>> - =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4 keypad.
>> + =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4+ keypad.
>>
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the
>> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
>> diff --git a/drivers/input/keyboard/omap4-keypad.c
>> b/drivers/input/keyboard/omap4-keypad.c
>> index e809ac0..d7102e8 100644
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad=
_data->reg_offset + offset);
>> +}
>> +
>> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset=
, u32 value)
>> +{
>> + =A0 =A0 =A0 __raw_writel(value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_=
data->reg_offset + offset);
>> +}
>> +
>> +static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 of=
fset)
>> +{
>> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad=
_data->irqreg_offset + offset);
>> +}
>> +
>> +static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 offset,=
 u32 value)
>> +{
>> + =A0 =A0 =A0 __raw_writel(value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_=
data->irqreg_offset + offset);
>> +}
>> +
>> +
>> =A0/* Interrupt handler */
>> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>> =A0{
>> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int
>> irq, void *dev_id)
>> =A0 =A0 =A0 =A0u32 *new_state =3D (u32 *) key_state;
>>
>> =A0 =A0 =A0 =A0/* Disable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_K=
BD_IRQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABL=
E);
>>
>> - =A0 =A0 =A0 *new_state =3D __raw_readl(keypad_data->base + OMAP4_K=
BD_FULLCODE31_0);
>> - =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
>> + =A0 =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCO=
DE31_0);
>> + =A0 =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_=
=46ULLCODE63_32);
>>
>> =A0 =A0 =A0 =A0for (row =3D 0; row < keypad_data->rows; row++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0changed =3D key_state[row] ^ keypad_d=
ata->key_state[row];
>> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int
>> irq, void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>>
>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD=
_IRQSTATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_IRQSTATUS);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(key=
pad_data, OMAP4_KBD_IRQSTATUS));
>>
>> =A0 =A0 =A0 =A0/* enable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_I=
RQENABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_IRQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_=
DEF_IRQENABLE_LONGKEY);
>>
>> =A0 =A0 =A0 =A0return IRQ_HANDLED;
>> =A0}
>> @@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev =
*input)
>>
>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_CTRL);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_DEBOUNCINGTIME);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_IRQSTATUS);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_I=
RQENABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_IRQENABLE);
>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_L=
ONG_KEY_ENA,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_WAKEUPENABLE);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCF=
G);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTI=
ME);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EV=
ENTEN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_=
DEF_IRQENABLE_LONGKEY);
>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_EN=
A | OMAP4_DEF_WUP_LONG_KEY_ENA);
>>
>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>
>> @@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_de=
v *input)
>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>
>> =A0 =A0 =A0 =A0/* Disable interrupts */
>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_K=
BD_IRQENABLE);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABL=
E);
>>
>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD=
_IRQSTATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OM=
AP4_KBD_IRQSTATUS);
>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(key=
pad_data, OMAP4_KBD_IRQSTATUS));
>>
>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>
>> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0struct resource *res;
>> =A0 =A0 =A0 =A0resource_size_t size;
>> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
>> + =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 =A0int irq;
>> =A0 =A0 =A0 =A0int error;
>>
>> @@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
>> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>>
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 * Enable clocks for the keypad module so that we can r=
ead
>> + =A0 =A0 =A0 * revision register.
>> + =A0 =A0 =A0 */
>> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 error =3D pm_runtime_get_sync(&pdev->dev);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pm_runtime_get_sy=
nc() failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REVI=
SION);
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Keypad reports unsupp=
orted revision %d", rev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0/* input device allocation */
>> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_d=
evice();
>> =A0 =A0 =A0 =A0if (!input_dev) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0input_dev->name =3D pdev->name;
>> @@ -273,14 +337,14 @@ static int __devinit omap4_keypad_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_dev->keycode, i=
nput_dev->keybit);
>>
>> =A0 =A0 =A0 =A0error =3D request_irq(keypad_data->irq, omap4_keypad_=
interrupt,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_TRIGGE=
R_RISING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABLED =
| IRQF_TRIGGER_RISING,
> Sorry, " IRQF_DISABLED" got included by mistake.
> Removing this stray change and sending it again.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "omap4-keypa=
d", keypad_data);
>> =A0 =A0 =A0 =A0if (error) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to regist=
er interrupt\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free_input;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>>
>> =A0 =A0 =A0 =A0error =3D input_register_device(keypad_data->input);
>> =A0 =A0 =A0 =A0if (error < 0) {
>> @@ -296,6 +360,8 @@ err_pm_disable:
>> =A0 =A0 =A0 =A0free_irq(keypad_data->irq, keypad_data);
>> =A0err_free_input:
>> =A0 =A0 =A0 =A0input_free_device(input_dev);
>> +err_pm_put_sync:
>> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>> =A0err_unmap:
>> =A0 =A0 =A0 =A0iounmap(keypad_data->base);
>> =A0err_release_mem:
>>
>>
>> ~Sourav
>>
>> On Wed, May 9, 2012 at 1:15 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>>> Hi Dmitry ,
>>>>
>>>>
>>>> On Wed, May 9, 2012 at 10:48 AM, Dmitry Torokhov
>>>> <dmitry.torokhov@gmail.com> wrote:
>>>> > Ho Sourav,
>>>> >
>>>> > On Thu, Apr 26, 2012 at 11:24:37AM +0530, Sourav Poddar wrote:
>>>> >>
>>>> >> -config KEYBOARD_OMAP4
>>>> >> - =A0 =A0 tristate "TI OMAP4 keypad support"
>>>> >> +config KEYBOARD_OMAP4+
>>>> >
>>>> > I think this works purely by accident - '+' sign getting dropped=
 by
>>>> > parser...
>>>> >
>>>> >> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input=
_dev *input)
>>>> >>
>>>> >> =A0 =A0 =A0 disable_irq(keypad_data->irq);
>>>> >>
>>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_CTRL);
>>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_DEBOUNCINGTIME);
>>>> >> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQSTATUS);
>>>> >> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_=
IRQENABLE_LONGKEY,
>>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQENABLE);
>>>> >> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_=
LONG_KEY_ENA,
>>>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_WAKEUPENABLE);
>>>> >> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_da=
ta,
>>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
>>>> >> + =A0 =A0 switch (keypad_data->revision) {
>>>> >> + =A0 =A0 case 1:
>>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_=
IRQSTATUS + 0x0c;
>>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_=
IRQENABLE + 0x0c;
>>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>>>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> >
>>>> > This should be done in probe().
>>>> >
>>>> Dont we then require "pm_runtime_put_sync" in probe, since we are =
trying
>>>> to read the keypad revision register.?
>>>
>>> Ah, indeed, but I think not pm_runtime_get_sync() but
>>> pm_runtime_set_active().
>>>
>>> Not sure if this will fix the crash...
>>>
>>> --
>>> Dmitry
>>>
>>>
>>> Input: omap-keypad - dynamically handle register offsets
>>>
>>> From: G, Manjunath Kondaiah <manjugk@ti.com>
>>>
>>> Keypad controller register offsets are different for omap4
>>> and omap5. Handle these offsets through static mapping and
>>> assign these mappings during run time.
>>>
>>> Tested on omap4430 sdp with 3.4-rc3.
>>> Tested on omap5430evm with 3.1-custom kernel.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>>> ---
>>>
>>> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
>>> =A0drivers/input/keyboard/omap4-keypad.c | =A0117 +++++++++++++++++=
+++++++++-------
>>> =A02 files changed, 94 insertions(+), 27 deletions(-)
>>>
>>>
>>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboar=
d/Kconfig
>>> index 20a3753..84ee155 100644
>>> --- a/drivers/input/keyboard/Kconfig
>>> +++ b/drivers/input/keyboard/Kconfig
>>> @@ -531,9 +531,9 @@ config KEYBOARD_OMAP
>>> =A0 =A0 =A0 =A0 =A0module will be called omap-keypad.
>>>
>>> =A0config KEYBOARD_OMAP4
>>> - =A0 =A0 =A0 tristate "TI OMAP4 keypad support"
>>> + =A0 =A0 =A0 tristate "TI OMAP4+ keypad support"
>>> =A0 =A0 =A0 =A0help
>>> - =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4 keypad.
>>> + =A0 =A0 =A0 =A0 Say Y here if you want to use the OMAP4+ keypad.
>>>
>>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M her=
e: the
>>> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
>>> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/=
keyboard/omap4-keypad.c
>>> index e809ac0..c9fd0df 100644
>>> --- a/drivers/input/keyboard/omap4-keypad.c
>>> +++ b/drivers/input/keyboard/omap4-keypad.c
>>> @@ -68,19 +68,52 @@
>>>
>>> =A0#define OMAP4_MASK_IRQSTATUSDISABLE =A0 =A00xFFFF
>>>
>>> +enum {
>>> + =A0 =A0 =A0 KBD_REVISION_OMAP4 =3D 0,
>>> + =A0 =A0 =A0 KBD_REVISION_OMAP5,
>>> +};
>>> +
>>> =A0struct omap4_keypad {
>>> =A0 =A0 =A0 =A0struct input_dev *input;
>>>
>>> =A0 =A0 =A0 =A0void __iomem *base;
>>> - =A0 =A0 =A0 int irq;
>>> + =A0 =A0 =A0 unsigned int irq;
>>>
>>> =A0 =A0 =A0 =A0unsigned int rows;
>>> =A0 =A0 =A0 =A0unsigned int cols;
>>> + =A0 =A0 =A0 u32 reg_offset;
>>> + =A0 =A0 =A0 u32 irqreg_offset;
>>> =A0 =A0 =A0 =A0unsigned int row_shift;
>>> =A0 =A0 =A0 =A0unsigned char key_state[8];
>>> =A0 =A0 =A0 =A0unsigned short keymap[];
>>> =A0};
>>>
>>> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
>>> +{
>>> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypa=
d_data->reg_offset + offset);
>>> +}
>>> +
>>> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offse=
t, u32 value)
>>> +{
>>> + =A0 =A0 =A0 __raw_writel(value,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad=
_data->reg_offset + offset);
>>> +}
>>> +
>>> +static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 o=
ffset)
>>> +{
>>> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypa=
d_data->irqreg_offset + offset);
>>> +}
>>> +
>>> +static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 offset=
, u32 value)
>>> +{
>>> + =A0 =A0 =A0 __raw_writel(value,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad=
_data->irqreg_offset + offset);
>>> +}
>>> +
>>> +
>>> =A0/* Interrupt handler */
>>> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>>> =A0{
>>> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int =
irq, void *dev_id)
>>> =A0 =A0 =A0 =A0u32 *new_state =3D (u32 *) key_state;
>>>
>>> =A0 =A0 =A0 =A0/* Disable interrupts */
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISAB=
LE);
>>>
>>> - =A0 =A0 =A0 *new_state =3D __raw_readl(keypad_data->base + OMAP4_=
KBD_FULLCODE31_0);
>>> - =A0 =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
>>> + =A0 =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLC=
ODE31_0);
>>> + =A0 =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD=
_FULLCODE63_32);
>>>
>>> =A0 =A0 =A0 =A0for (row =3D 0; row < keypad_data->rows; row++) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0changed =3D key_state[row] ^ keypad_=
data->key_state[row];
>>> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int=
 irq, void *dev_id)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>>>
>>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KB=
D_IRQSTATUS),
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQSTATUS);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(ke=
ypad_data, OMAP4_KBD_IRQSTATUS));
>>>
>>> =A0 =A0 =A0 =A0/* enable interrupts */
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_=
IRQENABLE_LONGKEY,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQENABLE);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
_DEF_IRQENABLE_LONGKEY);
>>>
>>> =A0 =A0 =A0 =A0return IRQ_HANDLED;
>>> =A0}
>>> @@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev=
 *input)
>>>
>>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>>
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_CTRL);
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_DEBOUNCINGTIME);
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQSTATUS);
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_=
IRQENABLE_LONGKEY,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQENABLE);
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_=
LONG_KEY_ENA,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_WAKEUPENABLE);
>>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALC=
=46G);
>>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGT=
IME);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE)=
;
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_E=
VENTEN |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
_DEF_IRQENABLE_LONGKEY);
>>> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_E=
NA | OMAP4_DEF_WUP_LONG_KEY_ENA);
>>>
>>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>>
>>> @@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_d=
ev *input)
>>> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>>>
>>> =A0 =A0 =A0 =A0/* Disable interrupts */
>>> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISAB=
LE);
>>>
>>> =A0 =A0 =A0 =A0/* clear pending interrupts */
>>> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KB=
D_IRQSTATUS),
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + O=
MAP4_KBD_IRQSTATUS);
>>> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(ke=
ypad_data, OMAP4_KBD_IRQSTATUS));
>>>
>>> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>>>
>>> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
>>> =A0 =A0 =A0 =A0struct resource *res;
>>> =A0 =A0 =A0 =A0resource_size_t size;
>>> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
>>> + =A0 =A0 =A0 int rev;
>>> =A0 =A0 =A0 =A0int irq;
>>> =A0 =A0 =A0 =A0int error;
>>>
>>> @@ -241,11 +276,40 @@ static int __devinit omap4_keypad_probe(struc=
t platform_device *pdev)
>>> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
>>> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>>>
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Mark device as active (and wake up its parent) s=
o we can read
>>> + =A0 =A0 =A0 =A0* revision register.
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 error =3D pm_runtime_set_active(&pdev->dev);
>>> + =A0 =A0 =A0 if (error) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pm_runtime_set_a=
ctive() failed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REV=
ISION);
>>> + =A0 =A0 =A0 rev &=3D 0x03 << 30;
>>> + =A0 =A0 =A0 rev >>=3D 30;
>>> + =A0 =A0 =A0 switch (rev) {
>>> + =A0 =A0 =A0 case KBD_REVISION_OMAP4:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x00;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x00;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 case KBD_REVISION_OMAP5:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqreg_offset =3D 0x0c;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 default:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Keypad reports unsup=
ported revision %d", rev);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_suspended;
>>> + =A0 =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 =A0/* input device allocation */
>>> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_=
device();
>>> =A0 =A0 =A0 =A0if (!input_dev) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_suspended;
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0input_dev->name =3D pdev->name;
>>> @@ -281,6 +345,7 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
>>> =A0 =A0 =A0 =A0}
>>>
>>> =A0 =A0 =A0 =A0pm_runtime_enable(&pdev->dev);
>>> + =A0 =A0 =A0 pm_runtime_put_sync(&pdev->dev);
>>>
>>> =A0 =A0 =A0 =A0error =3D input_register_device(keypad_data->input);
>>> =A0 =A0 =A0 =A0if (error < 0) {
>>> @@ -296,6 +361,8 @@ err_pm_disable:
>>> =A0 =A0 =A0 =A0free_irq(keypad_data->irq, keypad_data);
>>> =A0err_free_input:
>>> =A0 =A0 =A0 =A0input_free_device(input_dev);
>>> +err_pm_suspended:
>>> + =A0 =A0 =A0 pm_runtime_set_suspended(&pdev->dev);
>>> =A0err_unmap:
>>> =A0 =A0 =A0 =A0iounmap(keypad_data->base);
>>> =A0err_release_mem:
>
> From: G, Manjunath Kondaiah <manjugk@ti.com>
> Date: Mon, 10 Oct 2011 20:52:05 +0530
> Subject: [PATCH] Input: omap-keypad: dynamically handle register offs=
ets
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
> =A0drivers/input/keyboard/omap4-keypad.c | =A0118 +++++++++++++++++++=
++++++-------
> =A02 files changed, 94 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
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
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
> diff --git a/drivers/input/keyboard/omap4-keypad.c
> b/drivers/input/keyboard/omap4-keypad.c
> index e809ac0..28da0e4 100644
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_=
data->reg_offset + offset);
> +}
> +
> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset,=
 u32 value)
> +{
> + =A0 =A0 =A0 __raw_writel(value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_d=
ata->reg_offset + offset);
> +}
> +
> +static int kbd_read_irqreg(struct omap4_keypad *keypad_data, u32 off=
set)
> +{
> + =A0 =A0 =A0 return __raw_readl(keypad_data->base +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_=
data->irqreg_offset + offset);
> +}
> +
> +static void kbd_write_irqreg(struct omap4_keypad *keypad_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 offset, =
u32 value)
> +{
> + =A0 =A0 =A0 __raw_writel(value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + keypad_d=
ata->irqreg_offset + offset);
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KB=
D_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE=
);
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
> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int
> irq, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(keypad_data->key_state));
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_=
IRQSTATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keyp=
ad_data, OMAP4_KBD_IRQSTATUS));
>
> =A0 =A0 =A0 =A0/* enable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IR=
QENABLE_LONGKEY,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_D=
EF_IRQENABLE_LONGKEY);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -139,16 +172,17 @@ static int omap4_keypad_open(struct input_dev *=
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
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCFG=
);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTIM=
E);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVE=
NTEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_D=
EF_IRQENABLE_LONGKEY);
> + =A0 =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_ENA=
 | OMAP4_DEF_WUP_LONG_KEY_ENA);
>
> =A0 =A0 =A0 =A0enable_irq(keypad_data->irq);
>
> @@ -162,12 +196,12 @@ static void omap4_keypad_close(struct input_dev=
 *input)
> =A0 =A0 =A0 =A0disable_irq(keypad_data->irq);
>
> =A0 =A0 =A0 =A0/* Disable interrupts */
> - =A0 =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KB=
D_IRQENABLE);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_VAL_IRQDISABLE=
);
>
> =A0 =A0 =A0 =A0/* clear pending interrupts */
> - =A0 =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_=
IRQSTATUS),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMA=
P4_KBD_IRQSTATUS);
> + =A0 =A0 =A0 kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kbd_read_irqreg(keyp=
ad_data, OMAP4_KBD_IRQSTATUS));
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
> + =A0 =A0 =A0 * Enable clocks for the keypad module so that we can re=
ad
> + =A0 =A0 =A0 * revision register.
> + =A0 =A0 =A0 */
> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
> + =A0 =A0 =A0 error =3D pm_runtime_get_sync(&pdev->dev);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "pm_runtime_get_syn=
c() failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 rev =3D __raw_readl(keypad_data->base + OMAP4_KBD_REVIS=
ION);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Keypad reports unsuppo=
rted revision %d", rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* input device allocation */
> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_de=
vice();
> =A0 =A0 =A0 =A0if (!input_dev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pm_put_sync;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0input_dev->name =3D pdev->name;
> @@ -280,7 +344,7 @@ static int __devinit omap4_keypad_probe(struct
> platform_device *pdev)
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
> --
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
