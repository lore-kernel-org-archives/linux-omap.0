From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: TSC2301 update patches
Date: Mon, 19 Mar 2007 10:55:37 +0200
Message-ID: <20070319105537.54888cfc.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw"
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

This is a multi-part message in MIME format.

--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

First two patches here update recently pushed TSC2301 protocol driver:

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=a7b9b17c9025066cd05f555bbba5542bcf16df3a

Third one will change TSC2301 config names in N800 board files.

I'm sending these as attachments since first one is from Imre. These were generated against ftp://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git tree. I'll test them against mvista tree when cloning is ready...


Jarkko

--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw
Content-Type: text/plain;
	name="0001-TSC2301-touchscreen-fix-error-path-in-driver-probe-function.txt"
Content-Disposition: attachment;
	filename="0001-TSC2301-touchscreen-fix-error-path-in-driver-probe-function.txt"
Content-Transfer-Encoding: 7bit

>From 716687a1a02bab7ee4e600316c27dc51b79e2b79 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@solidboot.com>
Date: Mon, 12 Mar 2007 17:46:25 +0200
Subject: [PATCH] TSC2301 touchscreen: fix error path in driver probe function

Signed-off-by: Imre Deak <imre.deak@solidboot.com>
---
 drivers/spi/tsc2301-ts.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/tsc2301-ts.c b/drivers/spi/tsc2301-ts.c
index da91736..8657b56 100644
--- a/drivers/spi/tsc2301-ts.c
+++ b/drivers/spi/tsc2301-ts.c
@@ -629,19 +629,23 @@ int __devinit tsc2301_ts_init(struct tsc2301 *tsc,
 	}
 	set_irq_wake(ts->irq, 1);
 
-	device_create_file(&tsc->spi->dev, &dev_attr_pen_down);
-	device_create_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	if (device_create_file(&tsc->spi->dev, &dev_attr_pen_down) < 0)
+		goto err4;
+	if (device_create_file(&tsc->spi->dev, &dev_attr_disable_ts) < 0)
+		goto err5;
 
 	r = input_register_device(idev);
 	if (r < 0) {
 		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
-		goto err4;
+		goto err6;
 	}
 
 	return 0;
-err4:
+err6:
 	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+err5:
 	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+err4:
 	free_irq(ts->irq, tsc);
 err3:
 	tsc2301_ts_stop_scan(tsc);
-- 
1.4.4.4


--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw
Content-Type: text/plain;
	name="0002-SPI-Separate-TSC2301-features-under-proper-subsystem-directories.txt"
Content-Disposition: attachment;
	filename="0002-SPI-Separate-TSC2301-features-under-proper-subsystem-directories.txt"
Content-Transfer-Encoding: quoted-printable

>From a3389f31581d6f2dc7f8885e33215a998f8911e0 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Thu, 15 Mar 2007 08:59:47 +0200
Subject: [PATCH] SPI: Separate TSC2301 features under proper subsystem dire=
ctories

Patch moves keypad, touchscreen and audio feature modules of the TSC2301
into kernel directories where those features are maintained. Respective
TSC23001 Kconfig options changed also to be uniform with those subsystems.

Also some minor fixes for removing compilation time warnings and errors in
case if some of the TSC2301 feature is not enabled.

TODO: Make tsc2301-mixer to conform with ASoC.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/input/keyboard/Kconfig         |    6 +
 drivers/input/keyboard/Makefile        |    1 +
 drivers/input/keyboard/tsc2301_kp.c    |  559 +++++++++++++++++
 drivers/input/touchscreen/Kconfig      |    6 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/tsc2301_ts.c |  683 ++++++++++++++++++++
 drivers/spi/Kconfig                    |   20 -
 drivers/spi/Makefile                   |    4 -
 drivers/spi/tsc2301-core.c             |  302 ---------
 drivers/spi/tsc2301-kp.c               |  559 -----------------
 drivers/spi/tsc2301-mixer.c            | 1064 ----------------------------=
----
 drivers/spi/tsc2301-ts.c               |  683 --------------------
 drivers/spi/tsc2301.c                  |  302 +++++++++
 include/linux/spi/tsc2301.h            |    8 +-
 sound/soc/codecs/Kconfig               |    6 +
 sound/soc/codecs/Makefile              |    2 +
 sound/soc/codecs/tsc2301_mixer.c       | 1064 ++++++++++++++++++++++++++++=
++++
 17 files changed, 2634 insertions(+), 2636 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0088e1c..6fefc4d 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -239,4 +239,10 @@ config KEYBOARD_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio-keys.
=20
+config KEYBOARD_TSC2301
+	tristate "TSC2301 keypad support"
+	depends on SPI_TSC2301
+	help
+	  Say Y here for if you are using the keypad features of TSC2301.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makef=
ile
index 17e5ce0..f80aebe 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_KEYBOARD_OMAP)             +=3D omap-keypad.o
 obj-$(CONFIG_OMAP_PS2)			+=3D innovator_ps2.o
 obj-$(CONFIG_KEYBOARD_AAED2000)         +=3D aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+=3D gpio_keys.o
+obj-$(CONFIG_KEYBOARD_TSC2301)		+=3D tsc2301_kp.o
=20
diff --git a/drivers/input/keyboard/tsc2301_kp.c b/drivers/input/keyboard/t=
sc2301_kp.c
new file mode 100644
index 0000000..da14be5
--- /dev/null
+++ b/drivers/input/keyboard/tsc2301_kp.c
@@ -0,0 +1,559 @@
+/*
+ * TSC2301 keypad driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Written by Jarkko Oikarinen
+ * Rewritten by Juha Yrjola <juha.yrjola@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#include <linux/spi/tsc2301.h>
+
+#define TSC2301_KEYBOARD_PRODUCT_ID      0x0051
+#define TSC2301_KEYBOARD_PRODUCT_VERSION 0x0001
+#define TSC2301_DEBOUNCE_TIME_2MS        0x0000
+#define TSC2301_DEBOUNCE_TIME_10MS       0x0800
+#define TSC2301_DEBOUNCE_TIME_20MS       0x1000
+#define TSC2301_DEBOUNCE_TIME_50MS       0x1800
+#define TSC2301_DEBOUNCE_TIME_60MS       0x2000
+#define TSC2301_DEBOUNCE_TIME_80MS       0x2800
+#define TSC2301_DEBOUNCE_TIME_100MS      0x3000
+#define TSC2301_DEBOUNCE_TIME_120MS      0x3800
+
+#define TSC2301_DEBOUNCE_TIME		TSC2301_DEBOUNCE_TIME_20MS
+
+#define TSC2301_POLL_TIME		30
+
+struct tsc2301_kp {
+	struct input_dev	*idev;
+	char			phys[32];
+	spinlock_t		lock;
+	struct mutex		mutex;
+	struct timer_list	timer;
+	u16			keys_pressed;
+	unsigned		pending:1;
+	unsigned		user_disabled:1;
+	unsigned		disable_depth;
+
+	struct spi_transfer	read_xfer[4];
+	struct spi_message	read_msg;
+	u16			state;
+	u16			data;
+	u16			mask;
+
+	int			irq;
+	s16			keymap[16];
+
+	int			(*get_keyb_irq_state)(struct device *dev);
+};
+
+static inline int tsc2301_kp_disabled(struct tsc2301 *tsc)
+{
+	return tsc->kp->disable_depth !=3D 0;
+}
+
+static inline void tsc2301_kp_set_keypressed_state(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+
+	/* kp->state is updated only if we don't have the callback */
+	if (kp->get_keyb_irq_state !=3D NULL) {
+		if (kp->get_keyb_irq_state(&tsc->spi->dev))
+			kp->state =3D 1 << 15;
+		else
+			kp->state =3D 0;
+	}
+}
+
+static inline int tsc2301_kp_key_is_pressed(struct tsc2301 *tsc)
+{
+	return tsc->kp->state & (1 << 15);
+}
+
+static void tsc2301_kp_send_key_events(struct tsc2301 *tsc,
+				       u16 prev_state,
+				       u16 new_state)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+	u16 common, released, pressed;
+	int i;
+
+	common =3D prev_state & new_state;
+	released =3D common ^ prev_state;
+	pressed =3D common ^ new_state;
+	if (!released && !pressed)
+		return;
+	for (i =3D 0; i < 16 && (released || pressed); i++) {
+		if (released & 1) {
+			dev_dbg(&tsc->spi->dev, "key %d released\n", i);
+			input_report_key(kp->idev, kp->keymap[i], 0);
+		}
+		released >>=3D 1;
+		if (pressed & 1) {
+			dev_dbg(&tsc->spi->dev, "key %d pressed\n", i);
+			input_report_key(kp->idev, kp->keymap[i], 1);
+		}
+		pressed >>=3D 1;
+	}
+	input_sync(kp->idev);
+}
+
+static inline void tsc2301_kp_release_all_keys(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+	unsigned long flags;
+	int keys_pressed;
+
+	spin_lock_irqsave(&kp->lock, flags);
+	keys_pressed =3D kp->keys_pressed;
+	kp->keys_pressed =3D 0;
+	spin_unlock_irqrestore(&kp->lock, flags);
+	if (keys_pressed)
+		tsc2301_kp_send_key_events(tsc, keys_pressed, 0);
+}
+
+static inline void _filter_out(struct tsc2301 *tsc, u16 prev_state,
+			       u16 *new_state, int row1, int row2, u8 rect_pat)
+{
+	u16 mask;
+
+	mask =3D (rect_pat << (row1 * 4)) | (rect_pat << (row2 * 4));
+	mask &=3D ~prev_state;
+	*new_state &=3D ~mask;
+	dev_dbg(&tsc->spi->dev, "filtering ghost keys %02x\n", mask);
+}
+
+static void tsc2301_filter_ghost_keys(struct tsc2301 *tsc, u16 prev_state,
+				      u16 *new_state)
+{
+	int row1, row2;
+	u16 key_map;
+	u16 row1_map;
+	static const u8 rect_pat[] =3D {
+		0x3, 0x5, 0x9, 0x6, 0xa, 0xc, 0,
+	};
+
+	key_map =3D *new_state;
+	for (row1 =3D 0; row1 < 4; row1++) {
+		row1_map =3D (key_map >> (row1 * 4)) & 0xf;
+		if (!row1_map)
+			continue;
+		for (row2 =3D row1 + 1; row2 < 4; row2++) {
+			u16 rect_map =3D (key_map >> (row2 * 4)) & 0xf;
+			const u8 *rp;
+
+			rect_map &=3D row1_map;
+			if (!rect_map)
+				continue;
+			for (rp =3D rect_pat; *rp; rp++)
+				if ((rect_map & *rp) =3D=3D *rp)
+					_filter_out(tsc, prev_state, new_state,
+						    row1, row2, *rp);
+		}
+	}
+}
+
+static void tsc2301_kp_timer(unsigned long arg)
+{
+	struct tsc2301 *tsc =3D (void *) arg;
+	int r;
+
+	/* This needs to be done early enough, since reading the key data
+	 * register clears the IRQ line, which may be used to determine
+	 * the key pressed state.
+	 */
+	tsc2301_kp_set_keypressed_state(tsc);
+	r =3D spi_async(tsc->spi, &tsc->kp->read_msg);
+	if (unlikely(r < 0 && printk_ratelimit()))
+		dev_err(&tsc->spi->dev, "kp: spi_async() failed");
+}
+
+static void tsc2301_kp_rx(void *arg)
+{
+	struct tsc2301 *tsc =3D arg;
+	struct tsc2301_kp *kp =3D tsc->kp;
+	unsigned long flags;
+	int key_pressed;
+	u16 kp_data;
+
+	kp_data =3D kp->data;
+	key_pressed =3D tsc2301_kp_key_is_pressed(tsc);
+	dev_dbg(&tsc->spi->dev, "KP data %04x (%s)\n",
+		kp_data, key_pressed ? "pressed" : "not pressed");
+	if (!key_pressed)
+		kp_data =3D 0;
+	else
+		tsc2301_filter_ghost_keys(tsc, kp->keys_pressed, &kp_data);
+	tsc2301_kp_send_key_events(tsc, kp->keys_pressed, kp_data);
+	kp->keys_pressed =3D kp_data;
+	spin_lock_irqsave(&kp->lock, flags);
+	if (likely(!tsc2301_kp_disabled(tsc))) {
+		if (likely(key_pressed))
+			mod_timer(&kp->timer,
+				 jiffies + msecs_to_jiffies(TSC2301_POLL_TIME));
+		else {
+			kp->pending =3D 0;
+			enable_irq(kp->irq);
+		}
+	} else
+		kp->pending =3D 0;
+	spin_unlock_irqrestore(&kp->lock, flags);
+}
+
+static irqreturn_t tsc2301_kp_irq_handler(int irq, void *dev_id)
+{
+	struct tsc2301 *tsc =3D dev_id;
+	struct tsc2301_kp *kp =3D tsc->kp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kp->lock, flags);
+	BUG_ON(kp->pending);
+	if (tsc2301_kp_disabled(tsc)) {
+		spin_unlock_irqrestore(&kp->lock, flags);
+		return IRQ_HANDLED;
+	}
+	kp->pending =3D 1;
+	disable_irq_nosync(irq);
+	spin_unlock_irqrestore(&kp->lock, flags);
+	tsc2301_kp_timer((unsigned long) tsc);
+	return IRQ_HANDLED;
+}
+
+static void tsc2301_kp_start_scan(struct tsc2301 *tsc)
+{
+	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, tsc->kp->mask);
+	tsc2301_write_reg(tsc, TSC2301_REG_KEY, TSC2301_DEBOUNCE_TIME);
+}
+
+static void tsc2301_kp_stop_scan(struct tsc2301 *tsc)
+{
+	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 1 << 14);
+	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, 0xffff);
+}
+
+/* Must be called with the mutex held */
+static void tsc2301_kp_enable(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kp->lock, flags);
+	BUG_ON(!tsc2301_kp_disabled(tsc));
+	if (--kp->disable_depth !=3D 0) {
+		spin_unlock_irqrestore(&kp->lock, flags);
+		return;
+	}
+	if (kp->keys_pressed)
+		kp->pending =3D 1;
+	spin_unlock_irqrestore(&kp->lock, flags);
+
+	set_irq_type(kp->irq, IRQT_FALLING);
+	tsc2301_kp_start_scan(tsc);
+	if (kp->pending)
+		/* continue an interrupted polling */
+		mod_timer(&kp->timer,
+			  jiffies + msecs_to_jiffies(TSC2301_POLL_TIME));
+	else
+		enable_irq(kp->irq);
+}
+
+/* Must be called with the mutex held */
+static int tsc2301_kp_disable(struct tsc2301 *tsc, int release_keys)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kp->lock, flags);
+	if (kp->disable_depth++ !=3D 0) {
+		spin_unlock_irqrestore(&kp->lock, flags);
+		goto out;
+	}
+	if (!kp->pending)
+		disable_irq_nosync(kp->irq);
+
+	while (kp->pending) {
+		spin_unlock_irqrestore(&kp->lock, flags);
+		msleep(1);
+		spin_lock_irqsave(&kp->lock, flags);
+	}
+	spin_unlock_irqrestore(&kp->lock, flags);
+
+	tsc2301_kp_stop_scan(tsc);
+	set_irq_type(kp->irq, IRQT_NOEDGE);
+out:
+	if (release_keys)
+		tsc2301_kp_release_all_keys(tsc);
+
+	return 0;
+}
+
+/* The following workaround is needed for a HW bug triggered by the
+ * following:
+ * 1. keep any key pressed
+ * 2. disable keypad
+ * 3. release all keys
+ * 4. reenable keypad
+ * 5. disable touch screen controller
+ *
+ * After this the keypad scanner will get stuck in busy state and won't
+ * report any interrupts for further keypresses. One way to recover is to
+ * restart the keypad scanner whenever we enable / disable the
+ * touchscreen controller.
+ */
+void tsc2301_kp_restart(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+
+	mutex_lock(&kp->mutex);
+	if (!kp->user_disabled) {
+		tsc2301_kp_disable(tsc, 0);
+		tsc2301_kp_enable(tsc);
+	}
+	mutex_unlock(&kp->mutex);
+}
+
+static ssize_t tsc2301_kp_disable_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", tsc2301_kp_disabled(tsc) ? 1 : 0);
+}
+
+static ssize_t tsc2301_kp_disable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_kp	*kp =3D tsc->kp;
+	char *endp;
+	int i;
+
+	i =3D simple_strtoul(buf, &endp, 10);
+	i =3D i ? 1 : 0;
+
+	mutex_lock(&kp->mutex);
+	if (i =3D=3D kp->user_disabled) {
+		mutex_unlock(&kp->mutex);
+		return count;
+	}
+	kp->user_disabled =3D i;
+
+	if (i)
+		tsc2301_kp_disable(tsc, 1);
+	else
+		tsc2301_kp_enable(tsc);
+	mutex_unlock(&kp->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable_kp, 0664, tsc2301_kp_disable_show,
+		   tsc2301_kp_disable_store);
+
+static const u16 tsc2301_kp_read_data =3D 0x8000 | TSC2301_REG_KPDATA;
+static const u16 tsc2301_kp_read_state =3D 0x8000 | TSC2301_REG_KEY;
+
+static void tsc2301_kp_setup_spi_xfer(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+	struct spi_message *m =3D &kp->read_msg;
+	struct spi_transfer *x =3D &kp->read_xfer[0];
+
+	spi_message_init(&kp->read_msg);
+
+	if (kp->get_keyb_irq_state =3D=3D NULL) {
+		/* No platform specific way for determining the keypress
+		 * state, so we'll need an extra status register read.
+		 */
+		x->tx_buf =3D &tsc2301_kp_read_state;
+		x->len =3D 2;
+		spi_message_add_tail(x, m);
+		x++;
+
+		x->rx_buf =3D &kp->state;
+		x->len =3D 2;
+		x->cs_change =3D 1;
+		spi_message_add_tail(x, m);
+		x++;
+	}
+
+	x->tx_buf =3D &tsc2301_kp_read_data;
+	x->len =3D 2;
+	spi_message_add_tail(x, m);
+	x++;
+
+	x->rx_buf =3D &kp->data;
+	x->len =3D 2;
+	spi_message_add_tail(x, m);
+
+	m->complete =3D tsc2301_kp_rx;
+	m->context =3D tsc;
+}
+
+#ifdef CONFIG_PM
+int tsc2301_kp_suspend(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+
+	mutex_lock(&kp->mutex);
+	tsc2301_kp_disable(tsc, 1);
+	mutex_unlock(&kp->mutex);
+	return 0;
+}
+
+void tsc2301_kp_resume(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+
+	mutex_lock(&kp->mutex);
+	tsc2301_kp_enable(tsc);
+	mutex_unlock(&kp->mutex);
+}
+#endif
+
+int __devinit tsc2301_kp_init(struct tsc2301 *tsc,
+			      struct tsc2301_platform_data *pdata)
+{
+	struct input_dev *idev;
+	struct tsc2301_kp *kp;
+	int r, i;
+	u16 mask;
+
+	if (pdata->keyb_int < 0) {
+		dev_err(&tsc->spi->dev, "need kbirq");
+		return -EINVAL;
+	}
+
+	kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
+	if (kp =3D=3D NULL)
+		return -ENOMEM;
+	tsc->kp =3D kp;
+
+	kp->irq =3D pdata->keyb_int;
+	spin_lock_init(&kp->lock);
+	mutex_init(&kp->mutex);
+
+	init_timer(&kp->timer);
+	kp->timer.data =3D (unsigned long) tsc;
+	kp->timer.function =3D tsc2301_kp_timer;
+
+	kp->get_keyb_irq_state =3D pdata->get_keyb_irq_state;
+
+	idev =3D input_allocate_device();
+	if (idev =3D=3D NULL) {
+		r =3D -ENOMEM;
+		goto err1;
+	}
+	idev->name =3D "TSC2301 keypad";
+	snprintf(kp->phys, sizeof(kp->phys), "%s/input-kp", tsc->spi->dev.bus_id);
+	idev->phys =3D kp->phys;
+
+	mask =3D 0;
+	idev->evbit[0] =3D BIT(EV_KEY);
+	for (i =3D 0; i < 16; i++) {
+		if (pdata->keymap[i] > 0) {
+			set_bit(pdata->keymap[i], idev->keybit);
+			kp->keymap[i] =3D pdata->keymap[i];
+		} else {
+			kp->keymap[i] =3D -1;
+			mask |=3D 1 << i;
+		}
+	}
+
+	if (pdata->kp_rep)
+		set_bit(EV_REP, idev->evbit);
+
+	kp->idev =3D idev;
+
+	tsc2301_kp_setup_spi_xfer(tsc);
+
+	r =3D device_create_file(&tsc->spi->dev, &dev_attr_disable_kp);
+	if (r < 0)
+		goto err2;
+
+	tsc2301_kp_start_scan(tsc);
+
+	/* IRQ mode 0 is faulty, it can cause the KBIRQ to get stuck.
+	 * Mode 2 deasserts the IRQ at:
+	 * - HW or SW reset
+	 * - Setting SCS flag in REG_KEY register
+	 * - Releasing all keys
+	 * - Reading the REG_KPDATA
+	 */
+	tsc2301_write_kbc(tsc, 2);
+
+	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, mask);
+	kp->mask =3D mask;
+
+	set_irq_type(kp->irq, IRQT_FALLING);
+
+	r =3D request_irq(kp->irq, tsc2301_kp_irq_handler, SA_SAMPLE_RANDOM,
+			"tsc2301-kp", tsc);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get kbirq IRQ");
+		goto err3;
+	}
+	set_irq_wake(kp->irq, 1);
+
+	/* We need to read the register once..? */
+	tsc2301_read_reg(tsc, TSC2301_REG_KPDATA);
+
+	r =3D input_register_device(idev);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "can't register keypad device\n");
+		goto err4;
+	}
+
+	return 0;
+
+err4:
+	free_irq(kp->irq, tsc);
+err3:
+	tsc2301_kp_stop_scan(tsc);
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_kp);
+err2:
+	input_free_device(kp->idev);
+err1:
+	kfree(kp);
+	return r;
+}
+
+void __devexit tsc2301_kp_exit(struct tsc2301 *tsc)
+{
+	struct tsc2301_kp *kp =3D tsc->kp;
+
+	tsc2301_kp_disable(tsc, 1);
+	input_unregister_device(kp->idev);
+	free_irq(kp->irq, tsc);
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_kp);
+
+	kfree(kp);
+}
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 6b46c9b..caac4d4 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -159,4 +159,10 @@ config TOUCHSCREEN_UCB1400
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_ts.
=20
+config TOUCHSCREEN_TSC2301
+	tristate "TSC2301 touchscreen support"
+	depends on SPI_TSC2301
+	help
+	  Say Y here for if you are using the touchscreen features of TSC2301.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index 061bc14..ee27e0b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+=3D touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+=3D ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2102)	+=3D tsc2102_ts.o
 obj-$(CONFIG_TOUCHSCREEN_OMAP)	+=3D omap/
