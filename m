From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv2] Input: omap-keypad: dynamically handle register offsets
Date: Wed, 9 May 2012 12:37:37 +0530
Message-ID: <CAKdam57E9L6Hq5-A3QBO2CGcVOaR5xGRfaLeA_ph=6YB3jjdbQ@mail.gmail.com>
References: <1335419677-24934-1-git-send-email-sourav.poddar@ti.com>
	<20120509051809.GA10514@core.coreip.homeip.net>
	<CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52900 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755259Ab2EIHHk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 03:07:40 -0400
Received: by vbbfr13 with SMTP id fr13so4934733vbb.34
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 00:07:38 -0700 (PDT)
In-Reply-To: <CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, akpm@linux-foundation.org

On Wed, May 9, 2012 at 12:24 PM, Poddar, Sourav <sourav.poddar@ti.com> =
wrote:
> Hi Dmitry ,
>
>
> On Wed, May 9, 2012 at 10:48 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Ho Sourav,
>>
>> On Thu, Apr 26, 2012 at 11:24:37AM +0530, Sourav Poddar wrote:
>>>
>>> -config KEYBOARD_OMAP4
>>> - =A0 =A0 tristate "TI OMAP4 keypad support"
>>> +config KEYBOARD_OMAP4+
>>
>> I think this works purely by accident - '+' sign getting dropped by
>> parser...
>>
>>> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input_dev=
 *input)
