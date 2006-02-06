From: Paul Mundt <paul.mundt@nokia.com>
Subject: ARM: OMAP: STI/XTI support.
Date: Mon, 6 Feb 2006 21:46:58 +0200
Message-ID: <20060206194658.GA20394@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

This implements a simple subsystem for the OMAP serial tracing interface,
as found in omap16xx and omap24xx.

There's a few things implemented in this patch:

	- STI console support
	- STI netlink support
	- STI RX FIFO support

In addition to this, we also provide a general tracing framework that can
be used by both the kernel and userspace (and imask control for allowing
DSP-side STI manipulation).

Since the IRQ is multiplexed, drivers register for the bits they're
interested in (the RX FIFO is an example of this).

The netlink interface exists for streaming data bi-directionally. This is
currently done using NETLINK_USERSOCK, which ends up being somewhat
limiting.

All of these things have been tested on both OMAP1 and OMAP2, and it
takes in to account some of the protocol differences.

---


If someone wishes the patch split for review, I'll resubmit it as a small
patch series. Applies to current git.

 arch/arm/mach-omap1/devices.c        |   40 +++
 arch/arm/mach-omap2/clock.h          |   11=20
 arch/arm/mach-omap2/devices.c        |   42 +++
 arch/arm/plat-omap/Kconfig           |   11=20
 arch/arm/plat-omap/Makefile          |    3=20
 arch/arm/plat-omap/sti/Makefile      |    4=20
 arch/arm/plat-omap/sti/sti-console.c |  174 ++++++++++++++
 arch/arm/plat-omap/sti/sti-fifo.c    |  117 +++++++++
 arch/arm/plat-omap/sti/sti-netlink.c |  157 ++++++++++++
 arch/arm/plat-omap/sti/sti.c         |  425 ++++++++++++++++++++++++++++=
+++++++
 include/asm-arm/arch-omap/sti.h      |  159 +++++++++++++
 11 files changed, 1143 insertions(+)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.=
c
index ecbc475..876c38d 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -99,6 +99,45 @@ static void omap_init_rtc(void)
 static inline void omap_init_rtc(void) {}
 #endif
