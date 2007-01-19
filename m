From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Basic N800 support
Date: Fri, 19 Jan 2007 12:57:24 -0800
Message-ID: <20070119205723.GC16754@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a quick patch of N800 support against the current git tree for
people to play with until we get N800 support merged in. It just
contains the board support and basic NAND changes to get root mounted,
so most driver changes are not included. 

Regards,

Tony


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=patch-n800-add-minimal
Content-Transfer-Encoding: quoted-printable

--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -22,9 +22,14 @@
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
=20
+config MACH_NOKIA_N800
+	bool "Nokia N800"
+	depends on ARCH_OMAP24XX
+
 config MACH_OMAP2_TUSB6010
 	bool
 	depends on ARCH_OMAP2 && ARCH_OMAP2420
+	default y if MACH_NOKIA_N800
=20
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -20,6 +20,10 @@
 obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o
+obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \
+					   board-n800-mmc.o board-n800-bt.o \
+					   board-n800-audio.o board-n800-usb.o \
+					   board-n800-dsp.o board-n800-pm.o
=20
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+=3D usb-tusb6010.o
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -0,0 +1,357 @@
+/*
+ * linux/arch/arm/mach-omap/omap2/board-n800-audio.c
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Contact: Juha Yrj?l?
+ *          Jarkko Nikula <jarkko.nikula@nokia.com>
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
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/spi/tsc2301.h>
+
+#include <asm/io.h>
+#include <asm/arch/eac.h>
+
+#include "../plat-omap/dsp/dsp_common.h"
+
+#if defined(CONFIG_SPI_TSC2301_AUDIO) && defined(CONFIG_SND_OMAP24XX_EAC=
)
+#define AUDIO_ENABLED
+
+static struct clk *sys_clkout2;
+static struct clk *func96m_clk;
+static struct device *eac_device;
+static struct device *tsc2301_device;
+
+static int enable_audio;
+static int audio_ok;
+static spinlock_t audio_lock;
+
+
+/*
+ * Leaving EAC pins multiplexed to EAC functionality results
+ * in about 2 mA extra current leaked. The workaround is to
+ * multiplex the EAC pins to protected mode (with pull-ups enabled)
+ * whenever audio is not being used.
+ */
+static int mux_disabled;
+static u32 saved_mux[2];
+
+static void n800_enable_eac_mux(void)
+{
+	if (!mux_disabled)
+		return;
+	__raw_writel(saved_mux[0], IO_ADDRESS(0x480000e8));
+	__raw_writel(saved_mux[1], IO_ADDRESS(0x48000124));
+	mux_disabled =3D 0;
+}
+
+static void n800_disable_eac_mux(void)
+{
+	u32 l;
+
+	if (mux_disabled) {
+		WARN_ON(mux_disabled);
+		return;
+	}
+	saved_mux[0] =3D __raw_readl(IO_ADDRESS(0x480000e8));
+	saved_mux[1] =3D __raw_readl(IO_ADDRESS(0x48000124));
+	l =3D saved_mux[0] & ~0xff;
+	l |=3D 0x1f;
+	__raw_writel(l, IO_ADDRESS(0x480000e8));
+	__raw_writel(0x1f1f1f1f, IO_ADDRESS(0x48000124));
+	mux_disabled =3D 1;
+}
+
+static int n800_eac_enable_ext_clocks(struct device *dev)
+{
+	BUG_ON(tsc2301_device =3D=3D NULL);
+	n800_enable_eac_mux();
+	tsc2301_enable_mclk(tsc2301_device);
+
+	return 0;
+}
+
+static void n800_eac_disable_ext_clocks(struct device *dev)
+{
+	BUG_ON(tsc2301_device =3D=3D NULL);
+	n800_disable_eac_mux();
+	tsc2301_disable_mclk(tsc2301_device);
+}
+
+static int n800_audio_set_power(void *pdata, int dac, int adc)
+{
+	BUG_ON(pdata !=3D tsc2301_device);
+	tsc2301_mixer_set_power(tsc2301_device, dac, adc);
+
+	return 0;
+}
+
+static int n800_audio_register_controls(void *pdata, struct snd_card *ca=
rd)
+{
+	BUG_ON(pdata !=3D tsc2301_device);
+	return tsc2301_mixer_register_controls(tsc2301_device, card);
+}
+
+static struct eac_codec n800_eac_codec =3D {
+	.mclk_src =3D EAC_MCLK_EXT_2x12288000,
+	.codec_mode =3D EAC_CODEC_I2S,
+	.codec_conf.i2s.polarity_changed_mode =3D 0,
+	.codec_conf.i2s.sync_delay_enable =3D 0,
+	.default_rate =3D 48000,
+	.set_power =3D n800_audio_set_power,
+	.register_controls =3D n800_audio_register_controls,
+	.short_name =3D "TSC2301",
+};
+
+static int n800_register_codec(void)
+{
+	int r, do_enable =3D 0;
+	unsigned long flags;
+
+	n800_eac_codec.private_data =3D tsc2301_device;
+	r =3D eac_register_codec(eac_device, &n800_eac_codec);
+	if (r < 0)
+		return r;
+	spin_lock_irqsave(&audio_lock, flags);
+	audio_ok =3D 1;
+	if (enable_audio)
+		do_enable =3D 1;
+	spin_unlock_irqrestore(&audio_lock, flags);
+	if (do_enable)
+		eac_set_mode(eac_device, 1, 1);
+	return 0;
+}
+
+static void n800_unregister_codec(void)
+{
+	audio_ok =3D 0;
+	eac_unregister_codec(eac_device);
+	eac_set_mode(eac_device, 0, 0);
+}
+
+static int n800_eac_init(struct device *dev)
+{
+	int r;
+
+	BUG_ON(eac_device !=3D NULL);
+	eac_device =3D dev;
+	if (tsc2301_device !=3D NULL) {
+		r =3D n800_register_codec();
+		if (r < 0)
+			return r;
+	}
+
+	return 0;
+}
+
+static void n800_eac_cleanup(struct device *dev)
+{
+	eac_device =3D NULL;
+	if (tsc2301_device !=3D NULL)
+		n800_unregister_codec();
+}
+
+static int n800_codec_get_clocks(struct device *dev)
+{
+	sys_clkout2 =3D clk_get(dev, "sys_clkout2");
+	if (IS_ERR(sys_clkout2)) {
+		printk(KERN_ERR "Could not get sys_clkout2\n");
+		return -ENODEV;
+	}
+	/* configure 12 MHz output on SYS_CLKOUT2. Therefore we must use
+	 * 96 MHz as its parent in order to get 12 MHz */
+	func96m_clk =3D clk_get(dev, "func_96m_ck");
+	if (IS_ERR(func96m_clk)) {
+		printk(KERN_ERR "could not get func 96M clock\n");
+		clk_put(sys_clkout2);
+		return -ENODEV;
+	}
+
+	clk_set_parent(sys_clkout2, func96m_clk);
+	clk_set_rate(sys_clkout2, 12000000);
+
+	return 0;
+}
+
+static void n800_codec_put_clocks(struct device *dev)
+{
+	clk_put(func96m_clk);
+	clk_put(sys_clkout2);
+}
+
+static int n800_codec_enable_clock(struct device *dev)
+{
+	int err;
+
+	err =3D clk_enable(sys_clkout2);
+	if (err)
+		return err;
+	/* TODO: 'educated' guess for audio codec's PLL startup delay */
+	mdelay(1);
+
+	return 0;
+}
+
+static void n800_codec_disable_clock(struct device *dev)
+{
+	clk_disable(sys_clkout2);
+}
+
+static int n800_codec_init(struct device *dev)
+{
+	int r;
+
+	BUG_ON(tsc2301_device !=3D NULL);
+	tsc2301_device =3D dev;
+	if ((r =3D n800_codec_get_clocks(dev)) < 0)
+		return r;
+	if (eac_device !=3D NULL) {
+		r =3D n800_register_codec();
+		if (r < 0) {
+			n800_codec_put_clocks(dev);
+			return r;
+		}
+	}
+	return 0;
+}
+
+static void n800_codec_cleanup(struct device *dev)
+{
+	tsc2301_device =3D NULL;
+	if (eac_device !=3D NULL)
+		n800_unregister_codec();
+	n800_codec_put_clocks(dev);
+}
+
+static struct eac_platform_data n800_eac_data =3D {
+	.init =3D n800_eac_init,
+	.cleanup =3D n800_eac_cleanup,
+	.enable_ext_clocks =3D n800_eac_enable_ext_clocks,
+	.disable_ext_clocks =3D n800_eac_disable_ext_clocks,
+};
+
+static const struct tsc2301_mixer_gpio n800_mixer_gpios[] =3D {
+	{
+		.name			=3D "Headset Amplifier",
+		.gpio			=3D 1,
+		.deactivate_on_pd	=3D 1,
+	}, {
+		.name			=3D "Speaker Amplifier",
+		.gpio			=3D 2,
+		.def_enable		=3D 1,
+		.deactivate_on_pd	=3D 1,
+	}, {
+		.name			=3D "Headset Mic Select",
+		.gpio			=3D 3,
+	}
+};
+
+static struct platform_device retu_headset_device =3D {
+	.name		=3D "retu-headset",
+	.id		=3D -1,
+	.dev		=3D {
+		.release	=3D NULL,
+	},
+};
+
+void __init n800_audio_init(struct tsc2301_platform_data *tc)
+{
+	spin_lock_init(&audio_lock);
+
+	if (platform_device_register(&retu_headset_device) < 0)
+		return;
+	omap_init_eac(&n800_eac_data);
+
+	tc->pll_pdc =3D 7;
+	tc->pll_a =3D 7;
+	tc->pll_n =3D 9;
+	tc->pll_output =3D 1;
+	tc->mclk_ratio =3D TSC2301_MCLK_256xFS;
+	tc->i2s_sample_rate =3D TSC2301_I2S_SR_48000;
+	tc->i2s_format =3D TSC2301_I2S_FORMAT0;
+	tc->power_down_blocks =3D TSC2301_REG_PD_MISC_MOPD;
+	tc->mixer_gpios =3D n800_mixer_gpios;
+	tc->n_mixer_gpios =3D ARRAY_SIZE(n800_mixer_gpios);
+	tc->codec_init =3D n800_codec_init;
+	tc->codec_cleanup =3D n800_codec_cleanup;
+	tc->enable_clock =3D n800_codec_enable_clock;
+	tc->disable_clock =3D n800_codec_disable_clock;
+}
+
+#else
+
+void __init n800_audio_init(void)
+{
+}
+
+#endif
+
+#ifdef CONFIG_OMAP_DSP
+
+int n800_audio_enable(struct dsp_kfunc_device *kdev, int stage)
+{
+#ifdef AUDIO_ENABLED
+	unsigned long flags;
+	int do_enable =3D 0;
+
+	spin_lock_irqsave(&audio_lock, flags);
+
+	pr_debug("DSP power up request (audio codec %sinitialized)\n",
+		 audio_ok ? "" : "not ");
+
+	if (enable_audio)
+		goto out;
+	enable_audio =3D 1;
+	if (audio_ok)
+		do_enable =3D 1;
+out:
+	spin_unlock_irqrestore(&audio_lock, flags);
+	if (do_enable)
+		eac_set_mode(eac_device, 1, 1);
+#endif
+	return 0;
+}
+
+int n800_audio_disable(struct dsp_kfunc_device *kdev, int stage)
+{
+#ifdef AUDIO_ENABLED
+	unsigned long flags;
+	int do_disable =3D 0;
+
+	spin_lock_irqsave(&audio_lock, flags);
+
+	pr_debug("DSP power down request (audio codec %sinitialized)\n",
+		audio_ok ? "" : "not ");
+
+	if (!enable_audio)
+		goto out;
+	enable_audio =3D 0;
+	if (audio_ok)
+		do_disable =3D 1;
+out:
+	spin_unlock_irqrestore(&audio_lock, flags);
+	if (do_disable)
+		eac_set_mode(eac_device, 0, 0);
+#endif
+	return 0;
+}
+
+#endif /* CONFIG_OMAP_DSP */
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-bt.c
@@ -0,0 +1,42 @@
+/*
+ * Nokia N800 platform-specific data for Bluetooth
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ * Contact: Ville Tervo <ville.tervo@nokia.com>
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <asm/arch/board.h>
+
+static struct platform_device n800_bt_device =3D {
+	.name           =3D "hci_h4p",
+	.id             =3D -1,
+	.num_resources  =3D 0,
+};
+
+void __init n800_bt_init(void)
+{
+	const struct omap_bluetooth_config *bt_config;
+
+	bt_config =3D (void *) omap_get_config(OMAP_TAG_NOKIA_BT,
+					     struct omap_bluetooth_config);
+	n800_bt_device.dev.platform_data =3D (void *) bt_config;
+	if (platform_device_register(&n800_bt_device) < 0)
+		BUG();
+}
+
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-dsp.c
@@ -0,0 +1,158 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n800-dsp.c
+ *
+ * Copyright (C) 2006 Nokia Corporation.
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
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
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+
+#include "../plat-omap/dsp/dsp_common.h"
+
+extern int n800_audio_enable(struct dsp_kfunc_device *kdev, int stage);
+extern int n800_audio_disable(struct dsp_kfunc_device *kdev, int stage);
+
+#if	defined(CONFIG_OMAP_DSP)
+
+/*
+ * dsp peripheral device: AUDIO
+ */
+static struct dsp_kfunc_device n800_audio_device =3D {
+	.name	 =3D "audio",
+	.type	 =3D DSP_KFUNC_DEV_TYPE_AUDIO,
+	.enable	 =3D n800_audio_enable,
+	.disable =3D n800_audio_disable,
+};
+
+/*
+ * dsp peripheral device: TIMER
+ */
+static int dsp_timer_probe(struct dsp_kfunc_device *kdev)
+{
+	char clockname[20];
+
+	strcpy(clockname, kdev->name);
+	strcat(clockname, "_fck");
+
+	kdev->fck =3D clk_get(NULL, clockname);
+	if (IS_ERR(kdev->fck)) {
+		printk(KERN_ERR "couldn't acquire %s\n", clockname);
+		return PTR_ERR(kdev->fck);
+	}
+	pr_debug("%s probed successfully\n", clockname);
+
+	strcpy(clockname, kdev->name);
+	strcat(clockname, "_ick");
+	kdev->ick =3D clk_get(NULL, clockname);
+	if (IS_ERR(kdev->ick)) {
+		printk(KERN_ERR "couldn't acquire %s\n", clockname);
+		goto fail;
+	}
+	pr_debug("%s probed successfully\n", clockname);
+
+	return 0;
+ fail:
+	clk_put(kdev->fck);
+
+	return PTR_ERR(kdev->ick);
+}
+
+static int dsp_timer_remove(struct dsp_kfunc_device *kdev)
+{
+	clk_put(kdev->ick);
+	clk_put(kdev->fck);
+	pr_debug("%s removed successfully\n", kdev->name);
+	return 0;
+}
+
+static int dsp_timer_enable(struct dsp_kfunc_device *kdev, int stage)
+{
+	pr_debug("%s enabled(%d)\n", kdev->name, stage);
+
+	mutex_lock(&kdev->lock);
+
+	if (kdev->enabled)
+		goto out;
+	kdev->enabled =3D 1;
+
+	clk_enable(kdev->fck);
+	clk_enable(kdev->ick);
+ out:
+	mutex_unlock(&kdev->lock);
+
+	return 0;
+}
+
+static int dsp_timer_disable(struct dsp_kfunc_device *kdev, int stage)
+{
+	pr_debug("%s disabled(%d)\n", kdev->name, stage);
+
+	mutex_lock(&kdev->lock);
+
+	if (kdev->enabled =3D=3D 0)
+		goto out;
+	kdev->enabled =3D 0;
+
+	clk_disable(kdev->ick);
+	clk_disable(kdev->fck);
+ out:
+	mutex_unlock(&kdev->lock);
+
+	return 0;
+}
+
+static struct dsp_kfunc_device n800_timer_device =3D {
+	.name	 =3D "gpt5",
+	.type	 =3D DSP_KFUNC_DEV_TYPE_COMMON,
+	.probe	 =3D dsp_timer_probe,
+	.remove	 =3D dsp_timer_remove,
+	.enable	 =3D dsp_timer_enable,
+	.disable =3D dsp_timer_disable,
+};
+
+static struct dsp_kfunc_device *n800_kfunc_dev[] =3D {
+	&n800_audio_device,
+	&n800_timer_device,
+};
+
+void __init n800_dsp_init(void)
+{
+	int i, ret;
+	struct dsp_kfunc_device **p =3D n800_kfunc_dev;
+
+	for (i =3D 0; i < ARRAY_SIZE(n800_kfunc_dev); i++) {
+		ret =3D dsp_kfunc_device_register(p[i]);
+		if (ret) {
+			printk(KERN_ERR
+			       "KFUNC device registration failed: %s\n",
+			       p[i]->name);
+		}
+	}
+}
+
+#else
+void __init n800_dsp_init(void) { }
+#endif	/* CONFIG_OMAP_DSP */
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-flash.c
@@ -0,0 +1,61 @@
+/*
+ * linux/arch/arm/mach-omap/omap2/board-n800-flash.c
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Juha Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <asm/mach/flash.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/board.h>
+
+static struct mtd_partition n800_partitions[8];
+
+static struct omap_onenand_platform_data n800_onenand_data =3D {
+	.cs =3D 0,
+	.gpio_irq =3D 26,
+	.parts =3D n800_partitions,
+	.nr_parts =3D 0 /* filled later */
+};
+
+static struct platform_device n800_onenand_device =3D {
+	.name		=3D "omap2-onenand",
+	.id		=3D -1,
+	.dev =3D {
+		.platform_data =3D &n800_onenand_data,
+	},
+};
+
+
+void __init n800_flash_init(void)
+{
+	const struct omap_partition_config *part;
+	int i =3D 0;
+
+	while ((part =3D omap_get_nr_config(OMAP_TAG_PARTITION,
+					  struct omap_partition_config, i)) !=3D NULL) {
+		struct mtd_partition *mpart;
+
+		mpart =3D n800_partitions + i;
+		mpart->name =3D (char *) part->name;
+		mpart->size =3D part->size;
+		mpart->offset =3D part->offset;
+		mpart->mask_flags =3D part->mask_flags;
+		i++;
+		if (i =3D=3D ARRAY_SIZE(n800_partitions)) {
+			printk(KERN_ERR "Too many partitions supplied\n");
+			return;
+		}
+	}
+	n800_onenand_data.nr_parts =3D i;
+	if (platform_device_register(&n800_onenand_device) < 0) {
+		printk(KERN_ERR "Unable to register OneNAND device\n");
+		return;
+	}
+}
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -0,0 +1,279 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n800-mmc.c
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Juha Yrj?l?
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <asm/arch/mmc.h>
+#include <asm/arch/menelaus.h>
+#include <asm/arch/gpio.h>
+
+#ifdef CONFIG_MMC_OMAP
+
+static const int slot_switch_gpio =3D 96;
+static const int slot1_wp_gpio =3D 23;
+static const int slot2_wp_gpio =3D 8;
+static int slot1_cover_closed;
+static int slot2_cover_closed;
+static struct device *mmc_device;
+
+/*
+ * VMMC --> slot 1
+ * VDCDC3_APE, VMCS2_APE --> slot 2
+ * GPIO96 --> Menelaus GPIO2
+ */
+
+static int n800_mmc_switch_slot(struct device *dev, int slot)
+{
+#ifdef CONFIG_MMC_DEBUG
+	printk("Choose slot %d\n", slot + 1);
+#endif
+	if (slot =3D=3D 0)
+		omap_set_gpio_dataout(slot_switch_gpio, 0);
+	else
+		omap_set_gpio_dataout(slot_switch_gpio, 1);
+	return 0;
+}
+
+static int n800_mmc_set_power(struct device *dev, int slot, int power_on=
, int vdd)
+{
+	int mV;
+
+#ifdef CONFIG_MMC_DEBUG
+	printk("Set slot %d power: %s (vdd %d)\n", slot + 1,
+	       power_on ? "on" : "off", vdd);
+#endif
+	if (slot =3D=3D 0) {
+		if (!power_on)
+			return menelaus_set_vmmc(0);
+		switch (1 << vdd) {
+		case MMC_VDD_33_34:
+		case MMC_VDD_32_33:
+		case MMC_VDD_31_32:
+			mV =3D 3100;
+			break;
+		case MMC_VDD_30_31:
+			mV =3D 3000;
+			break;
+		case MMC_VDD_28_29:
+			mV =3D 2800;
+			break;
+		case MMC_VDD_18_19:
+			mV =3D 1850;
+			break;
+		default:
+			BUG();
+		}
+		return menelaus_set_vmmc(mV);
+	} else {
+		if (!power_on)
+			return menelaus_set_vdcdc(3, 0);
+		switch (1 << vdd) {
+		case MMC_VDD_33_34:
+		case MMC_VDD_32_33:
+			mV =3D 3300;
+			break;
+		case MMC_VDD_30_31:
+		case MMC_VDD_29_30:
+			mV =3D 3000;
+			break;
+		case MMC_VDD_28_29:
+		case MMC_VDD_27_28:
+			mV =3D 2800;
+			break;
+		case MMC_VDD_24_25:
+		case MMC_VDD_23_24:
+			mV =3D 2400;
+			break;
+		case MMC_VDD_22_23:
+		case MMC_VDD_21_22:
+			mV =3D 2200;
+			break;
+		case MMC_VDD_20_21:
+		case MMC_VDD_19_20:
+			mV =3D 2000;
+			break;
+		case MMC_VDD_18_19:
+		case MMC_VDD_17_18:
+			mV =3D 1800;
+			break;
+		case MMC_VDD_150_155:
+		case MMC_VDD_145_150:
+			mV =3D 1500;
+			break;
+		default:
+			BUG();
+		}
+		return menelaus_set_vdcdc(3, mV);
+	}
+	return 0;
+}
+
+static int n800_mmc_set_bus_mode(struct device *dev, int slot, int bus_m=
ode)
+{
+	int r;
+
+#ifdef CONFIG_MMC_DEBUG
+	printk("Set slot %d bus mode %s\n", slot + 1,
+	       bus_mode =3D=3D MMC_BUSMODE_OPENDRAIN ? "open-drain" : "push-pul=
l");
+#endif
+	BUG_ON(slot !=3D 0 && slot !=3D 1);
+	slot++;
+	switch (bus_mode) {
+	case MMC_BUSMODE_OPENDRAIN:
+		r =3D menelaus_set_mmc_opendrain(slot, 1);
+		break;
+	case MMC_BUSMODE_PUSHPULL:
+		r =3D menelaus_set_mmc_opendrain(slot, 0);
+		break;
+	default:
+		BUG();
+	}
+	if (r !=3D 0 && printk_ratelimit())
+		printk(KERN_ERR "MMC: unable to set bus mode for slot %d\n", slot);
+	return r;
+}
+
+#if 0
+static int n800_mmc_get_ro(struct device *dev, int slot)
+{
+	int ro;
+
+	slot++;
+	if (slot =3D=3D 1)
+		ro =3D omap_get_gpio_datain(slot1_wp_gpio);
+	else
+		ro =3D omap_get_gpio_datain(slot2_wp_gpio);
+#ifdef CONFIG_MMC_DEBUG
+	printk("Get RO slot %d: %s\n", slot, ro ? "read-only" : "read-write");
+#endif
+	return ro;
+}
+#endif
+
+static int n800_mmc_get_cover_state(struct device *dev, int slot)
+{
+	slot++;
+	BUG_ON(slot !=3D 1 && slot !=3D 2);
+	if (slot =3D=3D 1)
+		return slot1_cover_closed;
+	else
+		return slot2_cover_closed;
+}
+
+static void n800_mmc_callback(void *data, u8 card_mask)
+{
+	if (card_mask & (1 << 1))
+		slot2_cover_closed =3D 0;
+	else
+		slot2_cover_closed =3D 1;
+        omap_mmc_notify_cover_event(mmc_device, 1, slot2_cover_closed);
+}
+
+void n800_mmc_slot1_cover_handler(void *arg, int state)
+{
+	if (mmc_device =3D=3D NULL)
+		return;
+
+	slot1_cover_closed =3D state;
+	omap_mmc_notify_cover_event(mmc_device, 0, state);
+}
+
+static int n800_mmc_late_init(struct device *dev)
+{
+	int r;
+
+	mmc_device =3D dev;
+
+	r =3D menelaus_set_slot_sel(1);
+	if (r < 0)
+		return r;
+
+	r =3D menelaus_set_mmc_slot(1, 1, 0, 1);
+	if (r < 0)
+		return r;
+	r =3D menelaus_set_mmc_slot(2, 1, 0, 1);
+	if (r < 0)
+		return r;
+
+	r =3D menelaus_get_slot_pin_states();
+	if (r < 0)
+		return r;
+
+	if (r & (1 << 1))
+		slot2_cover_closed =3D 1;
+	else
+		slot2_cover_closed =3D 0;
+
+	r =3D menelaus_register_mmc_callback(n800_mmc_callback, NULL);
+
+	return r;
+}
+
+static void n800_mmc_cleanup(struct device *dev)
+{
+	menelaus_unregister_mmc_callback();
+}
+
+static struct omap_mmc_platform_data n800_mmc_data =3D {
+	.enabled		=3D 1,
+	.nr_slots		=3D 2,
+	.wire4			=3D 1,
+	.switch_slot		=3D n800_mmc_switch_slot,
+	.init			=3D n800_mmc_late_init,
+	.cleanup		=3D n800_mmc_cleanup,
+	.slots[0] =3D {
+		.set_power	=3D n800_mmc_set_power,
+		.set_bus_mode	=3D n800_mmc_set_bus_mode,
+		.get_ro		=3D NULL,
+		.get_cover_state=3D n800_mmc_get_cover_state,
+		.ocr_mask	=3D MMC_VDD_18_19 | MMC_VDD_28_29 | MMC_VDD_30_31 |
+				  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name		=3D "internal",
+	},
+	.slots[1] =3D {
+		.set_power	=3D n800_mmc_set_power,
+		.set_bus_mode	=3D n800_mmc_set_bus_mode,
+		.get_ro		=3D NULL,
+		.get_cover_state=3D n800_mmc_get_cover_state,
+		.ocr_mask	=3D MMC_VDD_150_155 | MMC_VDD_145_150 | MMC_VDD_17_18 |
+				  MMC_VDD_18_19 | MMC_VDD_19_20 | MMC_VDD_20_21 |
+				  MMC_VDD_21_22 | MMC_VDD_22_23 | MMC_VDD_23_24 |
+				  MMC_VDD_24_25 | MMC_VDD_27_28 | MMC_VDD_28_29 |
+				  MMC_VDD_29_30 | MMC_VDD_30_31 | MMC_VDD_32_33 |
+				  MMC_VDD_33_34,
+		.name		=3D "external",
+	},
+};
+
+void __init n800_mmc_init(void)
+{
+	omap_set_mmc_info(1, &n800_mmc_data);
+	if (omap_request_gpio(slot_switch_gpio) < 0)
+		BUG();
+	omap_set_gpio_dataout(slot_switch_gpio, 0);
+	omap_set_gpio_direction(slot_switch_gpio, 0);
+	if (omap_request_gpio(slot1_wp_gpio) < 0)
+		BUG();
+	if (omap_request_gpio(slot2_wp_gpio) < 0)
+		BUG();
+	omap_set_gpio_direction(slot1_wp_gpio, 1);
+	omap_set_gpio_direction(slot2_wp_gpio, 1);
+}
+
+#else
+
+void __init n800_mmc_init(void)
+{
+}
+
+void n800_mmc_slot1_cover_handler(void *arg, int state)
+{
+}
+
+#endif
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -0,0 +1,102 @@
+/*
+ * linux/arch/arm/mach-omap/omap2/board-n800-usb.c
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Juha Yrj?l?
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/usb/musb.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/gpio.h>
+
+#define TUSB_ASYNC_CS		1
+#define TUSB_SYNC_CS		4
+#define GPIO_TUSB_INT		58
+#define GPIO_TUSB_ENABLE	0
+
+static int tusb_set_power(int state);
+
+#if	defined(CONFIG_USB_MUSB_OTG)
+#	define BOARD_MODE	MUSB_OTG
+#elif	defined(CONFIG_USB_MUSB_PERIPHERAL)
+#	define BOARD_MODE	MUSB_PERIPHERAL
+#else	/* defined(CONFIG_USB_MUSB_HOST) */
+#	define BOARD_MODE	MUSB_HOST
+#endif
+
+static struct musb_hdrc_platform_data tusb_data =3D {
+	.mode		=3D BOARD_MODE,
+	.multipoint	=3D 1,
+	.set_power	=3D tusb_set_power,
+	.min_power	=3D 25,	/* x2 =3D 50 mA drawn from VBUS as peripheral */
+};
+
+/*
+ * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
+ * 1.5 V voltage regulators of PM companion chip. Companion chip will th=
en
+ * provide then PGOOD signal to TUSB6010 which will release it from rese=
t.
+ */
+static int tusb_set_power(int state)
+{
+	int i, retval =3D 0;
+
+	if (state) {
+		omap_set_gpio_dataout(GPIO_TUSB_ENABLE, 1);
+		msleep(1);
+
+		/* Wait until TUSB6010 pulls INT pin down */
+		i =3D 100;
+		while (i && omap_get_gpio_datain(GPIO_TUSB_INT)) {
+			msleep(1);
+			i--;
+		}
+
+		if (!i) {
+			printk(KERN_ERR "tusb: powerup failed\n");
+			retval =3D -ENODEV;
+		}
+	} else {
+		omap_set_gpio_dataout(GPIO_TUSB_ENABLE, 0);
+		msleep(10);
+	}
+
+	return retval;
+}
+
+void __init n800_usb_init(void)
+{
+	int ret =3D 0;
+	static char	announce[] __initdata =3D KERN_INFO "TUSB 6010\n";
+
+	/* PM companion chip power control pin */
+	ret =3D omap_request_gpio(GPIO_TUSB_ENABLE);
+	if (ret !=3D 0) {
+		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
+		       GPIO_TUSB_ENABLE);
+		return;
+	}
+	omap_set_gpio_direction(GPIO_TUSB_ENABLE, 0);
+
+	tusb_set_power(0);
+
+	ret =3D tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
+					TUSB_ASYNC_CS, TUSB_SYNC_CS,
+					GPIO_TUSB_INT, 0x3f);
+	if (ret !=3D 0)
+		goto err;
+
+	printk(announce);
+
+	return;
+
+err:
+	omap_free_gpio(GPIO_TUSB_ENABLE);
+}
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -0,0 +1,525 @@
+/*
+ * linux/arch/arm/mach-omap/omap2/board-n800.c
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Juha Yrj?l? <juha.yrjola@nokia.com>
+ *
+ * Modified from mach-omap2/board-generic.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2301.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+#include <asm/arch/mcspi.h>
+#include <asm/arch/menelaus.h>
+#include <asm/arch/lcd_mipid.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/gpio-switch.h>
+#include <asm/arch/omapfb.h>
+#include <asm/arch/blizzard.h>
+
+#include <../drivers/cbus/tahvo.h>
+
+#define N800_BLIZZARD_POWERDOWN_GPIO 15
+#define N800_STI_GPIO		62
+#define N800_CAM_SENSOR_RESET_GPIO	53
+#define N800_KEYB_IRQ_GPIO		109
+
+static void __init nokia_n800_init_irq(void)
+{
+	omap2_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+
+#ifdef CONFIG_OMAP_STI
+	if (omap_request_gpio(N800_STI_GPIO) < 0) {
+		printk(KERN_ERR "Failed to request GPIO %d for STI\n",
+		       N800_STI_GPIO);
+		return;
+	}
+
+	omap_set_gpio_direction(N800_STI_GPIO, 0);
+	omap_set_gpio_dataout(N800_STI_GPIO, 0);
+#endif
+}
+
+#if defined(CONFIG_MENELAUS) && defined(CONFIG_SENSORS_TMP105)
+
+static int n800_tmp105_set_power(int enable)
+{
+	return menelaus_set_vaux(enable ? 2800 : 0);
+}
+
+#else
+
+#define n800_tmp105_set_power NULL
+
+#endif
+
+static struct omap_uart_config n800_uart_config __initdata =3D {
+	.enabled_uarts =3D (1 << 0) | (1 << 2),
+};
+
+#include "../../../drivers/cbus/retu.h"
+
+static struct omap_fbmem_config n800_fbmem0_config __initdata =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_fbmem_config n800_fbmem1_config __initdata =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_fbmem_config n800_fbmem2_config __initdata =3D {
+	.size =3D 752 * 1024,
+};
+
+static struct omap_tmp105_config n800_tmp105_config __initdata =3D {
+	.tmp105_irq_pin =3D 125,
+	.set_power =3D n800_tmp105_set_power,
+};
+
+static void mipid_shutdown(struct mipid_platform_data *pdata)
+{
+	if (pdata->nreset_gpio !=3D -1) {
+		pr_info("shutdown LCD\n");
+		omap_set_gpio_dataout(pdata->nreset_gpio, 0);
+		msleep(120);
+	}
+}
+
+static struct mipid_platform_data n800_mipid_platform_data =3D {
+	.shutdown =3D mipid_shutdown,
+};
+
+static void __init mipid_dev_init(void)
+{
+	const struct omap_lcd_config *conf;
+
+	conf =3D omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf !=3D NULL) {
+		n800_mipid_platform_data.nreset_gpio =3D conf->nreset_gpio;
+		n800_mipid_platform_data.data_lines =3D conf->data_lines;
+	}
+}
+
+static struct {
+	struct clk *sys_ck;
+} blizzard;
+
+static int blizzard_get_clocks(void)
+{
+	blizzard.sys_ck =3D clk_get(0, "osc_ck");
+	if (IS_ERR(blizzard.sys_ck)) {
+		printk(KERN_ERR "can't get Blizzard clock\n");
+		return PTR_ERR(blizzard.sys_ck);
+	}
+	return 0;
+}
+
+static unsigned long blizzard_get_clock_rate(struct device *dev)
+{
+	return clk_get_rate(blizzard.sys_ck);
+}
+
+static void blizzard_enable_clocks(int enable)
+{
+	if (enable)
+		clk_enable(blizzard.sys_ck);
+	else
+		clk_disable(blizzard.sys_ck);
+}
+
+static void blizzard_power_up(struct device *dev)
+{
+	/* Vcore to 1.475V */
+	tahvo_set_clear_reg_bits(0x07, 0, 0xf);
+	msleep(10);
+
+	blizzard_enable_clocks(1);
+	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 1);
+}
+
+static void blizzard_power_down(struct device *dev)
+{
+	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 0);
+	blizzard_enable_clocks(0);
+
+	/* Vcore to 1.005V */
+	tahvo_set_clear_reg_bits(0x07, 0xf, 0);
+}
+
+static struct blizzard_platform_data n800_blizzard_data =3D {
+	.power_up	=3D blizzard_power_up,
+	.power_down	=3D blizzard_power_down,
+	.get_clock_rate	=3D blizzard_get_clock_rate,
+	.te_connected	=3D 1,
+};
+
+static void __init blizzard_dev_init(void)
+{
+	int r;
+
+	r =3D omap_request_gpio(N800_BLIZZARD_POWERDOWN_GPIO);
+	if (r < 0)
+		return;
+	omap_set_gpio_direction(N800_BLIZZARD_POWERDOWN_GPIO, 0);
+	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 1);
+
+	blizzard_get_clocks();
+	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
+}
+
+#if defined(CONFIG_CBUS_RETU) && defined(CONFIG_VIDEO_CAMERA_SENSOR_TCM8=
25X) && \
+	defined(CONFIG_MENELAUS)
+#define SUPPORT_SENSOR
+#endif
+
+#ifdef SUPPORT_SENSOR
+
+static int sensor_okay;
+
+/*
+ * VSIM1	--> CAM_IOVDD	--> IOVDD (1.8 V)
+ */
+static int tcm825x_sensor_power_on(void *data)
+{
+	int ret;
+
+	if (!sensor_okay)
+		return -ENODEV;
+
+	/* Set VMEM to 1.5V and VIO to 2.5V */
+	ret =3D menelaus_set_vmem(1500);
+	if (ret < 0) {
+		/* Try once more, it seems the sensor power up causes
+		 * some problems on the I2C bus. */
+		ret =3D menelaus_set_vmem(1500);
+		if (ret < 0)
+			return ret;
+	}
+	msleep(1);
+
+	ret =3D menelaus_set_vio(2500);
+	if (ret < 0)
+		return ret;
+
+	/* Set VSim1 on */
+	retu_write_reg(RETU_REG_CTRL_SET, 0x0080);
+	msleep(100);
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 1);
+	msleep(1);
+
+	return 0;
+}
+
+static int tcm825x_sensor_power_off(void * data)
+{
+	int ret;
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	msleep(1);
+
+	/* Set VSim1 off */
+	retu_write_reg(RETU_REG_CTRL_CLR, 0x0080);
+	msleep(1);
+
+	/* Set VIO_MODE to off */
+	ret =3D menelaus_set_vio(0);
+	if (ret < 0)
+		return ret;
+	msleep(1);
+
+	/* Set VMEM_MODE to off */
+	ret =3D menelaus_set_vmem(0);
+	if (ret < 0)
+		return ret;
+	msleep(1);
+
+	return 0;
+}
+
+static struct omap_camera_sensor_config n800_sensor_config =3D {
+	.power_on   =3D tcm825x_sensor_power_on,
+	.power_off  =3D tcm825x_sensor_power_off,
+};
+
+static void __init n800_cam_init(void)
+{
+	int r;
+
+	r =3D omap_request_gpio(N800_CAM_SENSOR_RESET_GPIO);
+	if (r < 0)
+		return;
+
+	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	omap_set_gpio_direction(N800_CAM_SENSOR_RESET_GPIO, 0);
+
+	sensor_okay =3D 1;
+}
+
+#else
+
+static inline void n800_cam_init(void) {}
+
+#endif
+
+static struct omap_board_config_kernel n800_config[] =3D {
+	{ OMAP_TAG_UART,	                &n800_uart_config },
+#ifdef SUPPORT_SENSOR
+	{ OMAP_TAG_CAMERA_SENSOR,		&n800_sensor_config },
+#endif
+	{ OMAP_TAG_FBMEM,			&n800_fbmem0_config },
+	{ OMAP_TAG_FBMEM,			&n800_fbmem1_config },
+	{ OMAP_TAG_FBMEM,			&n800_fbmem2_config },
+	{ OMAP_TAG_TMP105,			&n800_tmp105_config },
+};
+
+
+static int n800_get_keyb_irq_state(struct device *dev)
+{
+	return !omap_get_gpio_datain(N800_KEYB_IRQ_GPIO);
+}
+
+static struct tsc2301_platform_data tsc2301_config =3D {
+	.reset_gpio	=3D 118,
+	.dav_gpio	=3D 103,
+	.pen_int_gpio	=3D 106,
+	.keymap =3D {
+		-1,		/* Event for bit 0 */
+		KEY_UP,		/* Event for bit 1 (up) */
+		KEY_F5,		/* Event for bit 2 (home) */
+		-1,		/* Event for bit 3 */
+		KEY_LEFT,	/* Event for bit 4 (left) */
+		KEY_ENTER,	/* Event for bit 5 (enter) */
+		KEY_RIGHT,	/* Event for bit 6 (right) */
+		-1,		/* Event for bit 7 */
+		KEY_ESC,	/* Event for bit 8 (cycle) */
+		KEY_DOWN,	/* Event for bit 9 (down) */
+		KEY_F4,		/* Event for bit 10 (menu) */
+		-1,		/* Event for bit 11 */
+		KEY_F8,		/* Event for bit 12 (Zoom-) */
+		KEY_F6,		/* Event for bit 13 (FS) */
+		KEY_F7,		/* Event for bit 14 (Zoom+) */
+		-1,		/* Event for bit 15 */
+	},
+	.kp_rep 	=3D 0,
+	.get_keyb_irq_state =3D n800_get_keyb_irq_state,
+};
+
+static void tsc2301_dev_init(void)
+{
+	int gpio =3D N800_KEYB_IRQ_GPIO;
+
+	if (omap_request_gpio(gpio) < 0) {
+		printk("can't get KBIRQ GPIO\n");
+		return;
+	}
+	omap_set_gpio_direction(gpio, 1);
+	tsc2301_config.keyb_int =3D OMAP_GPIO_IRQ(gpio);
+}
+
+static struct omap2_mcspi_device_config tsc2301_mcspi_config =3D {
+	.turbo_mode	=3D 0,
+	.single_channel =3D 1,
+};
+
+static struct omap2_mcspi_device_config mipid_mcspi_config =3D {
+	.turbo_mode	=3D 0,
+	.single_channel	=3D 1,
+};
+
+static struct omap2_mcspi_device_config cx3110x_mcspi_config =3D {
+	.turbo_mode	=3D 0,
+	.single_channel =3D 1,
+};
+
+static struct spi_board_info n800_spi_board_info[] __initdata =3D {
+	[0] =3D {
+		.modalias	=3D "lcd_mipid",
+		.bus_num	=3D 1,
+		.chip_select	=3D 1,
+		.max_speed_hz	=3D 4000000,
+		.controller_data=3D &mipid_mcspi_config,
+		.platform_data	=3D &n800_mipid_platform_data,
+	}, [1] =3D {
+		.modalias	=3D "cx3110x",
+		.bus_num	=3D 2,
+		.chip_select	=3D 0,
+		.max_speed_hz   =3D 48000000,
+		.controller_data=3D &cx3110x_mcspi_config,
+	}, [2] =3D {
+		.modalias	=3D "tsc2301",
+		.bus_num	=3D 1,
+		.chip_select	=3D 0,
+		.max_speed_hz   =3D 6000000,
+		.controller_data=3D &tsc2301_mcspi_config,
+		.platform_data  =3D &tsc2301_config,
+	},
+};
+
+#if defined(CONFIG_CBUS_RETU) && defined(CONFIG_LEDS_OMAP_PWM)
+
+void retu_keypad_led_set_power(struct omap_pwm_led_platform_data *self,
+			       int on_off)
+{
+	if (on_off) {
+		retu_write_reg(RETU_REG_CTRL_SET, 1 << 6);
+		msleep(2);
+		retu_write_reg(RETU_REG_CTRL_SET, 1 << 3);
+	} else {
+		retu_write_reg(RETU_REG_CTRL_CLR, (1 << 6) | (1 << 3));
+	}
+}
+
+static struct omap_pwm_led_platform_data n800_keypad_led_data =3D {
+	.name =3D "keypad",
+	.intensity_timer =3D 10,
+	.blink_timer =3D 9,
+	.set_power =3D retu_keypad_led_set_power,
+};
+
+static struct platform_device n800_keypad_led_device =3D {
+	.name		=3D "omap_pwm_led",
+	.id		=3D -1,
+	.dev		=3D {
+		.platform_data =3D &n800_keypad_led_data,
+	},
+};
+#endif
+
+#if defined(CONFIG_SPI_TSC2301_TOUCHSCREEN)
+static void __init n800_ts_set_config(void)
+{
+	const struct omap_lcd_config *conf;
+
+	conf =3D omap_get_config(OMAP_TAG_LCD, struct omap_lcd_config);
+	if (conf !=3D NULL) {
+		if (strcmp(conf->panel_name, "lph8923") =3D=3D 0) {
+			tsc2301_config.ts_x_plate_ohm	=3D 180;
+			tsc2301_config.ts_hw_avg	=3D 4;
+			tsc2301_config.ts_ignore_last	=3D 1;
+			tsc2301_config.ts_max_pressure	=3D 255;
+			tsc2301_config.ts_stab_time	=3D 100;
+		} else if (strcmp(conf->panel_name, "ls041y3") =3D=3D 0) {
+			tsc2301_config.ts_x_plate_ohm	=3D 280;
+			tsc2301_config.ts_hw_avg	=3D 16;
+			tsc2301_config.ts_touch_pressure=3D 215;
+			tsc2301_config.ts_max_pressure	=3D 255;
+			tsc2301_config.ts_ignore_last	=3D 1;
+		} else {
+			printk(KERN_ERR "Unknown panel type, set default "
+			       "touchscreen configuration\n");
+			tsc2301_config.ts_x_plate_ohm	=3D 200;
+			tsc2301_config.ts_stab_time	=3D 100;
+		}
+	}
+}
+#else
+static inline void n800_ts_set_config(void)
+{
+}
+#endif
+
+extern void n800_mmc_slot1_cover_handler(void *arg, int state);
+
+static struct omap_gpio_switch n800_gpio_switches[] __initdata =3D {
+	{
+		.name			=3D "bat_cover",
+		.gpio			=3D -1,
+		.debounce_rising	=3D 100,
+		.debounce_falling	=3D 0,
+		.notify			=3D n800_mmc_slot1_cover_handler,
+		.notify_data		=3D NULL,
+	}, {
+		.name			=3D "headphone",
+		.gpio			=3D -1,
+		.debounce_rising	=3D 200,
+		.debounce_falling	=3D 200,
+	}, {
+		.name			=3D "cam_act",
+		.gpio			=3D -1,
+		.debounce_rising	=3D 200,
+		.debounce_falling	=3D 200,
+	}, {
+		.name			=3D "cam_turn",
+		.gpio			=3D -1,
+		.debounce_rising	=3D 100,
+		.debounce_falling	=3D 100,
+	},
+};
+
+static struct platform_device *n800_devices[] __initdata =3D {
+#if defined(CONFIG_CBUS_RETU) && defined(CONFIG_LEDS_OMAP_PWM)
+	&n800_keypad_led_device,
+#endif
+};
+
+extern void __init n800_flash_init(void);
+extern void __init n800_mmc_init(void);
+extern void __init n800_bt_init(void);
+extern void __init n800_audio_init(struct tsc2301_platform_data *);
+extern void __init n800_dsp_init(void);
+extern void __init n800_usb_init(void);
+extern void __init n800_pm_init(void);
+
+static void __init nokia_n800_init(void)
+{
+	platform_add_devices(n800_devices, ARRAY_SIZE(n800_devices));
+	n800_flash_init();
+	n800_mmc_init();
+	n800_bt_init();
+	n800_audio_init(&tsc2301_config);
+	n800_dsp_init();
+	n800_usb_init();
+	n800_cam_init();
+	n800_ts_set_config();
+	spi_register_board_info(n800_spi_board_info,
+				ARRAY_SIZE(n800_spi_board_info));
+	omap_serial_init();
+	mipid_dev_init();
+	blizzard_dev_init();
+	tsc2301_dev_init();
+	omap_register_gpio_switches(n800_gpio_switches,
+				    ARRAY_SIZE(n800_gpio_switches));
+	n800_pm_init();
+}
+
+static void __init nokia_n800_map_io(void)
+{
+	omap_board_config =3D n800_config;
+	omap_board_config_size =3D ARRAY_SIZE(n800_config);
+
+	omap2_map_common_io();
+}
+
+MACHINE_START(NOKIA_N800, "Nokia N800")
+	.phys_io	=3D 0x48000000,
+	.io_pg_offst	=3D ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	=3D 0x80000100,
+	.map_io		=3D nokia_n800_map_io,
+	.init_irq	=3D nokia_n800_init_irq,
+	.init_machine	=3D nokia_n800_init,
+	.timer		=3D &omap_timer,
+MACHINE_END
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -111,6 +111,13 @@
 	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
 }