+obj-$(CONFIG_TOUCHSCREEN_TSC2301)	+=3D tsc2301_ts.o
diff --git a/drivers/input/touchscreen/tsc2301_ts.c b/drivers/input/touchsc=
reen/tsc2301_ts.c
new file mode 100644
index 0000000..8657b56
--- /dev/null
+++ b/drivers/input/touchscreen/tsc2301_ts.c
@@ -0,0 +1,683 @@
+/*
+ * TSC2301 touchscreen driver
+ *
+ * Copyright (C) 2005-2006 Nokia Corporation
+ *
+ * Written by Jarkko Oikarinen, Imre Deak and Juha Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#include <linux/spi/tsc2301.h>
+
+/**
+ * The touchscreen interface operates as follows:
+ *
+ * Initialize:
+ *    Request access to GPIO103 (DAV)
+ *    tsc2301_dav_irq_handler will trigger when DAV line goes down
+ *
+ *  1) Pen is pressed against touchscreeen
+ *  2) TSC2301 performs AD conversion
+ *  3) After the conversion is done TSC2301 drives DAV line down
+ *  4) GPIO IRQ is received and tsc2301_dav_irq_handler is called
+ *  5) tsc2301_dav_irq_handler sets up tsc2301_ts_timer in TSC2301_TS_SCAN=
_TIME
+ *  6) tsc2301_ts_timer disables the irq and requests spi driver
+ *     to read X, Y, Z1 and Z2
+ *  7) SPI framework calls tsc2301_ts_rx after the coordinates are read
+ *  8) tsc2301_ts_rx reports coordinates to input layer and
+ *     sets up tsc2301_ts_timer to be called after TSC2301_TS_SCAN_TIME
+ *  9) if tsc2301_tx_timer notices that the pen has been lifted, the lift =
event
+ *     is sent, and irq is again enabled.
+ */
+
+
+#define TSC2301_TOUCHSCREEN_PRODUCT_ID      		0x0052
+#define TSC2301_TOUCHSCREEN_PRODUCT_VERSION 		0x0001
+
+#define TSC2301_TS_SCAN_TIME		     		1
+
+#define TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301	0x8000
+#define TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000
+
+#define TSC2301_ADCREG_FUNCTION_NONE			0x0000
+#define TSC2301_ADCREG_FUNCTION_XY			0x0400
+#define TSC2301_ADCREG_FUNCTION_XYZ			0x0800
+#define TSC2301_ADCREG_FUNCTION_X			0x0C00
+#define TSC2301_ADCREG_FUNCTION_Y			0x1000
+#define TSC2301_ADCREG_FUNCTION_Z			0x1400
+#define TSC2301_ADCREG_FUNCTION_DAT1			0x1800
+#define TSC2301_ADCREG_FUNCTION_DAT2			0x1C00
+#define TSC2301_ADCREG_FUNCTION_AUX1			0x2000
+#define TSC2301_ADCREG_FUNCTION_AUX2			0x2400
+#define TSC2301_ADCREG_FUNCTION_TEMP			0x2800
+
+#define TSC2301_ADCREG_RESOLUTION_8BIT			0x0100
+#define TSC2301_ADCREG_RESOLUTION_10BIT			0x0200
+#define TSC2301_ADCREG_RESOLUTION_12BIT			0x0300
+
+#define TSC2301_ADCREG_AVERAGING_NONE			0x0000
+#define TSC2301_ADCREG_AVERAGING_4AVG			0x0040
+#define TSC2301_ADCREG_AVERAGING_8AVG			0x0080
+#define TSC2301_ADCREG_AVERAGING_16AVG			0x00C0
+
+#define TSC2301_ADCREG_CLOCK_8MHZ			0x0000
+#define TSC2301_ADCREG_CLOCK_4MHZ			0x0010
+#define TSC2301_ADCREG_CLOCK_2MHZ			0x0020
+#define TSC2301_ADCREG_CLOCK_1MHZ			0x0030
+
+#define TSC2301_ADCREG_VOLTAGE_STAB_0US			0x0000
+#define TSC2301_ADCREG_VOLTAGE_STAB_100US		0x0002
+#define TSC2301_ADCREG_VOLTAGE_STAB_500US		0x0004
+#define TSC2301_ADCREG_VOLTAGE_STAB_1MS			0x0006
+#define TSC2301_ADCREG_VOLTAGE_STAB_5MS			0x0008
+#define TSC2301_ADCREG_VOLTAGE_STAB_10MS		0x000A
+#define TSC2301_ADCREG_VOLTAGE_STAB_50MS		0x000C
+#define TSC2301_ADCREG_VOLTAGE_STAB_100MS		0x000E
+
+#define TSC2301_ADCREG_STOP_CONVERSION			0x4000
+
+#define MAX_12BIT					((1 << 12) - 1)
+
+struct tsc2301_ts {
+	struct input_dev	*idev;
+	char			phys[32];
+	struct timer_list	timer;
+	spinlock_t		lock;
+
+	struct spi_transfer	read_xfer[2];
+	struct spi_message	read_msg;
+	u16                     data[4];
+
+	int			hw_avg_max;
+	u16			x;
+	u16			y;
+	u16			p;
+	int			sample_cnt;
+
+	int			ignore_last : 1;
+	u16			x_plate_ohm;
+	int			stab_time;
+	int			max_pressure;
+	int			touch_pressure;
+	int			pressure_limit;
+
+	u16			irq_enabled:1;
+	u16			pen_down:1;
+	u16			disabled:1;
+	u16			pending:1;
+
+	int			hw_flags;
+
+	s16			dav_gpio;
+	int			irq;
+};
+
+
+static const u16 tsc2301_ts_read_data =3D 0x8000 | TSC2301_REG_X;
+
+static int tsc2301_ts_check_config(struct tsc2301_ts *ts, int *hw_flags)
+{
+	int flags;
+
+	flags =3D 0;
+	switch (ts->hw_avg_max) {
+	case 0:
+		flags |=3D TSC2301_ADCREG_AVERAGING_NONE;
+		break;
+	case 4:
+		flags |=3D TSC2301_ADCREG_AVERAGING_4AVG;
+		break;
+	case 8:
+		flags |=3D TSC2301_ADCREG_AVERAGING_8AVG;
+		break;
+	case 16:
+		flags |=3D TSC2301_ADCREG_AVERAGING_16AVG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (ts->stab_time) {
+	case 0:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_0US;
+		break;
+	case 100:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_100US;
+		break;
+	case 500:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_500US;
+		break;
+	case 1000:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_1MS;
+		break;
+	case 5000:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_5MS;
+		break;
+	case 10000:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_10MS;
+		break;
+	case 50000:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_50MS;
+		break;
+	case 100000:
+		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*hw_flags =3D flags;
+	return 0;
+}
+
+/*
+ * This odd three-time initialization is to work around a bug in TSC2301.
+ * See TSC2301 errata for details.
+ */
+static int tsc2301_ts_configure(struct tsc2301 *tsc, int flags)
+{
+	struct spi_transfer xfer[3];
+	struct spi_transfer *x;
+	struct spi_message m;
+	int reg =3D TSC2301_REG_ADC;
+	u16 val1, val2, val3;
+	u16 data[6];
+
+	val1 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
+		TSC2301_ADCREG_STOP_CONVERSION |
+		TSC2301_ADCREG_FUNCTION_NONE |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_AVERAGING_NONE |
+		TSC2301_ADCREG_CLOCK_2MHZ |
+		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+
+	val2 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
+		TSC2301_ADCREG_FUNCTION_XYZ |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_AVERAGING_16AVG |
+		TSC2301_ADCREG_CLOCK_1MHZ |
+		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
+
+	/* Averaging and voltage stabilization settings in flags */
+	val3 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301 |
+		TSC2301_ADCREG_FUNCTION_XYZ |
+		TSC2301_ADCREG_RESOLUTION_12BIT |
+		TSC2301_ADCREG_CLOCK_1MHZ |
+		flags;
+
+	/* Now we prepare the command for transferring */
+	data[0] =3D reg;
+	data[1] =3D val1;
+	data[2] =3D reg;
+	data[3] =3D val2;
+	data[4] =3D reg;
+	data[5] =3D val3;
+
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	memset(xfer, 0, sizeof(xfer));
+	x =3D &xfer[0];
+
+	x->tx_buf =3D &data[0];
+	x->len =3D 4;
+	x->cs_change =3D 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf =3D &data[2];
+	x->len =3D 4;
+	x->cs_change =3D 1;
+	spi_message_add_tail(x, &m);
+
+	x++;
+	x->tx_buf =3D &data[4];
+	x->len =3D 4;
+	spi_message_add_tail(x, &m);
+
+	spi_sync(m.spi, &m);
+
+	return 0;
+}
+
+static void tsc2301_ts_start_scan(struct tsc2301 *tsc)
+{
+	tsc2301_ts_configure(tsc, tsc->ts->hw_flags);
+}
+
+static void tsc2301_ts_stop_scan(struct tsc2301 *tsc)
+{
+	tsc2301_ts_configure(tsc, TSC2301_ADCREG_STOP_CONVERSION);
+}
+
+static int device_suspended(struct device *dev)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	return dev->power.power_state.event !=3D PM_EVENT_ON || tsc->ts->disabled;
+}
+
+static void update_pen_state(struct tsc2301_ts *ts, int x, int y, int pres=
sure)
+{
+	int sync =3D 0;
+
+	if (pressure) {
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
+		if (!ts->pen_down)
+			input_report_key(ts->idev, BTN_TOUCH, 1);
+		sync =3D 1;
+	} else if (ts->pen_down) {
+		input_report_abs(ts->idev, ABS_PRESSURE, 0);
+		input_report_key(ts->idev, BTN_TOUCH, 0);
+		sync =3D 1;
+	}
+
+	if (sync)
+		input_sync(ts->idev);
+
+	ts->pen_down =3D pressure ? 1 : 0;
+#ifdef VERBOSE
+	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);
+#endif
+}
+
+/*
+ * This procedure is called by the SPI framework after the coordinates
+ * have been read from TSC2301
+ */
+static void tsc2301_ts_rx(void *arg)
+{
+	struct tsc2301 *tsc =3D arg;
+	struct tsc2301_ts *ts =3D tsc->ts;
+	unsigned int x, y, z1, z2, pressure;
+
+	x  =3D ts->data[0];
+	y  =3D ts->data[1];
+	z1 =3D ts->data[2];
+	z2 =3D ts->data[3];
+
+	if (z1) {
+		pressure =3D ts->x_plate_ohm * x;
+		pressure /=3D 4096;
+		pressure *=3D z2 - z1;
+		pressure /=3D z1;
+	} else
+		pressure =3D 0;
+
+	/* If pressure value is above a preset limit (pen is barely
+	 * touching the screen) we can't trust the coordinate values.
+	 */
+	if (pressure < ts->pressure_limit && x < MAX_12BIT && y < MAX_12BIT) {
+		ts->pressure_limit =3D ts->max_pressure;
+		if (ts->ignore_last) {
+			if (ts->sample_cnt)
+				update_pen_state(ts, ts->x, ts->y, ts->p);
+			ts->x =3D x;
+			ts->y =3D y;
+			ts->p =3D pressure;
+		} else
+			update_pen_state(ts, x, y, pressure);
+		ts->sample_cnt++;
+	}
+
+	mod_timer(&ts->timer,
+		  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
+}
+
+static int is_pen_down(struct tsc2301_ts *ts)
+{
+	return ts->pen_down;
+}
+
+/*
+ * Timer is called every TSC2301_TS_SCAN_TIME when the pen is down
+ */
+static void tsc2301_ts_timer(unsigned long arg)
+{
+	struct tsc2301 *tsc =3D (void *) arg;
+	struct tsc2301_ts *ts =3D tsc->ts;
+	unsigned long flags;
+	int ndav;
+	int r;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	ndav =3D omap_get_gpio_datain(ts->dav_gpio);
+	if (ndav || device_suspended(&tsc->spi->dev)) {
+		/* Pen has been lifted */
+		if (!device_suspended(&tsc->spi->dev)) {
+			ts->irq_enabled =3D 1;
+			enable_irq(ts->irq);
+		}
+		update_pen_state(ts, 0, 0, 0);
+		ts->pending =3D 0;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+	} else {
+		ts->pen_down =3D 1;
+		spin_unlock_irqrestore(&ts->lock, flags);
+
+		r =3D spi_async(tsc->spi, &ts->read_msg);
+		if (r)
+			dev_err(&tsc->spi->dev, "ts: spi_async() failed");
+	}
+}
+
+/*
+ * This interrupt is called when pen is down and first coordinates are
+ * available. That is indicated by a falling edge on DEV line.  IRQ is
+ * disabled here because while the pen is down the coordinates are
+ * read by a timer.
+ */
+static irqreturn_t tsc2301_ts_irq_handler(int irq, void *dev_id)
+{
+	struct tsc2301 *tsc =3D dev_id;
+	struct tsc2301_ts *ts =3D tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (ts->irq_enabled) {
+		ts->irq_enabled =3D 0;
+		disable_irq(ts->irq);
+		ts->pending =3D 1;
+		ts->pressure_limit =3D ts->touch_pressure;
+		ts->sample_cnt =3D 0;
+		mod_timer(&ts->timer,
+			  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
+	}
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+/* Must be called with ts->lock held */
+static void tsc2301_ts_disable(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+
+	if (ts->disabled)
+		return;
+
+	ts->disabled =3D 1;
+	if (!ts->pending) {
+		ts->irq_enabled =3D 0;
+		disable_irq(ts->irq);
+	} else {
+		while (ts->pending) {
+			spin_unlock_irq(&ts->lock);
+			msleep(1);
+			spin_lock_irq(&ts->lock);
+		}
+	}
+
+	spin_unlock_irq(&ts->lock);
+	tsc2301_ts_stop_scan(tsc);
+	/* Workaround a bug where turning on / off touchscreen scanner
+	 * can get the keypad scanner stuck.
+	 */
+	tsc2301_kp_restart(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+static void tsc2301_ts_enable(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+
+	if (!ts->disabled)
+		return;
+
+	ts->disabled =3D 0;
+	ts->irq_enabled =3D 1;
+	enable_irq(ts->irq);
+
+	spin_unlock_irq(&ts->lock);
+	tsc2301_ts_start_scan(tsc);
+	/* Same workaround as above. */
+	tsc2301_kp_restart(tsc);
+	spin_lock_irq(&ts->lock);
+}
+
+#ifdef CONFIG_PM
+int tsc2301_ts_suspend(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2301_ts_disable(tsc);
+	spin_unlock_irq(&ts->lock);
+
+	return 0;
+}
+
+void tsc2301_ts_resume(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+
+	spin_lock_irq(&ts->lock);
+	tsc2301_ts_enable(tsc);
+	spin_unlock_irq(&ts->lock);
+}
+#endif
+
+static void tsc2301_ts_setup_spi_xfer(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+	struct spi_message *m =3D &ts->read_msg;
+	struct spi_transfer *x =3D &ts->read_xfer[0];
+
+	spi_message_init(m);
+
+	x->tx_buf =3D &tsc2301_ts_read_data;
+	x->len =3D 2;
+	spi_message_add_tail(x, m);
+
+	x++;
+	x->rx_buf =3D &ts->data;
+	x->len =3D 8;
+	spi_message_add_tail(x, m);
+
+	m->complete =3D tsc2301_ts_rx;
+	m->context =3D tsc;
+}
+
+static ssize_t tsc2301_ts_pen_down_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));
+}
+
+static DEVICE_ATTR(pen_down, S_IRUGO, tsc2301_ts_pen_down_show, NULL);
+
+static ssize_t tsc2301_ts_disable_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_ts	*ts =3D tsc->ts;
+
+	return sprintf(buf, "%u\n", ts->disabled);
+}
+
+static ssize_t tsc2301_ts_disable_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_ts	*ts =3D tsc->ts;
+	char *endp;
+	int i;
+
+	i =3D simple_strtoul(buf, &endp, 10);
+	spin_lock_irq(&ts->lock);
+
+	if (i)
+		tsc2301_ts_disable(tsc);
+	else
+		tsc2301_ts_enable(tsc);
+
+	spin_unlock_irq(&ts->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable_ts, 0664, tsc2301_ts_disable_show,
+		   tsc2301_ts_disable_store);
+
+int __devinit tsc2301_ts_init(struct tsc2301 *tsc,
+			      struct tsc2301_platform_data *pdata)
+{
+	struct tsc2301_ts *ts;
+	struct input_dev *idev;
+	int dav_gpio, r;
+
+	if (pdata->dav_gpio < 0) {
+		dev_err(&tsc->spi->dev, "need DAV GPIO");
+		return -EINVAL;
+	}
+	dav_gpio =3D pdata->dav_gpio;
+
+	ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (ts =3D=3D NULL)
+		return -ENOMEM;
+	tsc->ts =3D ts;
+
+	ts->dav_gpio =3D dav_gpio;
+#ifdef CONFIG_ARCH_OMAP
+	r =3D omap_request_gpio(dav_gpio);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
+		goto err1;
+	}
+	omap_set_gpio_direction(dav_gpio, 1);
+	ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);
+#endif
+	init_timer(&ts->timer);
+	ts->timer.data =3D (unsigned long) tsc;
+	ts->timer.function =3D tsc2301_ts_timer;
+
+	spin_lock_init(&ts->lock);
+
+	ts->x_plate_ohm	=3D pdata->ts_x_plate_ohm ? : 280;
+	ts->hw_avg_max	=3D pdata->ts_hw_avg;
+	ts->max_pressure=3D pdata->ts_max_pressure ? : MAX_12BIT;
+	ts->touch_pressure =3D pdata->ts_touch_pressure ? : ts->max_pressure;
+	ts->ignore_last	=3D pdata->ts_ignore_last;
+	ts->stab_time	=3D pdata->ts_stab_time;
+
+	if ((r =3D tsc2301_ts_check_config(ts, &ts->hw_flags))) {
+		dev_err(&tsc->spi->dev, "invalid configuration\n");
+		goto err2;
+	}
+
+	idev =3D input_allocate_device();
+	if (idev =3D=3D NULL) {
+		r =3D -ENOMEM;
+		goto err2;
+	}
+	idev->name =3D "TSC2301 touchscreen";
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input-ts", tsc->spi->dev.bus_id);
+	idev->phys =3D ts->phys;
+
+	idev->evbit[0] =3D BIT(EV_ABS) | BIT(EV_KEY);
+	idev->absbit[0] =3D BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	ts->idev =3D idev;
+
+	tsc2301_ts_setup_spi_xfer(tsc);
+
+	/* These parameters should perhaps be configurable? */
+	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
+	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
+
+	tsc2301_ts_start_scan(tsc);
+
+	ts->irq_enabled =3D 1;
+	r =3D request_irq(ts->irq, tsc2301_ts_irq_handler,
+			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
+			"tsc2301-ts", tsc);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
+		goto err3;
+	}
+	set_irq_wake(ts->irq, 1);
+
+	if (device_create_file(&tsc->spi->dev, &dev_attr_pen_down) < 0)
+		goto err4;
+	if (device_create_file(&tsc->spi->dev, &dev_attr_disable_ts) < 0)
+		goto err5;
+
+	r =3D input_register_device(idev);
+	if (r < 0) {
+		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
+		goto err6;
+	}
+
+	return 0;
+err6:
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+err5:
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+err4:
+	free_irq(ts->irq, tsc);
+err3:
+	tsc2301_ts_stop_scan(tsc);
+	input_free_device(idev);
+err2:
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(dav_gpio);
+#endif
+err1:
+	kfree(ts);
+	return r;
+}
+
+void __devexit tsc2301_ts_exit(struct tsc2301 *tsc)
+{
+	struct tsc2301_ts *ts =3D tsc->ts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	tsc2301_ts_disable(tsc);
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
+	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
+
+	free_irq(ts->irq, tsc);
+	input_unregister_device(ts->idev);
+
+#ifdef CONFIG_ARCH_OMAP
+	omap_free_gpio(ts->dav_gpio);
+#endif
+	kfree(ts);
+}
+MODULE_AUTHOR("Jarkko Oikarinen <jarkko.oikarinen@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c98392c..1c86de7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -183,26 +183,6 @@ config SPI_TSC2301
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2301.
=20
-config SPI_TSC2301_KEYPAD
-	boolean "TSC2301 keypad support"
-	depends on SPI_TSC2301
-	select INPUT_KEYBOARD
-	help
-	  Say Y here for if you are using the keypad features of TSC2301.
-
-config SPI_TSC2301_TOUCHSCREEN
-	boolean "TSC2301 touchscreen support"
-	depends on SPI_TSC2301
-	select INPUT_TOUCHSCREEN
-	help
-	  Say Y here for if you are using the touchscreen features of TSC2301.
-
-config SPI_TSC2301_AUDIO
-	boolean "TSC2301 audio support"
-	depends on SPI_TSC2301 && SND
-	help
-	  Say Y here for if you are using the audio features of TSC2301.
-
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bfa8ea3..a1ce7d0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -27,10 +27,6 @@ obj-$(CONFIG_SPI_OMAP_UWIRE)		+=3D omap_uwire.o
 obj-$(CONFIG_TSC2102)			+=3D tsc2102.o
 obj-$(CONFIG_SPI_AT25)		+=3D at25.o
 obj-$(CONFIG_SPI_TSC2301)		+=3D tsc2301.o
-tsc2301-objs					:=3D tsc2301-core.o
-tsc2301-$(CONFIG_SPI_TSC2301_TOUCHSCREEN)	+=3D tsc2301-ts.o
-tsc2301-$(CONFIG_SPI_TSC2301_KEYPAD)		+=3D tsc2301-kp.o
-tsc2301-$(CONFIG_SPI_TSC2301_AUDIO)		+=3D tsc2301-mixer.o
 # 	... add above this line ...
=20
 # SPI slave controller drivers (upstream link)
diff --git a/drivers/spi/tsc2301-core.c b/drivers/spi/tsc2301-core.c
deleted file mode 100644
index ae15ca9..0000000
--- a/drivers/spi/tsc2301-core.c
+++ /dev/null
@@ -1,302 +0,0 @@
-/*
- * TSC2301 driver
- *
- * Copyright (C) 2005, 2006 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/tsc2301.h>
-
-#ifdef CONFIG_ARCH_OMAP
-#include <asm/arch/gpio.h>
-#endif
-
-u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
-{
-	struct spi_transfer t[2];
-	struct spi_message m;
-	u16 data =3D 0, cmd;
-
-	cmd =3D reg;
-	cmd |=3D 0x8000;
-
-	memset(t, 0, sizeof(t));
-	spi_message_init(&m);
-	m.spi =3D tsc->spi;
-
-	t[0].tx_buf =3D &cmd;
-	t[0].rx_buf =3D NULL;
-	t[0].len =3D 2;
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf =3D NULL;
-	t[1].rx_buf =3D &data;
-	t[1].len =3D 2;
-	spi_message_add_tail(&t[1], &m);
-
-	spi_sync(m.spi, &m);
-
-	return data;
-}
-
-void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u16 data[2];
-
-	/* Now we prepare the command for transferring */
-	data[0] =3D reg;
-	data[1] =3D val;
-
-	spi_message_init(&m);
-	m.spi =3D tsc->spi;
-
-	memset(&t, 0, sizeof(t));
-	t.tx_buf =3D data;
-	t.rx_buf =3D NULL;
-	t.len =3D 4;
-	spi_message_add_tail(&t, &m);
-
-	spi_sync(m.spi, &m);
-}
-
-void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
-{
-	u16 w;
-
-	w =3D tsc->config2_shadow;
-	w &=3D ~(0x03 << 14);
-	w |=3D (val & 0x03) << 14;
-	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
-	tsc->config2_shadow =3D w;
-}
-
-void tsc2301_write_pll(struct tsc2301 *tsc,
-		       int pll_n, int pll_a, int pll_pdc, int pct_e, int pll_o)
-{
-	u16 w;
-
-	w =3D tsc->config2_shadow;
-	w &=3D ~0x3fff;
-	w |=3D (pll_n & 0x0f) | ((pll_a & 0x0f) << 4) | ((pll_pdc & 0x0f) << 8);
-	w |=3D pct_e ? (1 << 12) : 0;
-	w |=3D pll_o ? (1 << 13) : 0;
-	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
-	tsc->config2_shadow =3D w;
-}
-
-void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *rx_buf, int len)
-{
-	struct spi_transfer t[2];
-	struct spi_message m;
-	u16 cmd, i;
-
-	cmd =3D reg;
-	cmd |=3D 0x8000;
-
-	spi_message_init(&m);
-	m.spi =3D tsc->spi;
-
-	memset(t, 0, sizeof(t));
-	t[0].tx_buf =3D &cmd;
-	t[0].rx_buf =3D NULL;
-	t[0].len =3D 2;
-	spi_message_add_tail(&t[0], &m);
-
-	t[1].tx_buf =3D NULL;
-	t[1].rx_buf =3D rx_buf;
-	t[1].len =3D 2 * len;
-	spi_message_add_tail(&t[1], &m);
-
-	spi_sync(m.spi, &m);
-
-	for (i =3D 0; i < len; i++)
-		printk(KERN_DEBUG "rx_buf[%d]: %04x\n", i, rx_buf[i]);
-}
-
-static int __devinit tsc2301_probe(struct spi_device *spi)
-{
-	struct tsc2301			*tsc;
-	struct tsc2301_platform_data	*pdata =3D spi->dev.platform_data;
-	int r;
-	u16 w;
-
-	if (!pdata) {
-		dev_dbg(&spi->dev, "no platform data?\n");
-		return -ENODEV;
-	}
-
-	tsc =3D kzalloc(sizeof(*tsc), GFP_KERNEL);
-	if (tsc =3D=3D NULL)
-		return -ENOMEM;
-
-	dev_set_drvdata(&spi->dev, tsc);
-	tsc->spi =3D spi;
-	spi->dev.power.power_state =3D PMSG_ON;
-
-	tsc->enable_clock =3D pdata->enable_clock;
-	tsc->disable_clock =3D pdata->disable_clock;
-
-	if (pdata->reset_gpio >=3D 0) {
-		tsc->reset_gpio =3D pdata->reset_gpio;
-#ifdef CONFIG_ARCH_OMAP
-		r =3D omap_request_gpio(tsc->reset_gpio);
-		if (r < 0)
-			goto err1;
-		omap_set_gpio_dataout(tsc->reset_gpio, 1);
-		omap_set_gpio_direction(tsc->reset_gpio, 0);
-		mdelay(1);
-		omap_set_gpio_dataout(tsc->reset_gpio, 0);
-#endif
-	} else
-		tsc->reset_gpio =3D -1;
-
-	spi->mode =3D SPI_MODE_0;
-	spi->bits_per_word =3D 16;
-	/* The max speed might've been defined by the board-specific
-	 * struct */
-	if (!spi->max_speed_hz)
-		spi->max_speed_hz =3D TSC2301_HZ;
-	spi_setup(spi);
-
-	/* Soft reset */
-	tsc2301_write_reg(tsc, TSC2301_REG_RESET, 0xbb00);
-	msleep(1);
-
-	w =3D tsc2301_read_reg(tsc, TSC2301_REG_ADC);
-	if (!(w & (1 << 14))) {
-		dev_err(&spi->dev, "invalid ADC reg value: %04x\n", w);
-		r =3D -ENODEV;
-		goto err1;
-	}
-
-	w =3D tsc2301_read_reg(tsc, TSC2301_REG_DAC);
-	if (!(w & (1 << 15))) {
-		dev_err(&spi->dev, "invalid DAC reg value: %04x\n", w);
-		r =3D -ENODEV;
-		goto err1;
-	}
-
-	/* Stop keypad scanning */
-	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 0x4000);
-
-	/* We have to cache this for read-modify-write, since we can't
-	 * read back BIT15 */
-	w =3D tsc2301_read_reg(tsc, TSC2301_REG_CONFIG2);
-	/* By default BIT15 is set */
-	w |=3D 1 << 15;
-	tsc->config2_shadow =3D w;
-
-	r =3D tsc2301_kp_init(tsc, pdata);
-	if (r)
-		goto err1;
-	r =3D tsc2301_ts_init(tsc, pdata);
-	if (r)
-		goto err2;
-	r =3D tsc2301_mixer_init(tsc, pdata);
-	if (r)
-		goto err3;
-	return 0;
-
-err3:
-	tsc2301_ts_exit(tsc);
-err2:
-	tsc2301_kp_exit(tsc);
-err1:
-	kfree(tsc);
-	return r;
-}
-
-static int __devexit tsc2301_remove(struct spi_device *spi)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
-
-	tsc2301_mixer_exit(tsc);
-        tsc2301_ts_exit(tsc);
-        tsc2301_kp_exit(tsc);
-	kfree(tsc);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int tsc2301_suspend(struct spi_device *spi, pm_message_t mesg)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
-	int r;
-
-	if ((r =3D tsc2301_mixer_suspend(tsc)) < 0)
-		return r;
-	if ((r =3D tsc2301_kp_suspend(tsc)) < 0)
-		goto err1;
-	if ((r =3D tsc2301_ts_suspend(tsc)) < 0)
-		goto err2;
-
-	return 0;
-err2:
-	tsc2301_kp_resume(tsc);
-err1:
-	tsc2301_mixer_resume(tsc);
-	return r;
-}
-
-static int tsc2301_resume(struct spi_device *spi)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
-
-	tsc2301_ts_resume(tsc);
-	tsc2301_kp_resume(tsc);
-	tsc2301_mixer_resume(tsc);
-	return 0;
-}
-#endif
-
-static struct spi_driver tsc2301_driver =3D {
-	.driver =3D {
-		   .name =3D "tsc2301",
-		   .bus =3D &spi_bus_type,
-		   .owner =3D THIS_MODULE,
-	},
-#ifdef CONFIG_PM
-	.suspend =3D tsc2301_suspend,
-	.resume =3D tsc2301_resume,
-#endif
-	.probe =3D tsc2301_probe,
-	.remove =3D __devexit_p(tsc2301_remove),
-};
-
-static int __init tsc2301_init(void)
-{
-	printk("TSC2301 driver initializing\n");
-
-	return spi_register_driver(&tsc2301_driver);
-}
-module_init(tsc2301_init);
-
-static void __exit tsc2301_exit(void)
-{
-	spi_unregister_driver(&tsc2301_driver);
-}
-module_exit(tsc2301_exit);
-
-MODULE_AUTHOR("Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301-kp.c b/drivers/spi/tsc2301-kp.c
deleted file mode 100644
index da14be5..0000000
--- a/drivers/spi/tsc2301-kp.c
+++ /dev/null
@@ -1,559 +0,0 @@
-/*
- * TSC2301 keypad driver
- *
- * Copyright (C) 2005-2006 Nokia Corporation
- *
- * Written by Jarkko Oikarinen
- * Rewritten by Juha Yrjola <juha.yrjola@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/spi/spi.h>
-
-#ifdef CONFIG_ARCH_OMAP
-#include <asm/arch/gpio.h>
-#endif
-
-#include <linux/spi/tsc2301.h>
-
-#define TSC2301_KEYBOARD_PRODUCT_ID      0x0051
-#define TSC2301_KEYBOARD_PRODUCT_VERSION 0x0001
-#define TSC2301_DEBOUNCE_TIME_2MS        0x0000
-#define TSC2301_DEBOUNCE_TIME_10MS       0x0800
-#define TSC2301_DEBOUNCE_TIME_20MS       0x1000
-#define TSC2301_DEBOUNCE_TIME_50MS       0x1800
-#define TSC2301_DEBOUNCE_TIME_60MS       0x2000
-#define TSC2301_DEBOUNCE_TIME_80MS       0x2800
-#define TSC2301_DEBOUNCE_TIME_100MS      0x3000
-#define TSC2301_DEBOUNCE_TIME_120MS      0x3800
-
-#define TSC2301_DEBOUNCE_TIME		TSC2301_DEBOUNCE_TIME_20MS
-
-#define TSC2301_POLL_TIME		30
-
-struct tsc2301_kp {
-	struct input_dev	*idev;
-	char			phys[32];
-	spinlock_t		lock;
-	struct mutex		mutex;
-	struct timer_list	timer;
-	u16			keys_pressed;
-	unsigned		pending:1;
-	unsigned		user_disabled:1;
-	unsigned		disable_depth;
-
-	struct spi_transfer	read_xfer[4];
-	struct spi_message	read_msg;
-	u16			state;
-	u16			data;
-	u16			mask;
-
-	int			irq;
-	s16			keymap[16];
-
-	int			(*get_keyb_irq_state)(struct device *dev);
-};
-
-static inline int tsc2301_kp_disabled(struct tsc2301 *tsc)
-{
-	return tsc->kp->disable_depth !=3D 0;
-}
-
-static inline void tsc2301_kp_set_keypressed_state(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-
-	/* kp->state is updated only if we don't have the callback */
-	if (kp->get_keyb_irq_state !=3D NULL) {
-		if (kp->get_keyb_irq_state(&tsc->spi->dev))
-			kp->state =3D 1 << 15;
-		else
-			kp->state =3D 0;
-	}
-}
-
-static inline int tsc2301_kp_key_is_pressed(struct tsc2301 *tsc)
-{
-	return tsc->kp->state & (1 << 15);
-}
-
-static void tsc2301_kp_send_key_events(struct tsc2301 *tsc,
-				       u16 prev_state,
-				       u16 new_state)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-	u16 common, released, pressed;
-	int i;
-
-	common =3D prev_state & new_state;
-	released =3D common ^ prev_state;
-	pressed =3D common ^ new_state;
-	if (!released && !pressed)
-		return;
-	for (i =3D 0; i < 16 && (released || pressed); i++) {
-		if (released & 1) {
-			dev_dbg(&tsc->spi->dev, "key %d released\n", i);
-			input_report_key(kp->idev, kp->keymap[i], 0);
-		}
-		released >>=3D 1;
-		if (pressed & 1) {
-			dev_dbg(&tsc->spi->dev, "key %d pressed\n", i);
-			input_report_key(kp->idev, kp->keymap[i], 1);
-		}
-		pressed >>=3D 1;
-	}
-	input_sync(kp->idev);
-}
-
-static inline void tsc2301_kp_release_all_keys(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-	unsigned long flags;
-	int keys_pressed;
-
-	spin_lock_irqsave(&kp->lock, flags);
-	keys_pressed =3D kp->keys_pressed;
-	kp->keys_pressed =3D 0;
-	spin_unlock_irqrestore(&kp->lock, flags);
-	if (keys_pressed)
-		tsc2301_kp_send_key_events(tsc, keys_pressed, 0);
-}
-
-static inline void _filter_out(struct tsc2301 *tsc, u16 prev_state,
-			       u16 *new_state, int row1, int row2, u8 rect_pat)
-{
-	u16 mask;
-
-	mask =3D (rect_pat << (row1 * 4)) | (rect_pat << (row2 * 4));
-	mask &=3D ~prev_state;
-	*new_state &=3D ~mask;
-	dev_dbg(&tsc->spi->dev, "filtering ghost keys %02x\n", mask);
-}
-
-static void tsc2301_filter_ghost_keys(struct tsc2301 *tsc, u16 prev_state,
-				      u16 *new_state)
-{
-	int row1, row2;
-	u16 key_map;
-	u16 row1_map;
-	static const u8 rect_pat[] =3D {
-		0x3, 0x5, 0x9, 0x6, 0xa, 0xc, 0,
-	};
-
-	key_map =3D *new_state;
-	for (row1 =3D 0; row1 < 4; row1++) {
-		row1_map =3D (key_map >> (row1 * 4)) & 0xf;
-		if (!row1_map)
-			continue;
-		for (row2 =3D row1 + 1; row2 < 4; row2++) {
-			u16 rect_map =3D (key_map >> (row2 * 4)) & 0xf;
-			const u8 *rp;
-
-			rect_map &=3D row1_map;
-			if (!rect_map)
-				continue;
-			for (rp =3D rect_pat; *rp; rp++)
-				if ((rect_map & *rp) =3D=3D *rp)
-					_filter_out(tsc, prev_state, new_state,
-						    row1, row2, *rp);
-		}
-	}
-}
-
-static void tsc2301_kp_timer(unsigned long arg)
-{
-	struct tsc2301 *tsc =3D (void *) arg;
-	int r;
-
-	/* This needs to be done early enough, since reading the key data
-	 * register clears the IRQ line, which may be used to determine
-	 * the key pressed state.
-	 */
-	tsc2301_kp_set_keypressed_state(tsc);
-	r =3D spi_async(tsc->spi, &tsc->kp->read_msg);
-	if (unlikely(r < 0 && printk_ratelimit()))
-		dev_err(&tsc->spi->dev, "kp: spi_async() failed");
-}
-
-static void tsc2301_kp_rx(void *arg)
-{
-	struct tsc2301 *tsc =3D arg;
-	struct tsc2301_kp *kp =3D tsc->kp;
-	unsigned long flags;
-	int key_pressed;
-	u16 kp_data;
-
-	kp_data =3D kp->data;
-	key_pressed =3D tsc2301_kp_key_is_pressed(tsc);
-	dev_dbg(&tsc->spi->dev, "KP data %04x (%s)\n",
-		kp_data, key_pressed ? "pressed" : "not pressed");
-	if (!key_pressed)
-		kp_data =3D 0;
-	else
-		tsc2301_filter_ghost_keys(tsc, kp->keys_pressed, &kp_data);
-	tsc2301_kp_send_key_events(tsc, kp->keys_pressed, kp_data);
-	kp->keys_pressed =3D kp_data;
-	spin_lock_irqsave(&kp->lock, flags);
-	if (likely(!tsc2301_kp_disabled(tsc))) {
-		if (likely(key_pressed))
-			mod_timer(&kp->timer,
-				 jiffies + msecs_to_jiffies(TSC2301_POLL_TIME));
-		else {
-			kp->pending =3D 0;
-			enable_irq(kp->irq);
-		}
-	} else
-		kp->pending =3D 0;
-	spin_unlock_irqrestore(&kp->lock, flags);
-}
-
-static irqreturn_t tsc2301_kp_irq_handler(int irq, void *dev_id)
-{
-	struct tsc2301 *tsc =3D dev_id;
-	struct tsc2301_kp *kp =3D tsc->kp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&kp->lock, flags);
-	BUG_ON(kp->pending);
-	if (tsc2301_kp_disabled(tsc)) {
-		spin_unlock_irqrestore(&kp->lock, flags);
-		return IRQ_HANDLED;
-	}
-	kp->pending =3D 1;
-	disable_irq_nosync(irq);
-	spin_unlock_irqrestore(&kp->lock, flags);
-	tsc2301_kp_timer((unsigned long) tsc);
-	return IRQ_HANDLED;
-}
-
-static void tsc2301_kp_start_scan(struct tsc2301 *tsc)
-{
-	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, tsc->kp->mask);
-	tsc2301_write_reg(tsc, TSC2301_REG_KEY, TSC2301_DEBOUNCE_TIME);
-}
-
-static void tsc2301_kp_stop_scan(struct tsc2301 *tsc)
-{
-	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 1 << 14);
-	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, 0xffff);
-}
-
-/* Must be called with the mutex held */
-static void tsc2301_kp_enable(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&kp->lock, flags);
-	BUG_ON(!tsc2301_kp_disabled(tsc));
-	if (--kp->disable_depth !=3D 0) {
-		spin_unlock_irqrestore(&kp->lock, flags);
-		return;
-	}
-	if (kp->keys_pressed)
-		kp->pending =3D 1;
-	spin_unlock_irqrestore(&kp->lock, flags);
-
-	set_irq_type(kp->irq, IRQT_FALLING);
-	tsc2301_kp_start_scan(tsc);
-	if (kp->pending)
-		/* continue an interrupted polling */
-		mod_timer(&kp->timer,
-			  jiffies + msecs_to_jiffies(TSC2301_POLL_TIME));
-	else
-		enable_irq(kp->irq);
-}
-
-/* Must be called with the mutex held */
-static int tsc2301_kp_disable(struct tsc2301 *tsc, int release_keys)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&kp->lock, flags);
-	if (kp->disable_depth++ !=3D 0) {
-		spin_unlock_irqrestore(&kp->lock, flags);
-		goto out;
-	}
-	if (!kp->pending)
-		disable_irq_nosync(kp->irq);
-
-	while (kp->pending) {
-		spin_unlock_irqrestore(&kp->lock, flags);
-		msleep(1);
-		spin_lock_irqsave(&kp->lock, flags);
-	}
-	spin_unlock_irqrestore(&kp->lock, flags);
-
-	tsc2301_kp_stop_scan(tsc);
-	set_irq_type(kp->irq, IRQT_NOEDGE);
-out:
-	if (release_keys)
-		tsc2301_kp_release_all_keys(tsc);
-
-	return 0;
-}
-
-/* The following workaround is needed for a HW bug triggered by the
- * following:
- * 1. keep any key pressed
- * 2. disable keypad
- * 3. release all keys
- * 4. reenable keypad
- * 5. disable touch screen controller
- *
- * After this the keypad scanner will get stuck in busy state and won't
- * report any interrupts for further keypresses. One way to recover is to
- * restart the keypad scanner whenever we enable / disable the
- * touchscreen controller.
- */
-void tsc2301_kp_restart(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-
-	mutex_lock(&kp->mutex);
-	if (!kp->user_disabled) {
-		tsc2301_kp_disable(tsc, 0);
-		tsc2301_kp_enable(tsc);
-	}
-	mutex_unlock(&kp->mutex);
-}
-
-static ssize_t tsc2301_kp_disable_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", tsc2301_kp_disabled(tsc) ? 1 : 0);
-}
-
-static ssize_t tsc2301_kp_disable_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_kp	*kp =3D tsc->kp;
-	char *endp;
-	int i;
-
-	i =3D simple_strtoul(buf, &endp, 10);
-	i =3D i ? 1 : 0;
-
-	mutex_lock(&kp->mutex);
-	if (i =3D=3D kp->user_disabled) {
-		mutex_unlock(&kp->mutex);
-		return count;
-	}
-	kp->user_disabled =3D i;
-
-	if (i)
-		tsc2301_kp_disable(tsc, 1);
-	else
-		tsc2301_kp_enable(tsc);
-	mutex_unlock(&kp->mutex);
-
-	return count;
-}
-
-static DEVICE_ATTR(disable_kp, 0664, tsc2301_kp_disable_show,
-		   tsc2301_kp_disable_store);
-
-static const u16 tsc2301_kp_read_data =3D 0x8000 | TSC2301_REG_KPDATA;
-static const u16 tsc2301_kp_read_state =3D 0x8000 | TSC2301_REG_KEY;
-
-static void tsc2301_kp_setup_spi_xfer(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-	struct spi_message *m =3D &kp->read_msg;
-	struct spi_transfer *x =3D &kp->read_xfer[0];
-
-	spi_message_init(&kp->read_msg);
-
-	if (kp->get_keyb_irq_state =3D=3D NULL) {
-		/* No platform specific way for determining the keypress
-		 * state, so we'll need an extra status register read.
-		 */
-		x->tx_buf =3D &tsc2301_kp_read_state;
-		x->len =3D 2;
-		spi_message_add_tail(x, m);
-		x++;
-
-		x->rx_buf =3D &kp->state;
-		x->len =3D 2;
-		x->cs_change =3D 1;
-		spi_message_add_tail(x, m);
-		x++;
-	}
-
-	x->tx_buf =3D &tsc2301_kp_read_data;
-	x->len =3D 2;
-	spi_message_add_tail(x, m);
-	x++;
-
-	x->rx_buf =3D &kp->data;
-	x->len =3D 2;
-	spi_message_add_tail(x, m);
-
-	m->complete =3D tsc2301_kp_rx;
-	m->context =3D tsc;
-}
-
-#ifdef CONFIG_PM
-int tsc2301_kp_suspend(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-
-	mutex_lock(&kp->mutex);
-	tsc2301_kp_disable(tsc, 1);
-	mutex_unlock(&kp->mutex);
-	return 0;
-}
-
-void tsc2301_kp_resume(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-
-	mutex_lock(&kp->mutex);
-	tsc2301_kp_enable(tsc);
-	mutex_unlock(&kp->mutex);
-}
-#endif
-
-int __devinit tsc2301_kp_init(struct tsc2301 *tsc,
-			      struct tsc2301_platform_data *pdata)
-{
-	struct input_dev *idev;
-	struct tsc2301_kp *kp;
-	int r, i;
-	u16 mask;
-
-	if (pdata->keyb_int < 0) {
-		dev_err(&tsc->spi->dev, "need kbirq");
-		return -EINVAL;
-	}
-
-	kp =3D kzalloc(sizeof(*kp), GFP_KERNEL);
-	if (kp =3D=3D NULL)
-		return -ENOMEM;
-	tsc->kp =3D kp;
-
-	kp->irq =3D pdata->keyb_int;
-	spin_lock_init(&kp->lock);
-	mutex_init(&kp->mutex);
-
-	init_timer(&kp->timer);
-	kp->timer.data =3D (unsigned long) tsc;
-	kp->timer.function =3D tsc2301_kp_timer;
-
-	kp->get_keyb_irq_state =3D pdata->get_keyb_irq_state;
-
-	idev =3D input_allocate_device();
-	if (idev =3D=3D NULL) {
-		r =3D -ENOMEM;
-		goto err1;
-	}
-	idev->name =3D "TSC2301 keypad";
-	snprintf(kp->phys, sizeof(kp->phys), "%s/input-kp", tsc->spi->dev.bus_id);
-	idev->phys =3D kp->phys;
-
-	mask =3D 0;
-	idev->evbit[0] =3D BIT(EV_KEY);
-	for (i =3D 0; i < 16; i++) {
-		if (pdata->keymap[i] > 0) {
-			set_bit(pdata->keymap[i], idev->keybit);
-			kp->keymap[i] =3D pdata->keymap[i];
-		} else {
-			kp->keymap[i] =3D -1;
-			mask |=3D 1 << i;
-		}
-	}
-
-	if (pdata->kp_rep)
-		set_bit(EV_REP, idev->evbit);
-
-	kp->idev =3D idev;
-
-	tsc2301_kp_setup_spi_xfer(tsc);
-
-	r =3D device_create_file(&tsc->spi->dev, &dev_attr_disable_kp);
-	if (r < 0)
-		goto err2;
-
-	tsc2301_kp_start_scan(tsc);
-
-	/* IRQ mode 0 is faulty, it can cause the KBIRQ to get stuck.
-	 * Mode 2 deasserts the IRQ at:
-	 * - HW or SW reset
-	 * - Setting SCS flag in REG_KEY register
-	 * - Releasing all keys
-	 * - Reading the REG_KPDATA
-	 */
-	tsc2301_write_kbc(tsc, 2);
-
-	tsc2301_write_reg(tsc, TSC2301_REG_KPMASK, mask);
-	kp->mask =3D mask;
-
-	set_irq_type(kp->irq, IRQT_FALLING);
-
-	r =3D request_irq(kp->irq, tsc2301_kp_irq_handler, SA_SAMPLE_RANDOM,
-			"tsc2301-kp", tsc);
-	if (r < 0) {
-		dev_err(&tsc->spi->dev, "unable to get kbirq IRQ");
-		goto err3;
-	}
-	set_irq_wake(kp->irq, 1);
-
-	/* We need to read the register once..? */
-	tsc2301_read_reg(tsc, TSC2301_REG_KPDATA);
-
-	r =3D input_register_device(idev);
-	if (r < 0) {
-		dev_err(&tsc->spi->dev, "can't register keypad device\n");
-		goto err4;
-	}
-
-	return 0;
-
-err4:
-	free_irq(kp->irq, tsc);
-err3:
-	tsc2301_kp_stop_scan(tsc);
-	device_remove_file(&tsc->spi->dev, &dev_attr_disable_kp);
-err2:
-	input_free_device(kp->idev);
-err1:
-	kfree(kp);
-	return r;
-}
-
-void __devexit tsc2301_kp_exit(struct tsc2301 *tsc)
-{
-	struct tsc2301_kp *kp =3D tsc->kp;
-
-	tsc2301_kp_disable(tsc, 1);
-	input_unregister_device(kp->idev);
-	free_irq(kp->irq, tsc);
-	device_remove_file(&tsc->spi->dev, &dev_attr_disable_kp);
-
-	kfree(kp);
-}
diff --git a/drivers/spi/tsc2301-mixer.c b/drivers/spi/tsc2301-mixer.c
deleted file mode 100644
index 27eba13..0000000
--- a/drivers/spi/tsc2301-mixer.c
+++ /dev/null
@@ -1,1064 +0,0 @@
-/*
- * drivers/spi/tsc2301-mixer.c
- *
- * ALSA Mixer implementation for TSC2301
- *
- * Copyright (C) 2006 Nokia Corporation.
- *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
- *          Juha Yrjola
- *
- * Some notes about TSC2301:
- * - PLL will stop when DAC and ADC's are powered down.
- * - Touchscreen will stop working when audio part is powered up and if au=
dio
- *   MCLK is stopped. Problem is avoided if audio is powered down before
- *   stopping MCLK.
- * - Audio DAC or audio outputs will activate only after 100 msec from the
- *   chip power-up. Reason seems to be VCM since there is no this delay if=
 the
- *   chip and VCM (bit AVPD on PD/MISC) were not powered down. The chip wi=
ll
- *   consume about 1 mA if all other audio blocks are powered down except =
the
- *   chip itself and VCM. Full power down consumes only about few uA.
- * - Power-down transition could happen earliest about 100 msec after the =
chip
- *   power-up. Otherwise power-down will fail if there is no that 100 msec
- *   on time before it. It's not obvious why is that since chip reports
- *   power-up to be completed and also PLL output on GPIO_0 is active in f=
ew
- *   milliseconds.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/tsc2301.h>
-
-#include <sound/driver.h>
-#include <sound/core.h>
-#include <sound/control.h>
-
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-static char *id =3D NULL;
-MODULE_PARM_DESC(id, "TSC2301 ALSA Mixer Driver");
-#endif
-
-/* shadow register indexes */
-enum {
-	/* audio control and volume registers */
-	AUDCNTL_INDEX,
-	ADCVOL_INDEX,
-	DACVOL_INDEX,
-	BPVOL_INDEX,
-	/* keyclick control register (not needed here) */
-	/* audio power control register */
-	PD_MISC_INDEX,
-	/* TSC2301 GPIO control register */
-	GPIO_INDEX,
-
-	SHADOW_REG_COUNT,
-};
-
-/* structure for driver private data */
-struct tsc2301_mixer {
-	struct tsc2301 *tsc;
-	struct mutex mutex;
-
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	struct snd_card *card;
-#endif
-
-	/* shadow registers holding TSC2301 audio registers. Used to hold
-	 * their states during the sleep and also to reduce communication with
-	 * the chip since get callback functions could get register values
-	 * directly from these shadow registers without needing to read them
-	 * from the chip */
-	u16 shadow_regs[SHADOW_REG_COUNT];
-
-	/* audio controller driver usage of the ADC and DAC */
-	unsigned adc_enabled:1, dac_enabled:1;
-	unsigned pll_output:1;
-	unsigned mclk_enabled;
-
-	/* latest audio power-up timestamp */
-	unsigned long pu_jiffies;
-
-	/* these are used when upper layer(s) are going to power-down TSC2301
-	 * before 100 msec is passed from power-up */
-	struct delayed_work delayed_power_down;
-	unsigned delayed_pd_active:1;
-
-	int (* platform_init)(struct device *);
-	void (* platform_cleanup)(struct device *);
-
-	struct tsc2301_mixer_gpio *mixer_gpios;
-	int n_mixer_gpios;
-};
-
-#define TSC2301_DAC_DELAY		msecs_to_jiffies(100)
-#define TSC2301_MIN_PU_PERIOD		msecs_to_jiffies(100)
-
-#define TSC2301_REG_TO_PVAL(reg)	\
-	(TSC2301_REG_TO_PAGE(reg) << 6 | TSC2301_REG_TO_ADDR(reg))
-#define  TSC2301_PVAL_TO_REG(v)		\
-	(TSC2301_REG((((v) >> 6) & 3),((v) & 0x1f)))
-
-#define TSC2301_VOLUME_MASK		0x7f
-#define TSC2301_MIN_ADCVOL		6
-#define TSC2301_MIN_DACVOL		0
-#define TSC2301_MIN_BPVOL		31
-#define TSC2301_MUTE_LEFT_SHIFT		15
-#define TSC2301_VOL_LEFT_SHIFT		8
-#define TSC2301_MUTE_RIGHT_SHIFT	7
-#define TSC2301_VOL_RIGHT_SHIFT		0
-
-#define TSC2301_INM_MASK		3
-#define TSC2301_INML_SHIFT		12
-#define TSC2301_INMR_SHIFT		10
-
-#define TSC2301_MICG_MASK		3
-#define TSC2301_MICG_MIN		1 /* values 0 & 1 both mean 0 dB */
-#define TSC2301_MICG_SHIFT		8
-
-#define TSC2301_REG_AUDCNTL_MCLK(v)	(((v) & 3) << 6)
-#define TSC2301_REG_AUDCNTL_I2SFS(v)	(((v) & 0xf) << 2)
-#define TSC2301_REG_AUDCNTL_I2SFM(v)	(((v) & 3) << 0)
-
-#define TSC2301_SINGLE(xname, xindex, reg, shadow_index, shift, mask, min)=
 \