>>>
>>> =A0 =A0 =A0 disable_irq(keypad_data->irq);
>>>
>>> - =A0 =A0 __raw_writel(OMAP4_VAL_FUNCTIONALCFG,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4=
_KBD_CTRL);
>>> - =A0 =A0 __raw_writel(OMAP4_VAL_DEBOUNCINGTIME,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4=
_KBD_DEBOUNCINGTIME);
>>> - =A0 =A0 __raw_writel(OMAP4_VAL_IRQDISABLE,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4=
_KBD_IRQSTATUS);
>>> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQE=
NABLE_LONGKEY,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4=
_KBD_IRQENABLE);
>>> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG=
_KEY_ENA,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4=
_KBD_WAKEUPENABLE);
>>> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
>>> + =A0 =A0 switch (keypad_data->revision) {
>>> + =A0 =A0 case 1:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQS=
TATUS + 0x0c;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQE=
NABLE + 0x0c;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> This should be done in probe().
>>
> Dont we then require "pm_runtime_put_sync" in probe, since we are try=
ing
> to read the keypad revision register.?

Sorry for the typo, I meant "pm_runtime_get_sync".
>> Could you please tell me if the version of the patch below works for
>> you?
>>
>
> I just quickly tested this patch and saw the following kernel carsh.
>
> [ =A0 =A01.571838] Bad mode in data abort handler detected
> [ =A0 =A01.576934] Internal error: Oops - bad mode: 0 [#1] SMP ARM
> [ =A0 =A01.582763] Modules linked in:
> [ =A0 =A01.585937] CPU: 0 =A0 =A0Not tainted =A0(3.4.0-rc5-dirty #11)
> [ =A0 =A01.591522] PC is at __key.13633+0x3f39df40/0x8
> [ =A0 =A01.596252] LR is at omap4_keypad_probe+0x1cc/0x3dc
> [ =A0 =A01.601348] pc : [<ffff0018>] =A0 =A0lr : [<c0466ffc>] =A0 =A0=
psr: 40000092
> [ =A0 =A01.601348] sp : df831e68 =A0ip : fc31c000 =A0fp : 00000040
> [ =A0 =A01.613311] r10: c2460000 =A0r9 : 00000080 =A0r8 : 00000003
> [ =A0 =A01.618774] r7 : de36e880 =A0r6 : df966008 =A0r5 : df965480 =A0=
r4 : c2422bc0
> [ =A0 =A01.625579] r3 : 60000013 =A0r2 : 00000000 =A0r1 : 00000000 =A0=
r0 : 0000001e
> [ =A0 =A01.632385] Flags: nZcv =A0IRQs off =A0FIQs on =A0Mode IRQ_32 =
=A0ISA ARM
> Segment kernel
> [ =A0 =A01.640106] Control: 10c53c7d =A0Table: 8000404a =A0DAC: 00000=
017
> [ =A0 =A01.646118] Process swapper/0 (pid: 1, stack limit =3D 0xdf830=
2f8)
> [ =A0 =A01.652374] Stack: (0xdf831e68 to 0xdf832000)
> [ =A0 =A01.656921] 1e60: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000001e=
 00000000 00000000
> 60000013 c2422bc0 df965480
> [ =A0 =A01.665466] 1e80: df966008 de36e880 00000003 00000080 c2460000
> 00000040 fc31c000 df831e68
> [ =A0 =A01.674011] 1ea0: c0466ffc ffff0018 40000092 ffffffff 00000000
> c008b744 df967590 00000098
> [ =A0 =A01.682556] 1ec0: df96603c df966008 c0c49dd8 df96603c c06f2a00
> 0000008e c06687f0 c0643fcc
> [ =A0 =A01.691070] 1ee0: 00000000 c02b8748 c02b8730 c02b72c4 df966008
> c06f2a00 df96603c 00000000
> [ =A0 =A01.699615] 1f00: 0000008e c02b74d8 c06f2a00 df831f18 c02b7444
> c02b5b2c df8402a8 df968e90
> [ =A0 =A01.708160] 1f20: 00000000 c06f2a00 c06e5e28 de395bc0 00000000
> c02b625c c0575768 c024d028
> [ =A0 =A01.716705] 1f40: df830000 c06f2a00 00000000 00000000 0000008e
> c06687f0 c0643fcc c02b7ac4
> [ =A0 =A01.725219] 1f60: df830000 00000007 c06fdc00 00000000 0000008e
> c0008630 00000001 c1058170
> [ =A0 =A01.733764] 1f80: c05f8500 c0643fcc 00000001 60000013 00000001
> c05716e0 00000006 00000006
> [ =A0 =A01.742309] 1fa0: 60000013 c064dbb0 00000007 c06fdc00 c061e20c
> 0000008e c06687f0 c064dbb8
> [ =A0 =A01.750854] 1fc0: 00000000 c061e374 00000006 00000006 c061e20c
> 00000000 00000000 c061e28c
> [ =A0 =A01.759399] 1fe0: c00152b8 00000013 00000000 00000000 00000000
> c00152b8 ffffffff 00000000
> [ =A0 =A01.767944] [<c0466ffc>] (omap4_keypad_probe+0x1cc/0x3dc) from
> [<df831e68>] (0xdf831e68)
> [ =A0 =A01.776397] Code: e59ff410 ea0000bb ea00009a ea0000fa (ea00007=
8)
> [ =A0 =A01.782775] ------------[ cut here ]------------
> [ =A0 =A01.787628] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113
> l3_interrupt_handler+0x17c/0x1b4()
> [ =A0 =A01.796783] L3 custom error: MASTER:MPU TARGET:L4CFG
> [ =A0 =A01.801971] Modules linked in:
> [ =A0 =A01.805175] [<c001bba4>] (unwind_backtrace+0x0/0xf4) from
> [<c003f9f0>] (warn_slowpath_common+0x4c/0x64)
> [ =A0 =A01.815002] [<c003f9f0>] (warn_slowpath_common+0x4c/0x64) from
> [<c003fa9c>] (warn_slowpath_fmt+0x30/0x40)
> [ =A0 =A01.825012] [<c003fa9c>] (warn_slowpath_fmt+0x30/0x40) from
> [<c00341ac>] (l3_interrupt_handler+0x17c/0x1b4)
> [ =A0 =A01.835205] [<c00341ac>] (l3_interrupt_handler+0x17c/0x1b4) fr=
om
> [<c009d88c>] (handle_irq_event_percpu+0x64/0x24c)
> [ =A0 =A01.846008] [<c009d88c>] (handle_irq_event_percpu+0x64/0x24c) =
from
> [<c009dab0>] (handle_irq_event+0x3c/0x5c)
> [ =A0 =A01.856292] [<c009dab0>] (handle_irq_event+0x3c/0x5c) from
> [<c00a05f4>] (handle_fasteoi_irq+0x98/0x13c)
> [ =A0 =A01.866088] [<c00a05f4>] (handle_fasteoi_irq+0x98/0x13c) from
> [<c009d330>] (generic_handle_irq+0x34/0x44)
> [ =A0 =A01.876098] [<c009d330>] (generic_handle_irq+0x34/0x44) from
> [<c00151cc>] (handle_IRQ+0x4c/0xac)
> [ =A0 =A01.885284] [<c00151cc>] (handle_IRQ+0x4c/0xac) from [<c000848=
0>]
> (gic_handle_irq+0x2c/0x60)
> [ =A0 =A01.894073] [<c0008480>] (gic_handle_irq+0x2c/0x60) from
> [<c04713a4>] (__irq_svc+0x44/0x60)
> [ =A0 =A01.902801] Exception stack(0xdf831ce8 to 0xdf831d30)
> [ =A0 =A01.908081] 1ce0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c06df3c8=
 0000000a 00000001
> 00000000 00000282 00000000
> [ =A0 =A01.916625] 1d00: df830000 c066e080 00000000 c070ffc0 ffff001a
> ffff001c df831d10 df831d30
> [ =A0 =A01.925170] 1d20: c0047390 c0047394 60000013 ffffffff
> [ =A0 =A01.930450] [<c04713a4>] (__irq_svc+0x44/0x60) from [<c0047394=
>]
> (__do_softirq+0x64/0x214)
> [ =A0 =A01.939086] [<c0047394>] (__do_softirq+0x64/0x214) from
> [<c0047720>] (irq_exit+0x90/0x98)
> [ =A0 =A01.947631] [<c0047720>] (irq_exit+0x90/0x98) from [<c00151d0>=
]
> (handle_IRQ+0x50/0xac)
> [ =A0 =A01.955902] [<c00151d0>] (handle_IRQ+0x50/0xac) from [<c000848=
0>]
> (gic_handle_irq+0x2c/0x60)
> [ =A0 =A01.964691] [<c0008480>] (gic_handle_irq+0x2c/0x60) from
> [<c04713a4>] (__irq_svc+0x44/0x60)
> [ =A0 =A01.973419] Exception stack(0xdf831da0 to 0xdf831de8)
> [ =A0 =A01.978668] 1da0: c06df3c8 00000000 df831dd8 00000000 c068ffa0
> df831e68 00000001 00000001
> [ =A0 =A01.987213] 1dc0: df831e2f 00000000 ffff001a ffff001c ffffffff
> df831de8 c0471138 c047113c
> [ =A0 =A01.995758] 1de0: 60000013 ffffffff
> [ =A0 =A01.999420] [<c04713a4>] (__irq_svc+0x44/0x60) from [<c047113c=
>]
> (_raw_spin_unlock_irq+0x28/0x2c)
> [ =A0 =A02.008697] [<c047113c>] (_raw_spin_unlock_irq+0x28/0x2c) from
> [<c001857c>] (die+0xe0/0x324)
> [ =A0 =A02.017486] [<c001857c>] (die+0xe0/0x324) from [<c00187fc>]
> (bad_mode+0x3c/0x60)
> [ =A0 =A02.025207] [<c00187fc>] (bad_mode+0x3c/0x60) from [<c0466ffc>=
]
> (omap4_keypad_probe+0x1cc/0x3dc)
> [ =A0 =A02.034393] [<c0466ffc>] (omap4_keypad_probe+0x1cc/0x3dc) from
> [<df831e68>] (0xdf831e68)
> [ =A0 =A02.042877] ---[ end trace 2dead3f602d0a977 ]---
> [ =A0 =A02.047760] ---[ end trace 2dead3f602d0a978 ]---
> [ =A0 =A02.052642] Kernel panic - not syncing: Attempted to kill init=
!
> exitcode=3D0x0000000b
>
> Looking more into this.
>
>
> ~Sourav
>
>
>
>> Thanks.
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
>> =A0drivers/input/keyboard/omap4-keypad.c | =A0102 ++++++++++++++++++=
+++++++--------
>> =A02 files changed, 80 insertions(+), 26 deletions(-)
>>
>>
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard=
/Kconfig
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
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the
>> =A0 =A0 =A0 =A0 =A0module will be called omap4-keypad.
>> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/k=
eyboard/omap4-keypad.c
>> index e809ac0..ddd5c9e 100644
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
>> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int i=
rq, void *dev_id)
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
>> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int =
irq, void *dev_id)
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
>> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct p=
latform_device *pdev)
>> =A0 =A0 =A0 =A0struct resource *res;
>> =A0 =A0 =A0 =A0resource_size_t size;
>> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
>> + =A0 =A0 =A0 int rev;
>> =A0 =A0 =A0 =A0int irq;
>> =A0 =A0 =A0 =A0int error;
>>
>> @@ -241,6 +276,25 @@ static int __devinit omap4_keypad_probe(struct =
platform_device *pdev)
>> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
>> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>>
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0/* input device allocation */
>> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_d=
evice();
>> =A0 =A0 =A0 =A0if (!input_dev) {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