=20
+unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
+{
+	unsigned long ticks =3D gpmc_ns_to_ticks(time_ns);
+
+	return ticks * gpmc_get_fclk_period() / 1000;
+}
+
 #ifdef DEBUG
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       int time, const char *name)
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n800-pm.c
@@ -0,0 +1,77 @@
+/*
+ * Nokia N800 PM code
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Amit Kucheria <amit.kucheria@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/arch/menelaus.h>
+
+#ifdef CONFIG_MENELAUS
+
+static int n800_auto_sleep_regulators(void)
+{
+	u32 val;
+	int ret;
+
+	val =3D EN_VPLL_SLEEP | EN_VMMC_SLEEP    \
+		| EN_VAUX_SLEEP | EN_VIO_SLEEP \
+		| EN_VMEM_SLEEP | EN_DC3_SLEEP \
+		| EN_VC_SLEEP | EN_DC2_SLEEP;
+
+	ret =3D menelaus_set_regulator_sleep(1, val);
+	if (ret < 0) {
+		printk(KERN_ERR "Could not set regulators to sleep on menelaus: %u\n",=
 ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int n800_auto_voltage_scale(void)
+{
+	int ret;
+
+	ret =3D menelaus_set_vcore_hw(1400, 1050);
+	if (ret < 0) {
+		printk(KERN_ERR "Could not set VCORE voltage on menelaus: %u\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int n800_menelaus_init(struct device *dev)
+{
+	int ret;
+
+	ret =3D n800_auto_voltage_scale();
+	if (ret < 0)
+		return ret;
+	ret =3D n800_auto_sleep_regulators();
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static struct menelaus_platform_data n800_menelaus_platform_data =3D {
+	.late_init =3D n800_menelaus_init,
+};
+
+void __init n800_pm_init(void)
+{
+	menelaus_set_platform_data(&n800_menelaus_platform_data);
+}
+
+#else
+
+void __init n800_pm_init(void)
+{
+}
+
+#endif
+
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -767,6 +767,7 @@
 e330			MACH_E330		E330			753
 rt3000			MACH_RT3000		RT3000			754
 nokia770		MACH_NOKIA770		NOKIA770		755
+nokia_n800		MACH_NOKIA_N800		NOKIA_N800		5555
 pnx0106			MACH_PNX0106		PNX0106			756
 hx21xx			MACH_HX21XX		HX21XX			757
 faraday			MACH_FARADAY		FARADAY			758
--- a/drivers/i2c/chips/menelaus.c
+++ b/drivers/i2c/chips/menelaus.c
@@ -14,7 +14,9 @@
  * Tony Lindgren <tony@atomide.com> and Imre Deak <imre.deak@nokia.com>
  * Cleanup and generalized support for voltage setting by
  * Juha Yrjola
- * Copyright (C) 2005-2006 Nokia Corporation
+ * Added support for controlling VCORE and regulator sleep states,
+ * Amit Kucheria <amit.kucheria@nokia.com>
+ * Copyright (C) 2005, 2006 Nokia Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -143,12 +145,14 @@
 	struct i2c_client	client;
 	struct work_struct	work;
 	int			irq;
+	unsigned		vcore_hw_mode:1;
 	void			*handlers[16];
 	void			(*mmc_callback)(void *data, u8 mask);
 	void			*mmc_callback_data;
 };
=20
 static struct menelaus_chip menelaus;
+static struct menelaus_platform_data *menelaus_pdata;
=20
 static int menelaus_write_reg(int reg, u8 value)
 {
@@ -470,6 +474,93 @@
 	return -EINVAL;
 }
=20
+/* Vcore can be programmed in two ways:
+ * SW-controlled: Required voltage is programmed into VCORE_CTRL1
+ * HW-controlled: Required range (roof-floor) is programmed into VCORE_C=
TRL3
+ * and VCORE_CTRL4
+
+ * Call correct 'set' function accordingly
+ */
+
+static const struct menelaus_vtg_value vcore_values[] =3D {
+	{ 1000, 0 },
+	{ 1025, 1 },
+	{ 1050, 2 },
+	{ 1075, 3 },
+	{ 1100, 4 },
+	{ 1125, 5 },
+	{ 1150, 6 },
+	{ 1175, 7 },
+	{ 1200, 8 },
+	{ 1225, 9 },
+	{ 1250, 10 },
+	{ 1275, 11 },
+	{ 1300, 12 },
+	{ 1325, 13 },
+	{ 1350, 14 },
+	{ 1375, 15 },
+	{ 1400, 16 },
+	{ 1425, 17 },
+	{ 1450, 18 },
+};
+
+int menelaus_set_vcore_sw(unsigned int mV)
+{
+	int val, ret;
+
+	val =3D menelaus_get_vtg_value(mV, vcore_values, ARRAY_SIZE(vcore_value=
s));
+	if (val < 0)
+		return -EINVAL;
+#ifdef DEBUG
+	printk("menelaus: Setting VCORE to %d mV (val 0x%02x)\n", mV, val);
+#endif
+
+	/* Set SW mode and the voltage in one go. */
+	mutex_lock(&menelaus.lock);
+	ret =3D menelaus_write_reg(MENELAUS_VCORE_CTRL1, val);
+	if (ret =3D=3D 0)
+		menelaus.vcore_hw_mode =3D 0;
+	mutex_unlock(&menelaus.lock);
+	msleep(1);
+
+	return ret;
+}
+
+int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floor_mV)
+{
+	int fval, rval, val, ret;
+
+	rval =3D menelaus_get_vtg_value(roof_mV, vcore_values, ARRAY_SIZE(vcore=
_values));
+	if (rval < 0)
+		return -EINVAL;
+	fval =3D menelaus_get_vtg_value(floor_mV, vcore_values, ARRAY_SIZE(vcor=
e_values));
+	if (fval < 0)
+		return -EINVAL;
+
+#ifdef DEBUG
+	printk("menelaus: Setting VCORE FLOOR to %d mV and ROOF to %d mV\n",
+	       floor_mV, roof_mV);
+#endif
+
+	mutex_lock(&menelaus.lock);
+	ret =3D menelaus_write_reg(MENELAUS_VCORE_CTRL3, fval);
+	if (ret < 0)
+		goto out;
+	ret =3D menelaus_write_reg(MENELAUS_VCORE_CTRL4, rval);
+	if (ret < 0)
+		goto out;
+	if (!menelaus.vcore_hw_mode) {
+		val =3D menelaus_read_reg(MENELAUS_VCORE_CTRL1);
+		val |=3D ((1 << 7) | (1 << 5)); /* HW mode, turn OFF byte comparator *=
/
+		ret =3D menelaus_write_reg(MENELAUS_VCORE_CTRL1, val);
+		menelaus.vcore_hw_mode =3D 1;
+	}
+	msleep(1);
+out:
+	mutex_unlock(&menelaus.lock);
+	return ret;
+}
+
 static const struct menelaus_vtg vmem_vtg =3D {
 	.name =3D "VMEM",
 	.vtg_reg =3D MENELAUS_LDO_CTRL1,
@@ -641,6 +732,31 @@
 }
 EXPORT_SYMBOL(menelaus_get_slot_pin_states);
=20
+int menelaus_set_regulator_sleep(int enable, u32 val)
+{
+	int t, ret;
+
+        mutex_lock(&menelaus.lock);
+	ret =3D menelaus_write_reg(MENELAUS_SLEEP_CTRL2, val);
+	if (ret < 0)
+		goto out;
+#ifdef DEBUG
+	printk("menelaus: regulator sleep configuration: %02x\n", val);
+#endif
+	ret =3D menelaus_read_reg(MENELAUS_GPIO_CTRL);
+	if (ret < 0)
+		goto out;
+	t =3D ((1 << 6) | 0x04);
+	if (enable)
+		ret |=3D t;
+	else
+		ret &=3D ~t;
+	ret =3D menelaus_write_reg(MENELAUS_GPIO_CTRL, ret);
+out:
+	mutex_unlock(&menelaus.lock);
+	return ret;
+}
+
 /*----------------------------------------------------------------------=
-*/
=20
 /* Handles Menelaus interrupts. Does not run in interrupt context */
@@ -695,7 +811,7 @@
 static int menelaus_probe(struct i2c_adapter *adapter, int address, int =
kind)
 {
 	struct i2c_client	*c;
-	int			rev =3D 0;
+	int			rev =3D 0, val;
 	int			err =3D 0;
=20
 	if (test_and_set_bit(0, &menelaus.initialized))
@@ -746,8 +862,24 @@
 	if (kind < 0)
 		pr_info("Menelaus rev %d.%d\n", rev >> 4, rev & 0x0f);
=20
-	return 0;
+	val =3D menelaus_read_reg(MENELAUS_VCORE_CTRL1);
+	if (val < 0)
+		goto fail3;
+	if (val & (1 << 7))
+		menelaus.vcore_hw_mode =3D 1;
+	else
+		menelaus.vcore_hw_mode =3D 0;
+
+	if (menelaus_pdata !=3D NULL && menelaus_pdata->late_init !=3D NULL) {
+		err =3D menelaus_pdata->late_init(&c->dev);
+		if (err < 0)
+			goto fail3;
+	}
=20
+	return 0;
+fail3:
+	free_irq(menelaus.irq, &menelaus);
+	flush_scheduled_work();
 fail2:
 	i2c_detach_client(c);
 fail1:
@@ -814,6 +946,11 @@
 	/* FIXME: Shutdown menelaus parts that can be shut down */
 }
=20
+void __init menelaus_set_platform_data(struct menelaus_platform_data *pd=
ata)
+{
+	menelaus_pdata =3D pdata;
+}
+
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_DESCRIPTION("I2C interface for Menelaus.");
 MODULE_LICENSE("GPL");
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -29,6 +29,13 @@
 	help
 	  Support for OneNAND flash via platform device driver.
=20
+config MTD_ONENAND_OMAP2
+	tristate "OneNAND on OMAP2 support"
+	depends on MTD_ONENAND && ARCH_OMAP2
+	help
+	  Support for a OneNAND flash device connected to an OMAP2 CPU
+	  via the GPMC memory controller.
+
 config MTD_ONENAND_OTP
 	bool "OneNAND OTP Support"
 	depends on MTD_ONENAND
--- a/drivers/mtd/onenand/Makefile
+++ b/drivers/mtd/onenand/Makefile
@@ -7,5 +7,6 @@
=20
 # Board specific.
 obj-$(CONFIG_MTD_ONENAND_GENERIC)	+=3D generic.o
+obj-$(CONFIG_MTD_ONENAND_OMAP2)		+=3D omap2.o
=20
 onenand-objs =3D onenand_base.o onenand_bbt.o
--- /dev/null
+++ b/drivers/mtd/onenand/omap2.c
@@ -0,0 +1,545 @@
+/*
+ *  linux/drivers/mtd/onenand/omap2.c
+ *
+ *  OneNAND driver for OMAP2
+ *
+ *  Copyright (C) 2005-2006 Nokia Corporation
+ *
+ *  Author: Jarkko Lavinen <jarkko.lavinen@nokia.com> and Juha Yrjola
+ *  IRQ and DMA support written by Timo Teras
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License version 2 as publis=
hed by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but W=
ITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License =
for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program; see the file COPYING. If not, write to the Free Softwar=
e
+ * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/mach/flash.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/pm.h>
+
+#include <linux/dma-mapping.h>
+#include <asm/dma-mapping.h>
+#include <asm/arch/dma.h>
+
+#include <asm/arch/board.h>
+
+#define ONENAND_IO_SIZE		SZ_128K
+
+struct omap2_onenand {
+	struct platform_device *pdev;
+	int gpmc_cs;
+	unsigned long phys_base;
+	int gpio_irq;
+	struct mtd_info mtd;
+	struct mtd_partition *parts;
+	struct onenand_chip onenand;
+	struct completion irq_done;
+	struct completion dma_done;
+	int dma_channel;
+};
+
+static unsigned short omap2_onenand_readw(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void omap2_onenand_writew(unsigned short value, void __iomem *add=
r)
+{
+	writew(value, addr);
+}
+
+static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
+{
+	struct omap2_onenand *info =3D data;
+
+	complete(&info->dma_done);
+}
+
+static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
+{
+	struct omap2_onenand *info =3D dev_id;
+
+	complete(&info->irq_done);
+
+	return IRQ_HANDLED;
+}
+
+static int omap2_onenand_wait(struct mtd_info *mtd, int state)
+{
+	struct omap2_onenand *info =3D container_of(mtd, struct omap2_onenand, =
mtd);
+	struct onenand_chip *this =3D mtd->priv;
+	unsigned int interrupt =3D 0;
+	unsigned int ctrl, ecc;
+	unsigned long timeout;
+	u32 syscfg;
+
+	if (state =3D=3D FL_RESETING) {
+		udelay(1);
+		return 0;
+	}
+
+	if (state !=3D FL_READING) {
+		/* Turn interrupts on */
+		syscfg =3D omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CF=
G1);
+		syscfg |=3D ONENAND_SYS_CFG1_IOBE;
+		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1=
);
+
+		INIT_COMPLETION(info->irq_done);
+		if (!omap_get_gpio_datain(info->gpio_irq)) {
+			wait_for_completion_timeout(&info->irq_done,
+						    msecs_to_jiffies(20));
+		}
+	} else {
+		/* Turn interrupts off */
+		syscfg =3D omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CF=
G1);
+		syscfg &=3D ~ONENAND_SYS_CFG1_IOBE;
+		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1=
);
+
+		timeout =3D jiffies + msecs_to_jiffies(20);
+		while (time_before(jiffies, timeout)) {
+			if (omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT) &
+			    ONENAND_INT_MASTER)
+				break;
+		}
+	}
+
+	/* To get correct interrupt status in timeout case */
+	interrupt =3D this->read_word(this->base + ONENAND_REG_INTERRUPT);
+	ctrl =3D this->read_word(this->base + ONENAND_REG_CTRL_STATUS);
+
+	if (ctrl & ONENAND_CTRL_ERROR) {
+		/* It maybe occur at initial bad block */
+		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: controller error =3D 0x%04x\n",=
 ctrl);
