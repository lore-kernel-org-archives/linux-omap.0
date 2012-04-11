From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH RESEND] Input: omap-keypad: dynamically handle register offsets
Date: Wed, 11 Apr 2012 14:19:48 +0530
Message-ID: <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
	<20120410162353.GA6217@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50021 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751175Ab2DKIuC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 04:50:02 -0400
Received: by wibhq7 with SMTP id hq7so3649368wib.14
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 01:49:48 -0700 (PDT)
In-Reply-To: <20120410162353.GA6217@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, balbi@ti.com

Hi Dmitry,

On Tue, Apr 10, 2012 at 9:53 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Sourav,
>
> On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
>> From: G, Manjunath Kondaiah <manjugk@ti.com>
>>
>> Keypad controller register offsets are different for omap4
>> and omap5. Handle these offsets through static mapping and
>> assign these mappings during run time.
>>
>
> In addition to Felipe's comments.
>
>> @@ -76,11 +81,66 @@ struct omap4_keypad {
>>
>> =A0 =A0 =A0 unsigned int rows;
>> =A0 =A0 =A0 unsigned int cols;
>> + =A0 =A0 unsigned int revision;
>> + =A0 =A0 u32 irqstatus;
>> + =A0 =A0 u32 irqenable;
>
> =A0 =A0 =A0 =A0u32 reg_offset;
>
> and you probably won't need revision field.
>
>> =A0 =A0 =A0 unsigned int row_shift;
>> =A0 =A0 =A0 unsigned char key_state[8];
>> =A0 =A0 =A0 unsigned short keymap[];
>> =A0};
>>
>> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
>> +{
>> + =A0 =A0 if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + off=
set);
>> + =A0 =A0 else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return __raw_readl(keypad_data->base + off=
set + 0x10);
>> +
>> + =A0 =A0 return -ENODEV;
>
> Instead do:
>
> =A0 =A0 =A0 =A0return __raw_readl(keypad_data->base + keypad_data->re=
g_offset +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset);
>> +}
I have a couple of doubts on this:
1. Before using kbd_readl/kbd_write anywhere we
need to populate the "keypad_data->reg_offset"  with the register addre=
ss
which we need to read or write.
>> +
>> +static void kbd_writel(struct omap4_keypad *keypad_data, u32 offset=
, u32
>> value)
>> +{
>> + =A0 =A0 if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(value, keypad_data->base + of=
fset);
>> + =A0 =A0 else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(value, keypad_data->base + of=
fset + 0x10);
>
> =A0 =A0 =A0 =A0__raw_writel(value,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + keypad_da=
ta->reg_offset + offset);
>
>> +}
>> +
>> +static int kbd_read_revision(struct omap4_keypad *keypad_data, u32
>> offset)
>> +{
>> + =A0 =A0 int reg;
>> + =A0 =A0 reg =3D __raw_readl(keypad_data->base + offset);
>> + =A0 =A0 reg &=3D 0x03 << 30;
>> + =A0 =A0 reg >>=3D 30;
>> +
>> + =A0 =A0 switch (reg) {
>> + =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return KBD_REVISION_OMAP5;
>> + =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return KBD_REVISION_OMAP4;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> -EINVAL? -EIO?
Hmm, -EINVAL looks more apt here.Will change.
>
>> + =A0 =A0 }
>> +}
>> +
>> =A0/* Interrupt handler */
>> =A0static irqreturn_t omap4_keypad_interrupt(int irq, void *dev_id)
>> =A0{
>> @@ -91,12 +151,11 @@ static irqreturn_t omap4_keypad_interrupt(int i=
rq,
>> void *dev_id)
>> =A0 =A0 =A0 u32 *new_state =3D (u32 *) key_state;
>>
>> =A0 =A0 =A0 /* Disable interrupts */
>> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_I=
RQENABLE);
>> + =A0 =A0 kbd_write_irqenable(keypad_data, keypad_data->irqenable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
>>
>> - =A0 =A0 *new_state =3D __raw_readl(keypad_data->base +
>> OMAP4_KBD_FULLCODE31_0);
>> - =A0 =A0 *(new_state + 1) =3D __raw_readl(keypad_data->base
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP4_KBD_FULLCODE63_32);
>> + =A0 =A0 *new_state =3D kbd_readl(keypad_data, OMAP4_KBD_FULLCODE31=
_0);
>> + =A0 =A0 *(new_state + 1) =3D kbd_readl(keypad_data, OMAP4_KBD_FULL=
CODE63_32);
>>
>> =A0 =A0 =A0 for (row =3D 0; row < keypad_data->rows; row++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 changed =3D key_state[row] ^ keypad_data=
->key_state[row];
>> @@ -121,12 +180,13 @@ static irqreturn_t omap4_keypad_interrupt(int =
irq,
>> void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(keypad_data->key_state));
>>
>> =A0 =A0 =A0 /* clear pending interrupts */
>> - =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQ=
STATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> + =A0 =A0 kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 kbd_read_irqstatus(keypad_data, keypad_dat=
a->irqstatus));
>>
>> =A0 =A0 =A0 /* enable interrupts */
>> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN |
>> OMAP4_DEF_IRQENABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>> + =A0 =A0 kbd_write_irqenable(keypad_data, keypad_data->irqenable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTEN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_LONGKE=
Y);
>>
>> =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0}
>> @@ -139,16 +199,30 @@ static int omap4_keypad_open(struct input_dev
>> *input)
>>
>> =A0 =A0 =A0 disable_irq(keypad_data->irq);
>>
>> - =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_CTRL);
>> - =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_DEBOUNCINGTIME);
>> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN |
>> OMAP4_DEF_IRQENABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_=
KEY_ENA,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_WAKEUPENABLE);
>> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
>
> =A0 =A0 =A0 =A0switch()
Ok. Will covert that to switch statement.
>> + =A0 =A0 if (keypad_data->revision =3D=3D KBD_REVISION_OMAP4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQST=
ATUS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQEN=
ABLE;
>> + =A0 =A0 } else if (keypad_data->revision =3D=3D KBD_REVISION_OMAP5=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQST=
ATUS + 0x0c;
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQEN=
ABLE + 0x0c;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Omap keypad not found\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> Hmm, this is in open() but should probably be in probe().
This requires reading of KBD_REVISION register, which can
be done once the clocks are enabled. As the current implementation
goes, clocks get enabled only when some input device is opened.
>

>> + =A0 =A0 }
>> +
>> + =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_CTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_FUNCTIONALCFG);
>> + =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_DEBOUNCINGTIME);
>> + =A0 =A0 kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
>> + =A0 =A0 kbd_write_irqenable(keypad_data, keypad_data->irqenable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_IRQENABLE_EVENTE=
N |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_=
IRQENABLE_LONGKEY);
>> + =A0 =A0 kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_DEF_WUP_EVENT_ENA |
>> OMAP4_DEF_WUP_LONG_KEY_ENA);
>>
>> =A0 =A0 =A0 enable_irq(keypad_data->irq);
>>
>> @@ -162,12 +236,12 @@ static void omap4_keypad_close(struct input_de=
v
>> *input)
>> =A0 =A0 =A0 disable_irq(keypad_data->irq);
>>
>> =A0 =A0 =A0 /* Disable interrupts */
>> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0keypad_data->base + OMAP4_KBD_I=
RQENABLE);
>> + =A0 =A0 kbd_write_irqenable(keypad_data, keypad_data->irqenable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_VAL_IRQDISABLE);
>>
>> =A0 =A0 =A0 /* clear pending interrupts */
>> - =A0 =A0 __raw_writel(__raw_readl(keypad_data->base + OMAP4_KBD_IRQ=
STATUS),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQSTATUS);
>> + =A0 =A0 kbd_write_irqstatus(keypad_data, keypad_data->irqstatus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 kbd_read_irqstatus(keypad_data, keypad_dat=
a->irqstatus));
>>
>> =A0 =A0 =A0 enable_irq(keypad_data->irq);
>>
>
> Thanks.
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
