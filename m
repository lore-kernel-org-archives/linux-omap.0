From: "G Kondaiah, Manjunath" <xgkondai@ti.com>
Subject: RE: [PATCH] omap24xx IrDA update
Date: Tue, 20 Dec 2005 10:51:36 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A503838845@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Komal,

The I/O expander on H4 uses I2C calls for changing the speed of the IrDA
transceiver. Speed change request some times occurs in interrupt
context,=20


+static irqreturn_t
+omap_irda_irq(int irq, void *dev_id, struct pt_regs *hw_regs)
+{
+	struct net_device *dev =3D dev_id;
+	struct omap_irda *si =3D dev->priv;
+	struct sk_buff *skb;
+
+	u8 status;
+	int w =3D 0;
+
+	__ECHO_IN;
+
+	/* Clear EOF interrupt */
+	status =3D uart_reg_in(UART3_IIR);
+
+	if (status & UART3_IIR_TX_STATUS) {
+		u8 mdr2 =3D uart_reg_in(UART3_MDR2);
+		HDBG1(2);
+		if (mdr2 & UART3_MDR2_IRTX_UNDERRUN)
+			printk(KERN_ERR "IrDA Buffer underrun error");
+
+		si->stats.tx_packets++;
+
+		if (si->newspeed) {
+			omap_irda_set_speed(dev, si->newspeed);
+			si->newspeed =3D 0;
+		}
+
+		netif_wake_queue(dev);
+		if (!(status & UART3_IIR_EOF))
+			return IRQ_HANDLED;
+	}

The problem can be solved if we use work queues for changing the IrDA
transceiver mode. Please refer deleted code in the patch.

Regards,
Manjunath

-----Original Message-----
From: Komal Shah [mailto:komal_shah802003@yahoo.com]=20
Sent: Tuesday, December 20, 2005 6:21 AM
To: linux-omap-open-source@linux.omap.com
Cc: G Kondaiah, Manjunath
Subject: [PATCH] omap24xx IrDA update

Tony/Manjunath,

I have attached the updated IrDA patch with 24xx support. This time I
have tested discovery with 2 Nokia mobiles (6230 and 6600).

Test Procedure:
On H4 Menelaus board, put
S1-7 OFF
S1-8 OFF
S1-4/5 ON ON positions.

#ifconfig irda0 up
#echo "1" > /proc/sys/net/irda/discovery
#cat /proc/net/irda/discovery
IrLMP Log:
nickname: Nokia 6230i, hint: 0xb125, saddr: 0x023f25ac, daddr:
0x0000f5bf

I wasn't able to cross-compile irdadump successfully, if somone gives
me the binary then it will be useful for further testing.

While testing discovery procedure continously, it suddenly gave me
following crash. I feel that it is because I have removed workqueue
stuff, and used local_irq_save/restore...any suggestions?

------
<3>scheduling while atomic: swapper/0x00010000/0
scheduling while atomic: swapper/0x00010000/0
<3>bad: scheduling from the idle thread!
bad: scheduling from the idle thread!
<1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
Unable to handle kernel NULL pointer dereference at virtual address
00000000
<1>pgd =3D c0004000
pgd =3D c0004000
<1>[00000000] *pgd=3D00000000[00000000] *pgd=3D00000000

Internal error: Oops: 17 [#1]
Internal error: Oops: 17 [#1]
Modules linked in:Modules linked in:

CPU: 0
CPU: 0
PC is at dequeue_task+0xc/0x78
PC is at dequeue_task+0xc/0x78
LR is at deactivate_task+0x24/0x30
LR is at deactivate_task+0x24/0x30
pc : [<c0039430>]    lr : [<c0039738>]    Not tainted
sp : c026dd24  ip : c026dd34  fp : c026dd30
pc : [<c0039430>]    lr : [<c0039738>]    Not tainted
sp : c026dd24  ip : c026dd34  fp : c026dd30
r10: c02cde48  r9 : 0000001f  r8 : 90017200
r10: c02cde48  r9 : 0000001f  r8 : 90017200
r7 : c026edf8  r6 : 00000064  r5 : c026c000  r4 : c026edf8
r7 : c026edf8  r6 : 00000064  r5 : c026c000  r4 : c026edf8
r3 : ffffffff  r2 : 00000000  r1 : 00000000  r0 : c026edf8
r3 : ffffffff  r2 : 00000000  r1 : 00000000  r0 : c026edf8
Flags: NzcvFlags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 80760000  DAC: 00000017
Control: C5387F  Table: 80760000  DAC: 00000017
Process swapper (pid: 0, stack limit =3D 0xc026c194)
Process swapper (pid: 0, stack limit =3D 0xc026c194)
Stack: (0xc026dd24 to 0xc026e000)
Stack: (0xc026dd24 to 0xc026e000)
dd20: dd20:                   c026dd44 c026dd44 c026dd34 c026dd34
c0039738 c0039
738 c0039430 c0039430 0000001f 0000001f c026dd84 c026dd84 c026dd48
c026dd48

dd40: dd40: c0224a40 c0224a40 c0039720 c0039720 c026ee2c c026ee2c
07270e00 07270
e00 c026ef20 c026ef20 00000000 00000000 c026dd84 c026dd84 00003558
00003558

dd60: dd60: c026c000 c026c000 00000064 00000064 c026dd88 c026dd88
c0274a8c c0274
a8c 00000001 00000001 00000064 00000064 c026ddc0 c026ddc0 c026dd88
c026dd88

dd80: dd80: c0225798 c0225798 c02248ac c02248ac c02d361c c02d361c
c02d361c c02d3
61c 00003558 00003558 c0046410 c0046410 c026edf8 c026edf8 c02d3354
c02d3354

dda0: dda0: c047b01c c047b01c c047b000 c047b000 c026dde8 c026dde8
c026de4c c026d
e4c c026c000 c026c000 c026de2c c026de2c c026ddc4 c026ddc4 c0175110
c0175110

ddc0: ddc0: c0225718 c0225718 00000001 00000001 00000000 00000000
00000000 00000
000 c047b070 c047b070 00000000 00000000 c026edf8 c026edf8 c0051480
c0051480

dde0: dde0: c026ddf4 c026ddf4 c026ddf4 c026ddf4 00000000 00000000
c026edf8 c026e
df8 c0051480 c0051480 c047b01c c047b01c c047b01c c047b01c 0003d950
0003d950

de00: de00: 00000000 00000000 c047b02c c047b02c c047b048 c047b048
c0603e60 c0603
e60 0001c200 0001c200 c0603c00 c0603c00 4107b362 4107b362 c02c8044
c02c8044

de20: de20: c026de44 c026de44 c026de30 c026de30 c017401c c017401c
c0174efc c0174
efc 00000020 00000020 c026de73 c026de73 c026de6c c026de6c c026de48
c026de48

de40: de40: c017598c c017598c c0173fd4 c0173fd4 c0603e60 c0603e60
00010020 00010
020 c0600002 c0600002 c026de4b c026de4b c063a9c0 c063a9c0 00000002
00000002

de60: de60: c026de88 c026de88 c026de70 c026de70 c002eba0 c002eba0
c0175944 c0175
944 c026de8c c026de8c c063a9c0 c063a9c0 60000113 60000113 c026dea8
c026dea8

de80: de80: c026de8c c026de8c c01722fc c01722fc c002eb8c c002eb8c
c063a9c0 c063a
9c0 00000000 00000000 c0603e60 c0603e60 00000020 00000020 c026dee0
c026dee0

dea0: dea0: c026deac c026deac c01724ec c01724ec c01722b8 c01722b8
c0045d0c c0045
d0c c02d3310 c02d3310 00000001 00000001 c063a9c0 c063a9c0 00000000
00000000

dec0: dec0: 00000000 00000000 0000004a 0000004a c026df54 c026df54
4107b362 4107b
362 c02c8044 c02c8044 c026df04 c026df04 c026dee4 c026dee4 c0024994
c0024994

dee0: dee0: c0172484 c0172484 c02c8f4c c02c8f4c 0000004a 0000004a
c026df54 c026d
f54 c02e9b58 c02e9b58 c026df54 c026df54 c026df20 c026df20 c026df08
c026df08

df00: df00: c0024bcc c0024bcc c002495c c002495c c026c000 c026c000
d80fe000 d80fe
000 c02d58e4 c02d58e4 c026df50 c026df50 c026df24 c026df24 c0024c74
c0024c74

df20: df20: c0024b70 c0024b70 c026df60 c026df60 c026df34 c026df34
ffffffff fffff
fff d80fe000 d80fe000 c02d58e4 c02d58e4 c02e9b58 c02e9b58 8001e340
8001e340

df40: df40: 8001e2d8 8001e2d8 c026dfa8 c026dfa8 c026df54 c026df54
c00239a4 c0023
9a4 c0024c2c c0024c2c c001cae0 c001cae0 00000002 00000002 00000000
00000000

df60: df60: 00000000 00000000 c0025498 c0025498 c026c000 c026c000
c02d58e4 c02d5
8e4 c02e9b58 c02e9b58 8001e340 8001e340 4107b362 4107b362 8001e2d8
8001e2d8

df80: df80: c026dfa8 c026dfa8 c026dfac c026dfac c026df9c c026df9c
c00254d0 c0025
4d0 c00254d4 c00254d4 60000013 60000013 ffffffff ffffffff c026dfc0
c026dfc0

dfa0: dfa0: c026dfac c026dfac c002551c c002551c c00254a4 c00254a4
00c5387d 00c53
87d c02c7bfc c02c7bfc c026dfd0 c026dfd0 c026dfc4 c026dfc4 c0023024
c0023024

dfc0: dfc0: c00254e8 c00254e8 c026dff4 c026dff4 c026dfd4 c026dfd4
c0008960 c0008
960 c002300c c002300c c0008464 c0008464 c02ccc08 c02ccc08 00c5387d
00c5387d

dfe0: dfe0: c02ccb84 c02ccb84 c026fcd0 c026fcd0 00000000 00000000
c026dff8 c026d
ff8 80008094 80008094 c0008804 c0008804 00000000 00000000 00000000
00000000

Backtrace: Backtrace:

[<c0039424>] [<c0039424>] (dequeue_task+0x0/0x78)
(dequeue_task+0x0/0x78) from [
<c0039738>] from [<c0039738>] (deactivate_task+0x24/0x30)
(deactivate_task+0x24/0x30)
[<c0039714>] [<c0039714>] (deactivate_task+0x0/0x30)
(deactivate_task+0x0/0x30)
from [<c0224a40>] from [<c0224a40>] (schedule+0x1a0/0x580)
(schedule+0x1a0/0x580)
 r4 =3D 0000001F  r4 =3D 0000001F

[<c02248a0>] [<c02248a0>] (schedule+0x0/0x580) (schedule+0x0/0x580)
from [<c0225
798>] from [<c0225798>] (schedule_timeout+0x8c/0xbc)
(schedule_timeout+0x8c/0xbc)
[<c022570c>] [<c022570c>] (schedule_timeout+0x0/0xbc)
(schedule_timeout+0x0/0xbc
) from [<c0175110>] from [<c0175110>] (omap_i2c_xfer+0x220/0x324)
(omap_i2c_xfer+0x220/0x324)
 r8 =3D C026C000  r8 =3D C026C000  r7 =3D C026DE4C  r7 =3D C026DE4C  r6 =
=3D
C026DDE8  r6 =3D
 C026DDE8  r5 =3D C047B000
 r5 =3D C047B000
 r4 =3D C047B01C  r4 =3D C047B01C

[<c0174ef0>] [<c0174ef0>] (omap_i2c_xfer+0x0/0x324)
(omap_i2c_xfer+0x0/0x324) fr
om [<c017401c>] from [<c017401c>] (i2c_transfer+0x54/0x78)
(i2c_transfer+0x54/0x78)
[<c0173fc8>] [<c0173fc8>] (i2c_transfer+0x0/0x78)
(i2c_transfer+0x0/0x78) from [
<c017598c>] from [<c017598c>] (read_gpio_expa+0x54/0x74)
(read_gpio_expa+0x54/0x74)
 r5 =3D C026DE73  r5 =3D C026DE73  r4 =3D 00000020  r4 =3D 00000020

[<c0175938>] [<c0175938>] (read_gpio_expa+0x0/0x74)
(read_gpio_expa+0x0/0x74) fr
om [<c002eba0>] from [<c002eba0>] (h4_transceiver_mode+0x20/0x78)
(h4_transceiver_mode+0x20/0x78)
 r5 =3D 00000002  r5 =3D 00000002  r4 =3D C063A9C0  r4 =3D C063A9C0

[<c002eb80>] [<c002eb80>] (h4_transceiver_mode+0x0/0x78)
(h4_transceiver_mode+0x
0/0x78) from [<c01722fc>] from [<c01722fc>]
(omap_irda_set_speed+0x50/0x1cc)
(omap_irda_set_speed+0x50/0x1cc)
 r5 =3D 60000113  r5 =3D 60000113  r4 =3D C063A9C0  r4 =3D C063A9C0

[<c01722ac>] [<c01722ac>] (omap_irda_set_speed+0x0/0x1cc)
(omap_irda_set_speed+0
x0/0x1cc) from [<c01724ec>] from [<c01724ec>]
(omap_irda_irq+0x74/0x2e4)
(omap_irda_irq+0x74/0x2e4)
 r7 =3D 00000020  r7 =3D 00000020  r6 =3D C0603E60  r6 =3D C0603E60  r5 =
=3D
00000000  r5 =3D
 00000000  r4 =3D C063A9C0
 r4 =3D C063A9C0
[<c0172478>] [<c0172478>] (omap_irda_irq+0x0/0x2e4)
(omap_irda_irq+0x0/0x2e4) fr
om [<c0024994>] from [<c0024994>] (__do_irq+0x44/0x78)
(__do_irq+0x44/0x78)
[<c0024950>] [<c0024950>] (__do_irq+0x0/0x78) (__do_irq+0x0/0x78) from
[<c0024bc
c>] from [<c0024bcc>] (do_level_IRQ+0x68/0xbc)
(do_level_IRQ+0x68/0xbc)
 r8 =3D C026DF54  r8 =3D C026DF54  r7 =3D C02E9B58  r7 =3D C02E9B58  r6 =
=3D
C026DF54  r6 =3D
 C026DF54  r5 =3D 0000004A
 r5 =3D 0000004A
 r4 =3D C02C8F4C  r4 =3D C02C8F4C

[<c0024b64>] [<c0024b64>] (do_level_IRQ+0x0/0xbc)
(do_level_IRQ+0x0/0xbc) from [
<c0024c74>] from [<c0024c74>] (asm_do_IRQ+0x54/0x130)
(asm_do_IRQ+0x54/0x130)
 r6 =3D C02D58E4  r6 =3D C02D58E4  r5 =3D D80FE000  r5 =3D D80FE000  r4 =
=3D
C026C000  r4 =3D
 C026C000

[<c0024c20>] [<c0024c20>] (asm_do_IRQ+0x0/0x130) (asm_do_IRQ+0x0/0x130)
from [<c
00239a4>] from [<c00239a4>] (__irq_svc+0x24/0x80)
(__irq_svc+0x24/0x80)
[<c0025498>] [<c0025498>] (default_idle+0x0/0x44)
(default_idle+0x0/0x44) from [
<c002551c>] from [<c002551c>] (cpu_idle+0x40/0x5c)
(cpu_idle+0x40/0x5c)
[<c00254dc>] [<c00254dc>] (cpu_idle+0x0/0x5c) (cpu_idle+0x0/0x5c) from
[<c002302
4>] from [<c0023024>] (__init_end+0x24/0x2c)
(__init_end+0x24/0x2c)
 r5 =3D C02C7BFC  r5 =3D C02C7BFC  r4 =3D 00C5387D  r4 =3D 00C5387D

[<c0023000>] [<c0023000>] (__init_end+0x0/0x2c) (__init_end+0x0/0x2c)
from [<c00
08960>] from [<c0008960>] (start_kernel+0x168/0x1b0)
(start_kernel+0x168/0x1b0)
[<c00087f8>] [<c00087f8>] (start_kernel+0x0/0x1b0)
(start_kernel+0x0/0x1b0) from
 [<80008094>] from [<80008094>] (0x80008094)
(0x80008094)
Code: Code: e89da800 e89da800 e1a0c00d e1a0c00d e92dd800 e92dd800
e24cb004 e24cb
004 (e5913000) (e5913000)

  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!
---------

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