+		/* Clear other interrupt bits for preventing ECC error */
+		interrupt &=3D ONENAND_INT_MASTER;
+	}
+
+	if (ctrl & ONENAND_CTRL_LOCK) {
+		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: it's locked error =3D 0x%04x\n"=
, ctrl);
+		return -EACCES;
+	}
+
+	if (interrupt & ONENAND_INT_READ) {
+		ecc =3D this->read_word(this->base + ONENAND_REG_ECC_STATUS);
+		if (ecc & ONENAND_ECC_2BIT_ALL) {
+			DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: ECC error =3D 0x%04x\n", ecc);
+			return -EBADMSG;
+		}
+	}
+
+	return 0;
+}
+
+static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, i=
nt area)
+{
+	struct onenand_chip *this =3D mtd->priv;
+
+	if (ONENAND_CURRENT_BUFFERRAM(this)) {
+		if (area =3D=3D ONENAND_DATARAM)
+			return mtd->writesize;
+		if (area =3D=3D ONENAND_SPARERAM)
+			return mtd->oobsize;
+	}
+
+	return 0;
+}
+
+static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	struct omap2_onenand *info =3D container_of(mtd, struct omap2_onenand, =
mtd);
+	struct onenand_chip *this =3D mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+
+	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
+	if ((info->dma_channel < 0) || ((void *) buffer >=3D (void *) high_memo=
ry) ||
+	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
+	    (count < 1024) || (count & 3)) {
+		memcpy(buffer, (void *)(this->base + bram_offset), count);
+		return 0;
+	}
+
+	dma_src =3D info->phys_base + bram_offset;
+	dma_dst =3D dma_map_single(&info->pdev->dev, buffer, count, DMA_FROM_DE=
VICE);
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count / 4, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap2_block_sleep();
+	omap_start_dma(info->dma_channel);
+	wait_for_completion(&info->dma_done);
+	omap2_allow_sleep();
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
+					 const unsigned char *buffer, int offset,
+					 size_t count)
+{
+	struct omap2_onenand *info =3D container_of(mtd, struct omap2_onenand, =
mtd);
+	struct onenand_chip *this =3D mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+
+	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
+	if ((info->dma_channel < 0) || ((void *) buffer >=3D (void *) high_memo=
ry) ||
+	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
+	    (count < 1024) || (count & 3)) {
+		memcpy((void *)(this->base + bram_offset), buffer, count);
+		return 0;
+	}
+
+	dma_src =3D dma_map_single(&info->pdev->dev, (void *) buffer, count,
+				 DMA_TO_DEVICE);
+	dma_dst =3D info->phys_base + bram_offset;
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S16,
+				     count / 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap_start_dma(info->dma_channel);
+	wait_for_completion(&info->dma_done);
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+static int omap2_onenand_set_async_mode(struct omap2_onenand *info)
+{
+	struct gpmc_timings t;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk =3D 0;
+	t.cs_on =3D 0;
+	t.adv_on =3D gpmc_round_ns_to_ticks(1);
+
+	/* FIXME: Get timings from platform data */
+	/* Read */
+	t.adv_rd_off =3D t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.oe_on =3D t.adv_rd_off + gpmc_round_ns_to_ticks(1);
+	t.access =3D t.oe_on + gpmc_round_ns_to_ticks(35);
+	t.oe_off =3D t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off =3D t.oe_off;
+	t.rd_cycle =3D t.cs_rd_off + gpmc_round_ns_to_ticks(15);
+
+	/* Write */
+	t.adv_wr_off =3D t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.we_on =3D t.adv_wr_off + gpmc_round_ns_to_ticks(1);
+	t.we_off =3D t.we_on + gpmc_round_ns_to_ticks(30);
+	t.cs_wr_off =3D t.we_off + gpmc_round_ns_to_ticks(1);
+	t.wr_cycle =3D t.cs_wr_off + gpmc_round_ns_to_ticks(15);
+
+	/* Configure GPMC for asynchronous read */
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_READTYPE_ASYNC |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(info->gpmc_cs, &t);
+}
+
+static int omap2_onenand_set_sync_mode(struct omap2_onenand *info)
+{
+	const int min_gpmc_clk_period =3D 18;
+	struct gpmc_timings t;
+	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency, cs=
;
+	u32 reg;
+
+	cs =3D info->gpmc_cs;
+	tick_ns =3D gpmc_round_ns_to_ticks(1);
+	div =3D gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
+	gpmc_clk_ns =3D div * tick_ns;
+	if (gpmc_clk_ns >=3D 24)
+		latency =3D 3;
+	else
+		latency =3D 4;
+
+	/* Configure OneNAND for sync read */
+	reg =3D omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+	reg &=3D ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=3D	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	omap2_onenand_writew(reg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+
+	/* FIXME: Get timings from platform data */
+	/* Set syncronous read timings */
+	memset(&t, 0, sizeof(t));
+	t.sync_clk =3D min_gpmc_clk_period;
+	t.cs_on =3D 0;
+	t.adv_on =3D gpmc_round_ns_to_ticks(7);
+	fclk_offset_ns =3D t.adv_on + gpmc_round_ns_to_ticks(7);
+	fclk_offset =3D fclk_offset_ns / gpmc_round_ns_to_ticks(1);
+	t.page_burst_access =3D gpmc_clk_ns;
+
+	/* Read */
+	t.adv_rd_off =3D fclk_offset_ns + gpmc_round_ns_to_ticks(7);
+	t.oe_on =3D t.adv_rd_off;
+	t.access =3D fclk_offset_ns + (latency + 1) * gpmc_clk_ns;
+	t.oe_off =3D t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off =3D t.oe_off;
+	t.rd_cycle =3D t.cs_rd_off + gpmc_round_ns_to_ticks(17);
+
+	/* Write */
+	t.adv_wr_off =3D t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.we_on =3D t.adv_wr_off + gpmc_round_ns_to_ticks(1);
+	t.we_off =3D t.we_on + gpmc_round_ns_to_ticks(40);
+	t.cs_wr_off =3D t.we_off + gpmc_round_ns_to_ticks(1);
+	t.wr_cycle =3D t.cs_wr_off + gpmc_round_ns_to_ticks(1);
+
+	/* Configure GPMC for synchronous read */
+	fclk_offset %=3D div;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_WRAPBURST_SUPP |
+			  GPMC_CONFIG1_READMULTIPLE_SUPP |
+			  GPMC_CONFIG1_READTYPE_SYNC |
+			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
+			  GPMC_CONFIG1_PAGE_LEN(2) |
+			  GPMC_CONFIG1_WAIT_READ_MON |
+			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
+static int __devinit omap2_onenand_probe(struct platform_device *pdev)
+{
+	struct omap_onenand_platform_data *pdata;
+	struct omap2_onenand *info;
+	int r;
+
+	pdata =3D pdev->dev.platform_data;
+	if (pdata =3D=3D NULL) {
+		dev_err(&pdev->dev, "platform data missing\n");
+		return -ENODEV;
+	}
+
+	info =3D kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	init_completion(&info->irq_done);
+	init_completion(&info->dma_done);
+	info->gpmc_cs =3D pdata->cs;
+	info->gpio_irq =3D pdata->gpio_irq;
+
+	r =3D gpmc_cs_request(info->gpmc_cs, ONENAND_IO_SIZE, &info->phys_base)=
;
+	if (r < 0) {
+		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
+		goto err_kfree;
+	}
+
+	if (request_mem_region(info->phys_base, ONENAND_IO_SIZE,
+			       pdev->dev.driver->name) =3D=3D NULL) {
+		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x=
%x\n",
+			info->phys_base, ONENAND_IO_SIZE);
+		r =3D -EBUSY;
+		goto err_free_cs;
+	}
+	info->onenand.base =3D ioremap(info->phys_base, ONENAND_IO_SIZE);
+	if (info->onenand.base =3D=3D NULL) {
+		r =3D -ENOMEM;
+		goto err_release_mem_region;
+	}
+
+	/* Force OneNAND to async mode */
+	omap2_onenand_writew(ONENAND_SYS_CFG1_BRL_4 | ONENAND_SYS_CFG1_RDY |
+			     ONENAND_SYS_CFG1_INT, info->onenand.base + ONENAND_REG_SYS_CFG1)=
;
+
+	/* Set async timings in GPMC */
+	if (omap2_onenand_set_async_mode(info) < 0) {
+		dev_err(&pdev->dev, "Unable to set async mode\n");
+		r =3D -EINVAL;
+		goto err_iounmap;
+	}
+
+	if ((r =3D omap_request_gpio(info->gpio_irq)) < 0) {
+		dev_err(&pdev->dev,  "Failed to request GPIO%d for OneNAND\n",
+		        info->gpio_irq);
+		goto err_iounmap;
+	}
+	omap_set_gpio_direction(info->gpio_irq, 1);
+
+	if ((r =3D request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
+			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
+			     pdev->dev.driver->name, info)) < 0)
+		goto err_release_gpio;
+
+	r =3D omap_request_dma(0, pdev->dev.driver->name,
+			     omap2_onenand_dma_cb, (void *) info,
+			     &info->dma_channel);
+	if (r =3D=3D 0) {
+		omap_set_dma_write_mode(info->dma_channel, OMAP_DMA_WRITE_NON_POSTED);
+		omap_set_dma_src_data_pack(info->dma_channel, 1);
+		omap_set_dma_src_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
+		omap_set_dma_dest_data_pack(info->dma_channel, 1);
+		omap_set_dma_dest_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8)=
;
+	} else {
+		dev_info(&pdev->dev,
+			 "failed to allocate DMA for OneNAND, using PIO instead\n");
+		info->dma_channel =3D -1;
+	}
+
+	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual =
base %p\n",
+		 info->gpmc_cs, info->phys_base, info->onenand.base);
+
+	info->pdev =3D pdev;
+	info->mtd.name =3D pdev->dev.bus_id;
+	info->mtd.priv =3D &info->onenand;
+	info->mtd.owner =3D THIS_MODULE;
+	info->onenand.wait =3D omap2_onenand_wait;
+	info->onenand.read_bufferram =3D omap2_onenand_read_bufferram;
+	info->onenand.write_bufferram =3D omap2_onenand_write_bufferram;
+
+	if ((r =3D onenand_scan(&info->mtd, 1)) < 0)
+		goto err_release_dma;
+
+	if (omap2_onenand_set_sync_mode(info) < 0) {
+		dev_err(&pdev->dev, "Unable to set sync mode\n");
+		r =3D -EINVAL;
+		goto err_release_onenand;
+	}
+
+#ifdef CONFIG_MTD_PARTITIONS
+	if (pdata->parts !=3D NULL)
+		r =3D add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
+#endif
+		r =3D add_mtd_device(&info->mtd);
+	if (r < 0)
+		goto err_release_onenand;
+
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+err_release_onenand:
+	onenand_release(&info->mtd);
+err_release_dma:
+	if (info->dma_channel !=3D -1)
+		omap_free_dma(info->dma_channel);
+	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+err_release_gpio:
+	omap_free_gpio(info->gpio_irq);
+err_iounmap:
+	iounmap(info->onenand.base);
+err_release_mem_region:
+	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
+err_free_cs:
+	gpmc_cs_free(info->gpmc_cs);
+err_kfree:
+	kfree(info);
+
+	return r;
+}
+
+static int __devexit omap2_onenand_remove(struct platform_device *pdev)
+{
+	struct omap2_onenand *info =3D dev_get_drvdata(&pdev->dev);
+
+	BUG_ON(info =3D=3D NULL);
+
+#ifdef CONFIG_MTD_PARTITIONS
+	if (info->parts)
+		del_mtd_partitions(&info->mtd);
+	else
+		del_mtd_device(&info->mtd);
+#else
+	del_mtd_device(&info->mtd);
+#endif
+
+	onenand_release(&info->mtd);
+	if (info->dma_channel !=3D -1)
+		omap_free_dma(info->dma_channel);
+	platform_set_drvdata(pdev, NULL);
+	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+	omap_free_gpio(info->gpio_irq);
+	iounmap(info->onenand.base);
+	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
+	kfree(info);
+
+	return 0;
+}
+
+static struct platform_driver omap2_onenand_driver =3D {
+	.probe		=3D omap2_onenand_probe,
+	.remove		=3D omap2_onenand_remove,
+	.driver		=3D {
+		.name	=3D "omap2-onenand",
+		.owner  =3D THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init omap2_onenand_init(void)
+{
+	printk(KERN_INFO "OMAP2 OneNAND driver initializing\n");
+	return platform_driver_register(&omap2_onenand_driver);
+}
+
+static void __exit omap2_onenand_exit(void)
+{
+	platform_driver_unregister(&omap2_onenand_driver);
+}
+
+module_init(omap2_onenand_init);
+module_exit(omap2_onenand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jarkko Lavinen <jarkko.lavinen@nokia.com>");
+MODULE_DESCRIPTION("Glue layer for OneNAND flash on OMAP2");
--- /dev/null
+++ b/include/asm-arm/arch-omap/blizzard.h
@@ -0,0 +1,12 @@
+#ifndef _BLIZZARD_H
+#define _BLIZZARD_H
+
+struct blizzard_platform_data {
+	void		(*power_up)(struct device *dev);
+	void		(*power_down)(struct device *dev);
+	unsigned long	(*get_clock_rate)(struct device *dev);
+
+	unsigned	te_connected : 1;
+};
+
+#endif
--- a/include/asm-arm/arch-omap/board.h
+++ b/include/asm-arm/arch-omap/board.h
@@ -25,9 +25,12 @@
 #define OMAP_TAG_FBMEM		0x4f08
 #define OMAP_TAG_STI_CONSOLE	0x4f09
 #define OMAP_TAG_CAMERA_SENSOR	0x4f0a
+#define OMAP_TAG_PARTITION      0x4f0b
+#define OMAP_TAG_TEA5761	0x4f10
+#define OMAP_TAG_TMP105		0x4f11
=20
 #define OMAP_TAG_BOOT_REASON    0x4f80
-#define OMAP_TAG_FLASH_PART	0x4f81
+#define OMAP_TAG_FLASH_PART_STR	0x4f81
 #define OMAP_TAG_VERSION_STR	0x4f82
=20
 struct omap_clock_config {
@@ -139,8 +142,25 @@
 	unsigned int enabled_uarts;
 };
=20
+struct omap_tea5761_config {
+	u16 enable_gpio;
+};
+
+/* This cannot be passed from the bootloader */
+struct omap_tmp105_config {
+	u16 tmp105_irq_pin;
+	int (* set_power)(int enable);
+};
+
+struct omap_partition_config {
+	char name[16];
+	unsigned int size;
+	unsigned int offset;
+	/* same as in include/linux/mtd/partitions.h */
+	unsigned int mask_flags;
+};
=20
-struct omap_flash_part_config {
+struct omap_flash_part_str_config {
 	char part_table[0];
 };
=20
--- /dev/null
+++ b/include/asm-arm/arch-omap/eac.h
@@ -0,0 +1,101 @@
+/*
+ * linux/include/asm-arm/arch-omap2/eac.h
+ *
+ * Defines for Enhanced Audio Controller
+ *
+ * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Copyright (C) 2004 Texas Instruments, Inc.
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
+#ifndef __ASM_ARM_ARCH_OMAP2_EAC_H
+#define __ASM_ARM_ARCH_OMAP2_EAC_H
+
+#include <asm/arch/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/irq.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+
+/* master codec clock source */
+#define EAC_MCLK_EXT_MASK	0x100
+enum eac_mclk_src {
+	EAC_MCLK_INT_11290000, /* internal 96 MHz / 8.5 =3D 11.29 Mhz */
+	EAC_MCLK_EXT_11289600 =3D EAC_MCLK_EXT_MASK,
+	EAC_MCLK_EXT_12288000,
+	EAC_MCLK_EXT_2x11289600,
+	EAC_MCLK_EXT_2x12288000,
+};
+
+/* codec port interface mode */
+enum eac_codec_mode {
+	EAC_CODEC_PCM,
+	EAC_CODEC_AC97,
+	EAC_CODEC_I2S,
+};
+
+/* configuration structure for I2S mode */
+struct eac_i2s_conf {
+	/* it seems according to TRM that the polarity-changed I2S mode is not
+	 * only that frame sync polarity (EAC.AC_FS) is changed but also direct=
ion
+	 * of it and interface serial clock (EAC.AC_SCLK) */
+	unsigned	polarity_changed_mode:1;
+	/* if enabled, then serial data starts one clock cycle after the
+	 * of EAC.AC_FS for first audio slot */
+	unsigned	sync_delay_enable:1;
+};
+
+/* configuration structure for EAC codec port */
+struct eac_codec {
+	enum eac_mclk_src	mclk_src;
+
+	enum eac_codec_mode	codec_mode;
+	union {
+		struct eac_i2s_conf	i2s;
+	} codec_conf;
+
+	int		default_rate; /* audio sampling rate */
+
+	int		(* set_power)(void *private_data, int dac, int adc);
+	int		(* register_controls)(void *private_data,
+					      struct snd_card *card);
+	const char 	*short_name;
+
+	void		*private_data;
+};
+
+/* structure for passing platform dependent data to the EAC driver */
+struct eac_platform_data {
+        int	(* init)(struct device *eac_dev);
+	void	(* cleanup)(struct device *eac_dev);
+	/* these callbacks are used to configure & control external MCLK
+	 * source. NULL if not used */
+	int	(* enable_ext_clocks)(struct device *eac_dev);
+	void	(* disable_ext_clocks)(struct device *eac_dev);
+};
+
+extern void omap_init_eac(struct eac_platform_data *pdata);
+
+extern int eac_register_codec(struct device *eac_dev, struct eac_codec *=
codec);
+extern void eac_unregister_codec(struct device *eac_dev);
+
+extern int eac_set_mode(struct device *eac_dev, int play, int rec);
+
+#endif /* __ASM_ARM_ARCH_OMAP2_EAC_H */
--- a/include/asm-arm/arch-omap/gpmc.h
+++ b/include/asm-arm/arch-omap/gpmc.h
@@ -81,6 +81,7 @@
 };
=20
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
+extern unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns);
=20
 extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern u32 gpmc_cs_read_reg(int cs, int idx);
--- a/include/asm-arm/arch-omap/menelaus.h
+++ b/include/asm-arm/arch-omap/menelaus.h
@@ -7,6 +7,15 @@
 #ifndef __ASM_ARCH_MENELAUS_H
 #define __ASM_ARCH_MENELAUS_H
=20
+struct device;
+
+struct menelaus_platform_data {
+	int (* late_init)(struct device *dev);
+};
+
+/* Call only at init time. */
+extern void menelaus_set_platform_data(struct menelaus_platform_data *pd=
ata);
+
 extern int menelaus_register_mmc_callback(void (*callback)(void *data, u=
8 card_mask),
 					  void *data);
 extern void menelaus_unregister_mmc_callback(void);
@@ -20,6 +29,19 @@
 extern int menelaus_set_vdcdc(int dcdc, unsigned int mV);
 extern int menelaus_set_slot_sel(int enable);
 extern int menelaus_get_slot_pin_states(void);
+extern int menelaus_set_vcore_sw(unsigned int mV);
+extern int menelaus_set_vcore_hw(unsigned int roof_mV, unsigned int floo=
r_mV);
+
+#define EN_VPLL_SLEEP	(1 << 7)
+#define EN_VMMC_SLEEP	(1 << 6)
+#define EN_VAUX_SLEEP	(1 << 5)
+#define EN_VIO_SLEEP	(1 << 4)
+#define EN_VMEM_SLEEP	(1 << 3)
+#define EN_DC3_SLEEP	(1 << 2)
+#define EN_DC2_SLEEP	(1 << 1)
+#define EN_VC_SLEEP	(1 << 0)
+
+extern int menelaus_set_regulator_sleep(int enable, u32 val);
=20
 #if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_MENELAUS)
 #define omap_has_menelaus()	1
@@ -28,4 +50,3 @@
 #endif
=20
 #endif
-
--- /dev/null
+++ b/include/asm-arm/arch-omap/mmc.h
@@ -0,0 +1,67 @@
+/*
+ * MMC definitions for OMAP2
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP2_MMC_H
+#define __OMAP2_MMC_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mmc/protocol.h>
+#include <linux/mmc/host.h>
+
+#define OMAP_MMC_MAX_SLOTS	2
+
+struct omap_mmc_platform_data {
+	unsigned enabled:1;
+	/* number of slots on board */
+	unsigned nr_slots:2;
+	/* nomux means "standard" muxing is wrong on this board, and that
+	 * board-specific code handled it before common init logic.
+	 */
+	unsigned nomux:1;
+	/* 4 wire signaling is optional, and is only used for SD/SDIO and
+	 * MMCv4 */
+	unsigned wire4:1;
+	/* set if your board has components or wiring that limits the
+	 * maximum frequency on the MMC bus */
+	unsigned int max_freq;
+
+	/* switch the bus to a new slot */
+	int (* switch_slot)(struct device *dev, int slot);
+	/* initialize board-specific MMC functionality, can be NULL if
+	 * not supported */
+	int (* init)(struct device *dev);
+	void (* cleanup)(struct device *dev);
+
+	struct omap_mmc_slot_data {
+		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
+		int (* set_power)(struct device *dev, int slot, int power_on, int vdd)=
;
+		int (* get_ro)(struct device *dev, int slot);
+
+		/* return MMC cover switch state, can be NULL if not supported.
+		 *
+		 * possible return values:
+		 *   0 - open
+		 *   1 - closed
+		 */
+		int (* get_cover_state)(struct device *dev, int slot);
+
+		const char *name;
+		u32 ocr_mask;
+	} slots[OMAP_MMC_MAX_SLOTS];
+};
+
+extern void omap_set_mmc_info(int host, const struct omap_mmc_platform_d=
ata *info);
+
+/* called from board-specific card detection service routine */
+extern void omap_mmc_notify_card_detect(struct device *dev, int slot, in=
t detected);
+extern void omap_mmc_notify_cover_event(struct device *dev, int slot, in=
t is_closed);
+
+#endif
--- /dev/null
+++ b/include/asm-arm/arch-omap/onenand.h
@@ -0,0 +1,19 @@
+/*
+ * include/asm-arm/arch-omap/onenand.h
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Author: Juha Yrjola
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mtd/partitions.h>
+
+struct omap_onenand_platform_data {
+	int			cs;
+	int			gpio_irq;
+	struct mtd_partition	*parts;
+	int			nr_parts;
+};
--- /dev/null
+++ b/include/linux/spi/tsc2301.h
@@ -0,0 +1,207 @@
+#ifndef _LINUX_SPI_TSC2301_H
+#define _LINUX_SPI_TSC2301_H
+
+#include <linux/types.h>
+#include <linux/timer.h>
+
+struct tsc2301_platform_data {
+	/*
+	 * Keypad
+	 */
+	s16	reset_gpio;
+	s16	keyb_int;
+	s16	keymap[16];	/* Set a key to a negative value if not used */
+	unsigned kp_rep:1;	/* Enable keypad repeating */
+
+	/*
+	 * Touchscreen
+	 */
+	s16	dav_gpio;
+	s16	pen_int_gpio;
+	u16	ts_x_plate_ohm;
+	u32	ts_stab_time;	/* voltage settling time */
+	u8	ts_hw_avg;	/* HW assiseted averaging. Can be
+				   0, 4, 8, 16 samples per reading */
+	u32	ts_max_pressure;/* Samples with bigger pressure value will
+				   be ignored, since the corresponding X, Y
+				   values are unreliable */
+	u32	ts_touch_pressure;	/* Pressure limit until we report a
+					   touch event. After that we switch
+					   to ts_max_pressure. */
+	unsigned ts_ignore_last : 1;
+
+	/*
+	 * Audio
+	 */
+	unsigned	pll_pdc:4;
+	unsigned	pll_a:4;
+	unsigned	pll_n:4;
+	unsigned	pll_output:1; /* Output PLL on GPIO_0 */
+
+	unsigned	mclk_ratio:2;
+	unsigned	i2s_sample_rate:4;
+	unsigned	i2s_format:2;
+	/* Mask for audio blocks to be powered down */
+	u16		power_down_blocks;
+
+	/* Called after codec has been initialized, can be NULL */
+	int (* codec_init)(struct device *tsc2301_dev);
+	/* Called when codec is being removed, can be NULL */
+	void (* codec_cleanup)(struct device *tsc2301_dev);
+	int	(*enable_clock)(struct device *dev);
+	void	(*disable_clock)(struct device *dev);
+	int	(*get_keyb_irq_state)(struct device *dev);
+
+	const struct tsc2301_mixer_gpio {
+		const char	*name;
+		unsigned	gpio:4;
+		unsigned	inverted:1;
+		unsigned	def_enable:1; /* enable by default */
+		unsigned	deactivate_on_pd:1; /* power-down flag */
+	} *mixer_gpios;
+	int	n_mixer_gpios;
+};
+
+struct tsc2301_kp;
+struct tsc2301_ts;
+struct tsc2301_mixer;
+
+struct tsc2301 {
+	struct spi_device	*spi;
+
+	s16			reset_gpio;
+	u16			config2_shadow;
+
+        struct tsc2301_kp	*kp;
+	struct tsc2301_ts	*ts;
+	struct tsc2301_mixer	*mixer;
+
+	int			(*enable_clock)(struct device *dev);
+	void			(*disable_clock)(struct device *dev);
+};
+
+
+#define TSC2301_HZ	33000000
+
+#define TSC2301_REG(page, addr)  (((page) << 11) | ((addr) << 5))
+#define TSC2301_REG_TO_PAGE(reg) (((reg) >> 11) & 0x03)
+#define TSC2301_REG_TO_ADDR(reg) (((reg) >> 5)  & 0x1f)
+
+#define TSC2301_REG_X		TSC2301_REG(0, 0)
+#define TSC2301_REG_Y		TSC2301_REG(0, 1)
+#define TSC2301_REG_Z1		TSC2301_REG(0, 2)
+#define TSC2301_REG_Z2		TSC2301_REG(0, 3)
+#define TSC2301_REG_KPDATA	TSC2301_REG(0, 4)
+#define TSC2301_REG_ADC		TSC2301_REG(1, 0)
+#define TSC2301_REG_KEY		TSC2301_REG(1, 1)
+#define TSC2301_REG_DAC		TSC2301_REG(1, 2)
+#define TSC2301_REG_REF		TSC2301_REG(1, 3)
+#define TSC2301_REG_CONFIG	TSC2301_REG(1, 5)
+#define TSC2301_REG_CONFIG2	TSC2301_REG(1, 6)
+#define TSC2301_REG_KPMASK	TSC2301_REG(1, 16)
+#define TSC2301_REG_AUDCNTL	TSC2301_REG(2, 0)
+#define TSC2301_REG_ADCVOL	TSC2301_REG(2, 1)
+#define TSC2301_REG_DACVOL	TSC2301_REG(2, 2)
+#define TSC2301_REG_BPVOL	TSC2301_REG(2, 3)
+#define TSC2301_REG_KEYCTL	TSC2301_REG(2, 4)
+#define TSC2301_REG_PD_MISC	TSC2301_REG(2, 5)
+#define TSC2301_REG_GPIO	TSC2301_REG(2, 6)
+#define TSC2301_REG_ADCLKCFG	TSC2301_REG(2, 27)
+
+#define TSC2301_REG_PD_MISC_APD		(1 << 15)
+#define TSC2301_REG_PD_MISC_AVPD	(1 << 14)
+#define TSC2301_REG_PD_MISC_ABPD	(1 << 13)
+#define TSC2301_REG_PD_MISC_HAPD	(1 << 12)
+#define TSC2301_REG_PD_MISC_MOPD	(1 << 11)
+#define TSC2301_REG_PD_MISC_DAPD	(1 << 10)
+#define TSC2301_REG_PD_MISC_ADPDL	(1 << 9)
+#define TSC2301_REG_PD_MISC_ADPDR	(1 << 8)
+#define TSC2301_REG_PD_MISC_PDSTS	(1 << 7)
+#define TSC2301_REG_PD_MISC_MIBPD	(1 << 6)
+
+/* I2S sample rate */
+#define TSC2301_I2S_SR_48000	0x00
+#define TSC2301_I2S_SR_44100	0x01
+#define TSC2301_I2S_SR_32000	0x02
+#define TSC2301_I2S_SR_24000	0x03
+#define TSC2301_I2S_SR_22050	0x04
+#define TSC2301_I2S_SR_16000	0x05
+#define TSC2301_I2S_SR_12000	0x06
+#define TSC2301_I2S_SR_11050	0x07
+#define TSC2301_I2S_SR_8000	0x08
+
+/* 16-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */
+#define TSC2301_I2S_FORMAT0	0x00
+/* 20-bit, MSB-first. DAC Right-Justified, ADC Left-Justified */
+#define TSC2301_I2S_FORMAT1	0x01
+/* 20-bit, MSB-first. DAC Left-Justified, ADC Left-Justified */
+#define TSC2301_I2S_FORMAT2	0x02
+/* 20-bit, MSB-first */
+#define TSC2301_I2S_FORMAT3	0x03
+
+/* Master Clock Ratio */
+#define TSC2301_MCLK_256xFS	0x00 /* default */
+#define TSC2301_MCLK_384xFS	0x01
+#define TSC2301_MCLK_512xFS	0x02
+
+
+extern u16 tsc2301_read_reg(struct tsc2301 *tsc, int reg);
+extern void tsc2301_write_reg(struct tsc2301 *tsc, int reg, u16 val);
+extern void tsc2301_write_kbc(struct tsc2301 *tsc, int val);
+extern void tsc2301_write_pll(struct tsc2301 *tsc, int pll_n, int pll_a,
+			      int pll_pdc, int pct_e, int pll_o);
+extern void tsc2301_read_buf(struct tsc2301 *tsc, int reg, u16 *buf, int=
 len);