-{\
-	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name =3D xname, \
-	.index =3D xindex, \
-	.info =3D snd_tsc2301_info_single, \
-	.get =3D snd_tsc2301_get_single, \
-	.put =3D snd_tsc2301_put_single, \
-	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
-		(shadow_index << 8) | (shift << 16) | (mask << 24) | \
-		(min << 28) \
-}
-#define TSC2301_SINGLE_MINVAL(v)	(((v) >> 28) & 15)
-#define TSC2301_SINGLE_SHIFT(v)		(((v) >> 16) & 15)
-#define TSC2301_SINGLE_MASK(v)		(((v) >> 24) & 15)
-
-#define TSC2301_DOUBLE(xname, xindex, reg, shadow_index, ls, rs, mask, min=
) \
-{\
-	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name =3D xname, \
-	.index =3D xindex, \
-	.info =3D snd_tsc2301_info_double, \
-	.get =3D snd_tsc2301_get_double, \
-	.put =3D snd_tsc2301_put_double, \
-	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
-		(shadow_index << 8) | (min << 11) | \
-		(ls << 16) | (rs << 20) | (mask << 24) \
-}
-#define TSC2301_DOUBLE_MINVAL(v)	(((v) >> 11) & 0x1f)
-#define TSC2301_DOUBLE_LEFT_SHIFT(v)	(((v) >> 16) & 15)
-#define TSC2301_DOUBLE_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
-#define TSC2301_DOUBLE_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
-
-#define TSC2301_MUX(xname, xindex, reg, shadow_index, ls, rs, mask) \
-{\
-	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name =3D xname, \
-	.index =3D xindex, \
-	.info =3D snd_tsc2301_info_mux, \
-	.get =3D snd_tsc2301_get_mux, \
-	.put =3D snd_tsc2301_put_mux, \
-	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
-		(shadow_index << 8) | (ls << 16) | (rs << 20) | (mask << 24) \
-}
-#define TSC2301_MUX_LEFT_SHIFT(v)	(((v) >> 16) & 15)
-#define TSC2301_MUX_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
-#define TSC2301_MUX_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
-
-#define TSC2301_BOOL(xname, xindex, reg, shadow_index, shift, invert, stat=
e) \
-{ \
-	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
-	.name =3D xname, \
-	.index =3D xindex, \
-	.info =3D snd_tsc2301_info_bool, \
-	.get =3D snd_tsc2301_get_bool, \
-	.put =3D snd_tsc2301_put_bool, \
-	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
-		(shadow_index << 8) | (shift << 16) | \
-		(invert << 24) | (state << 25) \
-}
-#define TSC2301_BOOL_SHIFT(v)		(((v) >> 16) & 7)
-#define TSC2301_BOOL_INVERT(v)		(((v) >> 24) & 1)
-#define TSC2301_BOOL_STATE(v)		(((v) >> 25) & 1)
-
-#define TSC2301_SHADOW_INDEX(v)		(((v) >> 8) & 7)
-
-/*
- * Power-down handler for additional GPIO mixer controls. GPIO state of GP=
IO
- * controls whose power-down flag is enabled are set to their false/deacti=
vate
- * state
- *
- * Must be called tsc->mixer->mutex locked
- */
-static void tsc2301_gpio_power_down(struct tsc2301 *tsc)
-{
-	struct tsc2301_mixer *mix =3D tsc->mixer;
-	u16 temp;
-	int i;
-
-	temp =3D mix->shadow_regs[GPIO_INDEX];
-	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
-		const struct tsc2301_mixer_gpio *mg;
-
-		mg =3D mix->mixer_gpios + i;
-		if (mg->deactivate_on_pd) {
-			int gpio =3D mg->gpio;
-
-			temp &=3D ~(1 << gpio);
-			temp |=3D mg->inverted << gpio;
-		}
-	}
-	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
-}
-
-/*
- * Powers down/up audio blocks which are muted or become unused.
- * shadow_index >=3D 0, changes power state of single audio block
- * shadow_index < 0, changes power state of all blocks
- *
- * Must be called tsc->mixer->mutex locked
- */
-#define TSC2301_MUTE_MASK \
-	((1 << TSC2301_MUTE_LEFT_SHIFT) | (1 << TSC2301_MUTE_RIGHT_SHIFT))
-static void tsc2301_power_ctrl(struct tsc2301 *tsc, int shadow_index,
-			       int poll_pdsts)
-{
-	struct tsc2301_mixer *mix =3D tsc->mixer;
-	u16 pd_ctrl, pd_ctrl_old, w;
-	unsigned long timeout;
-	int power_up =3D 0;
-
-	if (mix->delayed_pd_active) {
-		mix->delayed_pd_active =3D 0;
-		mix->mclk_enabled--;
-		cancel_delayed_work(&mix->delayed_power_down);
-	}
-
-	pd_ctrl =3D pd_ctrl_old =3D mix->shadow_regs[PD_MISC_INDEX];
-	/* power control helper based on used space mixer selections. See
-	 * actual power control decisions below */
-	if (shadow_index < 0 || shadow_index =3D=3D ADCVOL_INDEX) {
-		/* ADC left and right power down control */
-		if (mix->shadow_regs[ADCVOL_INDEX] &
-		    (1 << TSC2301_MUTE_LEFT_SHIFT))
-			/* left ADC muted. Power down the left ADC */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
-		else
-			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDL;
-		if (mix->shadow_regs[ADCVOL_INDEX] &
-		    (1 << TSC2301_MUTE_LEFT_SHIFT))
-			/* right ADC muted. Power down the right ADC */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
-		else
-			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDR;
-	}
-	if (shadow_index < 0 || shadow_index =3D=3D DACVOL_INDEX) {
-		/* DAC power down control */
-		if ((mix->shadow_regs[DACVOL_INDEX] &
-		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
-			/* both DACs muted. Power down the DAC */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
-		else
-			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_DAPD;
-	}
-	if (shadow_index < 0 || shadow_index =3D=3D BPVOL_INDEX) {
-		/* line bypass power down control */
-		if ((mix->shadow_regs[BPVOL_INDEX] &
-		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
-			/* both line bypasses muted. Power down the bypass
-			 * path */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_ABPD;
-		else
-			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ABPD;
-	}
-	if (shadow_index < 0 || shadow_index =3D=3D AUDCNTL_INDEX) {
-		/* mic bias power down control */
-		if ((mix->shadow_regs[AUDCNTL_INDEX] &
-		     (3 << TSC2301_INML_SHIFT)) &&
-		    (mix->shadow_regs[AUDCNTL_INDEX] &
-		     (3 << TSC2301_INMR_SHIFT)))
-			/* both ADC channels use other than mic input. Power
-			 * down the mic bias output */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
-		else
-			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_MIBPD;
-	}
-
-	/* power control decisions based on codec usage and user space mixer
-	 * selections detected above */
-	pd_ctrl &=3D ~TSC2301_REG_PD_MISC_APD; /* audio not powered down */
-	if (mix->mclk_enabled) {
-		if (!mix->adc_enabled) {
-			/* ADC not used, power down both ADC's and mic bias
-			 * output independently of user space mixer
-			 * selections */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
-		}
-		if (!mix->dac_enabled) {
-			/* DAC not used, power down DAC independently of user
-			 * space mixer selections */
-			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
-		}
-
-		if (mix->pll_output) {
-			/* GPIO_0 is configured as PLL output so audio
-			 * controller is expecting clock from TSC2301. Either
-			 * ADC or DAC must be active in order to keep PLL on */
-			if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
-			    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
-			    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
-				/* neither ADC or DAC used. Force ADC on in
-				 * order to keep PLL active */
-				pd_ctrl &=3D ~(TSC2301_REG_PD_MISC_ADPDL |
-					     TSC2301_REG_PD_MISC_ADPDR);
-			}
-		}
-	} else {
-		/* audio input clock is not enabled so power down DAC and ADC
-		 * in order to shutdown PLL and to keep touchscreen and keypad
-		 * parts working. Touchscreen and keypad use audio clock when
-		 * PLL is on and internal clock otherwise */
-		pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD |
-			   TSC2301_REG_PD_MISC_ADPDL |
-			   TSC2301_REG_PD_MISC_ADPDR;
-	}
-
-	if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
-	    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
-	    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD) &&
-	    (pd_ctrl & TSC2301_REG_PD_MISC_ABPD)) {
-		/* all ADC, DAC and line bypass path unused. Power down the
-		 * whole audio part of the TSC2301 */
-		pd_ctrl |=3D TSC2301_REG_PD_MISC_APD;
-	}
-
-	if (pd_ctrl =3D=3D pd_ctrl_old)
-		return;
-
-	/* power down control changed. Update into TSC2301 */
-	if ((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_APD) {
-		/* whole audio power state changed. Update GPIO states */
-		if (pd_ctrl & TSC2301_REG_PD_MISC_APD) {
-			/* power down GPIO controls before powering down
-			 * the codec */
-			tsc2301_gpio_power_down(tsc);
-			/* we must really ensure that codec has been on no less
-			 * than 100 msec before doing power-down */
-			timeout =3D mix->pu_jiffies + TSC2301_MIN_PU_PERIOD -
-				  jiffies;
-			if (timeout <=3D TSC2301_MIN_PU_PERIOD) {
-				mix->delayed_pd_active =3D 1;
-				mix->mclk_enabled++;
-				schedule_delayed_work(&mix->delayed_power_down,
-						      timeout + 1);
-				return;
-			}
-		} else
-			/* restore GPIOs after codec is powered up */
-			power_up =3D 1;
-	}
-	mix->shadow_regs[PD_MISC_INDEX] =3D pd_ctrl;
-	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC, pd_ctrl);
-	if (power_up)
-		mix->pu_jiffies =3D jiffies;
-	if (!poll_pdsts) {
-		if (power_up)
-			tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
-					  mix->shadow_regs[GPIO_INDEX]);
-		return;
-	}
-
-	/* wait until power-up/-down is completed */
-	timeout =3D jiffies + msecs_to_jiffies(100);
-	w =3D 0;
-	do {
-		if (time_after(jiffies, timeout)) {
-			/* Print a warning only if the I2S clock is not
-			 * present / out of sync. This can happen during
-			 * init time, when that clock will be turned on
-			 * by another driver like in the OMAP EAC with
-			 * external clock case.
-			 */
-			if (w & TSC2301_REG_PD_MISC_OTSYN) {
-				dev_warn(&tsc->spi->dev,
-				   "I2S clock not in sync or off.\n");
-			} else {
-				dev_err(&tsc->spi->dev,
-				   "power-up/-down timed out "
-				   "(0x%04x, 0x%04x -> 0x%04x)\n",
-				   w, pd_ctrl_old, pd_ctrl);
-			}
-			goto out;
-		}
-		w =3D tsc2301_read_reg(tsc, TSC2301_REG_PD_MISC);
-	} while (!(w & TSC2301_REG_PD_MISC_PDSTS));
-
-out:
-	if (((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_DAPD) &&
-	    !(pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
-		/* DAC powered up now. Ensure that DAC and audio outputs are
-		 * activated. They are up 100 msec after the chip power-up
-		 * command */
-		timeout =3D mix->pu_jiffies + TSC2301_DAC_DELAY - jiffies;
-		if (timeout <=3D TSC2301_DAC_DELAY)
-			schedule_timeout_interruptible(timeout);
-		/* FIXME: This is lazy. We restore GPIOs only after activating
-		 * the DAC. It would be better to do some kind of delayed GPIO
-		 * restore. That ensures that we restore them also if only ADC
-		 * path is activated. But this is required only if there is
-		 * some input amplifier, bias control, etc. and their power
-		 * state is under TSC GPIO control */
-		tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
-				  mix->shadow_regs[GPIO_INDEX]);
-	}
-}
-
-static int snd_tsc2301_info_single(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_info *uinfo)
-{
-	int mask =3D TSC2301_SINGLE_MASK(kcontrol->private_value);
-	int minval =3D TSC2301_SINGLE_MINVAL(kcontrol->private_value);
-
-	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count =3D 1;
-	uinfo->value.integer.min =3D minval;
-	uinfo->value.integer.max =3D mask;
-
-	return 0;
-}
-
-static int snd_tsc2301_get_single(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int mask =3D TSC2301_SINGLE_MASK(priv);
-	int shift =3D TSC2301_SINGLE_SHIFT(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg;
-
-	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
-
-	ucontrol->value.integer.value[0] =3D (shadow_reg >> shift) & mask;
-
-	return 0;
-}
-
-static int snd_tsc2301_put_single(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int mask =3D TSC2301_SINGLE_MASK(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg, shadow_reg_old;
-	int shift =3D TSC2301_SINGLE_SHIFT(priv);
-	int reg =3D TSC2301_PVAL_TO_REG(priv);
-	int changed;
-
-	mutex_lock(&tsc->mixer->mutex);
-	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
-
-	/* zero bits to be modified */
-	shadow_reg &=3D ~(mask << shift);
-	/* modify with new value */
-	shadow_reg |=3D ((ucontrol->value.integer.value[0] & mask) << shift);
-
-	changed =3D (shadow_reg !=3D shadow_reg_old);
-	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
-
-	/* update into TSC2301 if necessary */
-	if (changed)
-		tsc2301_write_reg(tsc, reg, shadow_reg);
-	mutex_unlock(&tsc->mixer->mutex);
-
-	return changed;
-}
-
-static int snd_tsc2301_info_double(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_info *uinfo)
-{
-	/* mask =3D=3D 1 : Switch
-	 * mask > 1 : Max volume */
-	int mask =3D TSC2301_DOUBLE_MASK(kcontrol->private_value);
-	int minval =3D TSC2301_DOUBLE_MINVAL(kcontrol->private_value);
-
-	uinfo->type =3D mask =3D=3D 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
-		SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count =3D 2;
-	uinfo->value.integer.min =3D minval;
-	uinfo->value.integer.max =3D mask;
-
-	return 0;
-}
-
-static int snd_tsc2301_get_double(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	/* mask =3D=3D 1 : Switch
-	 * mask > 1 : Volume */
-	int mask =3D TSC2301_DOUBLE_MASK(priv);
-	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
-	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg;
-
-	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
-
-	/* invert mute bits for the switches */
-	if (mask =3D=3D 1)
-		shadow_reg =3D ~shadow_reg;
-
-	ucontrol->value.integer.value[0] =3D (shadow_reg >> ls) & mask;
-	ucontrol->value.integer.value[1] =3D (shadow_reg >> rs) & mask;
-
-	return 0;
-}
-
-static int snd_tsc2301_put_double(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	/* mask =3D=3D 1 : Switch
-	 * mask > 1 : Volume */
-	int mask =3D TSC2301_DOUBLE_MASK(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg, shadow_reg_old;
-	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
-	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
-	int reg =3D TSC2301_PVAL_TO_REG(priv);
-	int changed;
-
-	mutex_lock(&tsc->mixer->mutex);
-	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
-
-	/* zero bits to be modified */
-	shadow_reg &=3D ~((mask << ls) | (mask << rs));
-	/* modify with new value */
-	if (mask =3D=3D 1) {
-		/* switch. Invert switch values for the mute bits */
-		shadow_reg |=3D
-			((~ucontrol->value.integer.value[0] & mask) << ls) |
-			((~ucontrol->value.integer.value[1] & mask) << rs);
-	} else {
-		/* volume */
-		shadow_reg |=3D
-			(ucontrol->value.integer.value[0] << ls) |
-			(ucontrol->value.integer.value[1] << rs);
-	}
-
-	changed =3D (shadow_reg !=3D shadow_reg_old);
-	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
-
-	/* update into TSC2301 if necessary */
-	if (changed)
-		tsc2301_write_reg(tsc, reg, shadow_reg);
-
-	if (mask =3D=3D 1)
-		/* check is need to power down/up audio blocks in case of
-		 * muted state change */
-		tsc2301_power_ctrl(tsc, shadow_index, 0);
-	mutex_unlock(&tsc->mixer->mutex);
-
-	return changed;
-}
-
-static int snd_tsc2301_info_mux(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info *uinfo)
-{
-	static char *texts[4] =3D {"Mic", "Line", "Line swapped", "Line mono"};
-
-	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count =3D 2;
-	uinfo->value.enumerated.items =3D 4;
-	if (uinfo->value.enumerated.item > 3)
-		uinfo->value.enumerated.item =3D 3;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-
-	return 0;
-}
-
-static int snd_tsc2301_get_mux(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int mask =3D TSC2301_MUX_MASK(priv);
-	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
-	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg;
-
-	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
-	ucontrol->value.enumerated.item[0] =3D (shadow_reg >> ls) & mask;
-	ucontrol->value.enumerated.item[1] =3D (shadow_reg >> rs) & mask;
-
-	return 0;
-}
-
-static int snd_tsc2301_put_mux(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int mask =3D TSC2301_MUX_MASK(priv);
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	u16 shadow_reg, shadow_reg_old;
-	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
-	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
-	int reg =3D TSC2301_PVAL_TO_REG(priv);
-	int changed;
-
-	mutex_lock(&tsc->mixer->mutex);
-	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
-
-	/* zero bits to be modified */
-	shadow_reg &=3D ~((mask << ls) | (mask << rs));
-	/* modify with new value */
-	shadow_reg |=3D (ucontrol->value.enumerated.item[0] << ls);
-	shadow_reg |=3D (ucontrol->value.enumerated.item[1] << rs);
-
-	changed =3D (shadow_reg !=3D shadow_reg_old);
-
-	/* update into TSC2301 if necessary */
-	if (changed) {
-		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
-		tsc2301_write_reg(tsc, reg, shadow_reg);
-	}
-
-	/* check is need to power up/down audio blocks in case of ADC input
-	 * change */
-	tsc2301_power_ctrl(tsc, shadow_index, 0);
-	mutex_unlock(&tsc->mixer->mutex);
-
-	return changed;
-}
-
-static int snd_tsc2301_info_bool(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
-	uinfo->count =3D 1;
-	uinfo->value.integer.min =3D 0;
-	uinfo->value.integer.max =3D 1;
-
-	return 0;
-}
-
-static int snd_tsc2301_get_bool(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	int shift =3D TSC2301_BOOL_SHIFT(priv);
-	int invert =3D TSC2301_BOOL_INVERT(priv);
-	u16 shadow_reg;
-
-	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
-	ucontrol->value.integer.value[0] =3D
-		invert ^ ((shadow_reg >> shift) & 1);
-
-	return 0;
-}
-
-static int snd_tsc2301_put_bool(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct tsc2301 *tsc =3D kcontrol->private_data;
-	unsigned long priv =3D kcontrol->private_value;
-	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
-	int shift =3D TSC2301_BOOL_SHIFT(priv);
-	int invert =3D TSC2301_BOOL_INVERT(priv);
-	int reg =3D TSC2301_PVAL_TO_REG(priv);
-	u16 shadow_reg, shadow_reg_old;
-	int changed;
-
-	mutex_lock(&tsc->mixer->mutex);
-	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
-
-	/* zero bit to be modified */
-	shadow_reg &=3D ~(1 << shift);
-	/* modify with new value */
-	shadow_reg |=3D
-		(invert ^ (ucontrol->value.integer.value[0] & 1)) << shift;
-
-	changed =3D (shadow_reg !=3D shadow_reg_old);
-
-	/* update into TSC2301 if necessary */
-	if (changed) {
-		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
-		if ((shadow_index =3D=3D GPIO_INDEX) &&
-		    (tsc->mixer->shadow_regs[PD_MISC_INDEX] &
-		     TSC2301_REG_PD_MISC_APD)) {
-			/* changing GPIO control and audio is powered down.
-			 * Update GPIO states according to their power-down
-			 * flag */
-			tsc2301_gpio_power_down(tsc);
-		} else
-			tsc2301_write_reg(tsc, reg, shadow_reg);
-	}
-	mutex_unlock(&tsc->mixer->mutex);
-
-	return changed;
-}
-
-/* TSC2301 internal mixer controls */
-static struct snd_kcontrol_new snd_tsc2301_controls[] =3D {
-	/* stereo ADC input switches and volumes */
-	TSC2301_DOUBLE("Capture Switch", 0,
-		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
-		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
-		1, 0),
-	TSC2301_DOUBLE("Capture Volume", 0,
-		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
-		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
-		TSC2301_VOLUME_MASK, TSC2301_MIN_ADCVOL),
-
-	/* stereo DAC output switches and volumes */
-	TSC2301_DOUBLE("PCM Playback Switch", 0,
-		TSC2301_REG_DACVOL, DACVOL_INDEX,
-		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
-		1, 0),
-	TSC2301_DOUBLE("PCM Playback Volume", 0,
-		TSC2301_REG_DACVOL, DACVOL_INDEX,
-		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
-		TSC2301_VOLUME_MASK, TSC2301_MIN_DACVOL),
-
-	/* stereo line input bypass switches and volumes */
-	TSC2301_DOUBLE("Line Playback Switch", 0,
-		TSC2301_REG_BPVOL, BPVOL_INDEX,
-		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
-		1, 0),
-	TSC2301_DOUBLE("Line Playback Volume", 0,
-		TSC2301_REG_BPVOL, BPVOL_INDEX,
-		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
-		TSC2301_VOLUME_MASK, TSC2301_MIN_BPVOL),
-
-	/* mono microphone input gain */
-	TSC2301_SINGLE("Mic Boost", 0,
-		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
-		TSC2301_MICG_SHIFT,
-		TSC2301_MICG_MASK, TSC2301_MICG_MIN),
-
-	/* ADC input sources. Both channels could be selected separately */
-	TSC2301_MUX("Capture Source", 0,
-		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
-		TSC2301_INML_SHIFT, TSC2301_INMR_SHIFT,
-		TSC2301_INM_MASK),
-};
-
-/* must be called tsc->mixer->mutex locked */
-static void tsc2301_flush_shadow_regs(struct tsc2301 *tsc)
-{
-	int i, page, addr;
-	u16 temp;
-
-	page =3D TSC2301_REG_TO_PAGE(TSC2301_REG_AUDCNTL);
-	addr =3D TSC2301_REG_TO_ADDR(TSC2301_REG_AUDCNTL);
-
-	for (i =3D 0; i < 4; i++) {
-		temp =3D tsc->mixer->shadow_regs[i];
-		tsc2301_write_reg(tsc, TSC2301_REG(page, addr + i), temp);
-	}
-	temp =3D tsc->mixer->shadow_regs[GPIO_INDEX];
-	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
-
-	/* Update power state of all audio blocks depending are they
-	 * muted or unused. */
-	tsc2301_power_ctrl(tsc, -1, 0);
-}
-
-#ifdef CONFIG_PM
-int tsc2301_mixer_suspend(struct tsc2301 *tsc)
-{
-	/* power down entire audio section inside TSC2301 in case the
-	 * chip is still powered during the system sleep. However this driver
-	 * doesn't require that chip is powered because registers are restored
-	 * in function tsc2301_mixer_resume */
-	mutex_lock(&tsc->mixer->mutex);
-	tsc2301_gpio_power_down(tsc);
-	tsc->mixer->shadow_regs[PD_MISC_INDEX] |=3D TSC2301_REG_PD_MISC_APD;
-	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC,
-			  tsc->mixer->shadow_regs[PD_MISC_INDEX]);
-	mutex_unlock(&tsc->mixer->mutex);
-	return 0;
-}
-
-void tsc2301_mixer_resume(struct tsc2301 *tsc)
-{
-	/* power up the TSC2301 audio section and restore registers */
-	mutex_lock(&tsc->mixer->mutex);
-	tsc->mixer->shadow_regs[PD_MISC_INDEX] &=3D ~TSC2301_REG_PD_MISC_APD;
-	tsc2301_flush_shadow_regs(tsc);
-	mutex_unlock(&tsc->mixer->mutex);
-}
-#endif
-
-void tsc2301_mixer_enable_mclk(struct device *dev)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_mixer *mix =3D tsc->mixer;
-
-	mutex_lock(&mix->mutex);
-	if (!mix->mclk_enabled++ && tsc->enable_clock !=3D NULL) {
-		tsc->enable_clock(dev);
-	}
-	tsc2301_power_ctrl(tsc, -1, 1);
-	mutex_unlock(&mix->mutex);
-}
-
-void tsc2301_mixer_disable_mclk(struct device *dev)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_mixer *mix =3D tsc->mixer;
-
-	mutex_lock(&mix->mutex);
-	mix->mclk_enabled--;
-	tsc2301_power_ctrl(tsc, -1, 1);
-	if (!mix->mclk_enabled && tsc->disable_clock !=3D NULL) {
-		tsc->disable_clock(dev);
-	}
-	mutex_unlock(&mix->mutex);
-}
-
-static void tsc2301_mixer_delayed_power_down(struct work_struct *work)
-{
-	struct tsc2301_mixer *mix =3D container_of(work, struct tsc2301_mixer,
-						 delayed_power_down.work);
-	struct tsc2301 *tsc =3D mix->tsc;
-
-	mutex_lock(&mix->mutex);
-	if (!mix->delayed_pd_active) {
-		mutex_unlock(&mix->mutex);
-		return;
-	}
-	mix->delayed_pd_active =3D 0;
-	mutex_unlock(&mix->mutex);
-	tsc2301_mixer_disable_mclk(&tsc->spi->dev);
-}
-
-/*
- * Allows audio controller driver to notify its usage of ADC and DAC
- */
-void tsc2301_mixer_set_power(struct device *dev, int dac, int adc)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-
-	mutex_lock(&tsc->mixer->mutex);
-	tsc->mixer->adc_enabled =3D adc;
-	tsc->mixer->dac_enabled =3D dac;
-
-	/* update power state of all audio blocks */
-	tsc2301_power_ctrl(tsc, -1, 1);
-	mutex_unlock(&tsc->mixer->mutex);
-}
-
-/*
- * Registers TSC2301 ALSA Mixer controls for the given sound card
- */
-int tsc2301_mixer_register_controls(struct device *dev, struct snd_card *c=
ard)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_mixer *mix =3D tsc->mixer;
-	int i, err;
-
-	/* Register ALSA mixer controls */
-	for (i =3D 0; i < ARRAY_SIZE(snd_tsc2301_controls); i++) {
-		err =3D snd_ctl_add(card,
-				  snd_ctl_new1(&snd_tsc2301_controls[i], tsc));
-		if (err < 0)
-			return err;
-	}
-
-	if (!mix->n_mixer_gpios)
-		return 0;
-
-	/* Register additional GPIO controls if defined */
-	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
-		const struct tsc2301_mixer_gpio *mg =3D mix->mixer_gpios + i;
-		struct snd_kcontrol *ctrlp;
-		struct snd_kcontrol_new ctrl =3D
-			TSC2301_BOOL((char *)mg->name, 0,
-				     TSC2301_REG_GPIO, GPIO_INDEX,
-				     mg->gpio, mg->inverted, mg->def_enable);
-
-		ctrlp =3D snd_ctl_new1(&ctrl, tsc);
-		err =3D snd_ctl_add(card, ctrlp);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-static int tsc2301_mixer_register_card(struct tsc2301 *tsc)
-{
-	struct snd_card *card;
-	int err;
-
-	/* create new sound card instance */
-	card =3D snd_card_new(-1, id, THIS_MODULE, 0);
-	if (card =3D=3D NULL)
-		return -ENOMEM;
-
-	tsc->mixer->card =3D card;
-
-	strcpy(card->driver, "TSC2301");
-	strcpy(card->shortname, "TSC2301");
-	sprintf(card->longname, "TSC2301 ALSA Mixer");
-	strcpy(card->mixername, "TSC2301 Mixer");
-
-	/* register mixer controls for the sound card */
-	if ((err =3D tsc2301_mixer_register_controls(&tsc->spi->dev, card)) !=3D =
0)
-		goto err1;
-
-	/* register the sound card instance */
-	if ((err =3D snd_card_register(card)) !=3D 0)
-		goto err1;
-
-	printk(KERN_INFO "TSC2301 ALSA Mixer support initialized\n");
-
-	return 0;
-err1:
-	snd_card_free(card);
-	return err;
-}
-#endif
-
-int tsc2301_mixer_init(struct tsc2301 *tsc,
-		       struct tsc2301_platform_data *pdata)
-{
-	struct tsc2301_mixer *mix;
-	int err =3D 0;
-	u16 w;
-
-	mix =3D kzalloc(sizeof(*mix), GFP_KERNEL);
-	if (mix =3D=3D NULL)
-		return -ENOMEM;
-	tsc->mixer =3D mix;
-
-	mix->tsc =3D tsc;
-	mutex_init(&mix->mutex);
-	mix->platform_init =3D pdata->codec_init;
-	mix->platform_cleanup =3D pdata->codec_cleanup;
-	mix->pll_output =3D pdata->pll_output;
-
-	INIT_DELAYED_WORK(&mix->delayed_power_down,
-			  tsc2301_mixer_delayed_power_down);
-
-	/* initialize shadow register default values */
-	w =3D 0xc000;
-	w |=3D (pdata->mclk_ratio << 6) | (pdata->i2s_sample_rate << 2);
-	w |=3D pdata->i2s_format;
-	mix->shadow_regs[AUDCNTL_INDEX] =3D w;
-	mix->shadow_regs[ADCVOL_INDEX] =3D 0xd7d7;
-	mix->shadow_regs[DACVOL_INDEX] =3D 0xffff;
-	mix->shadow_regs[BPVOL_INDEX] =3D 0xe7e7;
-	mix->shadow_regs[PD_MISC_INDEX] =3D pdata->power_down_blocks;
-
-	/* if extra mixer controls configured, then configure associated
-	 * GPIOs as output and drive their default state */
-	if (pdata->n_mixer_gpios) {
-		int i;
-
-		w =3D 0;
-		for (i =3D 0; i < pdata->n_mixer_gpios; i++) {
-			const struct tsc2301_mixer_gpio *mg;
-			int gpio;
-
-			mg =3D pdata->mixer_gpios + i;
-			gpio =3D mg->gpio;
-			w |=3D (1 << gpio) << 8;
-			w |=3D (mg->inverted ^ mg->def_enable) << gpio;
-		}
-		mix->shadow_regs[GPIO_INDEX] =3D w;
-
-		mix->mixer_gpios =3D kmalloc(sizeof(*pdata->mixer_gpios) *
-					   pdata->n_mixer_gpios,
-					   GFP_KERNEL);
-		if (mix->mixer_gpios =3D=3D NULL) {
-			err =3D -ENOMEM;
-			goto err1;
-		}
-		memcpy(mix->mixer_gpios, pdata->mixer_gpios,
-		       sizeof(*pdata->mixer_gpios) * pdata->n_mixer_gpios);
-		mix->n_mixer_gpios =3D pdata->n_mixer_gpios;
-	}
-
-	/* PLL control */
-	tsc2301_write_pll(tsc, pdata->pll_n, pdata->pll_a, pdata->pll_pdc,
-			  0, mix->pll_output ? 0 : 1);
-
-	tsc2301_flush_shadow_regs(tsc);
-
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	err =3D tsc2301_mixer_register_card(tsc);
-	if (err < 0)
-		goto err2;
-#endif
-
-	if (mix->platform_init !=3D NULL) {
-		err =3D mix->platform_init(&tsc->spi->dev);
-		if (err < 0)
-			goto err3;
-	}
-
-	return 0;
-err3:
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	snd_card_free(mix->card);
-err2:
-#endif
-	if (mix->mixer_gpios !=3D NULL)
-		kfree(mix->mixer_gpios);
-err1:
-	kfree(mix);
-	return err;
-}
-
-void tsc2301_mixer_exit(struct tsc2301 *tsc)
-{
-	struct tsc2301_mixer *mixer =3D tsc->mixer;
-
-#ifdef TSC2301_MIXER_SELF_REGISTRATION
-	snd_card_free(mixer->card);
-#endif
-
-	if (mixer->platform_cleanup !=3D NULL)
-		mixer->platform_cleanup(&tsc->spi->dev);
-
-	if (mixer->mixer_gpios !=3D NULL)
-		kfree(mixer->mixer_gpios);
-}
-
-MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301-ts.c b/drivers/spi/tsc2301-ts.c
deleted file mode 100644
index 8657b56..0000000
--- a/drivers/spi/tsc2301-ts.c
+++ /dev/null
@@ -1,683 +0,0 @@
-/*
- * TSC2301 touchscreen driver
- *
- * Copyright (C) 2005-2006 Nokia Corporation
- *
- * Written by Jarkko Oikarinen, Imre Deak and Juha Yrjola
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/spi/spi.h>
-
-#ifdef CONFIG_ARCH_OMAP
-#include <asm/arch/gpio.h>
-#endif
-
-#include <linux/spi/tsc2301.h>
-
-/**
- * The touchscreen interface operates as follows:
- *
- * Initialize:
- *    Request access to GPIO103 (DAV)
- *    tsc2301_dav_irq_handler will trigger when DAV line goes down
- *
- *  1) Pen is pressed against touchscreeen
- *  2) TSC2301 performs AD conversion
- *  3) After the conversion is done TSC2301 drives DAV line down
- *  4) GPIO IRQ is received and tsc2301_dav_irq_handler is called
- *  5) tsc2301_dav_irq_handler sets up tsc2301_ts_timer in TSC2301_TS_SCAN=
_TIME
- *  6) tsc2301_ts_timer disables the irq and requests spi driver
- *     to read X, Y, Z1 and Z2
- *  7) SPI framework calls tsc2301_ts_rx after the coordinates are read
- *  8) tsc2301_ts_rx reports coordinates to input layer and
- *     sets up tsc2301_ts_timer to be called after TSC2301_TS_SCAN_TIME
- *  9) if tsc2301_tx_timer notices that the pen has been lifted, the lift =
event
- *     is sent, and irq is again enabled.
- */
-
-
-#define TSC2301_TOUCHSCREEN_PRODUCT_ID      		0x0052
-#define TSC2301_TOUCHSCREEN_PRODUCT_VERSION 		0x0001
-
-#define TSC2301_TS_SCAN_TIME		     		1
-
-#define TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301	0x8000
-#define TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST		0x0000
-
-#define TSC2301_ADCREG_FUNCTION_NONE			0x0000
-#define TSC2301_ADCREG_FUNCTION_XY			0x0400
-#define TSC2301_ADCREG_FUNCTION_XYZ			0x0800
-#define TSC2301_ADCREG_FUNCTION_X			0x0C00
-#define TSC2301_ADCREG_FUNCTION_Y			0x1000
-#define TSC2301_ADCREG_FUNCTION_Z			0x1400
-#define TSC2301_ADCREG_FUNCTION_DAT1			0x1800
-#define TSC2301_ADCREG_FUNCTION_DAT2			0x1C00
-#define TSC2301_ADCREG_FUNCTION_AUX1			0x2000
-#define TSC2301_ADCREG_FUNCTION_AUX2			0x2400
-#define TSC2301_ADCREG_FUNCTION_TEMP			0x2800
-
-#define TSC2301_ADCREG_RESOLUTION_8BIT			0x0100
-#define TSC2301_ADCREG_RESOLUTION_10BIT			0x0200
-#define TSC2301_ADCREG_RESOLUTION_12BIT			0x0300
-
-#define TSC2301_ADCREG_AVERAGING_NONE			0x0000
-#define TSC2301_ADCREG_AVERAGING_4AVG			0x0040
-#define TSC2301_ADCREG_AVERAGING_8AVG			0x0080
-#define TSC2301_ADCREG_AVERAGING_16AVG			0x00C0
-
-#define TSC2301_ADCREG_CLOCK_8MHZ			0x0000
-#define TSC2301_ADCREG_CLOCK_4MHZ			0x0010
-#define TSC2301_ADCREG_CLOCK_2MHZ			0x0020
-#define TSC2301_ADCREG_CLOCK_1MHZ			0x0030
-
-#define TSC2301_ADCREG_VOLTAGE_STAB_0US			0x0000
-#define TSC2301_ADCREG_VOLTAGE_STAB_100US		0x0002
-#define TSC2301_ADCREG_VOLTAGE_STAB_500US		0x0004
-#define TSC2301_ADCREG_VOLTAGE_STAB_1MS			0x0006
-#define TSC2301_ADCREG_VOLTAGE_STAB_5MS			0x0008
-#define TSC2301_ADCREG_VOLTAGE_STAB_10MS		0x000A
-#define TSC2301_ADCREG_VOLTAGE_STAB_50MS		0x000C
-#define TSC2301_ADCREG_VOLTAGE_STAB_100MS		0x000E
-
-#define TSC2301_ADCREG_STOP_CONVERSION			0x4000
-
-#define MAX_12BIT					((1 << 12) - 1)
-
-struct tsc2301_ts {
-	struct input_dev	*idev;
-	char			phys[32];
-	struct timer_list	timer;
-	spinlock_t		lock;
-
-	struct spi_transfer	read_xfer[2];
-	struct spi_message	read_msg;
-	u16                     data[4];
-
-	int			hw_avg_max;
-	u16			x;
-	u16			y;
-	u16			p;
-	int			sample_cnt;
-
-	int			ignore_last : 1;
-	u16			x_plate_ohm;
-	int			stab_time;
-	int			max_pressure;
-	int			touch_pressure;
-	int			pressure_limit;
-
-	u16			irq_enabled:1;
-	u16			pen_down:1;
-	u16			disabled:1;
-	u16			pending:1;
-
-	int			hw_flags;
-
-	s16			dav_gpio;
-	int			irq;
-};
-
-
-static const u16 tsc2301_ts_read_data =3D 0x8000 | TSC2301_REG_X;
-
-static int tsc2301_ts_check_config(struct tsc2301_ts *ts, int *hw_flags)
-{
-	int flags;
-
-	flags =3D 0;
-	switch (ts->hw_avg_max) {
-	case 0:
-		flags |=3D TSC2301_ADCREG_AVERAGING_NONE;
-		break;
-	case 4:
-		flags |=3D TSC2301_ADCREG_AVERAGING_4AVG;
-		break;
-	case 8:
-		flags |=3D TSC2301_ADCREG_AVERAGING_8AVG;
-		break;
-	case 16:
-		flags |=3D TSC2301_ADCREG_AVERAGING_16AVG;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (ts->stab_time) {
-	case 0:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_0US;
-		break;
-	case 100:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_100US;
-		break;
-	case 500:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_500US;
-		break;
-	case 1000:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_1MS;
-		break;
-	case 5000:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_5MS;
-		break;
-	case 10000:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_10MS;
-		break;
-	case 50000:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_50MS;
-		break;
-	case 100000:
-		flags |=3D TSC2301_ADCREG_VOLTAGE_STAB_100MS;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	*hw_flags =3D flags;
-	return 0;
-}
-
-/*
- * This odd three-time initialization is to work around a bug in TSC2301.
- * See TSC2301 errata for details.
- */
-static int tsc2301_ts_configure(struct tsc2301 *tsc, int flags)
-{
-	struct spi_transfer xfer[3];
-	struct spi_transfer *x;
-	struct spi_message m;
-	int reg =3D TSC2301_REG_ADC;
-	u16 val1, val2, val3;
-	u16 data[6];
-
-	val1 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
-		TSC2301_ADCREG_STOP_CONVERSION |
-		TSC2301_ADCREG_FUNCTION_NONE |
-		TSC2301_ADCREG_RESOLUTION_12BIT |
-		TSC2301_ADCREG_AVERAGING_NONE |
-		TSC2301_ADCREG_CLOCK_2MHZ |
-		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
-
-	val2 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_HOST |
-		TSC2301_ADCREG_FUNCTION_XYZ |
-		TSC2301_ADCREG_RESOLUTION_12BIT |
-		TSC2301_ADCREG_AVERAGING_16AVG |
-		TSC2301_ADCREG_CLOCK_1MHZ |
-		TSC2301_ADCREG_VOLTAGE_STAB_100MS;
-
-	/* Averaging and voltage stabilization settings in flags */
-	val3 =3D TSC2301_ADCREG_CONVERSION_CTRL_BY_TSC2301 |
-		TSC2301_ADCREG_FUNCTION_XYZ |
-		TSC2301_ADCREG_RESOLUTION_12BIT |
-		TSC2301_ADCREG_CLOCK_1MHZ |
-		flags;
-
-	/* Now we prepare the command for transferring */
-	data[0] =3D reg;
-	data[1] =3D val1;
-	data[2] =3D reg;
-	data[3] =3D val2;
-	data[4] =3D reg;
-	data[5] =3D val3;
-
-	spi_message_init(&m);
-	m.spi =3D tsc->spi;
-
-	memset(xfer, 0, sizeof(xfer));
-	x =3D &xfer[0];
-
-	x->tx_buf =3D &data[0];
-	x->len =3D 4;
-	x->cs_change =3D 1;
-	spi_message_add_tail(x, &m);
-
-	x++;
-	x->tx_buf =3D &data[2];
-	x->len =3D 4;
-	x->cs_change =3D 1;
-	spi_message_add_tail(x, &m);
-
-	x++;
-	x->tx_buf =3D &data[4];
-	x->len =3D 4;
-	spi_message_add_tail(x, &m);
-
-	spi_sync(m.spi, &m);
-
-	return 0;
-}
-
-static void tsc2301_ts_start_scan(struct tsc2301 *tsc)
-{
-	tsc2301_ts_configure(tsc, tsc->ts->hw_flags);
-}
-
-static void tsc2301_ts_stop_scan(struct tsc2301 *tsc)
-{
-	tsc2301_ts_configure(tsc, TSC2301_ADCREG_STOP_CONVERSION);
-}
-
-static int device_suspended(struct device *dev)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-	return dev->power.power_state.event !=3D PM_EVENT_ON || tsc->ts->disabled;
-}
-
-static void update_pen_state(struct tsc2301_ts *ts, int x, int y, int pres=
sure)
-{
-	int sync =3D 0;
-
-	if (pressure) {
-		input_report_abs(ts->idev, ABS_X, x);
-		input_report_abs(ts->idev, ABS_Y, y);
-		input_report_abs(ts->idev, ABS_PRESSURE, pressure);
-		if (!ts->pen_down)
-			input_report_key(ts->idev, BTN_TOUCH, 1);
-		sync =3D 1;
-	} else if (ts->pen_down) {
-		input_report_abs(ts->idev, ABS_PRESSURE, 0);
-		input_report_key(ts->idev, BTN_TOUCH, 0);
-		sync =3D 1;
-	}
-
-	if (sync)
-		input_sync(ts->idev);
-
-	ts->pen_down =3D pressure ? 1 : 0;
-#ifdef VERBOSE
-	dev_dbg(&tsc->spi->dev, "x %4d y %4d p %4d\n", x, y, pressure);
-#endif
-}
-
-/*
- * This procedure is called by the SPI framework after the coordinates
- * have been read from TSC2301
- */
-static void tsc2301_ts_rx(void *arg)
-{
-	struct tsc2301 *tsc =3D arg;
-	struct tsc2301_ts *ts =3D tsc->ts;
-	unsigned int x, y, z1, z2, pressure;
-
-	x  =3D ts->data[0];
-	y  =3D ts->data[1];
-	z1 =3D ts->data[2];
-	z2 =3D ts->data[3];
-
-	if (z1) {
-		pressure =3D ts->x_plate_ohm * x;
-		pressure /=3D 4096;
-		pressure *=3D z2 - z1;
-		pressure /=3D z1;
-	} else
-		pressure =3D 0;
-
-	/* If pressure value is above a preset limit (pen is barely
-	 * touching the screen) we can't trust the coordinate values.
-	 */
-	if (pressure < ts->pressure_limit && x < MAX_12BIT && y < MAX_12BIT) {
-		ts->pressure_limit =3D ts->max_pressure;
-		if (ts->ignore_last) {
-			if (ts->sample_cnt)
-				update_pen_state(ts, ts->x, ts->y, ts->p);
-			ts->x =3D x;
-			ts->y =3D y;
-			ts->p =3D pressure;
-		} else
-			update_pen_state(ts, x, y, pressure);
-		ts->sample_cnt++;
-	}
-
-	mod_timer(&ts->timer,
-		  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
-}
-
-static int is_pen_down(struct tsc2301_ts *ts)
-{
-	return ts->pen_down;
-}
-
-/*
- * Timer is called every TSC2301_TS_SCAN_TIME when the pen is down
- */
-static void tsc2301_ts_timer(unsigned long arg)
-{
-	struct tsc2301 *tsc =3D (void *) arg;
-	struct tsc2301_ts *ts =3D tsc->ts;
-	unsigned long flags;
-	int ndav;
-	int r;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	ndav =3D omap_get_gpio_datain(ts->dav_gpio);
-	if (ndav || device_suspended(&tsc->spi->dev)) {
-		/* Pen has been lifted */
-		if (!device_suspended(&tsc->spi->dev)) {
-			ts->irq_enabled =3D 1;
-			enable_irq(ts->irq);
-		}
-		update_pen_state(ts, 0, 0, 0);
-		ts->pending =3D 0;
-		spin_unlock_irqrestore(&ts->lock, flags);
-
-	} else {
-		ts->pen_down =3D 1;
-		spin_unlock_irqrestore(&ts->lock, flags);
-
-		r =3D spi_async(tsc->spi, &ts->read_msg);
-		if (r)
-			dev_err(&tsc->spi->dev, "ts: spi_async() failed");
-	}
-}
-
-/*
- * This interrupt is called when pen is down and first coordinates are
- * available. That is indicated by a falling edge on DEV line.  IRQ is
- * disabled here because while the pen is down the coordinates are
- * read by a timer.
- */
-static irqreturn_t tsc2301_ts_irq_handler(int irq, void *dev_id)
-{
-	struct tsc2301 *tsc =3D dev_id;
-	struct tsc2301_ts *ts =3D tsc->ts;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	if (ts->irq_enabled) {
-		ts->irq_enabled =3D 0;
-		disable_irq(ts->irq);
-		ts->pending =3D 1;
-		ts->pressure_limit =3D ts->touch_pressure;
-		ts->sample_cnt =3D 0;
-		mod_timer(&ts->timer,
-			  jiffies + msecs_to_jiffies(TSC2301_TS_SCAN_TIME));
-	}
-	spin_unlock_irqrestore(&ts->lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-/* Must be called with ts->lock held */
-static void tsc2301_ts_disable(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-
-	if (ts->disabled)
-		return;
-
-	ts->disabled =3D 1;
-	if (!ts->pending) {
-		ts->irq_enabled =3D 0;
-		disable_irq(ts->irq);
-	} else {
-		while (ts->pending) {
-			spin_unlock_irq(&ts->lock);
-			msleep(1);
-			spin_lock_irq(&ts->lock);
-		}
-	}
-
-	spin_unlock_irq(&ts->lock);
-	tsc2301_ts_stop_scan(tsc);
-	/* Workaround a bug where turning on / off touchscreen scanner
-	 * can get the keypad scanner stuck.
-	 */
-	tsc2301_kp_restart(tsc);
-	spin_lock_irq(&ts->lock);
-}
-
-static void tsc2301_ts_enable(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-
-	if (!ts->disabled)
-		return;
-
-	ts->disabled =3D 0;
-	ts->irq_enabled =3D 1;
-	enable_irq(ts->irq);
-
-	spin_unlock_irq(&ts->lock);
-	tsc2301_ts_start_scan(tsc);
-	/* Same workaround as above. */
-	tsc2301_kp_restart(tsc);
-	spin_lock_irq(&ts->lock);
-}
-
-#ifdef CONFIG_PM
-int tsc2301_ts_suspend(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-
-	spin_lock_irq(&ts->lock);
-	tsc2301_ts_disable(tsc);
-	spin_unlock_irq(&ts->lock);
-
-	return 0;
-}
-
-void tsc2301_ts_resume(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-
-	spin_lock_irq(&ts->lock);
-	tsc2301_ts_enable(tsc);
-	spin_unlock_irq(&ts->lock);
-}
-#endif
-
-static void tsc2301_ts_setup_spi_xfer(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-	struct spi_message *m =3D &ts->read_msg;
-	struct spi_transfer *x =3D &ts->read_xfer[0];
-
-	spi_message_init(m);
-
-	x->tx_buf =3D &tsc2301_ts_read_data;
-	x->len =3D 2;
-	spi_message_add_tail(x, m);
-
-	x++;
-	x->rx_buf =3D &ts->data;
-	x->len =3D 8;
-	spi_message_add_tail(x, m);
-
-	m->complete =3D tsc2301_ts_rx;
-	m->context =3D tsc;
-}
-
-static ssize_t tsc2301_ts_pen_down_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
-
-	return sprintf(buf, "%u\n", is_pen_down(tsc->ts));
-}
-
-static DEVICE_ATTR(pen_down, S_IRUGO, tsc2301_ts_pen_down_show, NULL);
-
-static ssize_t tsc2301_ts_disable_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_ts	*ts =3D tsc->ts;
-
-	return sprintf(buf, "%u\n", ts->disabled);
-}
-
-static ssize_t tsc2301_ts_disable_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
-{
-	struct tsc2301		*tsc =3D dev_get_drvdata(dev);
-	struct tsc2301_ts	*ts =3D tsc->ts;
-	char *endp;
-	int i;
-
-	i =3D simple_strtoul(buf, &endp, 10);
-	spin_lock_irq(&ts->lock);
-
-	if (i)
-		tsc2301_ts_disable(tsc);
-	else
-		tsc2301_ts_enable(tsc);
-
-	spin_unlock_irq(&ts->lock);
-
-	return count;
-}
-
-static DEVICE_ATTR(disable_ts, 0664, tsc2301_ts_disable_show,
-		   tsc2301_ts_disable_store);
-
-int __devinit tsc2301_ts_init(struct tsc2301 *tsc,
-			      struct tsc2301_platform_data *pdata)
-{
-	struct tsc2301_ts *ts;
-	struct input_dev *idev;
-	int dav_gpio, r;
-
-	if (pdata->dav_gpio < 0) {
-		dev_err(&tsc->spi->dev, "need DAV GPIO");
-		return -EINVAL;
-	}
-	dav_gpio =3D pdata->dav_gpio;
-
-	ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (ts =3D=3D NULL)
-		return -ENOMEM;
-	tsc->ts =3D ts;
-
-	ts->dav_gpio =3D dav_gpio;
-#ifdef CONFIG_ARCH_OMAP
-	r =3D omap_request_gpio(dav_gpio);
-	if (r < 0) {
-		dev_err(&tsc->spi->dev, "unable to get DAV GPIO");
-		goto err1;
-	}
-	omap_set_gpio_direction(dav_gpio, 1);
-	ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);
-#endif
-	init_timer(&ts->timer);
-	ts->timer.data =3D (unsigned long) tsc;
-	ts->timer.function =3D tsc2301_ts_timer;
-
-	spin_lock_init(&ts->lock);
-
-	ts->x_plate_ohm	=3D pdata->ts_x_plate_ohm ? : 280;
-	ts->hw_avg_max	=3D pdata->ts_hw_avg;
-	ts->max_pressure=3D pdata->ts_max_pressure ? : MAX_12BIT;
-	ts->touch_pressure =3D pdata->ts_touch_pressure ? : ts->max_pressure;
-	ts->ignore_last	=3D pdata->ts_ignore_last;
-	ts->stab_time	=3D pdata->ts_stab_time;
-
-	if ((r =3D tsc2301_ts_check_config(ts, &ts->hw_flags))) {
-		dev_err(&tsc->spi->dev, "invalid configuration\n");
-		goto err2;
-	}
-
-	idev =3D input_allocate_device();
-	if (idev =3D=3D NULL) {
-		r =3D -ENOMEM;
-		goto err2;
-	}
-	idev->name =3D "TSC2301 touchscreen";
-	snprintf(ts->phys, sizeof(ts->phys),
-		 "%s/input-ts", tsc->spi->dev.bus_id);
-	idev->phys =3D ts->phys;
-
-	idev->evbit[0] =3D BIT(EV_ABS) | BIT(EV_KEY);
-	idev->absbit[0] =3D BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
-	ts->idev =3D idev;
-
-	tsc2301_ts_setup_spi_xfer(tsc);
-
-	/* These parameters should perhaps be configurable? */
-	input_set_abs_params(idev, ABS_X, 0, 4096, 0, 0);
-	input_set_abs_params(idev, ABS_Y, 0, 4096, 0, 0);
-	input_set_abs_params(idev, ABS_PRESSURE, 0, 1024, 0, 0);
-
-	tsc2301_ts_start_scan(tsc);
-
-	ts->irq_enabled =3D 1;
-	r =3D request_irq(ts->irq, tsc2301_ts_irq_handler,
-			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
-			"tsc2301-ts", tsc);
-	if (r < 0) {
-		dev_err(&tsc->spi->dev, "unable to get DAV IRQ");
-		goto err3;
-	}
-	set_irq_wake(ts->irq, 1);
-
-	if (device_create_file(&tsc->spi->dev, &dev_attr_pen_down) < 0)
-		goto err4;
-	if (device_create_file(&tsc->spi->dev, &dev_attr_disable_ts) < 0)
-		goto err5;
-
-	r =3D input_register_device(idev);
-	if (r < 0) {
-		dev_err(&tsc->spi->dev, "can't register touchscreen device\n");
-		goto err6;
-	}
-
-	return 0;
-err6:
-	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
-err5:
-	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
-err4:
-	free_irq(ts->irq, tsc);
-err3:
-	tsc2301_ts_stop_scan(tsc);
-	input_free_device(idev);
-err2:
-#ifdef CONFIG_ARCH_OMAP
-	omap_free_gpio(dav_gpio);
-#endif
-err1:
-	kfree(ts);
-	return r;
-}
-
-void __devexit tsc2301_ts_exit(struct tsc2301 *tsc)
-{
-	struct tsc2301_ts *ts =3D tsc->ts;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ts->lock, flags);
-	tsc2301_ts_disable(tsc);
-	spin_unlock_irqrestore(&ts->lock, flags);
-
-	device_remove_file(&tsc->spi->dev, &dev_attr_disable_ts);
-	device_remove_file(&tsc->spi->dev, &dev_attr_pen_down);
-
-	free_irq(ts->irq, tsc);
-	input_unregister_device(ts->idev);
-
-#ifdef CONFIG_ARCH_OMAP
-	omap_free_gpio(ts->dav_gpio);
-#endif
-	kfree(ts);
-}
-MODULE_AUTHOR("Jarkko Oikarinen <jarkko.oikarinen@nokia.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/spi/tsc2301.c b/drivers/spi/tsc2301.c
new file mode 100644
index 0000000..ae15ca9
--- /dev/null
+++ b/drivers/spi/tsc2301.c
@@ -0,0 +1,302 @@
+/*
+ * TSC2301 driver
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+
+#ifdef CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 data =3D 0, cmd;
+
+	cmd =3D reg;
+	cmd |=3D 0x8000;
+
+	memset(t, 0, sizeof(t));
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	t[0].tx_buf =3D &cmd;
+	t[0].rx_buf =3D NULL;
+	t[0].len =3D 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf =3D NULL;
+	t[1].rx_buf =3D &data;
+	t[1].len =3D 2;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	return data;
+}
+
+void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u16 data[2];
+
+	/* Now we prepare the command for transferring */
+	data[0] =3D reg;
+	data[1] =3D val;
+
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	memset(&t, 0, sizeof(t));
+	t.tx_buf =3D data;
+	t.rx_buf =3D NULL;
+	t.len =3D 4;
+	spi_message_add_tail(&t, &m);
+
+	spi_sync(m.spi, &m);
+}
+
+void tsc2301_write_kbc(struct tsc2301 *tsc, int val)
+{
+	u16 w;
+
+	w =3D tsc->config2_shadow;
+	w &=3D ~(0x03 << 14);
+	w |=3D (val & 0x03) << 14;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow =3D w;
+}
+
+void tsc2301_write_pll(struct tsc2301 *tsc,
+		       int pll_n, int pll_a, int pll_pdc, int pct_e, int pll_o)
+{
+	u16 w;
+
+	w =3D tsc->config2_shadow;
+	w &=3D ~0x3fff;
+	w |=3D (pll_n & 0x0f) | ((pll_a & 0x0f) << 4) | ((pll_pdc & 0x0f) << 8);
+	w |=3D pct_e ? (1 << 12) : 0;
+	w |=3D pll_o ? (1 << 13) : 0;
+	tsc2301_write_reg(tsc, TSC2301_REG_CONFIG2, w);
+	tsc->config2_shadow =3D w;
+}
+
+void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *rx_buf, int len)
+{
+	struct spi_transfer t[2];
+	struct spi_message m;
+	u16 cmd, i;
+
+	cmd =3D reg;
+	cmd |=3D 0x8000;
+
+	spi_message_init(&m);
+	m.spi =3D tsc->spi;
+
+	memset(t, 0, sizeof(t));
+	t[0].tx_buf =3D &cmd;
+	t[0].rx_buf =3D NULL;
+	t[0].len =3D 2;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf =3D NULL;
+	t[1].rx_buf =3D rx_buf;
+	t[1].len =3D 2 * len;
+	spi_message_add_tail(&t[1], &m);
+
+	spi_sync(m.spi, &m);
+
+	for (i =3D 0; i < len; i++)
+		printk(KERN_DEBUG "rx_buf[%d]: %04x\n", i, rx_buf[i]);
+}
+
+static int __devinit tsc2301_probe(struct spi_device *spi)
+{
+	struct tsc2301			*tsc;
+	struct tsc2301_platform_data	*pdata =3D spi->dev.platform_data;
+	int r;
+	u16 w;
+
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	tsc =3D kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (tsc =3D=3D NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tsc);
+	tsc->spi =3D spi;
+	spi->dev.power.power_state =3D PMSG_ON;
+
+	tsc->enable_clock =3D pdata->enable_clock;
+	tsc->disable_clock =3D pdata->disable_clock;
+
+	if (pdata->reset_gpio >=3D 0) {
+		tsc->reset_gpio =3D pdata->reset_gpio;
+#ifdef CONFIG_ARCH_OMAP
+		r =3D omap_request_gpio(tsc->reset_gpio);
+		if (r < 0)
+			goto err1;
+		omap_set_gpio_dataout(tsc->reset_gpio, 1);
+		omap_set_gpio_direction(tsc->reset_gpio, 0);
+		mdelay(1);
+		omap_set_gpio_dataout(tsc->reset_gpio, 0);
+#endif
+	} else
+		tsc->reset_gpio =3D -1;
+
+	spi->mode =3D SPI_MODE_0;
+	spi->bits_per_word =3D 16;
+	/* The max speed might've been defined by the board-specific
+	 * struct */
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz =3D TSC2301_HZ;
+	spi_setup(spi);
+
+	/* Soft reset */
+	tsc2301_write_reg(tsc, TSC2301_REG_RESET, 0xbb00);
+	msleep(1);
+
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_ADC);
+	if (!(w & (1 << 14))) {
+		dev_err(&spi->dev, "invalid ADC reg value: %04x\n", w);
+		r =3D -ENODEV;
+		goto err1;
+	}
+
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_DAC);
+	if (!(w & (1 << 15))) {
+		dev_err(&spi->dev, "invalid DAC reg value: %04x\n", w);
+		r =3D -ENODEV;
+		goto err1;
+	}
+
+	/* Stop keypad scanning */
+	tsc2301_write_reg(tsc, TSC2301_REG_KEY, 0x4000);
+
+	/* We have to cache this for read-modify-write, since we can't
+	 * read back BIT15 */
+	w =3D tsc2301_read_reg(tsc, TSC2301_REG_CONFIG2);
+	/* By default BIT15 is set */
+	w |=3D 1 << 15;
+	tsc->config2_shadow =3D w;
+
+	r =3D tsc2301_kp_init(tsc, pdata);
+	if (r)
+		goto err1;
+	r =3D tsc2301_ts_init(tsc, pdata);
+	if (r)
+		goto err2;
+	r =3D tsc2301_mixer_init(tsc, pdata);
+	if (r)
+		goto err3;
+	return 0;
+
+err3:
+	tsc2301_ts_exit(tsc);
+err2:
+	tsc2301_kp_exit(tsc);
+err1:
+	kfree(tsc);
+	return r;
+}
+
+static int __devexit tsc2301_remove(struct spi_device *spi)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+
+	tsc2301_mixer_exit(tsc);
+        tsc2301_ts_exit(tsc);
+        tsc2301_kp_exit(tsc);
+	kfree(tsc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tsc2301_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+	int r;
+
+	if ((r =3D tsc2301_mixer_suspend(tsc)) < 0)
+		return r;
+	if ((r =3D tsc2301_kp_suspend(tsc)) < 0)
+		goto err1;
+	if ((r =3D tsc2301_ts_suspend(tsc)) < 0)
+		goto err2;
+
+	return 0;
+err2:
+	tsc2301_kp_resume(tsc);
+err1:
+	tsc2301_mixer_resume(tsc);
+	return r;
+}
+
+static int tsc2301_resume(struct spi_device *spi)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(&spi->dev);
+
+	tsc2301_ts_resume(tsc);
+	tsc2301_kp_resume(tsc);
+	tsc2301_mixer_resume(tsc);
+	return 0;
+}
+#endif
+
+static struct spi_driver tsc2301_driver =3D {
+	.driver =3D {
+		   .name =3D "tsc2301",
+		   .bus =3D &spi_bus_type,
+		   .owner =3D THIS_MODULE,
+	},
+#ifdef CONFIG_PM
+	.suspend =3D tsc2301_suspend,
+	.resume =3D tsc2301_resume,
+#endif
+	.probe =3D tsc2301_probe,
+	.remove =3D __devexit_p(tsc2301_remove),
+};
+
+static int __init tsc2301_init(void)
+{
+	printk("TSC2301 driver initializing\n");
+
+	return spi_register_driver(&tsc2301_driver);
+}
+module_init(tsc2301_init);
+
+static void __exit tsc2301_exit(void)
+{
+	spi_unregister_driver(&tsc2301_driver);
+}
+module_exit(tsc2301_exit);
+
+MODULE_AUTHOR("Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/spi/tsc2301.h b/include/linux/spi/tsc2301.h
index adf460e..8121c87 100644
--- a/include/linux/spi/tsc2301.h
+++ b/include/linux/spi/tsc2301.h
@@ -174,21 +174,21 @@ static inline int  tsc2301_##module##_suspend(struct =
tsc2301 *tsc)	\
 }									\
 static inline void tsc2301_##module##_resume(struct tsc2301 *tsc) {}
