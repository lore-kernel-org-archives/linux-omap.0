From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] omap24xx IrDA update
Date: Tue, 20 Dec 2005 04:21:11 -0800 (PST)
Message-ID: <20051220122111.45028.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1824423800-1135081271=:44766"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-1824423800-1135081271=:44766
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

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
<1>pgd = c0004000
pgd = c0004000
<1>[00000000] *pgd=00000000[00000000] *pgd=00000000

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
Process swapper (pid: 0, stack limit = 0xc026c194)
Process swapper (pid: 0, stack limit = 0xc026c194)
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
 r4 = 0000001F  r4 = 0000001F

[<c02248a0>] [<c02248a0>] (schedule+0x0/0x580) (schedule+0x0/0x580)
from [<c0225
798>] from [<c0225798>] (schedule_timeout+0x8c/0xbc)
(schedule_timeout+0x8c/0xbc)
[<c022570c>] [<c022570c>] (schedule_timeout+0x0/0xbc)
(schedule_timeout+0x0/0xbc
) from [<c0175110>] from [<c0175110>] (omap_i2c_xfer+0x220/0x324)
(omap_i2c_xfer+0x220/0x324)
 r8 = C026C000  r8 = C026C000  r7 = C026DE4C  r7 = C026DE4C  r6 =
C026DDE8  r6 =
 C026DDE8  r5 = C047B000
 r5 = C047B000
 r4 = C047B01C  r4 = C047B01C

[<c0174ef0>] [<c0174ef0>] (omap_i2c_xfer+0x0/0x324)
(omap_i2c_xfer+0x0/0x324) fr
om [<c017401c>] from [<c017401c>] (i2c_transfer+0x54/0x78)
(i2c_transfer+0x54/0x78)
[<c0173fc8>] [<c0173fc8>] (i2c_transfer+0x0/0x78)
(i2c_transfer+0x0/0x78) from [
<c017598c>] from [<c017598c>] (read_gpio_expa+0x54/0x74)
(read_gpio_expa+0x54/0x74)
 r5 = C026DE73  r5 = C026DE73  r4 = 00000020  r4 = 00000020

[<c0175938>] [<c0175938>] (read_gpio_expa+0x0/0x74)
(read_gpio_expa+0x0/0x74) fr
om [<c002eba0>] from [<c002eba0>] (h4_transceiver_mode+0x20/0x78)
(h4_transceiver_mode+0x20/0x78)
 r5 = 00000002  r5 = 00000002  r4 = C063A9C0  r4 = C063A9C0

[<c002eb80>] [<c002eb80>] (h4_transceiver_mode+0x0/0x78)
(h4_transceiver_mode+0x
0/0x78) from [<c01722fc>] from [<c01722fc>]
(omap_irda_set_speed+0x50/0x1cc)
(omap_irda_set_speed+0x50/0x1cc)
 r5 = 60000113  r5 = 60000113  r4 = C063A9C0  r4 = C063A9C0

[<c01722ac>] [<c01722ac>] (omap_irda_set_speed+0x0/0x1cc)
(omap_irda_set_speed+0
x0/0x1cc) from [<c01724ec>] from [<c01724ec>]
(omap_irda_irq+0x74/0x2e4)
(omap_irda_irq+0x74/0x2e4)
 r7 = 00000020  r7 = 00000020  r6 = C0603E60  r6 = C0603E60  r5 =
00000000  r5 =
 00000000  r4 = C063A9C0
 r4 = C063A9C0
[<c0172478>] [<c0172478>] (omap_irda_irq+0x0/0x2e4)
(omap_irda_irq+0x0/0x2e4) fr
om [<c0024994>] from [<c0024994>] (__do_irq+0x44/0x78)
(__do_irq+0x44/0x78)
[<c0024950>] [<c0024950>] (__do_irq+0x0/0x78) (__do_irq+0x0/0x78) from
[<c0024bc
c>] from [<c0024bcc>] (do_level_IRQ+0x68/0xbc)
(do_level_IRQ+0x68/0xbc)
 r8 = C026DF54  r8 = C026DF54  r7 = C02E9B58  r7 = C02E9B58  r6 =
C026DF54  r6 =
 C026DF54  r5 = 0000004A
 r5 = 0000004A
 r4 = C02C8F4C  r4 = C02C8F4C

[<c0024b64>] [<c0024b64>] (do_level_IRQ+0x0/0xbc)
(do_level_IRQ+0x0/0xbc) from [
<c0024c74>] from [<c0024c74>] (asm_do_IRQ+0x54/0x130)
(asm_do_IRQ+0x54/0x130)
 r6 = C02D58E4  r6 = C02D58E4  r5 = D80FE000  r5 = D80FE000  r4 =
C026C000  r4 =
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
 r5 = C02C7BFC  r5 = C02C7BFC  r4 = 00C5387D  r4 = 00C5387D

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
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1824423800-1135081271=:44766
Content-Type: text/plain; name="omap-irda-02.patch"
Content-Description: 1279975987-omap-irda-02.patch
Content-Disposition: inline; filename="omap-irda-02.patch"

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 0fc2e0f..6da84a6 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -36,6 +36,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
+#include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/common.h>
 
@@ -171,10 +172,44 @@ static struct platform_device h2_smc91x_
 	.resource	= h2_smc91x_resources,
 };
 
+#define H2_IRDA_FIRSEL_GPIO_PIN	17
+
+static int h2_transceiver_mode(struct device *dev, int state)
+{
+	if (state & IR_SIRMODE)
+		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+	else    /* MIR/FIR */
+		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 1);
+		
+	return 0;
+}
+
+static struct omap_irda_config h2_irda_data = {
+	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+};
+
+static struct resource h2_irda_resources[] = {
+	[0] = {
+		.start	= INT_UART3,
+		.end	= INT_UART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+static struct platform_device h2_irda_device = {
+	.name		= "omapirda",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &h2_irda_data,
+	},
+	.num_resources	= ARRAY_SIZE(h2_irda_resources),
+	.resource	= h2_irda_resources,
+};
+
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
+	&h2_irda_device,
 };
 
 static void __init h2_init_smc91x(void)
@@ -266,6 +301,15 @@ static void __init h2_init(void)
 	// omap_cfg_reg(U19_ARMIO1);		/* CD */
 	omap_cfg_reg(BALLOUT_V8_ARMIO3);	/* WP */
 
+	/* Irda */
+#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
+	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
+	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
+		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+		h2_irda_data.transceiver_mode = h2_transceiver_mode;
+	}
+#endif
+
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
 	omap_board_config = h2_config;
 	omap_board_config_size = ARRAY_SIZE(h2_config);
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 2953d38..6360a65 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -34,9 +34,11 @@
 #include <asm/mach/map.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpioexpander.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
+#include <asm/arch/irda.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/common.h>
 
@@ -193,11 +195,87 @@ static struct platform_device intlat_dev
 	.resource       = intlat_resources,
 };
 