+
+#define TSC2301_DECL_MOD(module)					\
+extern int  tsc2301_##module##_init(struct tsc2301 *tsc,		\
+			   struct tsc2301_platform_data *pdata);	\
+extern void tsc2301_##module##_exit(struct tsc2301 *tsc);		\
+extern void tsc2301_##module##_prep_for_clk_stop(struct tsc2301 *tsc);	\
+extern void tsc2301_##module##_cont_after_clk_stop(struct tsc2301 *tsc);=
\
+extern int  tsc2301_##module##_suspend(struct tsc2301 *tsc);		\
+extern void tsc2301_##module##_resume(struct tsc2301 *tsc);
+
+#define TSC2301_DECL_EMPTY_MOD(module)					\
+static inline int tsc2301_##module##_init(struct tsc2301 *tsc,		\
+			   struct tsc2301_platform_data *pdata)		\
+{									\
+	return 0;							\
+}									\
+static inline void tsc2301_##module##_exit(struct tsc2301 *tsc) {}	\
+static inline void tsc2301_##module##_prep_for_clk_stop			\
+					(struct tsc2301 *tsc) {}	\
+static inline void tsc2301_##module##_cont_after_clk_stop		\
+					(struct tsc2301 *tsc) {}	\
+static inline int  tsc2301_##module##_suspend(struct tsc2301 *tsc)	\
+{									\
+	return 0;							\
+}									\
+static inline void tsc2301_##module##_resume(struct tsc2301 *tsc) {}
+
+#ifdef CONFIG_SPI_TSC2301_KEYPAD
+TSC2301_DECL_MOD(kp)
+#else
+TSC2301_DECL_EMPTY_MOD(kp)
+#endif
+
+#ifdef CONFIG_SPI_TSC2301_TOUCHSCREEN
+TSC2301_DECL_MOD(ts)
+#else
+TSC2301_DECL_EMPTY_MOD(ts)
+#endif
+
+#ifdef CONFIG_SPI_TSC2301_AUDIO
+TSC2301_DECL_MOD(mixer)
+extern void tsc2301_mixer_set_power(struct device *tsc_dev, int dac, int=
 adc);
