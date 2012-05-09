From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [RESEND/PATCHv2] Input: omap-keypad: dynamically handle register offsets
Date: Wed, 9 May 2012 12:24:00 +0530
Message-ID: <CAKdam56kv2qia-2DMeTRMYwWJbskOeiJkW46wJqfMU9-pVkXwQ@mail.gmail.com>
References: <1335419677-24934-1-git-send-email-sourav.poddar@ti.com>
	<20120509051809.GA10514@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:47881 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751800Ab2EIGyD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 02:54:03 -0400
Received: by vbbey12 with SMTP id ey12so74507vbb.28
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 23:54:00 -0700 (PDT)
In-Reply-To: <20120509051809.GA10514@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, akpm@linux-foundation.org

Hi Dmitry ,


On Wed, May 9, 2012 at 10:48 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Ho Sourav,
>
> On Thu, Apr 26, 2012 at 11:24:37AM +0530, Sourav Poddar wrote:
>>
>> -config KEYBOARD_OMAP4
>> - =A0 =A0 tristate "TI OMAP4 keypad support"
>> +config KEYBOARD_OMAP4+
>
> I think this works purely by accident - '+' sign getting dropped by
> parser...
>
>> @@ -139,16 +192,33 @@ static int omap4_keypad_open(struct input_dev =
*input)
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
>> - =A0 =A0 __raw_writel(OMAP4_DEF_IRQENABLE_EVENTEN | OMAP4_DEF_IRQEN=
ABLE_LONGKEY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_IRQENABLE);
>> - =A0 =A0 __raw_writel(OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_=
KEY_ENA,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->base + OMAP4_=
KBD_WAKEUPENABLE);
>> + =A0 =A0 keypad_data->revision =3D kbd_read_revision(keypad_data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_KBD_REVISION);
>> + =A0 =A0 switch (keypad_data->revision) {
>> + =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqstatus =3D OMAP4_KBD_IRQST=
ATUS + 0x0c;
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->irqenable =3D OMAP4_KBD_IRQEN=
ABLE + 0x0c;
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad_data->reg_offset =3D 0x10;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> This should be done in probe().
>
Dont we then require "pm_runtime_put_sync" in probe, since we are tryin=
g
to read the keypad revision register.?
> Could you please tell me if the version of the patch below works for
> you?
>

I just quickly tested this patch and saw the following kernel carsh.

[    1.571838] Bad mode in data abort handler detected
[    1.576934] Internal error: Oops - bad mode: 0 [#1] SMP ARM
[    1.582763] Modules linked in:
[    1.585937] CPU: 0    Not tainted  (3.4.0-rc5-dirty #11)
[    1.591522] PC is at __key.13633+0x3f39df40/0x8
[    1.596252] LR is at omap4_keypad_probe+0x1cc/0x3dc
[    1.601348] pc : [<ffff0018>]    lr : [<c0466ffc>]    psr: 40000092
[    1.601348] sp : df831e68  ip : fc31c000  fp : 00000040
[    1.613311] r10: c2460000  r9 : 00000080  r8 : 00000003
[    1.618774] r7 : de36e880  r6 : df966008  r5 : df965480  r4 : c2422b=
c0
[    1.625579] r3 : 60000013  r2 : 00000000  r1 : 00000000  r0 : 000000=
1e
[    1.632385] Flags: nZcv  IRQs off  FIQs on  Mode IRQ_32  ISA ARM
Segment kernel
[    1.640106] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    1.646118] Process swapper/0 (pid: 1, stack limit =3D 0xdf8302f8)
[    1.652374] Stack: (0xdf831e68 to 0xdf832000)
[    1.656921] 1e60:                   0000001e 00000000 00000000
60000013 c2422bc0 df965480
[    1.665466] 1e80: df966008 de36e880 00000003 00000080 c2460000
00000040 fc31c000 df831e68
[    1.674011] 1ea0: c0466ffc ffff0018 40000092 ffffffff 00000000
c008b744 df967590 00000098
[    1.682556] 1ec0: df96603c df966008 c0c49dd8 df96603c c06f2a00
0000008e c06687f0 c0643fcc
[    1.691070] 1ee0: 00000000 c02b8748 c02b8730 c02b72c4 df966008
c06f2a00 df96603c 00000000
[    1.699615] 1f00: 0000008e c02b74d8 c06f2a00 df831f18 c02b7444
c02b5b2c df8402a8 df968e90
[    1.708160] 1f20: 00000000 c06f2a00 c06e5e28 de395bc0 00000000
c02b625c c0575768 c024d028
[    1.716705] 1f40: df830000 c06f2a00 00000000 00000000 0000008e
c06687f0 c0643fcc c02b7ac4
[    1.725219] 1f60: df830000 00000007 c06fdc00 00000000 0000008e
c0008630 00000001 c1058170
[    1.733764] 1f80: c05f8500 c0643fcc 00000001 60000013 00000001
c05716e0 00000006 00000006
[    1.742309] 1fa0: 60000013 c064dbb0 00000007 c06fdc00 c061e20c
0000008e c06687f0 c064dbb8
[    1.750854] 1fc0: 00000000 c061e374 00000006 00000006 c061e20c
00000000 00000000 c061e28c
[    1.759399] 1fe0: c00152b8 00000013 00000000 00000000 00000000
c00152b8 ffffffff 00000000
[    1.767944] [<c0466ffc>] (omap4_keypad_probe+0x1cc/0x3dc) from
[<df831e68>] (0xdf831e68)
[    1.776397] Code: e59ff410 ea0000bb ea00009a ea0000fa (ea000078)
[    1.782775] ------------[ cut here ]------------
[    1.787628] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113
l3_interrupt_handler+0x17c/0x1b4()
[    1.796783] L3 custom error: MASTER:MPU TARGET:L4CFG
[    1.801971] Modules linked in:
[    1.805175] [<c001bba4>] (unwind_backtrace+0x0/0xf4) from
[<c003f9f0>] (warn_slowpath_common+0x4c/0x64)
[    1.815002] [<c003f9f0>] (warn_slowpath_common+0x4c/0x64) from
[<c003fa9c>] (warn_slowpath_fmt+0x30/0x40)
[    1.825012] [<c003fa9c>] (warn_slowpath_fmt+0x30/0x40) from
[<c00341ac>] (l3_interrupt_handler+0x17c/0x1b4)
[    1.835205] [<c00341ac>] (l3_interrupt_handler+0x17c/0x1b4) from
[<c009d88c>] (handle_irq_event_percpu+0x64/0x24c)
[    1.846008] [<c009d88c>] (handle_irq_event_percpu+0x64/0x24c) from
[<c009dab0>] (handle_irq_event+0x3c/0x5c)
[    1.856292] [<c009dab0>] (handle_irq_event+0x3c/0x5c) from
[<c00a05f4>] (handle_fasteoi_irq+0x98/0x13c)
[    1.866088] [<c00a05f4>] (handle_fasteoi_irq+0x98/0x13c) from
[<c009d330>] (generic_handle_irq+0x34/0x44)
[    1.876098] [<c009d330>] (generic_handle_irq+0x34/0x44) from
[<c00151cc>] (handle_IRQ+0x4c/0xac)
[    1.885284] [<c00151cc>] (handle_IRQ+0x4c/0xac) from [<c0008480>]
(gic_handle_irq+0x2c/0x60)
[    1.894073] [<c0008480>] (gic_handle_irq+0x2c/0x60) from
[<c04713a4>] (__irq_svc+0x44/0x60)
[    1.902801] Exception stack(0xdf831ce8 to 0xdf831d30)
[    1.908081] 1ce0:                   c06df3c8 0000000a 00000001
00000000 00000282 00000000
[    1.916625] 1d00: df830000 c066e080 00000000 c070ffc0 ffff001a
ffff001c df831d10 df831d30
[    1.925170] 1d20: c0047390 c0047394 60000013 ffffffff
[    1.930450] [<c04713a4>] (__irq_svc+0x44/0x60) from [<c0047394>]
(__do_softirq+0x64/0x214)
[    1.939086] [<c0047394>] (__do_softirq+0x64/0x214) from
[<c0047720>] (irq_exit+0x90/0x98)
[    1.947631] [<c0047720>] (irq_exit+0x90/0x98) from [<c00151d0>]
(handle_IRQ+0x50/0xac)
[    1.955902] [<c00151d0>] (handle_IRQ+0x50/0xac) from [<c0008480>]
(gic_handle_irq+0x2c/0x60)
[    1.964691] [<c0008480>] (gic_handle_irq+0x2c/0x60) from
[<c04713a4>] (__irq_svc+0x44/0x60)
[    1.973419] Exception stack(0xdf831da0 to 0xdf831de8)
[    1.978668] 1da0: c06df3c8 00000000 df831dd8 00000000 c068ffa0
df831e68 00000001 00000001
[    1.987213] 1dc0: df831e2f 00000000 ffff001a ffff001c ffffffff
df831de8 c0471138 c047113c
[    1.995758] 1de0: 60000013 ffffffff
[    1.999420] [<c04713a4>] (__irq_svc+0x44/0x60) from [<c047113c>]
(_raw_spin_unlock_irq+0x28/0x2c)
[    2.008697] [<c047113c>] (_raw_spin_unlock_irq+0x28/0x2c) from
[<c001857c>] (die+0xe0/0x324)
[    2.017486] [<c001857c>] (die+0xe0/0x324) from [<c00187fc>]
(bad_mode+0x3c/0x60)
[    2.025207] [<c00187fc>] (bad_mode+0x3c/0x60) from [<c0466ffc>]
(omap4_keypad_probe+0x1cc/0x3dc)
[    2.034393] [<c0466ffc>] (omap4_keypad_probe+0x1cc/0x3dc) from
[<df831e68>] (0xdf831e68)
[    2.042877] ---[ end trace 2dead3f602d0a977 ]---
[    2.047760] ---[ end trace 2dead3f602d0a978 ]---
[    2.052642] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b

Looking more into this.


~Sourav



> Thanks.
>
> --
> Dmitry
>
>
> Input: omap-keypad - dynamically handle register offsets
>
> From: G, Manjunath Kondaiah <manjugk@ti.com>
>
> Keypad controller register offsets are different for omap4
> and omap5. Handle these offsets through static mapping and
> assign these mappings during run time.
>
> Tested on omap4430 sdp with 3.4-rc3.
> Tested on omap5430evm with 3.1-custom kernel.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/input/keyboard/omap4-keypad.c | =A0102 +++++++++++++++++++=
++++++--------
> =A02 files changed, 80 insertions(+), 26 deletions(-)
>
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 20a3753..84ee155 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -531,9 +531,9 @@ config KEYBOARD_OMAP
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
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/ke=
yboard/omap4-keypad.c
> index e809ac0..ddd5c9e 100644
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
> @@ -91,12 +124,11 @@ static irqreturn_t omap4_keypad_interrupt(int ir=
q, void *dev_id)
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
> @@ -121,12 +153,13 @@ static irqreturn_t omap4_keypad_interrupt(int i=
rq, void *dev_id)
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
> @@ -182,6 +216,7 @@ static int __devinit omap4_keypad_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0resource_size_t size;
> =A0 =A0 =A0 =A0unsigned int row_shift, max_keys;
> + =A0 =A0 =A0 int rev;
> =A0 =A0 =A0 =A0int irq;
> =A0 =A0 =A0 =A0int error;
>
> @@ -241,6 +276,25 @@ static int __devinit omap4_keypad_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0keypad_data->rows =3D pdata->rows;
> =A0 =A0 =A0 =A0keypad_data->cols =3D pdata->cols;
>
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unmap;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* input device allocation */
> =A0 =A0 =A0 =A0keypad_data->input =3D input_dev =3D input_allocate_de=
vice();
> =A0 =A0 =A0 =A0if (!input_dev) {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