=20
-#ifdef CONFIG_SPI_TSC2301_KEYPAD
+#ifdef CONFIG_KEYBOARD_TSC2301
 TSC2301_DECL_MOD(kp)
 void tsc2301_kp_restart(struct tsc2301 *tsc);
 #else
 TSC2301_DECL_EMPTY_MOD(kp)
-void tsc2301_kp_restart(struct tsc2301 *tsc) {}
+static inline void tsc2301_kp_restart(struct tsc2301 *tsc) {}
 #endif
=20
-#ifdef CONFIG_SPI_TSC2301_TOUCHSCREEN
+#ifdef CONFIG_TOUCHSCREEN_TSC2301
 TSC2301_DECL_MOD(ts)
 #else
 TSC2301_DECL_EMPTY_MOD(ts)
 #endif
=20
-#ifdef CONFIG_SPI_TSC2301_AUDIO
+#ifdef CONFIG_SND_SOC_TSC2301
 TSC2301_DECL_MOD(mixer)
 extern void tsc2301_mixer_set_power(struct device *tsc_dev, int dac, int a=
dc);
=20
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ec2a278..7e6bc47 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -13,3 +13,9 @@ config SND_SOC_WM8750
 config SND_SOC_WM9712
 	tristate
 	depends on SND_SOC