=20
+#if defined(CONFIG_OMAP_STI)
+
+#define OMAP1_STI_BASE		IO_ADDRESS(0xfffea000)
+#define OMAP1_STI_CHANNEL_BASE	(OMAP1_STI_BASE + 0x400)
+
+static struct resource sti_resources[] =3D {
+	{
+		.start		=3D OMAP1_STI_BASE,
+		.end		=3D OMAP1_STI_BASE + SZ_1K - 1,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D OMAP1_STI_CHANNEL_BASE,
+		.end		=3D OMAP1_STI_CHANNEL_BASE + SZ_1K - 1,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D INT_1610_STI,
+		.flags		=3D IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device sti_device =3D {
+	.name		=3D "sti",
+	.id		=3D -1,
+	.dev =3D {
+		.release	=3D omap_nop_release,
+	},
+	.num_resources	=3D ARRAY_SIZE(sti_resources),
+	.resource	=3D sti_resources,
+};
+
+static inline void omap_init_sti(void)
+{
+	platform_device_register(&sti_device);
+}
+#else
+static inline void omap_init_sti(void) {}
+#endif
=20
 /*----------------------------------------------------------------------=
---*/
=20
@@ -129,6 +168,7 @@ static int __init omap1_init_devices(voi
 	 */
 	omap_init_irda();
 	omap_init_rtc();
+	omap_init_sti();
=20
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d33e2ba..7a7ae6b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -717,6 +717,16 @@ static struct clk sys_clkout2 =3D {
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
+static struct clk emul_ck =3D {
+	.name		=3D "emul_ck",
+	.parent		=3D &func_54m_ck,
+	.flags		=3D CLOCK_IN_OMAP242X,
+	.enable_reg	=3D (void __iomem *)&PRCM_CLKEMUL_CTRL,
+	.enable_bit	=3D 0,
+	.recalc		=3D &omap2_propagate_rate,
+
+};
+
 /*
  * MPU clock domain
  *	Clocks:
@@ -1957,6 +1967,7 @@ static struct clk *onchip_clks[] =3D {
 	&wdt1_osc_ck,
 	&sys_clkout,
 	&sys_clkout2,
+	&emul_ck,
 	/* mpu domain clocks */
 	&mpu_ck,
 	/* dsp domain clocks */
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.=
c
index 7181edb..def9e53 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -74,6 +74,47 @@ static void omap_init_i2c(void) {}
=20
 #endif
=20
+#if defined(CONFIG_OMAP_STI)
+
+#define OMAP2_STI_BASE		IO_ADDRESS(0x48068000)
+#define OMAP2_STI_CHANNEL_BASE	0x54000000
+#define OMAP2_STI_IRQ		4
+
+static struct resource sti_resources[] =3D {
+	{
+		.start		=3D OMAP2_STI_BASE,
+		.end		=3D OMAP2_STI_BASE + 0x7ff,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D OMAP2_STI_CHANNEL_BASE,
+		.end		=3D OMAP2_STI_CHANNEL_BASE + SZ_64K - 1,
+		.flags		=3D IORESOURCE_MEM,
+	},
+	{
+		.start		=3D OMAP2_STI_IRQ,
+		.flags		=3D IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device sti_device =3D {
+	.name		=3D "sti",
+	.id		=3D -1,
+	.dev =3D {
+		.release	=3D omap_nop_release,
+	},
+	.num_resources	=3D ARRAY_SIZE(sti_resources),
+	.resource	=3D sti_resources,
+};
+
+static inline void omap_init_sti(void)
+{
+	platform_device_register(&sti_device);
+}
+#else
+static inline void omap_init_sti(void) {}
+#endif
+
 /*----------------------------------------------------------------------=
---*/
=20
 static int __init omap2_init_devices(void)
@@ -82,6 +123,7 @@ static int __init omap2_init_devices(voi
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_init_i2c();
+	omap_init_sti();
=20
 	return 0;
 }
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ad2bd3e..c42fdbf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -83,6 +83,17 @@ config OMAP_MUX_WARNINGS
 	  to change the pin multiplexing setup.  When there are no warnings
 	  printed, it's safe to deselect OMAP_MUX for your product.
=20
+config OMAP_STI
+	bool "STI/XTI support"
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	default n
+
+config OMAP_STI_CONSOLE
+	bool "STI console support"
+	depends on OMAP_STI
+	help
+	  This enables a console driver by way of STI/XTI.
+
 choice
         prompt "System timer"
 	default OMAP_MPU_TIMER
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 01ceab4..c6ab756 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,6 +13,9 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+=3D timer32k
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
=20
+# STI support
+obj-$(CONFIG_OMAP_STI) +=3D sti/
+
 obj-$(CONFIG_CPU_FREQ) +=3D cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) +=3D dmtimer.o
 obj-$(CONFIG_OMAP_BOOT_REASON) +=3D bootreason.o
diff --git a/arch/arm/plat-omap/sti/Makefile b/arch/arm/plat-omap/sti/Mak=
efile
new file mode 100644
index 0000000..6ad9bb3
--- /dev/null
+++ b/arch/arm/plat-omap/sti/Makefile
@@ -0,0 +1,4 @@
+obj-y +=3D sti.o sti-fifo.o
+
+obj-$(CONFIG_OMAP_STI_CONSOLE)	+=3D sti-console.o
+obj-$(CONFIG_NET)		+=3D sti-netlink.o
diff --git a/arch/arm/plat-omap/sti/sti-console.c b/arch/arm/plat-omap/st=
i/sti-console.c
new file mode 100644
index 0000000..46f878c
--- /dev/null
+++ b/arch/arm/plat-omap/sti/sti-console.c
@@ -0,0 +1,174 @@
+/*
+ * Console support for OMAP STI/XTI
+ *
+ * Copyright (C) 2004, 2005, 2006 Nokia Corporation
+ * Written by: Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file "COPYING" in the main directory of this archiv=
e
+ * for more details.
+ */
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <asm/arch/sti.h>
+
+#define DRV_NAME "sticon"
+
+static struct tty_driver *tty_driver;
+static DEFINE_SPINLOCK(sti_console_lock);
+static unsigned int sti_console_channel =3D 32;
+static int sti_line_done =3D -1;
+
+/*
+ * Write a string to any channel (including terminating NULL)
+ * Returns number of characters written.
+ */
+static int sti_channel_puts(const char *string, unsigned int channel, in=
t len)
+{
+	int count =3D 0;
+
+	/*
+	 * sti_line_done is needed to determine when we have reached the
+	 * end of the line. write() has a tendency to hand us small
+	 * strings which otherwise end up creating newlines.. we need to
+	 * keep the channel open and in append mode until the line has
+	 * been terminated.
+	 */
+	if (sti_line_done !=3D 0) {
+#ifdef __LITTLE_ENDIAN
+		sti_channel_writeb(0xc3, channel);
+#else
+		sti_channel_writeb(0xc0, channel);
+#endif
+		xchg(&sti_line_done, 0);
+	}
+
+	while (*string && count !=3D len) {
+		char c =3D *string++;
+
+		count++;
+
+		if (c =3D=3D '\n') {
+			xchg(&sti_line_done, 1);
+			sti_channel_writeb(0, channel);
+			break;
+		} else
+			sti_channel_writeb(c, channel);
+	}
+
+	if (sti_line_done)
+		sti_channel_flush(channel);
+
+	return count;
+}
+
+static int sti_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	return 0;
+}
+
+static int sti_tty_write(struct tty_struct *tty,
+			 const unsigned char *buf, int len)
+{
+	unsigned long flags;
+	int bytes;
+
+	spin_lock_irqsave(&sti_console_lock, flags);
+	bytes =3D sti_channel_puts(buf, sti_console_channel, len);
+	spin_unlock_irqrestore(&sti_console_lock, flags);
+
+	return bytes;
+}
+
+static int sti_tty_write_room(struct tty_struct *tty)
+{
+	return 0x100000;
+}
+
+static int sti_tty_chars_in_buffer(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static struct tty_operations sti_tty_ops =3D {
+	.open			=3D sti_tty_open,
+	.write			=3D sti_tty_write,
+	.write_room		=3D sti_tty_write_room,
+	.chars_in_buffer	=3D sti_tty_chars_in_buffer,
+};
+
+static void sti_console_write(struct console *c, const char *s, unsigned=
 n)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sti_console_lock, flags);
+	sti_channel_puts(s, sti_console_channel, n);
+	spin_unlock_irqrestore(&sti_console_lock, flags);
+}
+
+static struct tty_driver *sti_console_device(struct console *c, int *ind=
ex)
+{
+	*index =3D c->index;
+	return tty_driver;
+}
+
+static int sti_console_setup(struct console *c, char *opts)
+{
+	return 0;
+}
+
+static struct console sti_console =3D {
+	.name		=3D DRV_NAME,
+	.write		=3D sti_console_write,
+	.device		=3D sti_console_device,
+	.setup		=3D sti_console_setup,
+	.flags		=3D CON_PRINTBUFFER | CON_ENABLED,
+	.index		=3D -1,
+};
+
+static int __init sti_console_init(void)
+{
+	register_console(&sti_console);
+	return 0;
+}
+__initcall(sti_console_init);
+
+static int __init sti_tty_init(void)
+{
+	struct tty_driver *tty;
+	int ret;
+
+	tty =3D alloc_tty_driver(1);
+	if (!tty)
+		return -ENOMEM;
+
+	tty->name		=3D DRV_NAME;
+	tty->driver_name	=3D DRV_NAME;
+	tty->major		=3D 0;	/* dynamic major */
+	tty->minor_start	=3D 0;
+	tty->type		=3D TTY_DRIVER_TYPE_SYSTEM;
+	tty->subtype		=3D SYSTEM_TYPE_SYSCONS;
+	tty->init_termios	=3D tty_std_termios;
+
+	tty_set_operations(tty, &sti_tty_ops);
+
+	ret =3D tty_register_driver(tty);
+	if (ret) {
+		put_tty_driver(tty);
+		return ret;
+	}
+
+	tty_driver =3D tty;
+	return 0;
+}
+late_initcall(sti_tty_init);
+
+module_param(sti_console_channel, uint, 0);
+MODULE_PARM_DESC(sti_console_channel, "STI console channel (default 32)"=
);
+MODULE_AUTHOR("Paul Mundt");
+MODULE_DESCRIPTION("OMAP STI console support");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-omap/sti/sti-fifo.c b/arch/arm/plat-omap/sti/s=
ti-fifo.c
new file mode 100644
index 0000000..1824417
--- /dev/null
+++ b/arch/arm/plat-omap/sti/sti-fifo.c
@@ -0,0 +1,117 @@
+/*
+ * STI RX FIFO Support
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ * Written by:  Paul Mundt <paul.mundt@nokia.com> and
+ *		Roman Tereshonkov <roman.tereshonkov@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file "COPYING" in the main directory of this archiv=
e
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <asm/arch/sti.h>
+
+#define STI_READ_BUFFER_SIZE	1024
+#define sti_buf_pos(pos)	((sti_crb->bufpos + (pos)) % \
+				 STI_READ_BUFFER_SIZE)
+
+static struct sti_cycle_buffer {
+	int bufpos;
+	int datalen;
+	unsigned char *buf;
+} *sti_crb;
+
+/**
+ * sti_read_packet - STI read packet (read an entire STI packet)
+ * @buf: Buffer to store the packet.
+ * @maxsize: Maximum size requested.
+ *
+ * This reads in a single completed STI packet from the RX FIFOs and
+ * places it in @buf for further processing.
+ *
+ * The return value is < 0 on error, and >=3D 0 for the number of bytes
+ * actually read. As per the STI specification, we require a 0xC1 to
+ * indicate the end of the packet, and we don't return the packet until
+ * we've read the entire thing in.
+ *
+ * Due to the size of the FIFOs, it's unrealistic to constantly drain
+ * this for 1 or 2 bytes at a time, so we assemble it here and return
+ * the whole thing.
+ */
+int sti_read_packet(unsigned char *buf, int maxsize)
+{
+	unsigned int pos;
+
+	if (unlikely(!buf))
+		return -EINVAL;
+	if (!sti_crb->datalen)
+		return 0;
+
+	pos =3D sti_buf_pos(sti_crb->datalen - 1);
+	/* End of packet */
+	if (sti_crb->buf[pos] =3D=3D 0xC1) {
+		int i;
+
+		for (i =3D 0; i < sti_crb->datalen && i < maxsize; i++) {
+			pos =3D sti_buf_pos(i);
+			buf[i] =3D sti_crb->buf[pos];
+		}
+
+		sti_crb->bufpos =3D sti_buf_pos(i);
+		sti_crb->datalen -=3D i;
+
+		return i;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sti_read_packet);
+
+static void sti_fifo_irq(unsigned long arg)
+{
+	/* If there is data read it */
+	while (!(sti_readl(STI_RX_STATUS) & STI_RXFIFO_EMPTY)) {
+		unsigned int pos =3D sti_buf_pos(sti_crb->datalen);
+
+		sti_crb->buf[pos] =3D sti_readl(STI_DR);
+		sti_crb->datalen++;
+	}
+
+	sti_ack_irq(STI_RX_INT);
+}
+
+static int __init sti_fifo_init(void)
+{
+	unsigned int size;
+	int ret;
+
+	size =3D sizeof(struct sti_cycle_buffer) + STI_READ_BUFFER_SIZE;
+	sti_crb =3D kmalloc(size, GFP_KERNEL);
+	if (!sti_crb)
+		return -ENOMEM;
+
+	sti_crb->bufpos =3D sti_crb->datalen =3D 0;
+	sti_crb->buf =3D (unsigned char *)(sti_crb + sizeof(*sti_crb));
+
+	ret =3D sti_request_irq(STI_RX_INT, sti_fifo_irq, 0);
+	if (ret !=3D 0)
+		kfree(sti_crb);
+
+	return ret;
+}
+
+static void __exit sti_fifo_exit(void)
+{
+	sti_free_irq(STI_RX_INT);
+	kfree(sti_crb);
+}
+
+module_init(sti_fifo_init);
+module_exit(sti_fifo_exit);
+
+MODULE_AUTHOR("Paul Mundt, Roman Tereshonkov");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-omap/sti/sti-netlink.c b/arch/arm/plat-omap/st=
i/sti-netlink.c
new file mode 100644
index 0000000..45b8085
--- /dev/null
+++ b/arch/arm/plat-omap/sti/sti-netlink.c
@@ -0,0 +1,157 @@
+/*
+ * OMAP STI/XTI communications interface via netlink socket.
+ *
+ * Copyright (C) 2004, 2005 Nokia Corporation
+ * Written by: Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file "COPYING" in the main directory of this archiv=
e
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/netlink.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <asm/arch/sti.h>
+
+static struct sock *sti_sock;
+static DECLARE_MUTEX(sti_netlink_sem);
+
+enum {
+	STI_READ,
+	STI_WRITE,
+};
+
+static int sti_netlink_read(int pid, int seq, void *payload, int size)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	int ret, len =3D NLMSG_SPACE(size);
+	unsigned char *tail;
+
+	skb =3D alloc_skb(len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	tail =3D skb->tail;
+	nlh =3D NLMSG_PUT(skb, pid, seq, STI_READ,
+			len - (sizeof(struct nlmsghdr)));
+	nlh->nlmsg_flags =3D 0;
+	memcpy(NLMSG_DATA(nlh), payload, size);
+	nlh->nlmsg_len =3D skb->tail - tail;
+
+	ret =3D netlink_unicast(sti_sock, skb, pid, MSG_DONTWAIT);
+	if (ret > 0)
+		ret =3D 0;
+
+	return ret;
+
+nlmsg_failure:
+	if (skb)
+		kfree_skb(skb);
+
+	return -EINVAL;
+}
+
+/*
+ * We abuse nlmsg_type and nlmsg_flags for our purposes.
+ *
+ * The ID is encoded into the upper 8 bits of the nlmsg_type, while the
+ * channel number is encoded into the upper 8 bits of the nlmsg_flags.
+ */
+static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghdr =
*nlh)
+{
+	void *data;
+	u8 chan, id;
+	int size, ret =3D 0, len =3D 0;
+
+	data	=3D NLMSG_DATA(nlh);
+	chan	=3D (nlh->nlmsg_flags >> 8) & 0xff;
+	id	=3D (nlh->nlmsg_type  >> 8) & 0xff;
+	size	=3D (int)(nlh->nlmsg_len - ((char *)data - (char *)nlh));
+
+	switch (nlh->nlmsg_type & 0xff) {
+	case STI_WRITE:
+		sti_channel_write_trace(size, id, data, chan);
+		break;
+	case STI_READ:
+		data =3D kmalloc(size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+		memset(data, 0, size);
+
+		len =3D sti_read_packet(data, size);
+		ret =3D sti_netlink_read(NETLINK_CB(skb).pid, nlh->nlmsg_seq,
+				       data, len);
+		kfree(data);
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return ret;
+}
+
+static int sti_netlink_receive_skb(struct sk_buff *skb)
+{
+	while (skb->len >=3D NLMSG_SPACE(0)) {
+		struct nlmsghdr *nlh;
+		u32 rlen;
+		int ret;
+
+		nlh =3D (struct nlmsghdr *)skb->data;
+		if (nlh->nlmsg_len < sizeof(struct nlmsghdr) ||
+		    skb->len < nlh->nlmsg_len)
+			break;
+
+		rlen =3D NLMSG_ALIGN(nlh->nlmsg_len);
+		if (rlen > skb->len)
+			rlen =3D skb->len;
+
+		ret =3D sti_netlink_receive_msg(skb, nlh);
+		if (ret)
+			netlink_ack(skb, nlh, -ret);
+		else if (nlh->nlmsg_flags & NLM_F_ACK)
+			netlink_ack(skb, nlh, 0);
+
+		skb_pull(skb, rlen);
+	}
+
+	return 0;
+}
+
+static void sti_netlink_receive(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	if (down_trylock(&sti_netlink_sem))
+		return;
+
+	while ((skb =3D skb_dequeue(&sk->sk_receive_queue)))
+		if (sti_netlink_receive_skb(skb) && skb->len)
+			skb_queue_head(&sk->sk_receive_queue, skb);
+		else
+			kfree_skb(skb);
+
+	up(&sti_netlink_sem);
+}
+
+static int __init sti_netlink_init(void)
+{
+	sti_sock =3D netlink_kernel_create(NETLINK_USERSOCK, 0,
+					 sti_netlink_receive, THIS_MODULE);
+	if (!sti_sock) {
+		printk(KERN_ERR "STI: Failed to create netlink socket\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(sti_netlink_init);
+
+MODULE_AUTHOR("Paul Mundt");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("STI netlink-driven communications interface");
diff --git a/arch/arm/plat-omap/sti/sti.c b/arch/arm/plat-omap/sti/sti.c
new file mode 100644
index 0000000..5226e95
--- /dev/null
+++ b/arch/arm/plat-omap/sti/sti.c
@@ -0,0 +1,425 @@
+/*
+ * Support functions for OMAP STI/XTI (Serial Tracing Interface)
+ *
+ * Copyright (C) 2004, 2005, 2006 Nokia Corporation
+ * Written by: Paul Mundt <paul.mundt@nokia.com>
+ *
+ * STI initialization code and channel handling
+ * from Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>.
+ *
+ * XTI initialization
+ * from Roman Tereshonkov <roman.tereshonkov@nokia.com>.
+ *
+ * This file is subject to the terms and conditions of the GNU General P=
ublic
+ * License.  See the file "COPYING" in the main directory of this archiv=
e
+ * for more details.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <asm/arch/sti.h>
+#include <asm/byteorder.h>
+
+static struct clk *sti_ck;
+unsigned long sti_base, sti_channel_base;
+static unsigned long sti_kern_mask =3D STIEn;
+static unsigned long sti_irq_mask =3D STI_IRQSTATUS_MASK;
+static DEFINE_SPINLOCK(sti_lock);
+
+static struct sti_irqdesc {
+	irqreturn_t (*func)(unsigned long);
+	unsigned long data;
+} ____cacheline_aligned sti_irq_desc[STI_NR_IRQS];
+
+void sti_channel_write_trace(int len, int id, void *data, unsigned int c=
hannel)
+{
+	const u8 *tpntr =3D data;
+
+	sti_channel_writeb(id, channel);
+
+	if (cpu_is_omap16xx())
+		/* Check u32 boundary */
+		if (!((u32)data & (STI_PERCHANNEL_SIZE - 1)) &&
+		     (len >=3D STI_PERCHANNEL_SIZE)) {
+			const u32 *asrc =3D data;
+
+			do {
+				sti_channel_writel(cpu_to_be32(*asrc++),
+						   channel);
+				len -=3D STI_PERCHANNEL_SIZE;
+			} while (len >=3D STI_PERCHANNEL_SIZE);
+
+			tpntr =3D (const u8 *)asrc;
+		}
+
+	while (len--)
+		sti_channel_writeb(*tpntr++, channel);
+
+	sti_channel_flush(channel);
+}
+EXPORT_SYMBOL(sti_channel_write_trace);
+
+void sti_enable_irq(unsigned int id)
+{
+	spin_lock_irq(&sti_lock);
+	sti_writel(1 << id, STI_IRQSETEN);
+	spin_unlock_irq(&sti_lock);
+}
+EXPORT_SYMBOL(sti_enable_irq);
+
+void sti_disable_irq(unsigned int id)
+{
+	spin_lock_irq(&sti_lock);
+
+	if (cpu_is_omap16xx())
+		sti_writel(1 << id, STI_IRQCLREN);
+	else if (cpu_is_omap24xx())
+		sti_writel(sti_readl(STI_IRQSETEN) & ~(1 << id), STI_IRQSETEN);
+	else
+		BUG();
+
+	spin_unlock_irq(&sti_lock);
+}
+EXPORT_SYMBOL(sti_disable_irq);
+
+void sti_ack_irq(unsigned int id)
+{
+	/* Even though the clear state is 0, we have to write 1 to clear */
+	sti_writel(1 << id, STI_IRQSTATUS);
+}
+EXPORT_SYMBOL(sti_ack_irq);
+
+int sti_request_irq(unsigned int irq, void *handler, unsigned long arg)
+{
+	struct sti_irqdesc *desc;
+
+	if (unlikely(!handler || irq > STI_NR_IRQS))
+		return -EINVAL;
+
+	desc =3D sti_irq_desc + irq;
+	if (unlikely(desc->func)) {
+		printk(KERN_WARNING "STI: Attempting to request in-use IRQ "
+				    "%d, consider fixing your code..\n", irq);
+		return -EBUSY;
+	}
+
+	desc->func =3D handler;
+	desc->data =3D arg;
+
+	sti_enable_irq(irq);
+	return 0;
+}
+EXPORT_SYMBOL(sti_request_irq);
+
+void sti_free_irq(unsigned int irq)
+{
+	struct sti_irqdesc *desc =3D sti_irq_desc + irq;
+
+	if (unlikely(irq > STI_NR_IRQS))
+		return;
+
+	sti_disable_irq(irq);
+
+	desc->func =3D NULL;
+	desc->data =3D 0;
+}
+EXPORT_SYMBOL(sti_free_irq);
+
+/*
+ * This is a bit heavy, so normally we would defer this to a tasklet.
+ * Unfortunately tasklets are too slow for the RX FIFO interrupt (and
+ * possibly some others), so we just do the irqdesc walking here.
+ */
+static irqreturn_t sti_interrupt(int irq, void *dev_id, struct pt_regs *=
regs)
+{
+	int ret =3D IRQ_NONE;
+	u16 status;
+	int i;
+
+	status =3D sti_readl(STI_IRQSTATUS) & sti_irq_mask;
+
+	for (i =3D 0; status; i++) {
+		struct sti_irqdesc *desc =3D sti_irq_desc + i;
+		u16 id =3D 1 << i;
+
+		if (!(status & id))
+			continue;
+
+		if (likely(desc && desc->func))
+			ret |=3D desc->func(desc->data);
+		if (unlikely(ret =3D=3D IRQ_NONE)) {
+			printk("STI: spurious interrupt (id %d)\n", id);
+			sti_disable_irq(i);
+			sti_ack_irq(i);
+			ret =3D IRQ_HANDLED;
+		}
+
+		status &=3D ~id;
+	}
+
+	return IRQ_RETVAL(ret);
+}
+
+static void omap_sti_reset(void)
+{
+	int i;
+
+	/* Reset STI module */
+	sti_writel(0x02, STI_SYSCONFIG);
+
+	/* Wait a while for the STI module to complete its reset */
+	for (i =3D 0; i < 10000; i++)
+		if (sti_readl(STI_SYSSTATUS) & 1)
+			break;
+}
+
+static int __init sti_init(void)
+{
+	char buf[64];
+	int i;
+
+	if (cpu_is_omap16xx()) {
+		/* Release ARM Rhea buses peripherals enable */
+		sti_writel(sti_readl(ARM_RSTCT2) | 0x0001, ARM_RSTCT2);
+
+		/* Enable TC1_CK (functional clock) */
+		sti_ck =3D clk_get(NULL, "tc1_ck");
+	} else if (cpu_is_omap24xx())
+		/* Enable emulation tools clock */
+		sti_ck =3D clk_get(NULL, "emul_ck");
+
+	if (IS_ERR(sti_ck))
+		return PTR_ERR(sti_ck);
+
+	clk_enable(sti_ck);
+
+	/* Reset STI module */
+	omap_sti_reset();
+
+	/* Enable STI */
+	sti_trace_enable(MPUCmdEn);
+
+	/* Change to custom serial protocol */
+	sti_writel(0x01, STI_SERIAL_CFG);
+
+	/* Set STI clock control register to normal mode */
+	sti_writel(0x00, STI_CLK_CTRL);
+
+	i =3D sti_readl(STI_REVISION);
+	snprintf(buf, sizeof(buf), "OMAP STI support loaded (HW v%u.%u)\n",
+	        (i >> 4) & 0x0f, i & 0x0f);
+	printk(KERN_INFO "%s", buf);
+
+	sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
+
+	return 0;
+}
+
+static void sti_exit(void)
+{
+	u32 tmp;
+
+	/*
+	 * This should have already been done by reset, but we switch off
+	 * STI entirely just for added sanity..
+	 */
+	tmp =3D sti_readl(STI_ER);
+	tmp &=3D ~STIEn;
+	sti_writel(tmp, STI_ER);
+
+	clk_disable(sti_ck);
+	clk_put(sti_ck);
+}
+
+static void __sti_trace_enable(int event)
+{
+	u32 tmp;
+
+	tmp =3D sti_readl(STI_ER);
+	tmp |=3D sti_kern_mask | event;
+	sti_writel(tmp, STI_ER);
+}
+
+int sti_trace_enable(int event)
+{
+	spin_lock_irq(&sti_lock);
+	sti_kern_mask |=3D event;
+	__sti_trace_enable(event);
+	spin_unlock_irq(&sti_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(sti_trace_enable);
+
+static void __sti_trace_disable(int event)
+{
+	u32 tmp;
+
+	tmp =3D sti_readl(STI_DR);
+	tmp |=3D event;
+	tmp &=3D ~sti_kern_mask;
+	sti_writel(tmp, STI_DR);
+}
+
+void sti_trace_disable(int event)
+{
+	spin_lock_irq(&sti_lock);
+	sti_kern_mask &=3D ~event;
+	__sti_trace_disable(event);
+	spin_unlock_irq(&sti_lock);
+}
+EXPORT_SYMBOL(sti_trace_disable);
+
+static ssize_t
+sti_trace_show(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	return sprintf(buf, "0x%08lx\n", sti_readl(STI_ER));
+}
+
+static ssize_t
+sti_trace_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int evt =3D simple_strtoul(buf, NULL, 0);
+	int mask =3D ~evt;
+
+	spin_lock_irq(&sti_lock);
+	__sti_trace_disable(mask);
+	__sti_trace_enable(evt);
+	spin_unlock_irq(&sti_lock);
+
+	return count;
+}
+static DEVICE_ATTR(trace, S_IRUGO | S_IWUSR, sti_trace_show, sti_trace_s=
tore);
+
+static ssize_t
+sti_imask_show(struct device *dev, struct device_attribute *attr, char *=
buf)
+{
+	return sprintf(buf, "0x%04lx\n", sti_irq_mask);
+}
+
+static ssize_t
+sti_imask_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	spin_lock_irq(&sti_lock);
+	sti_irq_mask =3D simple_strtoul(buf, NULL, 0);
+	spin_unlock_irq(&sti_lock);
+
+	return count;
+}
+static DEVICE_ATTR(imask, S_IRUGO | S_IWUSR, sti_imask_show, sti_imask_s=
tore);
+
+static int __devinit sti_probe(struct platform_device *pdev)
+{
+	struct resource *res, *cres;
+	int ret;
+
+	if (pdev->num_resources !=3D 3) {
+		dev_err(&pdev->dev, "invalid number of resources: %d\n",
+			pdev->num_resources);
+		return -ENODEV;
+	}
+
+	/* STI base */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		dev_err(&pdev->dev, "invalid mem resource\n");
+		return -ENODEV;
+	}
+
+	/* Channel base */
+	cres =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (unlikely(!cres)) {
+		dev_err(&pdev->dev, "invalid channel mem resource\n");
+		return -ENODEV;
+	}
+
+	ret =3D device_create_file(&pdev->dev, &dev_attr_trace);
+	if (unlikely(ret !=3D 0))
+		return ret;
+
+	ret =3D device_create_file(&pdev->dev, &dev_attr_imask);
+	if (unlikely(ret !=3D 0))
+		goto err;
+
+	sti_base =3D res->start;
+
+	/*
+	 * OMAP 16xx keeps channels in a relatively sane location,
+	 * whereas 24xx maps them much further out, and so they must be
+	 * remapped.
+	 */
+	if (cpu_is_omap16xx())
+		sti_channel_base =3D cres->start;
+	else if (cpu_is_omap24xx()) {
+		unsigned int size =3D cres->end - cres->start;
+
+		sti_channel_base =3D (unsigned long)ioremap(cres->start, size);
+		if (unlikely(!sti_channel_base)) {
+			ret =3D -ENODEV;
+			goto err_badremap;
+		}
+	}
+
+	ret =3D request_irq(platform_get_irq(pdev, 0), sti_interrupt,
+			  SA_INTERRUPT, "sti", NULL);
+	if (unlikely(ret !=3D 0))
+		goto err_badirq;
+
+	return sti_init();
+
+err_badirq:
+	iounmap((void *)sti_channel_base);
+err_badremap:
+	device_remove_file(&pdev->dev, &dev_attr_imask);
+err:
+	device_remove_file(&pdev->dev, &dev_attr_trace);
+
+	return ret;
+}
+
+static int __devexit sti_remove(struct platform_device *pdev)
+{
+	unsigned int irq =3D platform_get_irq(pdev, 0);
+
+	if (cpu_is_omap24xx())
+		iounmap((void *)sti_channel_base);
+
+	device_remove_file(&pdev->dev, &dev_attr_trace);
+	device_remove_file(&pdev->dev, &dev_attr_imask);
+	free_irq(irq, NULL);
+	sti_exit();
+
+	return 0;
+}
+
+static struct platform_driver sti_driver =3D {
+	.probe		=3D sti_probe,
+	.remove		=3D __devexit_p(sti_remove),
+	.driver		=3D {
+		.name	=3D "sti",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+static int __init sti_module_init(void)
+{
+	return platform_driver_register(&sti_driver);
+}
+
+static void __exit sti_module_exit(void)
+{
+	platform_driver_unregister(&sti_driver);
+}
+subsys_initcall(sti_module_init);
+module_exit(sti_module_exit);
+
+MODULE_AUTHOR("Paul Mundt, Juha Yrj=F6l=E4, Roman Tereshonkov");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-omap/sti.h b/include/asm-arm/arch-omap/=
sti.h
new file mode 100644
index 0000000..f42f6e5
--- /dev/null
+++ b/include/asm-arm/arch-omap/sti.h
@@ -0,0 +1,159 @@
+#ifndef __ASM_ARCH_OMAP_STI_H
+#define __ASM_ARCH_OMAP_STI_H
+
+#include <asm/io.h>
+
+/*
+ * STI/XTI
+ */
+#define STI_REVISION		0x00
+#define STI_SYSCONFIG		0x10
+#define STI_SYSSTATUS		0x14
+#define STI_IRQSTATUS		0x18
+#define STI_IRQSETEN		0x1c
+
+#if defined(CONFIG_ARCH_OMAP1)
+#define STI_IRQCLREN		0x20
+#define STI_ER			0x24
+#define STI_DR			0x28
+#define STI_RX_STATUS		0x30
+#define STI_CLK_CTRL		0x34
+#define STI_IOBOTT0		0x4c
+#define STI_IOTOP0		0x50
+#define STI_IOBOTT1		0x54
+#define STI_IOTOP1		0x58
+#define STI_SERIAL_CFG		0x60
+
+#define STI_OCPT2_MATCH_INT	0
+#define STI_OCPT1_MATCH_INT	1
+#define STI_EMIFS_MATCH_INT	2
+#define STI_EMIFF_MATCH_INT	3
+#define STI_IO_MATCH_INT	4
+#define STI_RX_INT		5
+#define STI_DUMP_REQUEST_INT	6
+#define STI_DUMP_UNDERRUN_INT	7
+#define STI_WAKEUP_INT		9
+
+#define STI_NR_IRQS	10
+
+#define STI_IRQSTATUS_MASK	0x2ff
+#define STI_PERCHANNEL_SIZE	4
+
+#define STI_RXFIFO_EMPTY	(1 << 0)
+
+/*
+ * We use the following enums to retain consistency with the STI "functi=
onal"
+ * specification.
+ */
+
+/* STI_ER */
+enum {
+	UnlockStatMatch	=3D (1 <<  2), /* Unlock status match event regs */
+	IOMPUStr1En1	=3D (1 <<  3), /* MPU IO match, strobe 1, window 1 */
+	IOMPUStr0En1	=3D (1 <<  4), /* MPU IO match, strobe 0, window 1 */
+	IOMPUStr1En0	=3D (1 <<  5), /* MPU IO match, strobe 1, window 0 */
+	IOMPUStr0En0	=3D (1 <<  6), /* MPU IO match, strobe 0, window 0 */
+	IODSPStr1En1	=3D (1 <<  7), /* DSP IO match, strobe 1, window 1 */
+	IODSPStr0En1	=3D (1 <<  8), /* DSP IO match, strobe 0, window 1 */
+	IODSPStr1En0	=3D (1 <<  9), /* DSP IO match, strobe 1, window 0 */
+	IODSPStr0En0	=3D (1 << 10), /* DSP IO match, strobe 0, window 0 */
+	MemMatchEn	=3D (1 << 11), /* Memory matched event */
+	DSPCmdEn	=3D (1 << 12), /* DSP command write */
+	MPUCmdEn	=3D (1 << 13), /* MPU command write */
+	MemDumpEn	=3D (1 << 14), /* System memory dump */
+	STIEn		=3D (1 << 15), /* Global trace enable */
+};
+#elif defined(CONFIG_ARCH_OMAP2)
+
+/* XTI interrupt bits */
+enum {
+	STI_WAKEUP_INT	=3D 0,
+	STI_ETB_THRESHOLD_INT,
+	STI_RX_INT,
+	STI_DUMP_REQUEST_INT,
+	STI_NR_IRQS,
+};
+
+/* XTI_TRACESELECT */
+enum {
+	CmdTimeStampEn	=3D (1 << 0),	/* Command write timestamps */
+	WinTimeStampEn	=3D (1 << 1),	/* Window match timestamps */
+	WinMatchEn	=3D (1 << 2),	/* Window match trace */
+	DSPCmdEn	=3D (1 << 3),	/* DSP command write */
+	MPUCmdEn	=3D (1 << 4),	/* MPU command write */
+	MemDumpEn0	=3D (1 << 5),	/* System memory dump */
+	MemDumpEn1	=3D (1 << 6),
+	MemDumpEn2	=3D (1 << 7),
+	ExtTriggerEn	=3D (1 << 8),	/* External trace trigger */
+	STIEn		=3D (1 << 9),	/* System trace enable */
+};
+
+#define STI_IRQSTATUS_MASK	0x0f
+#define STI_PERCHANNEL_SIZE	64
+
+/* XTI registers */
+#define XTI_SYSSTATUS		0x14
+#define XTI_TRACESELECT		0x24
+#define XTI_RXDATA		0x28
+#define XTI_SCLKCRTL		0x2c
+#define XTI_SCONFIG		0x30
+
+/* STI Compatability */
+#define STI_RX_STATUS		XTI_SYSSTATUS
+#define STI_IRQCLREN		STI_IRQSETEN
+#define STI_ER			XTI_TRACESELECT
+#define STI_DR			XTI_RXDATA
+#define STI_CLK_CTRL		XTI_SCLKCRTL
+#define STI_SERIAL_CFG		XTI_SCONFIG
+
+#define STI_RXFIFO_EMPTY	(1 << 8)
+
+#endif
+
+/* arch/arm/plat-omap/sti/sti.c */
+extern unsigned long sti_base, sti_channel_base;
+
+int sti_request_irq(unsigned int irq, void *handler, unsigned long arg);
+void sti_free_irq(unsigned int irq);
+void sti_enable_irq(unsigned int irq);
+void sti_disable_irq(unsigned int irq);
+void sti_ack_irq(unsigned int irq);
+
+int sti_trace_enable(int event);
+void sti_trace_disable(int event);
+
+void sti_channel_write_trace(int len, int id, void *data, unsigned int c=
hannel);
+
+/* arch/arm/plat-omap/sti/sti-fifo.c */
+int sti_read_packet(unsigned char *buf, int maxsize);
+
+static inline unsigned long sti_readl(unsigned long reg)
+{
+	return __raw_readl(sti_base + reg);
+}
+
+static inline void sti_writel(unsigned long data, unsigned long reg)
+{
+	__raw_writel(data, sti_base + reg);
+}
+
+#define to_channel_address(channel) \
+	(sti_channel_base + STI_PERCHANNEL_SIZE * (channel))
+
+static inline void sti_channel_writeb(unsigned char data, unsigned int c=
hannel)
+{
+	__raw_writeb(data, to_channel_address(channel));
+}
+
+static inline void sti_channel_writel(unsigned long data, unsigned int c=
hannel)
+{
+	__raw_writel(data, to_channel_address(channel));
+}
+
+#define STI_TRACE_CONTROL_CHANNEL	253
+
+static inline void sti_channel_flush(unsigned int channel)
+{
+	sti_channel_writeb(channel, STI_TRACE_CONTROL_CHANNEL);
+}
+#endif /* __ASM_ARCH_OMAP_STI_H */