+
+struct snd_card;
+extern int tsc2301_mixer_register_controls(struct device *tsc_dev,
+					   struct snd_card *card);
+#else
+TSC2301_DECL_EMPTY_MOD(mixer)
+#endif
+
+extern void tsc2301_enable_mclk(struct device *tsc_dev);
+extern void tsc2301_disable_mclk(struct device *tsc_dev);
+
+#endif
--- /dev/null
+++ b/arch/arm/configs/n800_defconfig
@@ -0,0 +1,1495 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.20-rc5-omap1
+# Wed Jan 17 17:19:12 2007
+#
+CONFIG_ARM=3Dy
+CONFIG_GENERIC_TIME=3Dy
+CONFIG_MMU=3Dy
+CONFIG_GENERIC_HARDIRQS=3Dy
+CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
+CONFIG_HARDIRQS_SW_RESEND=3Dy
+CONFIG_GENERIC_IRQ_PROBE=3Dy
+CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=3Dy
+CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
+CONFIG_VECTORS_BASE=3D0xffff0000
+CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=3Dy
+CONFIG_BROKEN_ON_SMP=3Dy
+CONFIG_INIT_ENV_ARG_LIMIT=3D32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=3D""
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SWAP=3Dy
+CONFIG_SYSVIPC=3Dy
+# CONFIG_IPC_NS is not set
+CONFIG_POSIX_MQUEUE=3Dy
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=3Dy
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=3D""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
+CONFIG_SYSCTL=3Dy
+# CONFIG_EMBEDDED is not set
+CONFIG_UID16=3Dy
+CONFIG_SYSCTL_SYSCALL=3Dy
+CONFIG_KALLSYMS=3Dy
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=3Dy
+CONFIG_PRINTK=3Dy
+CONFIG_BUG=3Dy
+CONFIG_ELF_CORE=3Dy
+CONFIG_BASE_FULL=3Dy
+CONFIG_FUTEX=3Dy
+CONFIG_EPOLL=3Dy
+CONFIG_SHMEM=3Dy
+CONFIG_SLAB=3Dy
+CONFIG_VM_EVENT_COUNTERS=3Dy
+CONFIG_RT_MUTEXES=3Dy
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=3D0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
+
+#
+# Block layer
+#
+CONFIG_BLOCK=3Dy
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=3Dy
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=3Dy
+CONFIG_DEFAULT_IOSCHED=3D"noop"
+
+#
+# System Type
+#
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+CONFIG_ARCH_OMAP=3Dy
+
+#
+# TI OMAP Implementations
+#
+CONFIG_ARCH_OMAP_OTG=3Dy
+# CONFIG_ARCH_OMAP1 is not set
+CONFIG_ARCH_OMAP2=3Dy
+
+#
+# OMAP Feature Selections
+#
+CONFIG_OMAP_RESET_CLOCKS=3Dy
+CONFIG_OMAP_BOOT_TAG=3Dy
+CONFIG_OMAP_BOOT_REASON=3Dy
+CONFIG_OMAP_COMPONENT_VERSION=3Dy
+CONFIG_OMAP_GPIO_SWITCH=3Dy
+# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_STI=3Dy
+CONFIG_OMAP_STI_CONSOLE=3Dy
+# CONFIG_OMAP_MCBSP is not set
+# CONFIG_OMAP_MPU_TIMER is not set
+CONFIG_OMAP_32K_TIMER=3Dy
+CONFIG_OMAP_32K_TIMER_HZ=3D128
+CONFIG_OMAP_DM_TIMER=3Dy
+# CONFIG_OMAP_LL_DEBUG_UART1 is not set
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+CONFIG_OMAP_LL_DEBUG_UART3=3Dy
+CONFIG_OMAP_DSP=3Dy
+# CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
+CONFIG_OMAP_DSP_TASK_MULTIOPEN=3Dy
+CONFIG_OMAP_DSP_FBEXPORT=3Dy
+CONFIG_MACH_OMAP_GENERIC=3Dy
+
+#
+# OMAP Core Type
+#
+CONFIG_ARCH_OMAP24XX=3Dy
+CONFIG_ARCH_OMAP2420=3Dy
+# CONFIG_ARCH_OMAP2430 is not set
+
+#
+# OMAP Board Type
+#
+CONFIG_MACH_NOKIA_N800=3Dy
+CONFIG_MACH_OMAP2_TUSB6010=3Dy
+# CONFIG_MACH_OMAP_H4 is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
+# CONFIG_MACH_OMAP_APOLLON is not set
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=3Dy
+CONFIG_CPU_V6=3Dy
+# CONFIG_CPU_32v6K is not set
+CONFIG_CPU_32v6=3Dy
+CONFIG_CPU_ABRT_EV6=3Dy
+CONFIG_CPU_CACHE_V6=3Dy
+CONFIG_CPU_CACHE_VIPT=3Dy
+CONFIG_CPU_COPY_V6=3Dy
+CONFIG_CPU_TLB_V6=3Dy
+CONFIG_CPU_CP15=3Dy
+CONFIG_CPU_CP15_MMU=3Dy
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=3Dy
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+
+#
+# Bus support
+#
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+# CONFIG_PREEMPT is not set
+CONFIG_NO_IDLE_HZ=3Dy
+CONFIG_HZ=3D128
+CONFIG_AEABI=3Dy
+CONFIG_OABI_COMPAT=3Dy
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=3Dy
+CONFIG_FLATMEM_MANUAL=3Dy
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=3Dy
+CONFIG_FLAT_NODE_MEM_MAP=3Dy
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=3D4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_LEDS=3Dy
+# CONFIG_LEDS_TIMER is not set
+# CONFIG_LEDS_CPU is not set
+CONFIG_ALIGNMENT_TRAP=3Dy
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=3D0x10C08000
+CONFIG_ZBOOT_ROM_BSS=3D0x10200000
+# CONFIG_ZBOOT_ROM is not set
+CONFIG_CMDLINE=3D"root=3D1f03 rootfstype=3Djffs2"
+# CONFIG_XIP_KERNEL is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+CONFIG_FPE_NWFPE=3Dy
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+CONFIG_VFP=3Dy
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=3Dy
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Power management options
+#
+CONFIG_PM=3Dy
+# CONFIG_PM_LEGACY is not set
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_APM is not set
+
+#
+# Networking
+#
+CONFIG_NET=3Dy
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=3Dy
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=3Dy
+CONFIG_XFRM=3Dy
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=3Dy
+CONFIG_IP_MULTICAST=3Dy
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=3Dy
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_BEET=3Dy
+CONFIG_INET_DIAG=3Dy
+CONFIG_INET_TCP_DIAG=3Dy
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=3Dy
+CONFIG_DEFAULT_TCP_CONG=3D"cubic"
+# CONFIG_TCP_MD5SIG is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETLABEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=3Dy
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+CONFIG_NETFILTER_NETLINK=3Dy
+# CONFIG_NETFILTER_NETLINK_QUEUE is not set
+# CONFIG_NETFILTER_NETLINK_LOG is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+CONFIG_NETFILTER_XTABLES=3Dy
+# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
+# CONFIG_NETFILTER_XT_TARGET_MARK is not set
+# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
+# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
+# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
+# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
+# CONFIG_NETFILTER_XT_MATCH_ESP is not set
+# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
+# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
+# CONFIG_NETFILTER_XT_MATCH_MAC is not set
+# CONFIG_NETFILTER_XT_MATCH_MARK is not set
+# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
+# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
+# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
+# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
+# CONFIG_NETFILTER_XT_MATCH_REALM is not set
+# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
+# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
+# CONFIG_NETFILTER_XT_MATCH_STRING is not set
+# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=3Dy
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
+# CONFIG_IP_NF_MATCH_TOS is not set
+# CONFIG_IP_NF_MATCH_RECENT is not set
+# CONFIG_IP_NF_MATCH_ECN is not set
+# CONFIG_IP_NF_MATCH_AH is not set
+# CONFIG_IP_NF_MATCH_TTL is not set
+# CONFIG_IP_NF_MATCH_OWNER is not set
+# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
+CONFIG_IP_NF_FILTER=3Dy
+# CONFIG_IP_NF_TARGET_REJECT is not set
+# CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
+# CONFIG_IP_NF_TARGET_TCPMSS is not set
+CONFIG_IP_NF_TARGET_IDLETIMER=3Dy
+# CONFIG_IP_NF_MANGLE is not set
+# CONFIG_IP_NF_RAW is not set
+# CONFIG_IP_NF_ARPTABLES is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+CONFIG_BT=3Dy
+CONFIG_BT_L2CAP=3Dy
+CONFIG_BT_SCO=3Dy
+CONFIG_BT_RFCOMM=3Dy
+CONFIG_BT_RFCOMM_TTY=3Dy
+CONFIG_BT_BNEP=3Dy
+# CONFIG_BT_BNEP_MC_FILTER is not set
+# CONFIG_BT_BNEP_PROTO_FILTER is not set
+CONFIG_BT_HIDP=3Dy
+
+#
+# Bluetooth device drivers
+#
+# CONFIG_BT_HCIUSB is not set
+# CONFIG_BT_HCIUART is not set
+# CONFIG_BT_HCIBCM203X is not set
+# CONFIG_BT_HCIBPA10X is not set
+# CONFIG_BT_HCIBFUSB is not set
+# CONFIG_BT_HCIBRF6150 is not set
+# CONFIG_BT_HCIVHCI is not set
+# CONFIG_IEEE80211 is not set
+CONFIG_WIRELESS_EXT=3Dy
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=3Dy
+CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
+CONFIG_FW_LOADER=3Dy
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=3Dy
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=3Dy
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=3Dy
+# CONFIG_MTD_AFS_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=3Dy
+CONFIG_MTD_BLOCK=3Dy
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
+CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
+CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=3Dy
+CONFIG_MTD_CFI_I2=3Dy
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# OneNAND Flash Device Drivers
+#
+CONFIG_MTD_ONENAND=3Dy
+# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
+# CONFIG_MTD_ONENAND_GENERIC is not set
+CONFIG_MTD_ONENAND_OMAP2=3Dy
+CONFIG_MTD_ONENAND_OTP=3Dy
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=3Dy
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=3Dy
+CONFIG_BLK_DEV_RAM_COUNT=3D16
+CONFIG_BLK_DEV_RAM_SIZE=3D4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
+CONFIG_BLK_DEV_INITRD=3Dy
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=3Dy
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=3Dy
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_SCSI_DEBUG is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=3Dy
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=3Dy
+
+#
+# PHY device support
+#
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+CONFIG_MII=3Dy
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=3Dy
+# CONFIG_NET_WIRELESS_RTNETLINK is not set
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_USB_ZD1201 is not set
+# CONFIG_HOSTAP is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+CONFIG_PPP=3Dy
+# CONFIG_PPP_MULTILINK is not set
+CONFIG_PPP_FILTER=3Dy
+CONFIG_PPP_ASYNC=3Dy
+CONFIG_PPP_SYNC_TTY=3Dy
+CONFIG_PPP_DEFLATE=3Dy
+CONFIG_PPP_BSDCOMP=3Dy
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPPOE is not set
+# CONFIG_SLIP is not set
+CONFIG_SLHC=3Dy
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=3Dy
+# CONFIG_INPUT_FF_MEMLESS is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=3Dy
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=3Dy
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=3Dy
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_OMAP is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+CONFIG_INPUT_TOUCHSCREEN=3Dy
+# CONFIG_TOUCHSCREEN_ADS7846 is not set
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=3Dy
+CONFIG_SERIO_SERPORT=3Dy
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=3Dy
+CONFIG_VT_CONSOLE=3Dy
+CONFIG_HW_CONSOLE=3Dy
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+CONFIG_SERIAL_8250_NR_UARTS=3D4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=3Dy
+CONFIG_SERIAL_CORE_CONSOLE=3Dy
+CONFIG_UNIX98_PTYS=3Dy
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+CONFIG_WATCHDOG=3Dy
+CONFIG_WATCHDOG_NOWAYOUT=3Dy
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=3Dy
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
+# CONFIG_HW_RANDOM is not set
+CONFIG_OMAP_RNG=3Dy
+# CONFIG_NVRAM is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=3Dy
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=3Dy
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+# CONFIG_GPIOEXPANDER_OMAP is not set
+CONFIG_MENELAUS=3Dy
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+CONFIG_SPI=3Dy
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=3Dy
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_OMAP_UWIRE is not set
+CONFIG_SPI_OMAP24XX=3Dy
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_TSC2102 is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=3Dy
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+# CONFIG_TIFM_CORE is not set
+
+#
+# LED devices
+#
+CONFIG_NEW_LEDS=3Dy
+CONFIG_LEDS_CLASS=3Dy
+
+#
+# LED drivers
+#
+# CONFIG_LEDS_OMAP_DEBUG is not set
+# CONFIG_LEDS_OMAP is not set
+CONFIG_LEDS_OMAP_PWM=3Dy
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=3Dy
+CONFIG_LEDS_TRIGGER_TIMER=3Dy
+CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
+
+#
+# Multimedia devices
+#
+CONFIG_VIDEO_DEV=3Dy
+# CONFIG_VIDEO_V4L1 is not set
+# CONFIG_VIDEO_V4L1_COMPAT is not set
+CONFIG_VIDEO_V4L2=3Dy
+
+#
+# Video Capture Adapters
+#
+
+#
+# Video Capture Adapters
+#
+# CONFIG_VIDEO_ADV_DEBUG is not set
+CONFIG_VIDEO_HELPER_CHIPS_AUTO=3Dy
+# CONFIG_VIDEO_VIVI is not set
+# CONFIG_VIDEO_SAA5246A is not set
+# CONFIG_VIDEO_SAA5249 is not set
+
+#
+# V4L USB devices
+#
+# CONFIG_VIDEO_PVRUSB2 is not set
+# CONFIG_VIDEO_USBVISION is not set
+# CONFIG_VIDEO_OMAP_CAMERA is not set
+
+#
+# Radio Adapters
+#
+# CONFIG_USB_DSBR is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FIRMWARE_EDID is not set
+CONFIG_FB=3Dy
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+CONFIG_FB_OMAP=3Dy
+CONFIG_FB_OMAP_LCDC_EXTERNAL=3Dy
+# CONFIG_FB_OMAP_LCDC_HWA742 is not set
+CONFIG_FB_OMAP_MANUAL_UPDATE=3Dy
+CONFIG_FB_OMAP_LCD_MIPID=3Dy
+CONFIG_FB_OMAP_BOOTLOADER_INIT=3Dy
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D4
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=3Dy
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Sound
+#
+CONFIG_SOUND=3Dy
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=3Dy
+# CONFIG_SND_SEQUENCER is not set
+CONFIG_SND_OSSEMUL=3Dy
+CONFIG_SND_MIXER_OSS=3Dy
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=3Dy
+# CONFIG_SND_VERBOSE_PROCFS is not set
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# ALSA ARM devices
+#
+# CONFIG_SND_OMAP_AIC23 is not set
+# CONFIG_SND_OMAP_TSC2101 is not set
+# CONFIG_SND_SX1 is not set
+# CONFIG_SND_OMAP_TSC2102 is not set
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
+
+#
+# HID Devices
+#
+CONFIG_HID=3Dy
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=3Dy
+CONFIG_USB_ARCH_HAS_OHCI=3Dy
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=3Dy
+CONFIG_USB_DEBUG=3Dy
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=3Dy
+# CONFIG_USB_BANDWIDTH is not set
+CONFIG_USB_DYNAMIC_MINORS=3Dy
+CONFIG_USB_SUSPEND=3Dy
+# CONFIG_USB_MULTITHREAD_PROBE is not set
+CONFIG_USB_OTG=3Dy
+CONFIG_USB_OTG_WHITELIST=3Dy
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+CONFIG_USB_MUSB_HDRC=3Dy
+CONFIG_USB_TUSB6010=3Dy
+# CONFIG_USB_MUSB_HOST is not set
+# CONFIG_USB_MUSB_PERIPHERAL is not set
+CONFIG_USB_MUSB_OTG=3Dy
+CONFIG_USB_GADGET_MUSB_HDRC=3Dy
+CONFIG_USB_MUSB_HDRC_HCD=3Dy
+# CONFIG_USB_INVENTRA_FIFO is not set
+# CONFIG_USB_INVENTRA_DMA is not set
+# CONFIG_USB_TI_CPPI_DMA is not set
+CONFIG_USB_TUSB_OMAP_DMA=3Dy
+CONFIG_USB_INVENTRA_HCD_LOGGING=3D1
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=3Dy
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+CONFIG_USB_LIBUSUAL=3Dy
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=3Dy
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+CONFIG_USB_RTL8150=3Dy
+# CONFIG_USB_USBNET_MII is not set
+CONFIG_USB_USBNET=3Dy
+CONFIG_USB_NET_CDCETHER=3Dy
+# CONFIG_USB_NET_GL620A is not set
+CONFIG_USB_NET_NET1080=3Dy
+CONFIG_USB_NET_PLUSB=3Dy
+# CONFIG_USB_NET_MCS7830 is not set
+CONFIG_USB_NET_RNDIS_HOST=3Dy
+CONFIG_USB_NET_CDC_SUBSET=3Dy
+# CONFIG_USB_ALI_M5632 is not set
+# CONFIG_USB_AN2720 is not set
+CONFIG_USB_BELKIN=3Dy
+CONFIG_USB_ARMLINUX=3Dy
+# CONFIG_USB_EPSON2888 is not set
+CONFIG_USB_NET_ZAURUS=3Dy
+CONFIG_USB_MON=3Dy
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_TEST is not set
+
+#
+# USB DSL modem support
+#
+
+#
+# USB Gadget Support
+#
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_GADGET_DEBUG_FILES=3Dy
+CONFIG_USB_GADGET_SELECTED=3Dy
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=3Dy
+# CONFIG_USB_ZERO is not set
+CONFIG_USB_ETH=3Dy
+CONFIG_USB_ETH_RNDIS=3Dy
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# Real Time Clock
+#
+CONFIG_RTC_LIB=3Dy
+# CONFIG_RTC_CLASS is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+# CONFIG_OMAP_TSC2101 is not set
+
+#
+# CBUS support
+#
+CONFIG_CBUS=3Dy
+CONFIG_CBUS_TAHVO=3Dy
+CONFIG_CBUS_TAHVO_USER=3Dy
+# CONFIG_CBUS_TAHVO_USB is not set
+CONFIG_CBUS_RETU=3Dy
+CONFIG_CBUS_RETU_USER=3Dy
+CONFIG_CBUS_RETU_POWERBUTTON=3Dy
+CONFIG_CBUS_RETU_RTC=3Dy
+CONFIG_CBUS_RETU_WDT=3Dy
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=3Dm
+CONFIG_EXT2_FS_XATTR=3Dy
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=3Dm
+CONFIG_EXT3_FS_XATTR=3Dy
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=3Dm
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=3Dm
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=3Dy
+CONFIG_INOTIFY_USER=3Dy
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=3Dy
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=3Dy
+CONFIG_MSDOS_FS=3Dy
+CONFIG_VFAT_FS=3Dy
+CONFIG_FAT_DEFAULT_CODEPAGE=3D437
+CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=3Dy
+CONFIG_PROC_SYSCTL=3Dy
+CONFIG_SYSFS=3Dy
+CONFIG_TMPFS=3Dy
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=3Dy
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=3Dy
+CONFIG_JFFS2_FS_DEBUG=3D0
+CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
+CONFIG_JFFS2_SUMMARY=3Dy
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
+CONFIG_JFFS2_ZLIB=3Dy
+CONFIG_JFFS2_RTIME=3Dy
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=3Dy
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=3Dy
+
+#
+# Native Language Support
+#
+CONFIG_NLS=3Dy
+CONFIG_NLS_DEFAULT=3D"iso8859-1"
+CONFIG_NLS_CODEPAGE_437=3Dy
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=3Dy
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+CONFIG_NLS_ISO8859_15=3Dy
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=3Dy
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+CONFIG_PRINTK_TIME=3Dy
+CONFIG_ENABLE_MUST_CHECK=3Dy
+CONFIG_MAGIC_SYSRQ=3Dy
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=3Dy
+CONFIG_LOG_BUF_SHIFT=3D14
+CONFIG_DETECT_SOFTLOCKUP=3Dy
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=3Dy
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+CONFIG_FRAME_POINTER=3Dy
+CONFIG_FORCED_INLINING=3Dy
+# CONFIG_RCU_TORTURE_TEST is not set
+CONFIG_DEBUG_USER=3Dy
+CONFIG_DEBUG_ERRORS=3Dy
+# CONFIG_DEBUG_LL is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+CONFIG_SECURITY=3Dy
+# CONFIG_SECURITY_NETWORK is not set
+# CONFIG_SECURITY_CAPABILITIES is not set
+# CONFIG_SECURITY_ROOTPLUG is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=3Dy
+CONFIG_CRC_CCITT=3Dy
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=3Dy
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=3Dy
+CONFIG_ZLIB_DEFLATE=3Dy
+CONFIG_PLIST=3Dy
+CONFIG_IOMAP_COPY=3Dy


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--c3bfwLpm8qysLVxt--