+
+config SND_SOC_TSC2301
+	tristate "TSC2301 audio support"
+	depends on SPI_TSC2301 && SND_SOC
+	help
+	  Say Y here for if you are using the audio features of TSC2301.
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3249a6e..f551ef2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -2,8 +2,10 @@ snd-soc-ac97-objs :=3D ac97.o
 snd-soc-wm8731-objs :=3D wm8731.o
 snd-soc-wm8750-objs :=3D wm8750.o
 snd-soc-wm9712-objs :=3D wm9712.o
+snd-soc-tsc2301-objs :=3D tsc2301_mixer.o
=20
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+=3D snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_WM8731)	+=3D snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)	+=3D snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM9712)	+=3D snd-soc-wm9712.o
+obj-$(CONFIG_SND_SOC_TSC2301)	+=3D snd-soc-tsc2301.o
diff --git a/sound/soc/codecs/tsc2301_mixer.c b/sound/soc/codecs/tsc2301_mi=
xer.c
new file mode 100644
index 0000000..27eba13
--- /dev/null
+++ b/sound/soc/codecs/tsc2301_mixer.c
@@ -0,0 +1,1064 @@
+/*
+ * drivers/spi/tsc2301-mixer.c
+ *
+ * ALSA Mixer implementation for TSC2301
+ *
+ * Copyright (C) 2006 Nokia Corporation.
+ *
+ * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ *          Juha Yrjola
+ *
+ * Some notes about TSC2301:
+ * - PLL will stop when DAC and ADC's are powered down.
+ * - Touchscreen will stop working when audio part is powered up and if au=
dio
+ *   MCLK is stopped. Problem is avoided if audio is powered down before
+ *   stopping MCLK.
+ * - Audio DAC or audio outputs will activate only after 100 msec from the
+ *   chip power-up. Reason seems to be VCM since there is no this delay if=
 the
+ *   chip and VCM (bit AVPD on PD/MISC) were not powered down. The chip wi=
ll
+ *   consume about 1 mA if all other audio blocks are powered down except =
the
+ *   chip itself and VCM. Full power down consumes only about few uA.
+ * - Power-down transition could happen earliest about 100 msec after the =
chip
+ *   power-up. Otherwise power-down will fail if there is no that 100 msec
+ *   on time before it. It's not obvious why is that since chip reports
+ *   power-up to be completed and also PLL output on GPIO_0 is active in f=
ew
+ *   milliseconds.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+static char *id =3D NULL;
+MODULE_PARM_DESC(id, "TSC2301 ALSA Mixer Driver");
+#endif
+
+/* shadow register indexes */
+enum {
+	/* audio control and volume registers */
+	AUDCNTL_INDEX,
+	ADCVOL_INDEX,
+	DACVOL_INDEX,
+	BPVOL_INDEX,
+	/* keyclick control register (not needed here) */
+	/* audio power control register */
+	PD_MISC_INDEX,
+	/* TSC2301 GPIO control register */
+	GPIO_INDEX,
+
+	SHADOW_REG_COUNT,
+};
+
+/* structure for driver private data */
+struct tsc2301_mixer {
+	struct tsc2301 *tsc;
+	struct mutex mutex;
+
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+	struct snd_card *card;
+#endif
+
+	/* shadow registers holding TSC2301 audio registers. Used to hold
+	 * their states during the sleep and also to reduce communication with
+	 * the chip since get callback functions could get register values
+	 * directly from these shadow registers without needing to read them
+	 * from the chip */
+	u16 shadow_regs[SHADOW_REG_COUNT];
+
+	/* audio controller driver usage of the ADC and DAC */
+	unsigned adc_enabled:1, dac_enabled:1;
+	unsigned pll_output:1;
+	unsigned mclk_enabled;
+
+	/* latest audio power-up timestamp */
+	unsigned long pu_jiffies;
+
+	/* these are used when upper layer(s) are going to power-down TSC2301
+	 * before 100 msec is passed from power-up */
+	struct delayed_work delayed_power_down;
+	unsigned delayed_pd_active:1;
+
+	int (* platform_init)(struct device *);
+	void (* platform_cleanup)(struct device *);
+
+	struct tsc2301_mixer_gpio *mixer_gpios;
+	int n_mixer_gpios;
+};
+
+#define TSC2301_DAC_DELAY		msecs_to_jiffies(100)
+#define TSC2301_MIN_PU_PERIOD		msecs_to_jiffies(100)
+
+#define TSC2301_REG_TO_PVAL(reg)	\
+	(TSC2301_REG_TO_PAGE(reg) << 6 | TSC2301_REG_TO_ADDR(reg))
+#define  TSC2301_PVAL_TO_REG(v)		\
+	(TSC2301_REG((((v) >> 6) & 3),((v) & 0x1f)))
+
+#define TSC2301_VOLUME_MASK		0x7f
+#define TSC2301_MIN_ADCVOL		6
+#define TSC2301_MIN_DACVOL		0
+#define TSC2301_MIN_BPVOL		31
+#define TSC2301_MUTE_LEFT_SHIFT		15
+#define TSC2301_VOL_LEFT_SHIFT		8
+#define TSC2301_MUTE_RIGHT_SHIFT	7
+#define TSC2301_VOL_RIGHT_SHIFT		0
+
+#define TSC2301_INM_MASK		3
+#define TSC2301_INML_SHIFT		12
+#define TSC2301_INMR_SHIFT		10
+
+#define TSC2301_MICG_MASK		3
+#define TSC2301_MICG_MIN		1 /* values 0 & 1 both mean 0 dB */
+#define TSC2301_MICG_SHIFT		8
+
+#define TSC2301_REG_AUDCNTL_MCLK(v)	(((v) & 3) << 6)
+#define TSC2301_REG_AUDCNTL_I2SFS(v)	(((v) & 0xf) << 2)
+#define TSC2301_REG_AUDCNTL_I2SFM(v)	(((v) & 3) << 0)
+
+#define TSC2301_SINGLE(xname, xindex, reg, shadow_index, shift, mask, min)=
 \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_single, \