+/* Select between the IrDA and aGPS module
+ */
+static int h3_select_irda(struct device *dev, int state)
+{
+	unsigned char expa;
+	int err = 0;
+
+	if ((err = read_gpio_expa(&expa, 0x26))) {
+		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
+		return err;
+	}
+
+	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
+	if (state & IR_SEL) { /* IrDA */
+		if ((err = write_gpio_expa(expa | 0x40, 0x26))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	} else {
+		if ((err = write_gpio_expa(expa & ~0x40, 0x26))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	}
+	return err;
+}
+
+static int h3_transceiver_mode(struct device *dev, int state)
+{
+	unsigned char expa;
+	int err = 0;
+	
+	if ((err = read_gpio_expa(&expa, 0x27)) != 0) {
+		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
+		return err;
+	}
+
+	expa &= ~0x03;
+
+	if (state & IR_SIRMODE) {
+		expa |= 0x01;
+	} else { /* MIR/FIR */
+		expa |= 0x03;
+	}
+
+	if ((err = write_gpio_expa(expa, 0x27)) != 0) {
+		printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+		return err;
+	}
+	return err;
+}
+
+static struct omap_irda_config h3_irda_data = {
+	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.transceiver_mode	= h3_transceiver_mode,
+	.select_irda	 	= h3_select_irda,
+};
+
+static struct resource h3_irda_resources[] = {
+	[0] = {
+		.start	= INT_UART3,
+		.end	= INT_UART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+static struct platform_device h3_irda_device = {
+	.name		= "omapirda",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &h3_irda_data,
+	},
+	.num_resources	= ARRAY_SIZE(h3_irda_resources),
+	.resource	= h3_irda_resources,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
         &smc91x_device,
 	&intlat_device,
+	&h3_irda_device,
 };
 
 static struct omap_usb_config h3_usb_config __initdata = {
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 6a5e88d..2a40892 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -25,8 +25,10 @@
 #include <asm/mach/flash.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/gpioexpander.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/irda.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include "prcm-regs.h"
@@ -108,9 +110,84 @@ static struct platform_device h4_smc91x_
 	.resource	= h4_smc91x_resources,
 };
 
+/* Select between the IrDA and aGPS module
+ */
+static int h4_select_irda(struct device *dev, int state)
+{
+	unsigned char expa;
+	int err = 0;
+
+	if ((err = read_gpio_expa(&expa, 0x21))) {
+		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
+		return err;
+	}
+
+	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
+	if (state & IR_SEL) {	/* IrDa */
+		if ((err = write_gpio_expa(expa | 0x01, 0x21))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	} else {		
+		if ((err = write_gpio_expa(expa & ~0x01, 0x21))) {
+			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
+			return err;
+		}
+	}
+	return err;
+}
+
+static int h4_transceiver_mode(struct device *dev, int state)
+{
+	unsigned char expa;
+	int err = 0;
+	
+	if ((err = read_gpio_expa(&expa, 0x20)) != 0) {
+		printk(KERN_ERR "Error reading from I/O EXPANDER\n");
+		return err;
+	}
+
+	expa &= ~0x01;
+
+	if (!(state & IR_SIRMODE)) { /* MIR/FIR */
+		expa |= 0x01;
+	}
+
+	if ((err = write_gpio_expa(expa, 0x20)) != 0) {
+		printk(KERN_ERR "Error writing to I/O EXPANDER\n");
+		return err;
+	}
+	return err;
+}
+
+static struct omap_irda_config h4_irda_data = {
+	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
+	.transceiver_mode	= h4_transceiver_mode,
+	.select_irda	 	= h4_select_irda,
+};
+
+static struct resource h4_irda_resources[] = {
+	[0] = {
+		.start	= INT_24XX_UART3_IRQ,
+		.end	= INT_24XX_UART3_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device h4_irda_device = {
+	.name		= "omapirda",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &h4_irda_data,
+	},
+	.num_resources	= 1,
+	.resource	= h4_irda_resources,
+};
+
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_smc91x_device,
 	&h4_flash_device,
+	&h4_irda_device,
 };
 
 static inline void __init h4_init_smc91x(void)
@@ -173,6 +250,10 @@ static void __init omap_h4_init(void)
 	 * You have to mux them off in device drivers later on
 	 * if not needed.
 	 */
+#if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
+	omap_cfg_reg(K15_24XX_UART3_TX);
+	omap_cfg_reg(K14_24XX_UART3_RX);
+#endif
 	platform_add_devices(h4_devices, ARRAY_SIZE(h4_devices));
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ea46548..9e6b79f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -54,6 +54,10 @@ MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
 
+/* UART3  */
+MUX_CFG_24XX("K15_24XX_UART3_TX",	0x118,	0,	0,	0,	1)
+MUX_CFG_24XX("K14_24XX_UART3_RX",	0x119,	0,	0,	0,	1)
+
 };
 
 int __init omap2_mux_init(void)
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index b200c50..b4562c2 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -341,12 +341,12 @@ config TOSHIBA_FIR
 	  To compile it as a module, choose M here: the module will be called
 	  donauboe.
 
-config OMAP1610_IR
-        tristate "OMAP1610 IrDA(SIR/MIR/FIR)"
-	depends on IRDA && ARCH_OMAP
-	select GPIOEXPANDER_OMAP if MACH_OMAP_H3
+config OMAP_IR
+        tristate "OMAP IrDA(SIR/MIR/FIR)"
+	depends on IRDA && (ARCH_OMAP1 || ARCH_OMAP2)
+	select GPIOEXPANDER_OMAP if (MACH_OMAP_H3 || MACH_OMAP_H4)
         help
-          Say Y here if you want to build support for the Omap1610 IR.
+          Say Y here if you want to build support for the OMAP IR.
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
diff --git a/drivers/net/irda/Makefile b/drivers/net/irda/Makefile
index 7db79a2..494b0f8 100644
--- a/drivers/net/irda/Makefile
+++ b/drivers/net/irda/Makefile
@@ -43,7 +43,7 @@ obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_b
 obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120-sir.o
 obj-$(CONFIG_ACT200L_DONGLE)	+= act200l-sir.o
 obj-$(CONFIG_MA600_DONGLE)	+= ma600-sir.o
-obj-$(CONFIG_OMAP1610_IR)       += omap1610-ir.o
+obj-$(CONFIG_OMAP_IR)		+= omap-ir.o
 
 
 # The SIR helper module
diff --git a/drivers/net/irda/omap-ir.c b/drivers/net/irda/omap-ir.c
new file mode 100644
index 0000000..17b6184
--- /dev/null
+++ b/drivers/net/irda/omap-ir.c
@@ -0,0 +1,1009 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *
+ *	Infra-red driver for the OMAP1610-H2 and OMAP1710-H3 Platforms
+ *          (SIR/MIR/FIR modes)
+ *          (based on omap-sir.c)
+ *
+ * Copyright 2003 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *	   source@mvista.com
+ * 
+ * Copyright 2004 Texas Instruments.
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ Modifications:
+ Feb 2004, Texas Instruments
+ - Ported to 2.6 kernel (Feb 2004).
+ *
+ Apr 2004, Texas Instruments
+ - Added support for H3 (Apr 2004). 
+ Nov 2004, Texas Instruments
+ - Added support for Power Management.
+ 
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/slab.h>
+#include <linux/rtnetlink.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irmod.h>
+#include <net/irda/wrapper.h>
+#include <net/irda/irda_device.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/serial.h>
+#include <asm/mach-types.h>
+#include <asm/dma.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/irda.h>
+
+#define UART3_EFR_EN			(1 << 4)
+#define UART3_MCR_EN_TCR_TLR 		(1 << 6)
+
+#define UART3_LCR_WL_8			(3 << 0)
+#define UART3_LCR_SP2			(1 << 2)
+#define UART3_LCR_DIVEN			(1 << 7)
+
+#define UART3_FCR_FIFO_EN		(1 << 0)
+#define UART3_FCR_FIFO_RX		(1 << 1)
+#define UART3_FCR_FIFO_TX		(1 << 2)
+#define UART3_FCR_FIFO_DMA1		(1 << 3)
+#define UART3_FCR_FIFO_TX_TRIG16	(1 << 4)
+#define UART3_FCR_FIFO_RX_TRIG16	(1 << 6)
+#define UART3_FCR_CONFIG	UART3_FCR_FIFO_EN | UART3_FCR_FIFO_RX |	\
+				UART3_FCR_FIFO_TX | UART3_FCR_FIFO_DMA1 | \
+				UART3_FCR_FIFO_TX_TRIG16 | \
+				UART3_FCR_FIFO_RX_TRIG16 
+
+#define UART3_SCR_TX_TRIG1		(1 << 6)
+#define UART3_SCR_RX_TRIG1		(1 << 7)
+
+#define UART3_MDR1_RESET 		(0x07)
+#define UART3_MDR1_SIR			(1 << 0)
+#define UART3_MDR1_MIR			(4 << 0)
+#define UART3_MDR1_FIR			(5 << 0)
+#define UART3_MDR1_SIP_AUTO		(1 << 6)
+
+#define UART3_MDR2_TRIG1		(0 << 1)
+#define UART3_MDR2_IRTX_UNDERRUN	(1 << 0)
+				
+#define UART3_ACERG_TX_UNDERRUN_DIS	(1 << 4)
+#define UART3_ACERG_SD_MODE_LOW		(1 << 6)
+#define UART3_ACERG_DIS_IR_RX		(1 << 5)
+
+#define UART3_IER_EOF			(1 << 5)
+#define UART3_IER_CTS			(1 << 7)
+
+#define UART3_IIR_TX_STATUS		(1 << 5)
+#define UART3_IIR_EOF			(0x80)
+
+#define IS_FIR(si)		((si)->speed >= 4000000)
+
+static int rx_state = 0;	/* RX state for IOCTL */
+
+struct omap_irda {
+	unsigned char open;
+	int speed;		/* Current IrDA speed */
+	int newspeed;
+
+	struct net_device_stats stats;
+	struct irlap_cb *irlap;
+	struct qos_info qos;
+
+	int rx_dma_channel;
+	int tx_dma_channel;
+
+	dma_addr_t rx_buf_dma_phys;	/* Physical adress of RX DMA buffer */
+	dma_addr_t tx_buf_dma_phys;	/* Physical adress of TX DMA buffer */
+
+	void *rx_buf_dma_virt;	/* Virtual adress of RX DMA buffer */
+	void *tx_buf_dma_virt;	/* Virtual adress of TX DMA buffer */
+
+	struct device *dev;
+	struct omap_irda_config *pdata;
+};
+
+#define OMAP_IRDA_DEBUG	0
+
+#if (OMAP_IRDA_DEBUG > 0)
+#define DBG(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
+#define DBG_IRQ(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
+#else
+#define DBG(format, args...)
+#define DBG_IRQ(format, args...)
+#endif
+
+#if (OMAP_IRDA_DEBUG > 1)
+#define __ECHO_IN printk(KERN_ERR "%s: enter\n",__FUNCTION__);
+#define __ECHO_OUT printk(KERN_ERR "%s: exit\n",__FUNCTION__);
+#else
+#define __ECHO_IN
+#define __ECHO_OUT
+#endif
+
+#ifdef OMAP1610_IR_HARDWARE_DEBUG_ENABLE
+#define HDBG_DELAY 200
+
+void hard_debug1(u16 i)
+{
+	for (; i; i--) {
+		omap_writew(0x2000,
+			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
+		udelay(HDBG_DELAY);
+
+		omap_writew(0x2000,
+			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
+		udelay(HDBG_DELAY);
+	}
+}
+
+void hard_debug2(u16 i)
+{
+	for (; i; i--) {
+		omap_writew(0x8000,
+			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
+		udelay(HDBG_DELAY);
+
+		omap_writew(0x8000,
+			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
+		udelay(HDBG_DELAY);
+	}
+}
+
+#define HDBG1(i) hard_debug1(i)
+#define HDBG2(i) hard_debug2(i)
+#else
+#define HDBG1(i)
+#define HDBG2(i)
+#endif
+
+static void inline uart_reg_out(int idx, u8 val)
+{
+	omap_writeb(val, idx);
+}
+
+static u8 inline uart_reg_in(int idx)
+{
+	u8 b = omap_readb(idx);
+	return b;
+}
+
+/* forward declarations */
+extern void irda_device_setup(struct net_device *dev);
+extern void omap_stop_dma(int lch);
+static int omap_irda_set_speed(struct net_device *dev, int speed);
+
+static void omap_irda_start_rx_dma(struct omap_irda *si)
+{
+	/* default for h2/h3 */
+	unsigned long src_start = 0xfffb9800;
+	unsigned int trigger = 0;	
+
+	if (machine_is_omap_h2() || machine_is_omap_h3()) {
+		src_start = UART3_RHR;
+		trigger = 0;
+	}
+	if (machine_is_omap_h4()) {
+		src_start = OMAP_UART3_BASE;
+		trigger = OMAP24XX_DMA_UART3_RX;
+	}
+	    
+	/* Configure DMA */
+    	omap_set_dma_src_params(si->rx_dma_channel, 0x3, 0x0, src_start,
+				0, 0);
+
+	omap_enable_dma_irq(si->rx_dma_channel, 0x01);
+
+	omap_set_dma_dest_params(si->rx_dma_channel, 0x0, 0x1,
+				 si->rx_buf_dma_phys,
+				 0, 0);
+
+	omap_set_dma_transfer_params(si->rx_dma_channel, 0x0, 4096, 0x1,
+				     0x0, trigger, 0);
+
+	omap_start_dma(si->rx_dma_channel);
+}
+
+static void omap_start_tx_dma(struct omap_irda *si, int size)
+{
+	/* default for h2/h3 */
+	unsigned long dest_start = 0xfffb9800;
+	unsigned int trigger = 0;	
+
+	if (machine_is_omap_h2() || machine_is_omap_h3()) {
+		dest_start = UART3_THR;
+		trigger = 0;
+	}
+	if (machine_is_omap_h4()) {
+		dest_start = OMAP_UART3_BASE;
+		trigger = OMAP24XX_DMA_UART3_TX;
+	}
+
+	__ECHO_IN;
+	/* Configure DMA */
+	omap_set_dma_dest_params(si->tx_dma_channel, 0x03, 0x0,
+				 dest_start, 0, 0);
+	omap_enable_dma_irq(si->tx_dma_channel, 0x01);
+
+	omap_set_dma_src_params(si->tx_dma_channel, 0x0, 0x1,
+				si->tx_buf_dma_phys,
+				0, 0);
+
+	omap_set_dma_transfer_params(si->tx_dma_channel, 0x0, size, 0x1,
+				     0x0, trigger, 0);
+
+	HDBG1(1);
+
+	/* Start DMA */
+	omap_start_dma(si->tx_dma_channel);
+
+	HDBG1(1);
+
+	__ECHO_OUT;
+}
+
+/* DMA RX callback - normally, we should not go here, 
+   it calls only if something is going wrong
+ */
+static void omap_irda_rx_dma_callback(int lch, u16 ch_status, void *data)
+{
+	struct net_device *dev = data;
+	struct omap_irda *si = dev->priv;
+
+	printk(KERN_ERR "RX Transfer error or very big frame \n");
+
+	/* Clear interrupts */
+	uart_reg_in(UART3_IIR);
+
+	si->stats.rx_frame_errors++;
+
+	uart_reg_in(UART3_RESUME);
+
+	/* Re-init RX DMA */
+	omap_irda_start_rx_dma(si);
+
+}
+
+/* DMA TX callback - calling when frame transfer has been finished */
+
+static void omap_irda_tx_dma_callback(int lch, u16 ch_status, void *data)
+{
+	struct net_device *dev = data;
+	struct omap_irda *si = dev->priv;
+
+	__ECHO_IN;
+
+	/*Stop DMA controller */
+	omap_stop_dma(si->tx_dma_channel);
+
+	__ECHO_OUT;
+
+}
+
+/*
+ * Set the IrDA communications speed.
+ * Interrupt have to be disabled here.
+ */
+
+static int omap_irda_startup(struct net_device *dev)
+{
+	struct omap_irda *si = dev->priv;
+	__ECHO_IN;
+
+	
+	/* FIXME: use clk_* apis for UART3 clock*/
+	/* Enable UART3 clock and set UART3 to IrDA mode */
+	if (machine_is_omap_h2() || machine_is_omap_h3())
+		omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
+			    MOD_CONF_CTRL_0);
+	
+	/* It was only called for H2
+	 * Don't know how it behaves on H3/H4
+	 */
+	if (si->pdata->transceiver_mode)
+		si->pdata->transceiver_mode(si->dev, IR_SIRMODE);
+
+	uart_reg_out(UART3_MDR1, UART3_MDR1_RESET);	/* Reset mode */
+
+	/* Clear DLH and DLL */
+	uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
+
+	uart_reg_out(UART3_DLL, 0);
+	uart_reg_out(UART3_DLH, 0);
+	uart_reg_out(UART3_LCR, 0xbf);	/* FIXME: Add #define */
+
+	uart_reg_out(UART3_EFR, UART3_EFR_EN);
+	uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
+
+	/* Enable access to UART3_TLR and UART3_TCR registers */
+	uart_reg_out(UART3_MCR, UART3_MCR_EN_TCR_TLR);
+
+	uart_reg_out(UART3_SCR, 0);
+	/* Set Rx trigger to 1 and Tx trigger to 1 */
+	uart_reg_out(UART3_TLR, 0);
+
+	/* Set LCR to 8 bits and 1 stop bit */
+	uart_reg_out(UART3_LCR, 0x03);
+
+	/* Clear RX and TX FIFO and enable FIFO */
+	/* Use DMA Req for transfers */
+	uart_reg_out(UART3_FCR, UART3_FCR_CONFIG);
+
+	uart_reg_out(UART3_MCR, 0);
+
+	uart_reg_out(UART3_SCR, UART3_SCR_TX_TRIG1 |
+		     UART3_SCR_RX_TRIG1);
+
+	/* Enable UART3 SIR Mode,(Frame-length method to end frames) */
+	uart_reg_out(UART3_MDR1, UART3_MDR1_SIR);
+
+	/* Set Status FIFO trig to 1 */
+	uart_reg_out(UART3_MDR2, 0);
+
+	/* Enables RXIR input */
+	/* and disable TX underrun */
+	/* SEND_SIP pulse */
+	uart_reg_out(UART3_ACREG, UART3_ACERG_SD_MODE_LOW |
+		     UART3_ACERG_TX_UNDERRUN_DIS);
+
+	/* Enable EOF Interrupt only */
+	uart_reg_out(UART3_IER, UART3_IER_CTS | UART3_IER_EOF);
+
+	/* Set Maximum Received Frame size to 2048 bytes */
+	uart_reg_out(UART3_RXFLL, 0x00);
+	uart_reg_out(UART3_RXFLH, 0x08);
+
+	uart_reg_in(UART3_RESUME);
+
+	__ECHO_OUT;
+
+	return 0;
+
+}
+
+static int omap_irda_shutdown(struct omap_irda *si)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* Disable all UART3 Interrupts */
+	uart_reg_out(UART3_IER, 0);
+
+	/* Disable UART3 and disable baud rate generator */
+	uart_reg_out(UART3_MDR1, UART3_MDR1_RESET);
+
+	/* set SD_MODE pin to high and Disable RX IR */
+	uart_reg_out(UART3_ACREG, (UART3_ACERG_DIS_IR_RX |
+		     ~(UART3_ACERG_SD_MODE_LOW)));
+
+	/* Clear DLH and DLL */
+	uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
+	uart_reg_out(UART3_DLL, 0);
+	uart_reg_out(UART3_DLH, 0);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static irqreturn_t
+omap_irda_irq(int irq, void *dev_id, struct pt_regs *hw_regs)
+{
+	struct net_device *dev = dev_id;
+	struct omap_irda *si = dev->priv;
+	struct sk_buff *skb;
+
+	u8 status;
+	int w = 0;
+
+	__ECHO_IN;
+
+	/* Clear EOF interrupt */
+	status = uart_reg_in(UART3_IIR);
+
+	if (status & UART3_IIR_TX_STATUS) {
+		u8 mdr2 = uart_reg_in(UART3_MDR2);
+		HDBG1(2);
+		if (mdr2 & UART3_MDR2_IRTX_UNDERRUN)
+			printk(KERN_ERR "IrDA Buffer underrun error");
+
+		si->stats.tx_packets++;
+
+		if (si->newspeed) {
+			omap_irda_set_speed(dev, si->newspeed);
+			si->newspeed = 0;
+		}
+
+		netif_wake_queue(dev);
+		if (!(status & UART3_IIR_EOF))
+			return IRQ_HANDLED;
+	}
+
+	/* Stop DMA and if there are no errors, send frame to upper layer */
+
+	omap_stop_dma(si->rx_dma_channel);
+
+	status = uart_reg_in(UART3_SFLSR);	/* Take a frame status */
+
+	if (status != 0) {	/* Bad frame? */
+		si->stats.rx_frame_errors++;
+		uart_reg_in(UART3_RESUME);
+	} else {
+		/* We got a frame! */
+		skb = alloc_skb(4096, GFP_ATOMIC);
+
+		if (!skb) {
+			printk(KERN_ERR "omap_sir: out of memory for RX SKB\n");
+			return IRQ_HANDLED;
+		}
+		/*
+		 * Align any IP headers that may be contained
+		 * within the frame.
+		 */
+
+		skb_reserve(skb, 1);
+
+		w = OMAP_DMA_CDAC_REG(si->rx_dma_channel);
+
+		if (cpu_is_omap16xx())
+			w -= OMAP1_DMA_CDSA_L_REG(si->rx_dma_channel);
+		if (cpu_is_omap24xx())
+			w -= OMAP2_DMA_CDSA_REG(si->rx_dma_channel);
+
+		if (!IS_FIR(si)) {
+			/* Copy DMA buffer to skb */
+			memcpy(skb_put(skb, w - 2), si->rx_buf_dma_virt, w - 2);
+		} else {  		
+			/* Copy DMA buffer to skb */
+			memcpy(skb_put(skb, w - 4), si->rx_buf_dma_virt, w - 4);
+		}
+
+		skb->dev = dev;
+		skb->mac.raw = skb->data;
+		skb->protocol = htons(ETH_P_IRDA);
+		si->stats.rx_packets++;
+		si->stats.rx_bytes += skb->len;
+		netif_receive_skb(skb);	/* Send data to upper level */
+	}
+
+	/* Re-init RX DMA */
+	omap_irda_start_rx_dma(si);
+
+	dev->last_rx = jiffies;
+
+	__ECHO_OUT;
+
+	return IRQ_HANDLED;
+}
+
+static int omap_irda_hard_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct omap_irda *si = dev->priv;
+	int speed = irda_get_next_speed(skb);
+	int mtt = irda_get_mtt(skb);
+	int xbofs = irda_get_next_xbofs(skb);
+
+	__ECHO_IN;
+
+	/*
+	 * Does this packet contain a request to change the interface
+	 * speed?  If so, remember it until we complete the transmission
+	 * of this frame.
+	 */
+	if (speed != si->speed && speed != -1)
+		si->newspeed = speed;
+
+	if (xbofs) {
+		/* Set number of addtional BOFS */
+		uart_reg_out(UART3_EBLR, xbofs + 1);
+	}
+	
+	/*
+	 * If this is an empty frame, we can bypass a lot.
+	 */
+	if (skb->len == 0) {
+		if (si->newspeed) {
+			si->newspeed = 0;
+			omap_irda_set_speed(dev, speed);
+		}
+		dev_kfree_skb(skb);
+		return 0;
+	}
+
+	netif_stop_queue(dev);
+
+	/* Copy skb data to DMA buffer */
+	memcpy(si->tx_buf_dma_virt, skb->data, skb->len);
+
+	/* Copy skb data to DMA buffer */
+	si->stats.tx_bytes += skb->len;
+
+	/* Set frame length */
+	uart_reg_out(UART3_TXFLL, (skb->len & 0xff));
+	uart_reg_out(UART3_TXFLH, (skb->len >> 8));
+
+	if (mtt > 1000)
+		mdelay(mtt / 1000);
+	else
+		udelay(mtt);
+
+	/* Start TX DMA transfer */
+	omap_start_tx_dma(si, skb->len);
+
+	/* We can free skb now because it's already in DMA buffer */
+	dev_kfree_skb(skb);
+
+	dev->trans_start = jiffies;
+
+	__ECHO_OUT;
+
+	return 0;
+}
+
+static int
+omap_irda_ioctl(struct net_device *dev, struct ifreq *ifreq, int cmd)
+{
+	struct if_irda_req *rq = (struct if_irda_req *)ifreq;
+	struct omap_irda *si = dev->priv;
+	int ret = -EOPNOTSUPP;
+
+	__ECHO_IN;
+
+	switch (cmd) {
+	case SIOCSBANDWIDTH:
+		if (capable(CAP_NET_ADMIN)) {
+			/*
+			 * We are unable to set the speed if the
+			 * device is not running.
+			 */
+			if (si->open) {
+				ret =
+				    omap_irda_set_speed(dev, rq->ifr_baudrate);
+			} else {
+				printk (KERN_ERR "omap_irda_ioctl: SIOCSBANDWIDTH: !netif_running\n");
+				ret = 0;
+			}
+		}
+		break;
+
+	case SIOCSMEDIABUSY:
+		ret = -EPERM;
+		if (capable(CAP_NET_ADMIN)) {
+			irda_device_set_media_busy(dev, TRUE);
+			ret = 0;
+		}
+		break;
+
+	case SIOCGRECEIVING:
+		rq->ifr_receiving = rx_state;
+		break;
+
+	default:
+		break;
+	}
+
+	__ECHO_OUT;
+
+	return ret;
+}
+
+static struct net_device_stats *omap_irda_stats(struct net_device *dev)
+{
+	struct omap_irda *si = dev->priv;
+	return &si->stats;
+}
+
+static int omap_irda_start(struct net_device *dev)
+{
+	struct omap_irda *si = dev->priv;
+	int err;
+	unsigned long flags = 0;
+	int rx_channel, tx_channel;
+
+	__ECHO_IN;
+	si->speed = 9600;
+
+	err = request_irq(dev->irq, omap_irda_irq, 0, dev->name, dev);
+	if (err)
+		goto err_irq;
+
+	/*
+	 * The interrupt must remain disabled for now.
+	 */
+	disable_irq(dev->irq);
+	
+	/* FIXME: These info can come from board-* files, if no one
+	 * objects
+	 */
+	if (machine_is_omap_h2() || machine_is_omap_h3()) {
+		rx_channel = OMAP_DMA_UART3_RX;
+		tx_channel = OMAP_DMA_UART3_TX;
+	}
+	if (machine_is_omap_h4()) {
+		rx_channel = OMAP24XX_DMA_UART3_RX;
+		tx_channel = OMAP24XX_DMA_UART3_TX;
+	}
+
+	/*  Request DMA channels for IrDA hardware */
+	if (omap_request_dma(rx_channel, "IrDA Rx DMA",
+			     (void *)omap_irda_rx_dma_callback,
+			     dev, &(si->rx_dma_channel))) {
+		printk(KERN_ERR "Failed to request IrDA Rx DMA \n");
+		goto err_irq;
+	}
+
+	if (omap_request_dma(tx_channel, "IrDA Tx DMA",
+			     (void *)omap_irda_tx_dma_callback,
+			     dev, &(si->tx_dma_channel))) {
+		printk(KERN_ERR "Failed to request IrDA Tx DMA \n");
+		goto err_irq;
+	}
+
+	/* Allocate TX and RX buffers for DMA channels */
+	si->rx_buf_dma_virt =
+	    dma_alloc_coherent(NULL, 4096, &(si->rx_buf_dma_phys), flags);
+
+	si->tx_buf_dma_virt =
+	    dma_alloc_coherent(NULL, 4096, &(si->tx_buf_dma_phys), flags);
+
+	/*
+	 * Setup the serial port for the specified config.
+	 */
+	if (si->pdata->select_irda)
+		si->pdata->select_irda(si->dev, IR_SEL);
+	
+	err = omap_irda_startup(dev);
+
+	if (err)
+		goto err_startup;
+
+	omap_irda_set_speed(dev, si->speed = 9600);
+
+	/*
+	 * Open a new IrLAP layer instance.
+	 */
+	si->irlap = irlap_open(dev, &si->qos, "omap_sir");
+
+	err = -ENOMEM;
+	if (!si->irlap)
+		goto err_irlap;
+
+	/* Now enable the interrupt and start the queue  */
+	si->open = 1;
+
+	/* Start RX DMA */
+	omap_irda_start_rx_dma(si);
+
+	enable_irq(dev->irq);
+	netif_start_queue(dev);
+
+	__ECHO_OUT;
+
+	return 0;
+
+err_irlap:
+	si->open = 0;
+	omap_irda_shutdown(si);
+err_startup:
+err_irq:
+	free_irq(dev->irq, dev);
+	return err;
+}
+
+static int omap_irda_stop(struct net_device *dev)
+{
+	struct omap_irda *si = dev->priv;
+
+	__ECHO_IN;
+
+	disable_irq(dev->irq);
+
+	netif_stop_queue(dev);
+
+	omap_free_dma(si->rx_dma_channel);
+	omap_free_dma(si->tx_dma_channel);
+
+	if (si->rx_buf_dma_virt)
+		dma_free_coherent(NULL, 4096, si->rx_buf_dma_virt, si->rx_buf_dma_phys);
+	if (si->tx_buf_dma_virt)
+		dma_free_coherent(NULL, 4096, si->tx_buf_dma_virt, si->tx_buf_dma_phys);
+
+	omap_irda_shutdown(si);
+
+	/* Stop IrLAP */
+	if (si->irlap) {
+		irlap_close(si->irlap);
+		si->irlap = NULL;
+	}
+
+	si->open = 0;
+
+	/*
+	 * Free resources
+	 */
+	free_irq(dev->irq, dev);
+
+	__ECHO_OUT;
+
+	return 0;
+}
+
+static int omap_irda_set_speed(struct net_device *dev, int speed)
+{
+	struct omap_irda *si = dev->priv;
+	int divisor;
+	unsigned long flags;
+
+	__ECHO_IN;
+
+	/* Set IrDA speed */
+	if (speed <= 115200) {
+
+	    	local_irq_save(flags);
+	    
+		/* SIR mode */
+		if (si->pdata->transceiver_mode)
+			si->pdata->transceiver_mode(si->dev, IR_SIRMODE);
+
+		/* Set SIR mode */
+		uart_reg_out(UART3_MDR1, 1);
+		uart_reg_out(UART3_EBLR, 1);
+
+		divisor = 48000000 / (16 * speed);	/* Base clock 48 MHz */
+
+		HDBG2(1);
+
+		uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
+		uart_reg_out(UART3_DLL, (divisor & 0xff));
+		uart_reg_out(UART3_DLH, (divisor >> 8));
+		uart_reg_out(UART3_LCR, 0x03);
+
+		uart_reg_out(UART3_MCR, 0);
+
+		HDBG2(1);
+		
+		local_irq_restore(flags);
+
+	} else if (speed <= 1152000) {
+	
+		local_irq_save(flags);    			    
+	    
+		/* Set MIR mode, auto SIP */
+		uart_reg_out(UART3_MDR1, UART3_MDR1_MIR |
+			     UART3_MDR1_SIP_AUTO);	
+
+		uart_reg_out(UART3_EBLR, 2);
+
+		divisor = 48000000 / (41 * speed);	/* Base clock 48 MHz */
+
+		uart_reg_out(UART3_LCR, UART3_LCR_DIVEN);
+		uart_reg_out(UART3_DLL, (divisor & 0xff));
+		uart_reg_out(UART3_DLH, (divisor >> 8));
+		uart_reg_out(UART3_LCR, 0x03);
+
+		if (si->pdata->transceiver_mode)
+			si->pdata->transceiver_mode(si->dev, IR_MIRMODE);
+
+		local_irq_restore(flags);
+
+	} else {
+		local_irq_save(flags);    			    
+		
+		/* FIR mode */
+		uart_reg_out(UART3_MDR1, UART3_MDR1_FIR |
+			     UART3_MDR1_SIP_AUTO);	
+
+		if (si->pdata->transceiver_mode)
+			si->pdata->transceiver_mode(si->dev, IR_FIRMODE);
+
+		local_irq_restore(flags);    			    
+	}
+
+	si->speed = speed;
+
+	__ECHO_OUT;
+
+	return 0;
+
+}
+
+#ifdef CONFIG_PM
+/*
+ * Suspend the IrDA interface.
+ */
+static int omap_irda_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct omap_irda *si = dev->priv;
+
+	if (!dev)
+		return 0;
+
+	if (si->open) {
+		/*
+		 * Stop the transmit queue
+		 */
+		netif_device_detach(dev);
+		disable_irq(dev->irq);
+		omap_irda_shutdown(si);
+	}
+	return 0;
+}
+
+/*
+ * Resume the IrDA interface.
+ */
+static int omap_irda_resume(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct omap_irda *si= dev->priv;
+
+	if (!dev)
+		return 0;
+
+	if (si->open) {
+		/*
+		 * If we missed a speed change, initialise at the new speed
+		 * directly.  It is debatable whether this is actually
+		 * required, but in the interests of continuing from where
+		 * we left off it is desireable.  The converse argument is
+		 * that we should re-negotiate at 9600 baud again.
+		 */
+		if (si->newspeed) {
+			si->speed = si->newspeed;
+			si->newspeed = 0;
+		}
+
+		omap_irda_startup(dev);
+		omap_irda_set_speed(dev, si->speed);
+		enable_irq(dev->irq);
+
+		/*
+		 * This automatically wakes up the queue
+		 */
+		netif_device_attach(dev);
+	}
+
+	return 0;
+}
+#else
+#define omap_irda_suspend	NULL
+#define omap_irda_resume	NULL
+#endif
+
+static int omap_irda_probe(struct platform_device *pdev)
+{
+	struct net_device *dev;
+	struct omap_irda *si;
+	unsigned int baudrate_mask;
+	int err = 0;
+	int irq = NO_IRQ;
+
+	if (!pdev->dev.platform_data) {
+		printk(KERN_ERR "IrDA Platform data not supplied\n");
+		return -ENOENT;
+	}
+
+	dev = alloc_irdadev(sizeof(struct omap_irda));
+	if (!dev)
+		goto err_mem_1;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		printk(KERN_WARNING "no irq for IrDA\n");
+		return -ENOENT;
+	}
+
+	si = dev->priv;
+	si->dev = &pdev->dev;
+	si->pdata = pdev->dev.platform_data;
+
+	dev->hard_start_xmit	= omap_irda_hard_xmit;
+	dev->open		= omap_irda_start;
+	dev->stop		= omap_irda_stop;
+	dev->do_ioctl		= omap_irda_ioctl;
+	dev->get_stats		= omap_irda_stats;
+	dev->irq		= irq;
+
+	irda_init_max_qos_capabilies(&si->qos);
+
+	baudrate_mask = 0;
+	if (si->pdata->transceiver_cap & IR_SIRMODE)
+		baudrate_mask |= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+	if (si->pdata->transceiver_cap & IR_MIRMODE)
+		baudrate_mask |= IR_57600 | IR_1152000;
+	if (si->pdata->transceiver_cap & IR_FIRMODE)
+		baudrate_mask |= IR_4000000 << 8;
+
+	si->qos.baud_rate.bits &= baudrate_mask;
+	si->qos.min_turn_time.bits = 7;
+
+	irda_qos_bits_to_value(&si->qos);
+
+	err = register_netdev(dev);
+	if (!err)
+		platform_set_drvdata(pdev, dev);
+	else 
+		free_netdev(dev);
+
+err_mem_1:
+	return err;
+}
+
+static int omap_irda_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	if (pdev) {
+		unregister_netdev(dev);
+		free_netdev(dev);
+	}
+	return 0;
+}
+
+static struct platform_driver omapir_driver = {
+	.probe		= omap_irda_probe,
+	.remove		= omap_irda_remove,
+	.suspend	= omap_irda_suspend,
+	.resume		= omap_irda_resume,
+	.driver		= {
+		.name	= "omapirda",
+	},
+};
+
+static char __initdata banner[] = "OMAP IrDA driver\n";
+
+static int __init omap_irda_init(void)
+{
+	printk(banner);
+	return platform_driver_register(&omapir_driver);
+}
+
+static void __exit omap_irda_exit(void)
+{
+	platform_driver_unregister(&omapir_driver);
+}
+
+module_init(omap_irda_init);
+module_exit(omap_irda_exit);
+
+MODULE_AUTHOR("MontaVista");
+MODULE_DESCRIPTION("OMAP IrDA Driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/net/irda/omap1610-ir.c b/drivers/net/irda/omap1610-ir.c
deleted file mode 100644
index 1fa8e89..0000000
--- a/drivers/net/irda/omap1610-ir.c
+++ /dev/null
@@ -1,997 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *
- *	Infra-red driver for the OMAP1610-H2 and OMAP1710-H3 Platforms
- *          (SIR/MIR/FIR modes)
- *          (based on omap-sir.c)
- *
- * Copyright 2003 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *	   source@mvista.com
- * 
- * Copyright 2004 Texas Instruments.
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
- *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
- *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- Modifications:
- Feb 2004, Texas Instruments
- - Ported to 2.6 kernel (Feb 2004).
- *
- Apr 2004, Texas Instruments
- - Added support for H3 (Apr 2004). 
- Nov 2004, Texas Instruments
- - Added support for Power Management.
- 
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/netdevice.h>
-#include <linux/slab.h>
-#include <linux/rtnetlink.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/ioport.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-
-#include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/wrapper.h>
-#include <net/irda/irda_device.h>
-
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/hardware.h>
-#include <asm/serial.h>
-#include <asm/mach-types.h>
-#include <asm/dma.h>
-#include <asm/arch/mux.h>
-#include <asm/arch/gpio.h>
-#include <linux/i2c.h>
-
-#ifdef CONFIG_MACH_OMAP_H3
-#include <asm/arch/gpioexpander.h>
-#endif
-
-#define SIR_MODE 0
-#define MIR_MODE 1
-#define FIR_MODE 2
-
-#define OMAP1610_H2_FIRSEL_GPIO 17
-
-static int rx_state = 0;	/* RX state for IOCTL */
-
-struct omap1610_irda {
-	unsigned char open;
-	int speed;		/* Current IrDA speed */
-	int newspeed;
-
-	struct net_device_stats stats;
-	struct irlap_cb *irlap;
-	struct qos_info qos;
-
-	int rx_dma_channel;
-	int tx_dma_channel;
-
-	dma_addr_t rx_buf_dma_phys;	/* Physical adress of RX DMA buffer */
-	dma_addr_t tx_buf_dma_phys;	/* Physical adress of TX DMA buffer */
-
-	void *rx_buf_dma_virt;	/* Virtual adress of RX DMA buffer */
-	void *tx_buf_dma_virt;	/* Virtual adress of TX DMA buffer */
-
-	struct device *dev;
-};
-
-#define OMAP_IRDA_DEBUG	0
-
-#if (OMAP_IRDA_DEBUG > 0)
-#define DBG(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#define DBG_IRQ(format, args...) printk(KERN_ERR "%s(): " format, __FUNCTION__, ## args);
-#else
-#define DBG(format, args...)
-#define DBG_IRQ(format, args...)
-#endif
-
-#if (OMAP_IRDA_DEBUG > 1)
-#define __ECHO_IN printk(KERN_ERR "%s: enter\n",__FUNCTION__);
-#define __ECHO_OUT printk(KERN_ERR "%s: exit\n",__FUNCTION__);
-#else
-#define __ECHO_IN
-#define __ECHO_OUT
-#endif
-
-#ifdef OMAP1610_IR_HARDWARE_DEBUG_ENABLE
-#define HDBG_DELAY 200
-
-void hard_debug1(u16 i)
-{
-	for (; i; i--) {
-		omap_writew(0x2000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
-		udelay(HDBG_DELAY);
-
-		omap_writew(0x2000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
-		udelay(HDBG_DELAY);
-	}
-}
-
-void hard_debug2(u16 i)
-{
-	for (; i; i--) {
-		omap_writew(0x8000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_CLEAR_DATAOUT);
-		udelay(HDBG_DELAY);
-
-		omap_writew(0x8000,
-			    OMAP1610_GPIO1_BASE + OMAP1610_GPIO_SET_DATAOUT);
-		udelay(HDBG_DELAY);
-	}
-}
-
-#define HDBG1(i) hard_debug1(i)
-#define HDBG2(i) hard_debug2(i)
-#else
-#define HDBG1(i)
-#define HDBG2(i)
-#endif
-
-/* forward declarations */
-
-extern void irda_device_setup(struct net_device *dev);
-extern void omap_stop_dma(int lch);
-static int omap1610_irda_set_speed(struct net_device *dev, int speed);
-
-static void omap1610_irda_start_rx_dma(struct omap1610_irda *si)
-{
-	/* Configure DMA */
-	omap_set_dma_src_params(si->rx_dma_channel, 0x3, 0x0, (unsigned long)UART3_RHR,
-				0, 0);
-
-	omap_enable_dma_irq(si->rx_dma_channel, 0x01);
-
-	omap_set_dma_dest_params(si->rx_dma_channel, 0x0, 0x1,
-				 si->rx_buf_dma_phys,
-				 0, 0);
-
-	omap_set_dma_transfer_params(si->rx_dma_channel, 0x0, 4096, 0x1, 0x0, 0, 0);
-
-	omap_start_dma(si->rx_dma_channel);
-}
-
-static void omap1610_start_tx_dma(struct omap1610_irda *si, int size)
-{
-	__ECHO_IN;
-
-	/* Configure DMA */
-	omap_set_dma_dest_params(si->tx_dma_channel, 0x03, 0x0, (unsigned long)UART3_THR,
-					0, 0);
-	omap_enable_dma_irq(si->tx_dma_channel, 0x01);
-
-	omap_set_dma_src_params(si->tx_dma_channel, 0x0, 0x1,
-				si->tx_buf_dma_phys,
-				0, 0);
-
-	omap_set_dma_transfer_params(si->tx_dma_channel, 0x0, size, 0x1, 0x0, 0, 0);
-
-	HDBG1(1);
-
-	/* Start DMA */
-	omap_start_dma(si->tx_dma_channel);
-
-	HDBG1(1);
-
-	__ECHO_OUT;
-}
-
-/* DMA RX callback - normally, we should not go here, 
-   it calls only if something is going wrong
- */
-
-static void omap1610_irda_rx_dma_callback(int lch, u16 ch_status, void *data)
-{
-	struct net_device *dev = data;
-	struct omap1610_irda *si = dev->priv;
-
-	printk(KERN_ERR "RX Transfer error or very big frame \n");
-
-	/* Clear interrupts */
-	omap_readb(UART3_IIR);
-
-	si->stats.rx_frame_errors++;
-
-	omap_readb(UART3_RESUME);
-
-	/* Re-init RX DMA */
-	omap1610_irda_start_rx_dma(si);
-
-}
-
-/* DMA TX callback - calling when frame transfer has been finished */
-
-static void omap1610_irda_tx_dma_callback(int lch, u16 ch_status, void *data)
-{
-	struct net_device *dev = data;
-	struct omap1610_irda *si = dev->priv;
-
-	__ECHO_IN;
-
-	/*Stop DMA controller */
-	omap_stop_dma(si->tx_dma_channel);
-
-	__ECHO_OUT;
-
-}
-
-/*
- * Set the IrDA communications speed.
- * Interrupt have to be disabled here.
- */
-
-static int omap1610_irda_startup(struct net_device *dev)
-{
-	__ECHO_IN;
-
-	/* Enable UART3 clock and set UART3 to IrDA mode */
-	omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
-		    MOD_CONF_CTRL_0);
-
-	if (machine_is_omap_h2()) {
-//              omap_cfg_reg(Y15_1610_GPIO17);
-		omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
-
-		omap_set_gpio_direction(OMAP1610_H2_FIRSEL_GPIO, 0);
-		omap_set_gpio_dataout(OMAP1610_H2_FIRSEL_GPIO, 0);
-	}
-
-	omap_writeb(0x07, UART3_MDR1);	/* Put UART3 in reset mode */
-
-	/* Clear DLH and DLL */
-	omap_writeb(1 << 7, UART3_LCR);
-
-	omap_writeb(0, UART3_DLL);
-	omap_writeb(0, UART3_DLH);
-
-	omap_writeb(0xbf, UART3_LCR);
-
-	omap_writeb(1 << 4, UART3_EFR);
-
-	omap_writeb(1 << 7, UART3_LCR);
-
-	/* Enable access to UART3_TLR and UART3_TCR registers */
-	omap_writeb(1 << 6, UART3_MCR);
-
-	omap_writeb(0, UART3_SCR);
-
-	/* Set Rx trigger to 1 and Tx trigger to 1 */
-	omap_writeb(0, UART3_TLR);
-
-	/* Set LCR to 8 bits and 1 stop bit */
-	omap_writeb(0x03, UART3_LCR);
-
-	/* Clear RX and TX FIFO and enable FIFO */
-	/* Use DMA Req for transfers */
-
-	omap_writeb((1 << 2) | (1 << 1) | (1 << 3) | (1 << 4) | (1 << 6) | 1,
-		    UART3_FCR);
-
-	omap_writeb(0, UART3_MCR);
-
-	omap_writeb((1 << 7) | (1 << 6), UART3_SCR);
-
-	/* Enable UART3 SIR Mode,(Frame-length method to end frames) */
-	omap_writeb(1, UART3_MDR1);
-
-	/* Set Status FIFO trig to 1 */
-	omap_writeb(0, UART3_MDR2);
-
-	/* Enables RXIR input */
-	/* and disable TX underrun */
-	/* SEND_SIP pulse */
-
-	//   omap_writeb((1 << 7) | (1 << 6) | (1 << 4), UART3_ACREG);
-	omap_writeb((1 << 6) | (1 << 4), UART3_ACREG);
-
-	/* Enable EOF Interrupt only */
-	omap_writeb((1 << 7) | (1 << 5), UART3_IER);
-
-	/* Set Maximum Received Frame size to 2048 bytes */
-	omap_writeb(0x00, UART3_RXFLL);
-	omap_writeb(0x08, UART3_RXFLH);
-
-	omap_readb(UART3_RESUME);
-
-	__ECHO_OUT;
-
-	return 0;
-
-}
-
-static int omap1610_irda_shutdown(struct omap1610_irda *si)
-{
-	/* Disable all UART3 Interrupts */
-	omap_writeb(0, UART3_IER);
-
-	/* Disable UART3 and disable baud rate generator */
-	omap_writeb(0x07, UART3_MDR1);	/* Put UART3 in reset mode */
-
-	omap_writeb((1 << 5), UART3_ACREG);	/* set SD_MODE pin to high and Disable RX IR */
-
-	/* Clear DLH and DLL */
-	omap_writeb(1 << 7, UART3_LCR);
-	omap_writeb(0, UART3_DLL);
-	omap_writeb(0, UART3_DLH);
-
-	return 0;
-}
-
-static irqreturn_t
-omap1610_irda_irq(int irq, void *dev_id, struct pt_regs *hw_regs)
-{
-	struct net_device *dev = dev_id;
-	struct omap1610_irda *si = dev->priv;
-	struct sk_buff *skb;
-
-	u8 status;
-	int w = 0;
-
-	__ECHO_IN;
-
-	/* Clear EOF interrupt */
-	status = omap_readb(UART3_IIR);
-
-	if (status & (1 << 5)) {
-		u8 mdr2 = omap_readb(UART3_MDR2);
-		HDBG1(2);
-		if (mdr2 & 1)
-			printk(KERN_ERR "IRDA Buffer underrun error");
-
-		si->stats.tx_packets++;
-
-		if (si->newspeed) {
-			omap1610_irda_set_speed(dev, si->newspeed);
-			si->newspeed = 0;
-		}
-
-		netif_wake_queue(dev);
-
-		if (!(status & 0x80))
-			return IRQ_HANDLED;
-	}
-
-	/* Stop DMA and if there are no errors, send frame to upper layer */
-
-	omap_stop_dma(si->rx_dma_channel);
-
-	status = omap_readb(UART3_SFLSR);	/* Take a frame status */
-
-	if (status != 0) {	/* Bad frame? */
-		si->stats.rx_frame_errors++;
-		omap_readb(UART3_RESUME);
-	} else {
-		/* We got a frame! */
-		skb = alloc_skb(4096, GFP_ATOMIC);
-
-		if (!skb) {
-			printk(KERN_ERR "omap_sir: out of memory for RX SKB\n");
-			return IRQ_HANDLED;
-		}
-		/*
-		 * Align any IP headers that may be contained
-		 * within the frame.
-		 */
-
-		skb_reserve(skb, 1);
-
-		w = OMAP_DMA_CDAC_REG(si->rx_dma_channel);
-		w -= OMAP1_DMA_CDSA_L_REG(si->rx_dma_channel);
-
-		if (si->speed != 4000000) {
-			memcpy(skb_put(skb, w - 2), si->rx_buf_dma_virt, w - 2);	/* Copy DMA buffer to skb */
-		} else {
-			memcpy(skb_put(skb, w - 4), si->rx_buf_dma_virt, w - 4);	/* Copy DMA buffer to skb */
-		}
-
-		skb->dev = dev;
-		skb->mac.raw = skb->data;
-		skb->protocol = htons(ETH_P_IRDA);
-		si->stats.rx_packets++;
-		si->stats.rx_bytes += skb->len;
-		netif_receive_skb(skb);	/* Send data to upper level */
-	}
-
-	/* Re-init RX DMA */
-	omap1610_irda_start_rx_dma(si);
-
-	dev->last_rx = jiffies;
-
-	__ECHO_OUT;
-
-	return IRQ_HANDLED;
-}
-
-static int omap1610_irda_hard_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct omap1610_irda *si = dev->priv;
-	int speed = irda_get_next_speed(skb);
-	int mtt = irda_get_mtt(skb);
-	int xbofs = irda_get_next_xbofs(skb);
-
-	__ECHO_IN;
-
-	/*
-	 * Does this packet contain a request to change the interface
-	 * speed?  If so, remember it until we complete the transmission
-	 * of this frame.
-	 */
-	if (speed != si->speed && speed != -1)
-		si->newspeed = speed;
-
-	if (xbofs) {
-		/* Set number of addtional BOFS */
-		omap_writeb(xbofs + 1, UART3_EBLR);
-	}
-
-	/*
-	 * If this is an empty frame, we can bypass a lot.
-	 */
-	if (skb->len == 0) {
-		if (si->newspeed) {
-			si->newspeed = 0;
-			omap1610_irda_set_speed(dev, speed);
-		}
-		dev_kfree_skb(skb);
-		return 0;
-	}
-
-	netif_stop_queue(dev);
-
-	/* Copy skb data to DMA buffer */
-
-	memcpy(si->tx_buf_dma_virt, skb->data, skb->len);
-
-	si->stats.tx_bytes += skb->len;
-
-	/* Set frame length */
-
-	omap_writeb((skb->len & 0xff), UART3_TXFLL);
-	omap_writeb((skb->len >> 8), UART3_TXFLH);
-
-	if (mtt > 1000)
-		mdelay(mtt / 1000);
-	else
-		udelay(mtt);
-
-	/* Start TX DMA transfer */
-
-	omap1610_start_tx_dma(si, skb->len);
-
-	/* We can free skb now because it's already in DMA buffer */
-
-	dev_kfree_skb(skb);
-
-	dev->trans_start = jiffies;
-
-	__ECHO_OUT;
-
-	return 0;
-}
-
-static int
-omap1610_irda_ioctl(struct net_device *dev, struct ifreq *ifreq, int cmd)
-{
-	struct if_irda_req *rq = (struct if_irda_req *)ifreq;
-	struct omap1610_irda *si = dev->priv;
-	int ret = -EOPNOTSUPP;
-
-	__ECHO_IN;
-
-	switch (cmd) {
-	case SIOCSBANDWIDTH:
-		if (capable(CAP_NET_ADMIN)) {
-			/*
-			 * We are unable to set the speed if the
-			 * device is not running.
-			 */
-			if (si->open) {
-				ret =
-				    omap1610_irda_set_speed(dev,
-							    rq->ifr_baudrate);
-			} else {
-				printk
-				    (KERN_ERR
-				     "omap_irda_ioctl: SIOCSBANDWIDTH: !netif_running\n");
-				ret = 0;
-			}
-		}
-		break;
-
-	case SIOCSMEDIABUSY:
-		ret = -EPERM;
-		if (capable(CAP_NET_ADMIN)) {
-			irda_device_set_media_busy(dev, TRUE);
-			ret = 0;
-		}
-		break;
-
-	case SIOCGRECEIVING:
-		rq->ifr_receiving = rx_state;
-		break;
-
-	default:
-		break;
-	}
-
-	__ECHO_OUT;
-
-	return ret;
-}
-
-static struct net_device_stats *omap1610_irda_stats(struct net_device *dev)
-{
-	struct omap1610_irda *si = dev->priv;
-	return &si->stats;
-}
-
-static int omap1610_irda_start(struct net_device *dev)
-{
-	struct omap1610_irda *si = dev->priv;
-	int err;
-	unsigned long flags = 0;
-
-#ifdef CONFIG_MACH_OMAP_H3
-	u8 ioExpanderVal = 0;
-#endif
-
-	__ECHO_IN;
-	si->speed = 9600;
-
-	err = request_irq(dev->irq, omap1610_irda_irq, 0, dev->name, dev);
-	if (err)
-		goto err_irq;
-
-	/*
-	 * The interrupt must remain disabled for now.
-	 */
-
-	disable_irq(dev->irq);
-
-	/*  Request DMA channels for IrDA hardware */
-
-	if (omap_request_dma(OMAP_DMA_UART3_RX, "IrDA Rx DMA",
-			     (void *)omap1610_irda_rx_dma_callback,
-			     dev, &(si->rx_dma_channel))) {
-		printk(KERN_ERR "Failed to request IrDA Rx DMA \n");
-		goto err_irq;
-	}
-
-	if (omap_request_dma(OMAP_DMA_UART3_TX, "IrDA Tx DMA",
-			     (void *)omap1610_irda_tx_dma_callback,
-			     dev, &(si->tx_dma_channel))) {
-		printk(KERN_ERR "Failed to request IrDA Tx DMA \n");
-		goto err_irq;
-	}
-
-	/* Allocate TX and RX buffers for DMA channels */
-
-	si->rx_buf_dma_virt =
-	    dma_alloc_coherent(NULL, 4096, &(si->rx_buf_dma_phys), flags);
-
-	si->tx_buf_dma_virt =
-	    dma_alloc_coherent(NULL, 4096, &(si->tx_buf_dma_phys), flags);
-
-	/*
-	 * Setup the serial port for the specified config.
-	 */
-
-#ifdef CONFIG_MACH_OMAP_H3
-
-	if ((err = read_gpio_expa(&ioExpanderVal, 0x26))) {
-		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
-		return err;
-	}
-
-	ioExpanderVal |= 0x40;	/* 'P6' Enable IRDA_TX and IRDA_RX */
-
-	if ((err = write_gpio_expa(ioExpanderVal, 0x26))) {
-		printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-		return err;
-	}
-#endif
-	err = omap1610_irda_startup(dev);
-
-	if (err)
-		goto err_startup;
-
-	omap1610_irda_set_speed(dev, si->speed = 9600);
-
-	/*
-	 * Open a new IrLAP layer instance.
-	 */
-
-	si->irlap = irlap_open(dev, &si->qos, "omap_sir");
-
-	err = -ENOMEM;
-	if (!si->irlap)
-		goto err_irlap;
-
-	/* Now enable the interrupt and start the queue  */
-	si->open = 1;
-
-	/* Start RX DMA */
-
-	omap1610_irda_start_rx_dma(si);
-
-	enable_irq(dev->irq);
-	netif_start_queue(dev);
-
-	__ECHO_OUT;
-
-	return 0;
-
-      err_irlap:
-	si->open = 0;
-	omap1610_irda_shutdown(si);
-      err_startup:
-      err_irq:
-	free_irq(dev->irq, dev);
-	return err;
-}
-
-static int omap1610_irda_stop(struct net_device *dev)
-{
-	struct omap1610_irda *si = dev->priv;
-
-	__ECHO_IN;
-
-	disable_irq(dev->irq);
-
-	netif_stop_queue(dev);
-
-	omap_free_dma(si->rx_dma_channel);
-	omap_free_dma(si->tx_dma_channel);
-
-	dma_free_coherent(NULL, 4096, si->rx_buf_dma_virt, si->rx_buf_dma_phys);
-	dma_free_coherent(NULL, 4096, si->tx_buf_dma_virt, si->tx_buf_dma_phys);
-
-	omap1610_irda_shutdown(si);
-
-	/* Stop IrLAP */
-	if (si->irlap) {
-		irlap_close(si->irlap);
-		si->irlap = NULL;
-	}
-
-	si->open = 0;
-
-	/*
-	 * Free resources
-	 */
-
-	free_irq(dev->irq, dev);
-
-	__ECHO_OUT;
-
-	return 0;
-}
-
-#ifdef CONFIG_MACH_OMAP_H3
-
-static void set_h3_gpio_expa(u8 FIR_SEL, u8 IrDA_INVSEL)
-{
-	u8 ioExpanderVal = 0;
-
-	if (read_gpio_expa(&ioExpanderVal, 0x27) != 0) {
-		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
-		return;
-	}
-
-	ioExpanderVal &= ~0x03;
-	ioExpanderVal |= FIR_SEL << 1;
-	ioExpanderVal |= IrDA_INVSEL << 0;
-
-	if (write_gpio_expa(ioExpanderVal, 0x27) != 0) {
-		printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-		return;
-	}
-	if (read_gpio_expa(&ioExpanderVal, 0x27) != 0) {
-		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
-		return;
-	}
-}
-
-int which_speed;
-
-static void set_h3_gpio_expa_handler(void *data)
-{
-	int *mode = data;
-
-	if (*mode == SIR_MODE)
-		set_h3_gpio_expa(0, 1);
-	else if (*mode == MIR_MODE)
-		set_h3_gpio_expa(1, 1);
-	else if (*mode == FIR_MODE)
-		set_h3_gpio_expa(1, 1);
-}
-
-DECLARE_WORK(set_h3_gpio_expa_work, &set_h3_gpio_expa_handler, &which_speed);
-
-static inline void set_h3_irda_mode(int mode)
-{
-	cancel_delayed_work(&set_h3_gpio_expa_work);
-	which_speed = mode;
-	schedule_work(&set_h3_gpio_expa_work);
-}
-#else
-#define set_h3_irda_mode(x)
-#endif
-
-static int omap1610_irda_set_speed(struct net_device *dev, int speed)
-{
-	struct omap1610_irda *si = dev->priv;
-	int divisor;
-
-	__ECHO_IN;
-
-	/* Set IrDA speed */
-	if (speed <= 115200) {
-		/* SIR mode */
-		if (machine_is_omap_h2()) {
-			omap_set_gpio_dataout(OMAP1610_H2_FIRSEL_GPIO, 0);
-		}
-
-		if (machine_is_omap_h3())
-			set_h3_irda_mode(SIR_MODE);
-
-		printk("Set SIR Mode! Speed: %d\n", speed);
-
-		omap_writeb(1, UART3_MDR1);	/* Set SIR mode */
-
-		omap_writeb(1, UART3_EBLR);
-
-		divisor = 48000000 / (16 * speed);	/* Base clock 48 MHz */
-
-		HDBG2(1);
-		omap_writeb(1 << 7, UART3_LCR);
-
-		omap_writeb((divisor & 0xFF), UART3_DLL);
-
-		omap_writeb((divisor >> 8), UART3_DLH);
-
-		omap_writeb(0x03, UART3_LCR);
-
-		omap_writeb(0, UART3_MCR);
-
-		HDBG2(1);
-
-	} else if (speed <= 1152000) {
-		/* MIR mode */
-		printk("Set MIR Mode! Speed: %d\n", speed);
-
-		omap_writeb((1 << 2) | (1 << 6), UART3_MDR1);	/* Set MIR mode with 
-								   SIP after each frame */
-
-		omap_writeb(2, UART3_EBLR);
-
-		divisor = 48000000 / (41 * speed);	/* Base clock 48 MHz */
-
-		omap_writeb(1 << 7, UART3_LCR);
-
-		omap_writeb((divisor & 0xFF), UART3_DLL);
-
-		omap_writeb((divisor >> 8), UART3_DLH);
-
-		omap_writeb(0x03, UART3_LCR);
-
-		if (machine_is_omap_h2())
-			omap_set_gpio_dataout(OMAP1610_H2_FIRSEL_GPIO, 1);
-
-		if (machine_is_omap_h3())
-			set_h3_irda_mode(MIR_MODE);
-
-	} else {
-		/* FIR mode */
-
-		printk("Set FIR Mode! Speed: %d\n", speed);
-
-		omap_writeb((1 << 2) | (1 << 6) | 1, UART3_MDR1);	/* Set FIR mode
-									   with SIP after each frame */
-		if (machine_is_omap_h2())
-			omap_set_gpio_dataout(OMAP1610_H2_FIRSEL_GPIO, 1);
-
-		if (machine_is_omap_h3())
-			set_h3_irda_mode(FIR_MODE);
-	}
-
-	si->speed = speed;
-
-	__ECHO_OUT;
-
-	return 0;
-
-}
-
-#ifdef CONFIG_PM
-/*
- * Suspend the IrDA interface.
- */
-static int omap1610_irda_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct net_device *dev = platform_get_drvdata(pdev);
-	struct omap1610_irda *si = dev->priv;
-
-	if (!dev)
-		return 0;
-
-	if (si->open) {
-		/*
-		 * Stop the transmit queue
-		 */
-		netif_device_detach(dev);
-		disable_irq(dev->irq);
-		omap1610_irda_shutdown(si);
-	}
-	return 0;
-}
-
-/*
- * Resume the IrDA interface.
- */
-static int omap1610_irda_resume(struct platform_device *pdev)
-{
-	struct net_device *dev = platform_get_drvdata(pdev);
-	struct omap1610_irda *si= dev->priv;
-
-	if (!dev)
-		return 0;
-
-	if (si->open) {
-		/*
-		 * If we missed a speed change, initialise at the new speed
-		 * directly.  It is debatable whether this is actually
-		 * required, but in the interests of continuing from where
-		 * we left off it is desireable.  The converse argument is
-		 * that we should re-negotiate at 9600 baud again.
-		 */
-		if (si->newspeed) {
-			si->speed = si->newspeed;
-			si->newspeed = 0;
-		}
-
-		omap1610_irda_startup(dev);
-		omap1610_irda_set_speed(dev, si->speed);
-		enable_irq(dev->irq);
-
-		/*
-		 * This automatically wakes up the queue
-		 */
-		netif_device_attach(dev);
-	}
-
-	return 0;
-}
-#else
-#define omap1610_irda_suspend	NULL
-#define omap1610_irda_resume	NULL
-#endif
-
-static int omap1610_irda_probe(struct platform_device *pdev)
-{
-	struct net_device *dev;
-	struct omap1610_irda *si;
-	unsigned int baudrate_mask;
-	int err = 0;
-
-	dev = alloc_irdadev(sizeof(struct omap1610_irda));
-	if (!dev)
-		goto err_mem_1;
-
-	si = dev->priv;
-	si->dev = &pdev->dev;
-	dev->hard_start_xmit = omap1610_irda_hard_xmit;
-	dev->open = omap1610_irda_start;
-	dev->stop = omap1610_irda_stop;
-	dev->do_ioctl = omap1610_irda_ioctl;
-	dev->get_stats = omap1610_irda_stats;
-	dev->irq = INT_UART3;
-
-	irda_init_max_qos_capabilies(&si->qos);
-
-	/*
-	 *  OMAP1610  supports SIR, MIR, FIR modes,
-	 *  but actualy supported modes depend on hardware implementation.
-	 *  OMAP1610 Innovator supports only SIR and 
-	 *  OMAP1610 H2 supports both SIR and FIR
-	 */
-
-	baudrate_mask =
-	    IR_9600 | IR_19200 | IR_38400 | IR_57600 | IR_115200 | IR_576000 |
-	    IR_1152000;
-
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-
-		baudrate_mask |= (IR_4000000 << 8);
-	}
-
-	si->qos.baud_rate.bits &= baudrate_mask;
-	si->qos.min_turn_time.bits = 7;
-
-	irda_qos_bits_to_value(&si->qos);
-
-	err = register_netdev(dev);
-	if (!err)
-		platform_set_drvdata(pdev, dev);
-	else 
-		free_netdev(dev);
-
- err_mem_1:
-	return err;
-}
-
-static int omap1610_irda_remove(struct platform_device *pdev)
-{
-	struct net_device *dev = platform_get_drvdata(pdev);
-
-#ifdef CONFIG_MACH_OMAP_H3
-	if (machine_is_omap_h3())
-		cancel_delayed_work(&set_h3_gpio_expa_work);
-#endif
-	if (pdev) {
-		unregister_netdev(dev);
-		free_netdev(dev);
-	}
-	return 0;
-}
-
-static struct platform_driver omap1610ir_driver = {
-	.probe		= omap1610_irda_probe,
-	.remove		= omap1610_irda_remove,
-	.suspend	= omap1610_irda_suspend,
-	.resume		= omap1610_irda_resume,
-	.driver		= {
-		.name	= "omap1610-ir",
-	},
-};
-
-static char __initdata banner[] = "OMAP1610 IrDA driver\n";
-
-static int __init omap1610_irda_init(void)
-{
-	printk(banner);
-	return platform_driver_register(&omap1610ir_driver);
-}
-
-static void __exit omap1610_irda_exit(void)
-{
-	platform_driver_unregister(&omap1610ir_driver);
-}
-
-module_init(omap1610_irda_init);
-module_exit(omap1610_irda_exit);
-
-MODULE_AUTHOR("MontaVista");
-MODULE_DESCRIPTION("OMAP IrDA Driver");
-MODULE_LICENSE("GPL");
-
diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
diff --git a/include/asm-arm/arch-omap/irda.h b/include/asm-arm/arch-omap/irda.h
new file mode 100644
index 0000000..361ed9a
--- /dev/null
+++ b/include/asm-arm/arch-omap/irda.h
@@ -0,0 +1,26 @@
+/*
+ *  linux/include/asm-arm/arch-omap/irda.h
+ *
+ *  Copyright (C) 2005 Komal Shah <komal_shah802003@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASMARM_ARCH_IRDA_H
+#define ASMARM_ARCH_IRDA_H
+
+/* board specific transceiver capabilities */
+
+#define IR_SEL		1	/* Selects IrDA */
+#define IR_SIRMODE	2
+#define IR_FIRMODE	4
+#define IR_MIRMODE	8
+
+struct omap_irda_config {
+	int transceiver_cap;
+	int (*transceiver_mode)(struct device *dev, int state);
+	int (*select_irda)(struct device *dev, int state);
+};
+
+#endif
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index 4ffce1d..42bb4c2 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -242,6 +242,7 @@
 #define INT_24XX_GPIO_BANK2	30
 #define INT_24XX_GPIO_BANK3	31
 #define INT_24XX_GPIO_BANK4	32
+#define INT_24XX_UART3_IRQ	74
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 8d1c62e..9776338 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -410,6 +410,11 @@ enum omap24xx_index {
 	/* 24xx GPIO */
 	Y20_24XX_GPIO60,
 	M15_24XX_GPIO92,
+
+	/* UART3 */
+	K15_24XX_UART3_TX,
+	K14_24XX_UART3_RX,
+
 };
 
 #ifdef	CONFIG_OMAP_MUX

--0-1824423800-1135081271=:44766
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1824423800-1135081271=:44766--