+	.get =3D snd_tsc2301_get_single, \
+	.put =3D snd_tsc2301_put_single, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (shift << 16) | (mask << 24) | \
+		(min << 28) \
+}
+#define TSC2301_SINGLE_MINVAL(v)	(((v) >> 28) & 15)
+#define TSC2301_SINGLE_SHIFT(v)		(((v) >> 16) & 15)
+#define TSC2301_SINGLE_MASK(v)		(((v) >> 24) & 15)
+
+#define TSC2301_DOUBLE(xname, xindex, reg, shadow_index, ls, rs, mask, min=
) \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_double, \
+	.get =3D snd_tsc2301_get_double, \
+	.put =3D snd_tsc2301_put_double, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (min << 11) | \
+		(ls << 16) | (rs << 20) | (mask << 24) \
+}
+#define TSC2301_DOUBLE_MINVAL(v)	(((v) >> 11) & 0x1f)
+#define TSC2301_DOUBLE_LEFT_SHIFT(v)	(((v) >> 16) & 15)
+#define TSC2301_DOUBLE_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
+#define TSC2301_DOUBLE_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
+
+#define TSC2301_MUX(xname, xindex, reg, shadow_index, ls, rs, mask) \
+{\
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_mux, \
+	.get =3D snd_tsc2301_get_mux, \
+	.put =3D snd_tsc2301_put_mux, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (ls << 16) | (rs << 20) | (mask << 24) \
+}
+#define TSC2301_MUX_LEFT_SHIFT(v)	(((v) >> 16) & 15)
+#define TSC2301_MUX_RIGHT_SHIFT(v)	(((v) >> 20) & 15)
+#define TSC2301_MUX_MASK(v)		(((v) >> 24) & TSC2301_VOLUME_MASK)
+
+#define TSC2301_BOOL(xname, xindex, reg, shadow_index, shift, invert, stat=
e) \
+{ \
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name =3D xname, \
+	.index =3D xindex, \
+	.info =3D snd_tsc2301_info_bool, \
+	.get =3D snd_tsc2301_get_bool, \
+	.put =3D snd_tsc2301_put_bool, \
+	.private_value =3D TSC2301_REG_TO_PVAL(reg) | \
+		(shadow_index << 8) | (shift << 16) | \
+		(invert << 24) | (state << 25) \
+}
+#define TSC2301_BOOL_SHIFT(v)		(((v) >> 16) & 7)
+#define TSC2301_BOOL_INVERT(v)		(((v) >> 24) & 1)
+#define TSC2301_BOOL_STATE(v)		(((v) >> 25) & 1)
+
+#define TSC2301_SHADOW_INDEX(v)		(((v) >> 8) & 7)
+
+/*
+ * Power-down handler for additional GPIO mixer controls. GPIO state of GP=
IO
+ * controls whose power-down flag is enabled are set to their false/deacti=
vate
+ * state
+ *
+ * Must be called tsc->mixer->mutex locked
+ */
+static void tsc2301_gpio_power_down(struct tsc2301 *tsc)
+{
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	u16 temp;
+	int i;
+
+	temp =3D mix->shadow_regs[GPIO_INDEX];
+	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
+		const struct tsc2301_mixer_gpio *mg;
+
+		mg =3D mix->mixer_gpios + i;
+		if (mg->deactivate_on_pd) {
+			int gpio =3D mg->gpio;
+
+			temp &=3D ~(1 << gpio);
+			temp |=3D mg->inverted << gpio;
+		}
+	}
+	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
+}
+
+/*
+ * Powers down/up audio blocks which are muted or become unused.
+ * shadow_index >=3D 0, changes power state of single audio block
+ * shadow_index < 0, changes power state of all blocks
+ *
+ * Must be called tsc->mixer->mutex locked
+ */
+#define TSC2301_MUTE_MASK \
+	((1 << TSC2301_MUTE_LEFT_SHIFT) | (1 << TSC2301_MUTE_RIGHT_SHIFT))
+static void tsc2301_power_ctrl(struct tsc2301 *tsc, int shadow_index,
+			       int poll_pdsts)
+{
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	u16 pd_ctrl, pd_ctrl_old, w;
+	unsigned long timeout;
+	int power_up =3D 0;
+
+	if (mix->delayed_pd_active) {
+		mix->delayed_pd_active =3D 0;
+		mix->mclk_enabled--;
+		cancel_delayed_work(&mix->delayed_power_down);
+	}
+
+	pd_ctrl =3D pd_ctrl_old =3D mix->shadow_regs[PD_MISC_INDEX];
+	/* power control helper based on used space mixer selections. See
+	 * actual power control decisions below */
+	if (shadow_index < 0 || shadow_index =3D=3D ADCVOL_INDEX) {
+		/* ADC left and right power down control */
+		if (mix->shadow_regs[ADCVOL_INDEX] &
+		    (1 << TSC2301_MUTE_LEFT_SHIFT))
+			/* left ADC muted. Power down the left ADC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDL;
+		if (mix->shadow_regs[ADCVOL_INDEX] &
+		    (1 << TSC2301_MUTE_LEFT_SHIFT))
+			/* right ADC muted. Power down the right ADC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ADPDR;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D DACVOL_INDEX) {
+		/* DAC power down control */
+		if ((mix->shadow_regs[DACVOL_INDEX] &
+		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
+			/* both DACs muted. Power down the DAC */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_DAPD;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D BPVOL_INDEX) {
+		/* line bypass power down control */
+		if ((mix->shadow_regs[BPVOL_INDEX] &
+		     TSC2301_MUTE_MASK) =3D=3D TSC2301_MUTE_MASK)
+			/* both line bypasses muted. Power down the bypass
+			 * path */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ABPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_ABPD;
+	}
+	if (shadow_index < 0 || shadow_index =3D=3D AUDCNTL_INDEX) {
+		/* mic bias power down control */
+		if ((mix->shadow_regs[AUDCNTL_INDEX] &
+		     (3 << TSC2301_INML_SHIFT)) &&
+		    (mix->shadow_regs[AUDCNTL_INDEX] &
+		     (3 << TSC2301_INMR_SHIFT)))
+			/* both ADC channels use other than mic input. Power
+			 * down the mic bias output */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
+		else
+			pd_ctrl &=3D ~TSC2301_REG_PD_MISC_MIBPD;
+	}
+
+	/* power control decisions based on codec usage and user space mixer
+	 * selections detected above */
+	pd_ctrl &=3D ~TSC2301_REG_PD_MISC_APD; /* audio not powered down */
+	if (mix->mclk_enabled) {
+		if (!mix->adc_enabled) {
+			/* ADC not used, power down both ADC's and mic bias
+			 * output independently of user space mixer
+			 * selections */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDL;
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_ADPDR;
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_MIBPD;
+		}
+		if (!mix->dac_enabled) {
+			/* DAC not used, power down DAC independently of user
+			 * space mixer selections */
+			pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD;
+		}
+
+		if (mix->pll_output) {
+			/* GPIO_0 is configured as PLL output so audio
+			 * controller is expecting clock from TSC2301. Either
+			 * ADC or DAC must be active in order to keep PLL on */
+			if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
+			    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
+			    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
+				/* neither ADC or DAC used. Force ADC on in
+				 * order to keep PLL active */
+				pd_ctrl &=3D ~(TSC2301_REG_PD_MISC_ADPDL |
+					     TSC2301_REG_PD_MISC_ADPDR);
+			}
+		}
+	} else {
+		/* audio input clock is not enabled so power down DAC and ADC
+		 * in order to shutdown PLL and to keep touchscreen and keypad
+		 * parts working. Touchscreen and keypad use audio clock when
+		 * PLL is on and internal clock otherwise */
+		pd_ctrl |=3D TSC2301_REG_PD_MISC_DAPD |
+			   TSC2301_REG_PD_MISC_ADPDL |
+			   TSC2301_REG_PD_MISC_ADPDR;
+	}
+
+	if ((pd_ctrl & TSC2301_REG_PD_MISC_ADPDL) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_ADPDR) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_DAPD) &&
+	    (pd_ctrl & TSC2301_REG_PD_MISC_ABPD)) {
+		/* all ADC, DAC and line bypass path unused. Power down the
+		 * whole audio part of the TSC2301 */
+		pd_ctrl |=3D TSC2301_REG_PD_MISC_APD;
+	}
+
+	if (pd_ctrl =3D=3D pd_ctrl_old)
+		return;
+
+	/* power down control changed. Update into TSC2301 */
+	if ((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_APD) {
+		/* whole audio power state changed. Update GPIO states */
+		if (pd_ctrl & TSC2301_REG_PD_MISC_APD) {
+			/* power down GPIO controls before powering down
+			 * the codec */
+			tsc2301_gpio_power_down(tsc);
+			/* we must really ensure that codec has been on no less
+			 * than 100 msec before doing power-down */
+			timeout =3D mix->pu_jiffies + TSC2301_MIN_PU_PERIOD -
+				  jiffies;
+			if (timeout <=3D TSC2301_MIN_PU_PERIOD) {
+				mix->delayed_pd_active =3D 1;
+				mix->mclk_enabled++;
+				schedule_delayed_work(&mix->delayed_power_down,
+						      timeout + 1);
+				return;
+			}
+		} else
+			/* restore GPIOs after codec is powered up */
+			power_up =3D 1;
+	}
+	mix->shadow_regs[PD_MISC_INDEX] =3D pd_ctrl;
+	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC, pd_ctrl);
+	if (power_up)
+		mix->pu_jiffies =3D jiffies;
+	if (!poll_pdsts) {
+		if (power_up)
+			tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
+					  mix->shadow_regs[GPIO_INDEX]);
+		return;
+	}
+
+	/* wait until power-up/-down is completed */
+	timeout =3D jiffies + msecs_to_jiffies(100);
+	w =3D 0;
+	do {
+		if (time_after(jiffies, timeout)) {
+			/* Print a warning only if the I2S clock is not
+			 * present / out of sync. This can happen during
+			 * init time, when that clock will be turned on
+			 * by another driver like in the OMAP EAC with
+			 * external clock case.
+			 */
+			if (w & TSC2301_REG_PD_MISC_OTSYN) {
+				dev_warn(&tsc->spi->dev,
+				   "I2S clock not in sync or off.\n");
+			} else {
+				dev_err(&tsc->spi->dev,
+				   "power-up/-down timed out "
+				   "(0x%04x, 0x%04x -> 0x%04x)\n",
+				   w, pd_ctrl_old, pd_ctrl);
+			}
+			goto out;
+		}
+		w =3D tsc2301_read_reg(tsc, TSC2301_REG_PD_MISC);
+	} while (!(w & TSC2301_REG_PD_MISC_PDSTS));
+
+out:
+	if (((pd_ctrl ^ pd_ctrl_old) & TSC2301_REG_PD_MISC_DAPD) &&
+	    !(pd_ctrl & TSC2301_REG_PD_MISC_DAPD)) {
+		/* DAC powered up now. Ensure that DAC and audio outputs are
+		 * activated. They are up 100 msec after the chip power-up
+		 * command */
+		timeout =3D mix->pu_jiffies + TSC2301_DAC_DELAY - jiffies;
+		if (timeout <=3D TSC2301_DAC_DELAY)
+			schedule_timeout_interruptible(timeout);
+		/* FIXME: This is lazy. We restore GPIOs only after activating
+		 * the DAC. It would be better to do some kind of delayed GPIO
+		 * restore. That ensures that we restore them also if only ADC
+		 * path is activated. But this is required only if there is
+		 * some input amplifier, bias control, etc. and their power
+		 * state is under TSC GPIO control */
+		tsc2301_write_reg(tsc, TSC2301_REG_GPIO,
+				  mix->shadow_regs[GPIO_INDEX]);
+	}
+}
+
+static int snd_tsc2301_info_single(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	int mask =3D TSC2301_SINGLE_MASK(kcontrol->private_value);
+	int minval =3D TSC2301_SINGLE_MINVAL(kcontrol->private_value);
+
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D minval;
+	uinfo->value.integer.max =3D mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_single(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_SINGLE_MASK(priv);
+	int shift =3D TSC2301_SINGLE_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+
+	ucontrol->value.integer.value[0] =3D (shadow_reg >> shift) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_single(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_SINGLE_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int shift =3D TSC2301_SINGLE_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~(mask << shift);
+	/* modify with new value */
+	shadow_reg |=3D ((ucontrol->value.integer.value[0] & mask) << shift);
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+
+	/* update into TSC2301 if necessary */
+	if (changed)
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_double(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Max volume */
+	int mask =3D TSC2301_DOUBLE_MASK(kcontrol->private_value);
+	int minval =3D TSC2301_DOUBLE_MINVAL(kcontrol->private_value);
+
+	uinfo->type =3D mask =3D=3D 1 ? SNDRV_CTL_ELEM_TYPE_BOOLEAN :
+		SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 2;
+	uinfo->value.integer.min =3D minval;
+	uinfo->value.integer.max =3D mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_double(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Volume */
+	int mask =3D TSC2301_DOUBLE_MASK(priv);
+	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* invert mute bits for the switches */
+	if (mask =3D=3D 1)
+		shadow_reg =3D ~shadow_reg;
+
+	ucontrol->value.integer.value[0] =3D (shadow_reg >> ls) & mask;
+	ucontrol->value.integer.value[1] =3D (shadow_reg >> rs) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_double(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	/* mask =3D=3D 1 : Switch
+	 * mask > 1 : Volume */
+	int mask =3D TSC2301_DOUBLE_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int ls =3D TSC2301_DOUBLE_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_DOUBLE_RIGHT_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~((mask << ls) | (mask << rs));
+	/* modify with new value */
+	if (mask =3D=3D 1) {
+		/* switch. Invert switch values for the mute bits */
+		shadow_reg |=3D
+			((~ucontrol->value.integer.value[0] & mask) << ls) |
+			((~ucontrol->value.integer.value[1] & mask) << rs);
+	} else {
+		/* volume */
+		shadow_reg |=3D
+			(ucontrol->value.integer.value[0] << ls) |
+			(ucontrol->value.integer.value[1] << rs);
+	}
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+	tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+
+	/* update into TSC2301 if necessary */
+	if (changed)
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+
+	if (mask =3D=3D 1)
+		/* check is need to power down/up audio blocks in case of
+		 * muted state change */
+		tsc2301_power_ctrl(tsc, shadow_index, 0);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_mux(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[4] =3D {"Mic", "Line", "Line swapped", "Line mono"};
+
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count =3D 2;
+	uinfo->value.enumerated.items =3D 4;
+	if (uinfo->value.enumerated.item > 3)
+		uinfo->value.enumerated.item =3D 3;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_tsc2301_get_mux(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_MUX_MASK(priv);
+	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+	ucontrol->value.enumerated.item[0] =3D (shadow_reg >> ls) & mask;
+	ucontrol->value.enumerated.item[1] =3D (shadow_reg >> rs) & mask;
+
+	return 0;
+}
+
+static int snd_tsc2301_put_mux(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int mask =3D TSC2301_MUX_MASK(priv);
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int ls =3D TSC2301_MUX_LEFT_SHIFT(priv);
+	int rs =3D TSC2301_MUX_RIGHT_SHIFT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* zero bits to be modified */
+	shadow_reg &=3D ~((mask << ls) | (mask << rs));
+	/* modify with new value */
+	shadow_reg |=3D (ucontrol->value.enumerated.item[0] << ls);
+	shadow_reg |=3D (ucontrol->value.enumerated.item[1] << rs);
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+
+	/* update into TSC2301 if necessary */
+	if (changed) {
+		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+		tsc2301_write_reg(tsc, reg, shadow_reg);
+	}
+
+	/* check is need to power up/down audio blocks in case of ADC input
+	 * change */
+	tsc2301_power_ctrl(tsc, shadow_index, 0);
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+static int snd_tsc2301_info_bool(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+
+	return 0;
+}
+
+static int snd_tsc2301_get_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	int shift =3D TSC2301_BOOL_SHIFT(priv);
+	int invert =3D TSC2301_BOOL_INVERT(priv);
+	u16 shadow_reg;
+
+	shadow_reg =3D tsc->mixer->shadow_regs[shadow_index];
+	ucontrol->value.integer.value[0] =3D
+		invert ^ ((shadow_reg >> shift) & 1);
+
+	return 0;
+}
+
+static int snd_tsc2301_put_bool(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct tsc2301 *tsc =3D kcontrol->private_data;
+	unsigned long priv =3D kcontrol->private_value;
+	int shadow_index =3D TSC2301_SHADOW_INDEX(priv);
+	int shift =3D TSC2301_BOOL_SHIFT(priv);
+	int invert =3D TSC2301_BOOL_INVERT(priv);
+	int reg =3D TSC2301_PVAL_TO_REG(priv);
+	u16 shadow_reg, shadow_reg_old;
+	int changed;
+
+	mutex_lock(&tsc->mixer->mutex);
+	shadow_reg =3D shadow_reg_old =3D tsc->mixer->shadow_regs[shadow_index];
+
+	/* zero bit to be modified */
+	shadow_reg &=3D ~(1 << shift);
+	/* modify with new value */
+	shadow_reg |=3D
+		(invert ^ (ucontrol->value.integer.value[0] & 1)) << shift;
+
+	changed =3D (shadow_reg !=3D shadow_reg_old);
+
+	/* update into TSC2301 if necessary */
+	if (changed) {
+		tsc->mixer->shadow_regs[shadow_index] =3D shadow_reg;
+		if ((shadow_index =3D=3D GPIO_INDEX) &&
+		    (tsc->mixer->shadow_regs[PD_MISC_INDEX] &
+		     TSC2301_REG_PD_MISC_APD)) {
+			/* changing GPIO control and audio is powered down.
+			 * Update GPIO states according to their power-down
+			 * flag */
+			tsc2301_gpio_power_down(tsc);
+		} else
+			tsc2301_write_reg(tsc, reg, shadow_reg);
+	}
+	mutex_unlock(&tsc->mixer->mutex);
+
+	return changed;
+}
+
+/* TSC2301 internal mixer controls */
+static struct snd_kcontrol_new snd_tsc2301_controls[] =3D {
+	/* stereo ADC input switches and volumes */
+	TSC2301_DOUBLE("Capture Switch", 0,
+		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("Capture Volume", 0,
+		TSC2301_REG_ADCVOL, ADCVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_ADCVOL),
+
+	/* stereo DAC output switches and volumes */
+	TSC2301_DOUBLE("PCM Playback Switch", 0,
+		TSC2301_REG_DACVOL, DACVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("PCM Playback Volume", 0,
+		TSC2301_REG_DACVOL, DACVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_DACVOL),
+
+	/* stereo line input bypass switches and volumes */
+	TSC2301_DOUBLE("Line Playback Switch", 0,
+		TSC2301_REG_BPVOL, BPVOL_INDEX,
+		TSC2301_MUTE_LEFT_SHIFT, TSC2301_MUTE_RIGHT_SHIFT,
+		1, 0),
+	TSC2301_DOUBLE("Line Playback Volume", 0,
+		TSC2301_REG_BPVOL, BPVOL_INDEX,
+		TSC2301_VOL_LEFT_SHIFT, TSC2301_VOL_RIGHT_SHIFT,
+		TSC2301_VOLUME_MASK, TSC2301_MIN_BPVOL),
+
+	/* mono microphone input gain */
+	TSC2301_SINGLE("Mic Boost", 0,
+		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
+		TSC2301_MICG_SHIFT,
+		TSC2301_MICG_MASK, TSC2301_MICG_MIN),
+
+	/* ADC input sources. Both channels could be selected separately */
+	TSC2301_MUX("Capture Source", 0,
+		TSC2301_REG_AUDCNTL, AUDCNTL_INDEX,
+		TSC2301_INML_SHIFT, TSC2301_INMR_SHIFT,
+		TSC2301_INM_MASK),
+};
+
+/* must be called tsc->mixer->mutex locked */
+static void tsc2301_flush_shadow_regs(struct tsc2301 *tsc)
+{
+	int i, page, addr;
+	u16 temp;
+
+	page =3D TSC2301_REG_TO_PAGE(TSC2301_REG_AUDCNTL);
+	addr =3D TSC2301_REG_TO_ADDR(TSC2301_REG_AUDCNTL);
+
+	for (i =3D 0; i < 4; i++) {
+		temp =3D tsc->mixer->shadow_regs[i];
+		tsc2301_write_reg(tsc, TSC2301_REG(page, addr + i), temp);
+	}
+	temp =3D tsc->mixer->shadow_regs[GPIO_INDEX];
+	tsc2301_write_reg(tsc, TSC2301_REG_GPIO, temp);
+
+	/* Update power state of all audio blocks depending are they
+	 * muted or unused. */
+	tsc2301_power_ctrl(tsc, -1, 0);
+}
+
+#ifdef CONFIG_PM
+int tsc2301_mixer_suspend(struct tsc2301 *tsc)
+{
+	/* power down entire audio section inside TSC2301 in case the
+	 * chip is still powered during the system sleep. However this driver
+	 * doesn't require that chip is powered because registers are restored
+	 * in function tsc2301_mixer_resume */
+	mutex_lock(&tsc->mixer->mutex);
+	tsc2301_gpio_power_down(tsc);
+	tsc->mixer->shadow_regs[PD_MISC_INDEX] |=3D TSC2301_REG_PD_MISC_APD;
+	tsc2301_write_reg(tsc, TSC2301_REG_PD_MISC,
+			  tsc->mixer->shadow_regs[PD_MISC_INDEX]);
+	mutex_unlock(&tsc->mixer->mutex);
+	return 0;
+}
+
+void tsc2301_mixer_resume(struct tsc2301 *tsc)
+{
+	/* power up the TSC2301 audio section and restore registers */
+	mutex_lock(&tsc->mixer->mutex);
+	tsc->mixer->shadow_regs[PD_MISC_INDEX] &=3D ~TSC2301_REG_PD_MISC_APD;
+	tsc2301_flush_shadow_regs(tsc);
+	mutex_unlock(&tsc->mixer->mutex);
+}
+#endif
+
+void tsc2301_mixer_enable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+
+	mutex_lock(&mix->mutex);
+	if (!mix->mclk_enabled++ && tsc->enable_clock !=3D NULL) {
+		tsc->enable_clock(dev);
+	}
+	tsc2301_power_ctrl(tsc, -1, 1);
+	mutex_unlock(&mix->mutex);
+}
+
+void tsc2301_mixer_disable_mclk(struct device *dev)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+
+	mutex_lock(&mix->mutex);
+	mix->mclk_enabled--;
+	tsc2301_power_ctrl(tsc, -1, 1);
+	if (!mix->mclk_enabled && tsc->disable_clock !=3D NULL) {
+		tsc->disable_clock(dev);
+	}
+	mutex_unlock(&mix->mutex);
+}
+
+static void tsc2301_mixer_delayed_power_down(struct work_struct *work)
+{
+	struct tsc2301_mixer *mix =3D container_of(work, struct tsc2301_mixer,
+						 delayed_power_down.work);
+	struct tsc2301 *tsc =3D mix->tsc;
+
+	mutex_lock(&mix->mutex);
+	if (!mix->delayed_pd_active) {
+		mutex_unlock(&mix->mutex);
+		return;
+	}
+	mix->delayed_pd_active =3D 0;
+	mutex_unlock(&mix->mutex);
+	tsc2301_mixer_disable_mclk(&tsc->spi->dev);
+}
+
+/*
+ * Allows audio controller driver to notify its usage of ADC and DAC
+ */
+void tsc2301_mixer_set_power(struct device *dev, int dac, int adc)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+
+	mutex_lock(&tsc->mixer->mutex);
+	tsc->mixer->adc_enabled =3D adc;
+	tsc->mixer->dac_enabled =3D dac;
+
+	/* update power state of all audio blocks */
+	tsc2301_power_ctrl(tsc, -1, 1);
+	mutex_unlock(&tsc->mixer->mutex);
+}
+
+/*
+ * Registers TSC2301 ALSA Mixer controls for the given sound card
+ */
+int tsc2301_mixer_register_controls(struct device *dev, struct snd_card *c=
ard)
+{
+	struct tsc2301 *tsc =3D dev_get_drvdata(dev);
+	struct tsc2301_mixer *mix =3D tsc->mixer;
+	int i, err;
+
+	/* Register ALSA mixer controls */
+	for (i =3D 0; i < ARRAY_SIZE(snd_tsc2301_controls); i++) {
+		err =3D snd_ctl_add(card,
+				  snd_ctl_new1(&snd_tsc2301_controls[i], tsc));
+		if (err < 0)
+			return err;
+	}
+
+	if (!mix->n_mixer_gpios)
+		return 0;
+
+	/* Register additional GPIO controls if defined */
+	for (i =3D 0; i < mix->n_mixer_gpios; i++) {
+		const struct tsc2301_mixer_gpio *mg =3D mix->mixer_gpios + i;
+		struct snd_kcontrol *ctrlp;
+		struct snd_kcontrol_new ctrl =3D
+			TSC2301_BOOL((char *)mg->name, 0,
+				     TSC2301_REG_GPIO, GPIO_INDEX,
+				     mg->gpio, mg->inverted, mg->def_enable);
+
+		ctrlp =3D snd_ctl_new1(&ctrl, tsc);
+		err =3D snd_ctl_add(card, ctrlp);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+static int tsc2301_mixer_register_card(struct tsc2301 *tsc)
+{
+	struct snd_card *card;
+	int err;
+
+	/* create new sound card instance */
+	card =3D snd_card_new(-1, id, THIS_MODULE, 0);
+	if (card =3D=3D NULL)
+		return -ENOMEM;
+
+	tsc->mixer->card =3D card;
+
+	strcpy(card->driver, "TSC2301");
+	strcpy(card->shortname, "TSC2301");
+	sprintf(card->longname, "TSC2301 ALSA Mixer");
+	strcpy(card->mixername, "TSC2301 Mixer");
+
+	/* register mixer controls for the sound card */
+	if ((err =3D tsc2301_mixer_register_controls(&tsc->spi->dev, card)) !=3D =
0)
+		goto err1;
+
+	/* register the sound card instance */
+	if ((err =3D snd_card_register(card)) !=3D 0)
+		goto err1;
+
+	printk(KERN_INFO "TSC2301 ALSA Mixer support initialized\n");
+
+	return 0;
+err1:
+	snd_card_free(card);
+	return err;
+}
+#endif
+
+int tsc2301_mixer_init(struct tsc2301 *tsc,
+		       struct tsc2301_platform_data *pdata)
+{
+	struct tsc2301_mixer *mix;
+	int err =3D 0;
+	u16 w;
+
+	mix =3D kzalloc(sizeof(*mix), GFP_KERNEL);
+	if (mix =3D=3D NULL)
+		return -ENOMEM;
+	tsc->mixer =3D mix;
+
+	mix->tsc =3D tsc;
+	mutex_init(&mix->mutex);
+	mix->platform_init =3D pdata->codec_init;
+	mix->platform_cleanup =3D pdata->codec_cleanup;
+	mix->pll_output =3D pdata->pll_output;
+
+	INIT_DELAYED_WORK(&mix->delayed_power_down,
+			  tsc2301_mixer_delayed_power_down);
+
+	/* initialize shadow register default values */
+	w =3D 0xc000;
+	w |=3D (pdata->mclk_ratio << 6) | (pdata->i2s_sample_rate << 2);
+	w |=3D pdata->i2s_format;
+	mix->shadow_regs[AUDCNTL_INDEX] =3D w;
+	mix->shadow_regs[ADCVOL_INDEX] =3D 0xd7d7;
+	mix->shadow_regs[DACVOL_INDEX] =3D 0xffff;
+	mix->shadow_regs[BPVOL_INDEX] =3D 0xe7e7;
+	mix->shadow_regs[PD_MISC_INDEX] =3D pdata->power_down_blocks;
+
+	/* if extra mixer controls configured, then configure associated
+	 * GPIOs as output and drive their default state */
+	if (pdata->n_mixer_gpios) {
+		int i;
+
+		w =3D 0;
+		for (i =3D 0; i < pdata->n_mixer_gpios; i++) {
+			const struct tsc2301_mixer_gpio *mg;
+			int gpio;
+
+			mg =3D pdata->mixer_gpios + i;
+			gpio =3D mg->gpio;
+			w |=3D (1 << gpio) << 8;
+			w |=3D (mg->inverted ^ mg->def_enable) << gpio;
+		}
+		mix->shadow_regs[GPIO_INDEX] =3D w;
+
+		mix->mixer_gpios =3D kmalloc(sizeof(*pdata->mixer_gpios) *
+					   pdata->n_mixer_gpios,
+					   GFP_KERNEL);
+		if (mix->mixer_gpios =3D=3D NULL) {
+			err =3D -ENOMEM;
+			goto err1;
+		}
+		memcpy(mix->mixer_gpios, pdata->mixer_gpios,
+		       sizeof(*pdata->mixer_gpios) * pdata->n_mixer_gpios);
+		mix->n_mixer_gpios =3D pdata->n_mixer_gpios;
+	}
+
+	/* PLL control */
+	tsc2301_write_pll(tsc, pdata->pll_n, pdata->pll_a, pdata->pll_pdc,
+			  0, mix->pll_output ? 0 : 1);
+
+	tsc2301_flush_shadow_regs(tsc);
+
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+	err =3D tsc2301_mixer_register_card(tsc);
+	if (err < 0)
+		goto err2;
+#endif
+
+	if (mix->platform_init !=3D NULL) {
+		err =3D mix->platform_init(&tsc->spi->dev);
+		if (err < 0)
+			goto err3;
+	}
+
+	return 0;
+err3:
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+	snd_card_free(mix->card);
+err2:
+#endif
+	if (mix->mixer_gpios !=3D NULL)
+		kfree(mix->mixer_gpios);
+err1:
+	kfree(mix);
+	return err;
+}
+
+void tsc2301_mixer_exit(struct tsc2301 *tsc)
+{
+	struct tsc2301_mixer *mixer =3D tsc->mixer;
+
+#ifdef TSC2301_MIXER_SELF_REGISTRATION
+	snd_card_free(mixer->card);
+#endif
+
+	if (mixer->platform_cleanup !=3D NULL)
+		mixer->platform_cleanup(&tsc->spi->dev);
+
+	if (mixer->mixer_gpios !=3D NULL)
+		kfree(mixer->mixer_gpios);
+}
+
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_LICENSE("GPL");
--=20
1.4.4.4


--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw
Content-Type: text/plain;
	name="0001-ARM-OMAP-Update-changed-TSC2301-config-names-in-N800-board-files.txt"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Update-changed-TSC2301-config-names-in-N800-board-files.txt"
Content-Transfer-Encoding: 7bit

>From a13969da06868c009699eee19db824f143cdcedd Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Fri, 16 Mar 2007 14:00:50 +0200
Subject: [PATCH] ARM: OMAP: Update changed TSC2301 config names in N800 board files

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800-audio.c |    2 +-
 arch/arm/mach-omap2/board-n800.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
index b5b107d..09119fb 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -31,7 +31,7 @@
 
 #include "../plat-omap/dsp/dsp_common.h"
 
-#if defined(CONFIG_SPI_TSC2301_AUDIO) && defined(CONFIG_SND_OMAP24XX_EAC)
+#if defined(CONFIG_SND_SOC_TSC2301) && defined(CONFIG_SND_OMAP24XX_EAC)
 #define AUDIO_ENABLED
 
 static struct clk *sys_clkout2;
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 69e5d36..bb805cf 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -409,7 +409,7 @@ static struct platform_device n800_keypad_led_device = {
 };
 #endif
 
-#if defined(CONFIG_SPI_TSC2301_TOUCHSCREEN)
+#if defined(CONFIG_TOUCHSCREEN_TSC2301)
 static void __init n800_ts_set_config(void)
 {
 	const struct omap_lcd_config *conf;
-- 
1.4.4.4


--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Multipart=_Mon__19_Mar_2007_10_55_37_+0200_07STthLWU3LMWVaw--
