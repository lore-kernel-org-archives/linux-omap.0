From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] ARM: OMAP: Move STI support to drivers/misc
Date: Wed, 12 Mar 2008 12:45:50 +0200
Message-ID: <1205318750-9596-11-git-send-email-tony@atomide.com>
References: 34xx-2008-03-12
 <1205318750-9596-1-git-send-email-tony@atomide.com>
 <1205318750-9596-2-git-send-email-tony@atomide.com>
 <1205318750-9596-3-git-send-email-tony@atomide.com>
 <1205318750-9596-4-git-send-email-tony@atomide.com>
 <1205318750-9596-5-git-send-email-tony@atomide.com>
 <1205318750-9596-6-git-send-email-tony@atomide.com>
 <1205318750-9596-7-git-send-email-tony@atomide.com>
 <1205318750-9596-8-git-send-email-tony@atomide.com>
 <1205318750-9596-9-git-send-email-tony@atomide.com>
 <1205318750-9596-10-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49468 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYCLKqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:46:24 -0400
In-Reply-To: <1205318750-9596-10-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

This is to allow syncing plat-omap with mainline kernel.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Makefile          |    3 -
 arch/arm/plat-omap/sti/Makefile      |    4 -
 arch/arm/plat-omap/sti/sti-console.c |  189 ---------------
 arch/arm/plat-omap/sti/sti-fifo.c    |  117 ---------
 arch/arm/plat-omap/sti/sti-netlink.c |  152 ------------
 arch/arm/plat-omap/sti/sti.c         |  432 --------------------------=
--------
 drivers/misc/Makefile                |    1 +
 drivers/misc/sti/Makefile            |    4 +
 drivers/misc/sti/sti-console.c       |  189 +++++++++++++++
 drivers/misc/sti/sti-fifo.c          |  117 +++++++++
 drivers/misc/sti/sti-netlink.c       |  152 ++++++++++++
 drivers/misc/sti/sti.c               |  432 ++++++++++++++++++++++++++=
++++++++
 12 files changed, 895 insertions(+), 897 deletions(-)
 delete mode 100644 arch/arm/plat-omap/sti/Makefile
 delete mode 100644 arch/arm/plat-omap/sti/sti-console.c
 delete mode 100644 arch/arm/plat-omap/sti/sti-fifo.c
 delete mode 100644 arch/arm/plat-omap/sti/sti-netlink.c
 delete mode 100644 arch/arm/plat-omap/sti/sti.c
 create mode 100644 drivers/misc/sti/Makefile
 create mode 100644 drivers/misc/sti/sti-console.c
 create mode 100644 drivers/misc/sti/sti-fifo.c
 create mode 100644 drivers/misc/sti/sti-netlink.c
 create mode 100644 drivers/misc/sti/sti.c

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index c1ada8f..a3f1f5c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -14,9 +14,6 @@ obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
-# STI support
-obj-$(CONFIG_OMAP_STI) +=3D sti/
-
 obj-$(CONFIG_CPU_FREQ) +=3D cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) +=3D dmtimer.o
 obj-$(CONFIG_OMAP_BOOT_REASON) +=3D bootreason.o
diff --git a/arch/arm/plat-omap/sti/Makefile b/arch/arm/plat-omap/sti/M=
akefile
deleted file mode 100644
index 6ad9bb3..0000000
--- a/arch/arm/plat-omap/sti/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y +=3D sti.o sti-fifo.o
-
-obj-$(CONFIG_OMAP_STI_CONSOLE)	+=3D sti-console.o
-obj-$(CONFIG_NET)		+=3D sti-netlink.o
diff --git a/arch/arm/plat-omap/sti/sti-console.c b/arch/arm/plat-omap/=
sti/sti-console.c
deleted file mode 100644
index 451a139..0000000
--- a/arch/arm/plat-omap/sti/sti-console.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- * Console support for OMAP STI/XTI
- *
- * Copyright (C) 2004, 2005, 2006 Nokia Corporation
- * Written by: Paul Mundt <paul.mundt@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General=
 Public
- * License.  See the file "COPYING" in the main directory of this arch=
ive
- * for more details.
- */
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/tty.h>
-#include <linux/tty_driver.h>
-#include <asm/arch/sti.h>
-#include <asm/arch/board.h>
-
-#define DRV_NAME "sticon"
-
-static struct tty_driver *tty_driver;
-static DEFINE_SPINLOCK(sti_console_lock);
-static unsigned int sti_console_channel =3D -1;
-static int sti_line_done =3D -1;
-
-/*
- * Write a string to any channel (including terminating NULL)
- * Returns number of characters written.
- */
-static int sti_channel_puts(const char *string, unsigned int channel, =
int len)
-{
-	int count =3D 0;
-
-	/*
-	 * sti_line_done is needed to determine when we have reached the
-	 * end of the line. write() has a tendency to hand us small
-	 * strings which otherwise end up creating newlines.. we need to
-	 * keep the channel open and in append mode until the line has
-	 * been terminated.
-	 */
-	if (sti_line_done !=3D 0) {
-#ifdef __LITTLE_ENDIAN
-		sti_channel_writeb(0xc3, channel);
-#else
-		sti_channel_writeb(0xc0, channel);
-#endif
-		xchg(&sti_line_done, 0);
-	}
-
-	while (*string && count !=3D len) {
-		char c =3D *string++;
-
-		count++;
-
-		if (c =3D=3D '\n') {
-			xchg(&sti_line_done, 1);
-			sti_channel_writeb(0, channel);
-			break;
-		} else
-			sti_channel_writeb(c, channel);
-	}
-
-	if (sti_line_done)
-		sti_channel_flush(channel);
-
-	return count;
-}
-
-static int sti_tty_open(struct tty_struct *tty, struct file *filp)
-{
-	return 0;
-}
-
-static int sti_tty_write(struct tty_struct *tty,
-			 const unsigned char *buf, int len)
-{
-	unsigned long flags;
-	int bytes;
-
-	spin_lock_irqsave(&sti_console_lock, flags);
-	bytes =3D sti_channel_puts(buf, sti_console_channel, len);
-	spin_unlock_irqrestore(&sti_console_lock, flags);
-
-	return bytes;
-}
-
-static int sti_tty_write_room(struct tty_struct *tty)
-{
-	return 0x100000;
-}
-
-static int sti_tty_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;
-}
-
-static struct tty_operations sti_tty_ops =3D {
-	.open			=3D sti_tty_open,
-	.write			=3D sti_tty_write,
-	.write_room		=3D sti_tty_write_room,
-	.chars_in_buffer	=3D sti_tty_chars_in_buffer,
-};
-
-static void sti_console_write(struct console *c, const char *s, unsign=
ed n)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&sti_console_lock, flags);
-	sti_channel_puts(s, sti_console_channel, n);
-	spin_unlock_irqrestore(&sti_console_lock, flags);
-}
-
-static struct tty_driver *sti_console_device(struct console *c, int *i=
ndex)
-{
-	*index =3D c->index;
-	return tty_driver;
-}
-
-static int sti_console_setup(struct console *c, char *opts)
-{
-	return 0;
-}
-
-static struct console sti_console =3D {
-	.name		=3D DRV_NAME,
-	.write		=3D sti_console_write,
-	.device		=3D sti_console_device,
-	.setup		=3D sti_console_setup,
-	.flags		=3D CON_PRINTBUFFER | CON_ENABLED,
-	.index		=3D -1,
-};
-
-static int __init sti_console_init(void)
-{
-	const struct omap_sti_console_config *info;
-
-	info =3D omap_get_config(OMAP_TAG_STI_CONSOLE,
-			       struct omap_sti_console_config);
-	if (info && info->enable) {
-		add_preferred_console(DRV_NAME, 0, NULL);
-
-		sti_console_channel =3D info->channel;
-	}
-
-	if (unlikely(sti_console_channel =3D=3D -1))
-		return -EINVAL;
-
-	register_console(&sti_console);
-
-	return 0;
-}
-__initcall(sti_console_init);
-
-static int __init sti_tty_init(void)
-{
-	struct tty_driver *tty;
-	int ret;
-
-	tty =3D alloc_tty_driver(1);
-	if (!tty)
-		return -ENOMEM;
-
-	tty->name		=3D DRV_NAME;
-	tty->driver_name	=3D DRV_NAME;
-	tty->major		=3D 0;	/* dynamic major */
-	tty->minor_start	=3D 0;
-	tty->type		=3D TTY_DRIVER_TYPE_SYSTEM;
-	tty->subtype		=3D SYSTEM_TYPE_SYSCONS;
-	tty->init_termios	=3D tty_std_termios;
-
-	tty_set_operations(tty, &sti_tty_ops);
-
-	ret =3D tty_register_driver(tty);
-	if (ret) {
-		put_tty_driver(tty);
-		return ret;
-	}
-
-	tty_driver =3D tty;
-	return 0;
-}
-late_initcall(sti_tty_init);
-
-module_param(sti_console_channel, uint, 0);
-MODULE_PARM_DESC(sti_console_channel, "STI console channel");
-MODULE_AUTHOR("Paul Mundt");
-MODULE_DESCRIPTION("OMAP STI console support");
-MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-omap/sti/sti-fifo.c b/arch/arm/plat-omap/sti=
/sti-fifo.c
deleted file mode 100644
index 4069d9b..0000000
--- a/arch/arm/plat-omap/sti/sti-fifo.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * STI RX FIFO Support
- *
- * Copyright (C) 2005, 2006 Nokia Corporation
- * Written by:  Paul Mundt <paul.mundt@nokia.com> and
- *		Roman Tereshonkov <roman.tereshonkov@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General=
 Public
- * License.  See the file "COPYING" in the main directory of this arch=
ive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <asm/arch/sti.h>
-
-#define STI_READ_BUFFER_SIZE	1024
-#define sti_buf_pos(pos)	((sti_crb->bufpos + (pos)) % \
-				 STI_READ_BUFFER_SIZE)
-
-static struct sti_cycle_buffer {
-	int bufpos;
-	int datalen;
-	unsigned char *buf;
-} *sti_crb;
-
-/**
- * sti_read_packet - STI read packet (read an entire STI packet)
- * @buf: Buffer to store the packet.
- * @maxsize: Maximum size requested.
- *
- * This reads in a single completed STI packet from the RX FIFOs and
- * places it in @buf for further processing.
- *
- * The return value is < 0 on error, and >=3D 0 for the number of byte=
s
- * actually read. As per the STI specification, we require a 0xC1 to
- * indicate the end of the packet, and we don't return the packet unti=
l
- * we've read the entire thing in.
- *
- * Due to the size of the FIFOs, it's unrealistic to constantly drain
- * this for 1 or 2 bytes at a time, so we assemble it here and return
- * the whole thing.
- */
-int sti_read_packet(unsigned char *buf, int maxsize)
-{
-	unsigned int pos;
-
-	if (unlikely(!buf))
-		return -EINVAL;
-	if (!sti_crb->datalen)
-		return 0;
-
-	pos =3D sti_buf_pos(sti_crb->datalen - 1);
-	/* End of packet */
-	if (sti_crb->buf[pos] =3D=3D 0xC1) {
-		int i;
-
-		for (i =3D 0; i < sti_crb->datalen && i < maxsize; i++) {
-			pos =3D sti_buf_pos(i);
-			buf[i] =3D sti_crb->buf[pos];
-		}
-
-		sti_crb->bufpos =3D sti_buf_pos(i);
-		sti_crb->datalen -=3D i;
-
-		return i;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(sti_read_packet);
-
-static void sti_fifo_irq(unsigned long arg)
-{
-	/* If there is data read it */
-	while (!(sti_readl(STI_RX_STATUS) & STI_RXFIFO_EMPTY)) {
-		unsigned int pos =3D sti_buf_pos(sti_crb->datalen);
-
-		sti_crb->buf[pos] =3D sti_readl(STI_RX_DR);
-		sti_crb->datalen++;
-	}
-
-	sti_ack_irq(STI_RX_INT);
-}
-
-static int __init sti_fifo_init(void)
-{
-	unsigned int size;
-	int ret;
-
-	size =3D sizeof(struct sti_cycle_buffer) + STI_READ_BUFFER_SIZE;
-	sti_crb =3D kmalloc(size, GFP_KERNEL);
-	if (!sti_crb)
-		return -ENOMEM;
-
-	sti_crb->bufpos =3D sti_crb->datalen =3D 0;
-	sti_crb->buf =3D (unsigned char *)(sti_crb + sizeof(*sti_crb));
-
-	ret =3D sti_request_irq(STI_RX_INT, sti_fifo_irq, 0);
-	if (ret !=3D 0)
-		kfree(sti_crb);
-
-	return ret;
-}
-
-static void __exit sti_fifo_exit(void)
-{
-	sti_free_irq(STI_RX_INT);
-	kfree(sti_crb);
-}
-
-module_init(sti_fifo_init);
-module_exit(sti_fifo_exit);
-
-MODULE_AUTHOR("Paul Mundt, Roman Tereshonkov");
-MODULE_LICENSE("GPL");
diff --git a/arch/arm/plat-omap/sti/sti-netlink.c b/arch/arm/plat-omap/=
sti/sti-netlink.c
deleted file mode 100644
index ca3533e..0000000
--- a/arch/arm/plat-omap/sti/sti-netlink.c
+++ /dev/null
@@ -1,152 +0,0 @@
-/*
- * OMAP STI/XTI communications interface via netlink socket.
- *
- * Copyright (C) 2004, 2005, 2006 Nokia Corporation
- * Written by: Paul Mundt <paul.mundt@nokia.com>
- *
- * This file is subject to the terms and conditions of the GNU General=
 Public
- * License.  See the file "COPYING" in the main directory of this arch=
ive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/netlink.h>
-#include <linux/socket.h>
-#include <linux/skbuff.h>
-#include <linux/mutex.h>
-#include <net/sock.h>
-#include <asm/arch/sti.h>
-
-static struct sock *sti_sock;
-static DEFINE_MUTEX(sti_netlink_mutex);
-
-enum {
-	STI_READ,
-	STI_WRITE,
-};
-
-static int sti_netlink_read(int pid, int seq, void *payload, int size)
-{
-	struct sk_buff *skb;
-	struct nlmsghdr *nlh;
-	int ret, len =3D NLMSG_SPACE(size);
-	unsigned char *tail;
-
-	skb =3D alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
-	tail =3D skb->tail;
-	nlh =3D NLMSG_PUT(skb, pid, seq, STI_READ,
-			len - (sizeof(struct nlmsghdr)));
-	nlh->nlmsg_flags =3D 0;
-	memcpy(NLMSG_DATA(nlh), payload, size);
-	nlh->nlmsg_len =3D skb->tail - tail;
-
-	ret =3D netlink_unicast(sti_sock, skb, pid, MSG_DONTWAIT);
-	if (ret > 0)
-		ret =3D 0;
-
-	return ret;
-
-nlmsg_failure:
-	if (skb)
-		kfree_skb(skb);
-
-	return -EINVAL;
-}
-
-/*
- * We abuse nlmsg_type and nlmsg_flags for our purposes.
- *
- * The ID is encoded into the upper 8 bits of the nlmsg_type, while th=
e
- * channel number is encoded into the upper 8 bits of the nlmsg_flags.
- */
-static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghd=
r *nlh)
-{
-	void *data;
-	u8 chan, id;
-	int size, ret =3D 0, len =3D 0;
-
-	data	=3D NLMSG_DATA(nlh);
-	chan	=3D (nlh->nlmsg_flags >> 8) & 0xff;
-	id	=3D (nlh->nlmsg_type  >> 8) & 0xff;
-	size	=3D (int)(nlh->nlmsg_len - ((char *)data - (char *)nlh));
-
-	switch (nlh->nlmsg_type & 0xff) {
-	case STI_WRITE:
-		sti_channel_write_trace(size, id, data, chan);
-		break;
-	case STI_READ:
-		data =3D kmalloc(size, GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
-		memset(data, 0, size);
-
-		len =3D sti_read_packet(data, size);
-		ret =3D sti_netlink_read(NETLINK_CB(skb).pid, nlh->nlmsg_seq,
-				       data, len);
-		kfree(data);
-		break;
-	default:
-		return -ENOTTY;
-	}
-
-	return ret;
-}
-
-static int sti_netlink_receive_skb(struct sk_buff *skb)
-{
-	while (skb->len >=3D NLMSG_SPACE(0)) {
-		struct nlmsghdr *nlh;
-		u32 rlen;
-		int ret;
-
-		nlh =3D (struct nlmsghdr *)skb->data;
-		if (nlh->nlmsg_len < sizeof(struct nlmsghdr) ||
-		    skb->len < nlh->nlmsg_len)
-			break;
-
-		rlen =3D NLMSG_ALIGN(nlh->nlmsg_len);
-		if (rlen > skb->len)
-			rlen =3D skb->len;
-
-		ret =3D sti_netlink_receive_msg(skb, nlh);
-		if (ret)
-			netlink_ack(skb, nlh, -ret);
-		else if (nlh->nlmsg_flags & NLM_F_ACK)
-			netlink_ack(skb, nlh, 0);
-
-		skb_pull(skb, rlen);
-	}
-
-	return 0;
-}
-
-static void sti_netlink_receive(struct sk_buff *skb)
-{
-	if (!mutex_trylock(&sti_netlink_mutex))
-		return;
-
-	sti_netlink_receive_skb(skb);
-	mutex_unlock(&sti_netlink_mutex);
-}
-
-static int __init sti_netlink_init(void)
-{
-	sti_sock =3D netlink_kernel_create(&init_net, NETLINK_USERSOCK, 0,
-					 sti_netlink_receive, NULL,
-					 THIS_MODULE);
-	if (!sti_sock) {
-		printk(KERN_ERR "STI: Failed to create netlink socket\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-module_init(sti_netlink_init);
-
-MODULE_AUTHOR("Paul Mundt");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("STI netlink-driven communications interface");
diff --git a/arch/arm/plat-omap/sti/sti.c b/arch/arm/plat-omap/sti/sti.=
c
deleted file mode 100644
index e828860..0000000
--- a/arch/arm/plat-omap/sti/sti.c
+++ /dev/null
@@ -1,432 +0,0 @@
-/*
- * Support functions for OMAP STI/XTI (Serial Tracing Interface)
- *
- * Copyright (C) 2004, 2005, 2006 Nokia Corporation
- * Written by: Paul Mundt <paul.mundt@nokia.com>
- *
- * STI initialization code and channel handling
- * from Juha Yrj=F6l=E4 <juha.yrjola@nokia.com>.
- *
- * XTI initialization
- * from Roman Tereshonkov <roman.tereshonkov@nokia.com>.
- *
- * This file is subject to the terms and conditions of the GNU General=
 Public
- * License.  See the file "COPYING" in the main directory of this arch=
ive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <asm/arch/sti.h>
-#include <asm/byteorder.h>
-
-static struct clk *sti_ck;
-unsigned long sti_base, sti_channel_base;
-static unsigned long sti_kern_mask =3D STIEn;
-static unsigned long sti_irq_mask =3D STI_IRQSTATUS_MASK;
-static DEFINE_SPINLOCK(sti_lock);
-
-static struct sti_irqdesc {
-	irqreturn_t (*func)(unsigned long);
-	unsigned long data;
-} ____cacheline_aligned sti_irq_desc[STI_NR_IRQS];
-
-void sti_channel_write_trace(int len, int id, void *data, unsigned int=
 channel)
-{
-	const u8 *tpntr =3D data;
-
-	sti_channel_writeb(id, channel);
-
-	if (cpu_is_omap16xx())
-		/* Check u32 boundary */
-		if (!((u32)data & (STI_PERCHANNEL_SIZE - 1)) &&
-		     (len >=3D STI_PERCHANNEL_SIZE)) {
-			const u32 *asrc =3D data;
-
-			do {
-				sti_channel_writel(cpu_to_be32(*asrc++),
-						   channel);
-				len -=3D STI_PERCHANNEL_SIZE;
-			} while (len >=3D STI_PERCHANNEL_SIZE);
-
-			tpntr =3D (const u8 *)asrc;
-		}
-
-	while (len--)
-		sti_channel_writeb(*tpntr++, channel);
-
-	sti_channel_flush(channel);
-}
-EXPORT_SYMBOL(sti_channel_write_trace);
-
-void sti_enable_irq(unsigned int id)
-{
-	spin_lock_irq(&sti_lock);
-	sti_writel(1 << id, STI_IRQSETEN);
-	spin_unlock_irq(&sti_lock);
-}
-EXPORT_SYMBOL(sti_enable_irq);
-
-void sti_disable_irq(unsigned int id)
-{
-	spin_lock_irq(&sti_lock);
-
-	if (cpu_is_omap16xx())
-		sti_writel(1 << id, STI_IRQCLREN);
-	else if (cpu_is_omap24xx())
-		sti_writel(sti_readl(STI_IRQSETEN) & ~(1 << id), STI_IRQSETEN);
-	else
-		BUG();
-
-	spin_unlock_irq(&sti_lock);
-}
-EXPORT_SYMBOL(sti_disable_irq);
-
-void sti_ack_irq(unsigned int id)
-{
-	/* Even though the clear state is 0, we have to write 1 to clear */
-	sti_writel(1 << id, STI_IRQSTATUS);
-}
-EXPORT_SYMBOL(sti_ack_irq);
-
-int sti_request_irq(unsigned int irq, void *handler, unsigned long arg=
)
-{
-	struct sti_irqdesc *desc;
-
-	if (unlikely(!handler || irq > STI_NR_IRQS))
-		return -EINVAL;
-
-	desc =3D sti_irq_desc + irq;
-	if (unlikely(desc->func)) {
-		printk(KERN_WARNING "STI: Attempting to request in-use IRQ "
-				    "%d, consider fixing your code..\n", irq);
-		return -EBUSY;
-	}
-
-	desc->func =3D handler;
-	desc->data =3D arg;
-
-	sti_enable_irq(irq);
-	return 0;
-}
-EXPORT_SYMBOL(sti_request_irq);
-
-void sti_free_irq(unsigned int irq)
-{
-	struct sti_irqdesc *desc =3D sti_irq_desc + irq;
-
-	if (unlikely(irq > STI_NR_IRQS))
-		return;
-
-	sti_disable_irq(irq);
-
-	desc->func =3D NULL;
-	desc->data =3D 0;
-}
-EXPORT_SYMBOL(sti_free_irq);
-
-/*
- * This is a bit heavy, so normally we would defer this to a tasklet.
- * Unfortunately tasklets are too slow for the RX FIFO interrupt (and
- * possibly some others), so we just do the irqdesc walking here.
- */
-static irqreturn_t sti_interrupt(int irq, void *dev_id)
-{
-	int ret =3D IRQ_NONE;
-	u16 status;
-	int i;
-
-	status =3D sti_readl(STI_IRQSTATUS) & sti_irq_mask;
-
-	for (i =3D 0; status; i++) {
-		struct sti_irqdesc *desc =3D sti_irq_desc + i;
-		u16 id =3D 1 << i;
-
-		if (!(status & id))
-			continue;
-
-		if (likely(desc && desc->func))
-			ret |=3D desc->func(desc->data);
-		if (unlikely(ret =3D=3D IRQ_NONE)) {
-			printk("STI: spurious interrupt (id %d)\n", id);
-			sti_disable_irq(i);
-			sti_ack_irq(i);
-			ret =3D IRQ_HANDLED;
-		}
-
-		status &=3D ~id;
-	}
-
-	return IRQ_RETVAL(ret);
-}
-
-static void omap_sti_reset(void)
-{
-	int i;
-
-	/* Reset STI module */
-	sti_writel(0x02, STI_SYSCONFIG);
-
-	/* Wait a while for the STI module to complete its reset */
-	for (i =3D 0; i < 10000; i++)
-		if (sti_readl(STI_SYSSTATUS) & 1)
-			break;
-}
-
-static int __init sti_init(void)
-{
-	char buf[64];
-	int i;
-
-	if (cpu_is_omap16xx()) {
-		/* Release ARM Rhea buses peripherals enable */
-		sti_writel(sti_readl(ARM_RSTCT2) | 0x0001, ARM_RSTCT2);
-
-		/* Enable TC1_CK (functional clock) */
-		sti_ck =3D clk_get(NULL, "tc1_ck");
-	} else if (cpu_is_omap24xx())
-		/* Enable emulation tools clock */
-		sti_ck =3D clk_get(NULL, "emul_ck");
-
-	if (IS_ERR(sti_ck))
-		return PTR_ERR(sti_ck);
-
-	clk_enable(sti_ck);
-
-	/* Reset STI module */
-	omap_sti_reset();
-
-	/* Enable STI */
-	sti_trace_enable(MPUCmdEn);
-
-	/* Change to custom serial protocol */
-	sti_writel(0x01, STI_SERIAL_CFG);
-
-	/* Set STI clock control register to normal mode */
-	sti_writel(0x00, STI_CLK_CTRL);
-
-	i =3D sti_readl(STI_REVISION);
-	snprintf(buf, sizeof(buf), "OMAP STI support loaded (HW v%u.%u)\n",
-	        (i >> 4) & 0x0f, i & 0x0f);
-	printk(KERN_INFO "%s", buf);
-
-	sti_channel_write_trace(strlen(buf), 0xc3, buf, 239);
-
-	return 0;
-}
-
-static void sti_exit(void)
-{
-	u32 tmp;
-
-	/*
-	 * This should have already been done by reset, but we switch off
-	 * STI entirely just for added sanity..
-	 */
-	tmp =3D sti_readl(STI_ER);
-	tmp &=3D ~STIEn;
-	sti_writel(tmp, STI_ER);
-
-	clk_disable(sti_ck);
-	clk_put(sti_ck);
-}
-
-static void __sti_trace_enable(int event)
-{
-	u32 tmp;
-
-	tmp =3D sti_readl(STI_ER);
-	tmp |=3D sti_kern_mask | event;
-	sti_writel(tmp, STI_ER);
-}
-
-int sti_trace_enable(int event)
-{
-	spin_lock_irq(&sti_lock);
-	sti_kern_mask |=3D event;
-	__sti_trace_enable(event);
-	spin_unlock_irq(&sti_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL(sti_trace_enable);
-
-static void __sti_trace_disable(int event)
-{
-	u32 tmp;
-
-	tmp =3D sti_readl(STI_DR);
-
-	if (cpu_is_omap16xx()) {
-		tmp |=3D event;
-		tmp &=3D ~sti_kern_mask;
-	} else if (cpu_is_omap24xx()) {
-		tmp &=3D ~event;
-		tmp |=3D sti_kern_mask;
-	} else
-		BUG();
-
-	sti_writel(tmp, STI_DR);
-}
-
-void sti_trace_disable(int event)
-{
-	spin_lock_irq(&sti_lock);
-	sti_kern_mask &=3D ~event;
-	__sti_trace_disable(event);
-	spin_unlock_irq(&sti_lock);
-}
-EXPORT_SYMBOL(sti_trace_disable);
-
-static ssize_t
-sti_trace_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
-{
-	return sprintf(buf, "0x%08lx\n", sti_readl(STI_ER));
-}
-
-static ssize_t
-sti_trace_store(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	int evt =3D simple_strtoul(buf, NULL, 0);
-	int mask =3D ~evt;
-
-	spin_lock_irq(&sti_lock);
-	__sti_trace_disable(mask);
-	__sti_trace_enable(evt);
-	spin_unlock_irq(&sti_lock);
-
-	return count;
-}
-static DEVICE_ATTR(trace, S_IRUGO | S_IWUSR, sti_trace_show, sti_trace=
_store);
-
-static ssize_t
-sti_imask_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
-{
-	return sprintf(buf, "0x%04lx\n", sti_irq_mask);
-}
-
-static ssize_t
-sti_imask_store(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
-{
-	spin_lock_irq(&sti_lock);
-	sti_irq_mask =3D simple_strtoul(buf, NULL, 0);
-	spin_unlock_irq(&sti_lock);
-
-	return count;
-}
-static DEVICE_ATTR(imask, S_IRUGO | S_IWUSR, sti_imask_show, sti_imask=
_store);
-
-static int __devinit sti_probe(struct platform_device *pdev)
-{
-	struct resource *res, *cres;
-	int ret;
-
-	if (pdev->num_resources !=3D 3) {
-		dev_err(&pdev->dev, "invalid number of resources: %d\n",
-			pdev->num_resources);
-		return -ENODEV;
-	}
-
-	/* STI base */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!res)) {
-		dev_err(&pdev->dev, "invalid mem resource\n");
-		return -ENODEV;
-	}
-
-	/* Channel base */
-	cres =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (unlikely(!cres)) {
-		dev_err(&pdev->dev, "invalid channel mem resource\n");
-		return -ENODEV;
-	}
-
-	ret =3D device_create_file(&pdev->dev, &dev_attr_trace);
-	if (unlikely(ret !=3D 0))
-		return ret;
-
-	ret =3D device_create_file(&pdev->dev, &dev_attr_imask);
-	if (unlikely(ret !=3D 0))
-		goto err;
-
-	sti_base =3D res->start;
-
-	/*
-	 * OMAP 16xx keeps channels in a relatively sane location,
-	 * whereas 24xx maps them much further out, and so they must be
-	 * remapped.
-	 */
-	if (cpu_is_omap16xx())
-		sti_channel_base =3D cres->start;
-	else if (cpu_is_omap24xx()) {
-		unsigned int size =3D cres->end - cres->start;
-
-		sti_channel_base =3D (unsigned long)ioremap(cres->start, size);
-		if (unlikely(!sti_channel_base)) {
-			ret =3D -ENODEV;
-			goto err_badremap;
-		}
-	}
-
-	ret =3D request_irq(platform_get_irq(pdev, 0), sti_interrupt,
-			  IRQF_DISABLED, "sti", NULL);
-	if (unlikely(ret !=3D 0))
-		goto err_badirq;
-
-	return sti_init();
-
-err_badirq:
-	iounmap((void *)sti_channel_base);
-err_badremap:
-	device_remove_file(&pdev->dev, &dev_attr_imask);
-err:
-	device_remove_file(&pdev->dev, &dev_attr_trace);
-
-	return ret;
-}
-
-static int __devexit sti_remove(struct platform_device *pdev)
-{
-	unsigned int irq =3D platform_get_irq(pdev, 0);
-
-	if (cpu_is_omap24xx())
-		iounmap((void *)sti_channel_base);
-
-	device_remove_file(&pdev->dev, &dev_attr_trace);
-	device_remove_file(&pdev->dev, &dev_attr_imask);
-	free_irq(irq, NULL);
-	sti_exit();
-
-	return 0;
-}
-
-static struct platform_driver sti_driver =3D {
-	.probe		=3D sti_probe,
-	.remove		=3D __devexit_p(sti_remove),
-	.driver		=3D {
-		.name	=3D "sti",
-		.owner	=3D THIS_MODULE,
-	},
-};
-
-static int __init sti_module_init(void)
-{
-	return platform_driver_register(&sti_driver);
-}
-
-static void __exit sti_module_exit(void)
-{
-	platform_driver_unregister(&sti_driver);
-}
-subsys_initcall(sti_module_init);
-module_exit(sti_module_exit);
-
-MODULE_AUTHOR("Paul Mundt, Juha Yrj=F6l=E4, Roman Tereshonkov");
-MODULE_LICENSE("GPL");
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3b12f5d..d65b43d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -5,6 +5,7 @@ obj- :=3D misc.o	# Dummy rule to force built-in.o to be=
 made
=20
 obj-$(CONFIG_IBM_ASM)		+=3D ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+=3D hdpuftrs/
+obj-$(CONFIG_OMAP_STI)		+=3D sti/
 obj-$(CONFIG_MSI_LAPTOP)     +=3D msi-laptop.o
 obj-$(CONFIG_ACER_WMI)     +=3D acer-wmi.o
 obj-$(CONFIG_ASUS_LAPTOP)     +=3D asus-laptop.o
diff --git a/drivers/misc/sti/Makefile b/drivers/misc/sti/Makefile
new file mode 100644
index 0000000..6ad9bb3
--- /dev/null
+++ b/drivers/misc/sti/Makefile
@@ -0,0 +1,4 @@
+obj-y +=3D sti.o sti-fifo.o
+
+obj-$(CONFIG_OMAP_STI_CONSOLE)	+=3D sti-console.o
+obj-$(CONFIG_NET)		+=3D sti-netlink.o
diff --git a/drivers/misc/sti/sti-console.c b/drivers/misc/sti/sti-cons=
ole.c
new file mode 100644
index 0000000..451a139
--- /dev/null
+++ b/drivers/misc/sti/sti-console.c
@@ -0,0 +1,189 @@
+/*
+ * Console support for OMAP STI/XTI
+ *
+ * Copyright (C) 2004, 2005, 2006 Nokia Corporation
+ * Written by: Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General=
 Public
+ * License.  See the file "COPYING" in the main directory of this arch=
ive
+ * for more details.
+ */
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <asm/arch/sti.h>
+#include <asm/arch/board.h>
+
+#define DRV_NAME "sticon"
+
+static struct tty_driver *tty_driver;
+static DEFINE_SPINLOCK(sti_console_lock);
+static unsigned int sti_console_channel =3D -1;
+static int sti_line_done =3D -1;
+
+/*
+ * Write a string to any channel (including terminating NULL)
+ * Returns number of characters written.
+ */
+static int sti_channel_puts(const char *string, unsigned int channel, =
int len)
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
+static void sti_console_write(struct console *c, const char *s, unsign=
ed n)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sti_console_lock, flags);
+	sti_channel_puts(s, sti_console_channel, n);
+	spin_unlock_irqrestore(&sti_console_lock, flags);
+}
+
+static struct tty_driver *sti_console_device(struct console *c, int *i=
ndex)
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
+	const struct omap_sti_console_config *info;
+
+	info =3D omap_get_config(OMAP_TAG_STI_CONSOLE,
+			       struct omap_sti_console_config);
+	if (info && info->enable) {
+		add_preferred_console(DRV_NAME, 0, NULL);
+
+		sti_console_channel =3D info->channel;
+	}
+
+	if (unlikely(sti_console_channel =3D=3D -1))
+		return -EINVAL;
+
+	register_console(&sti_console);
+
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
+MODULE_PARM_DESC(sti_console_channel, "STI console channel");
+MODULE_AUTHOR("Paul Mundt");
+MODULE_DESCRIPTION("OMAP STI console support");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/sti/sti-fifo.c b/drivers/misc/sti/sti-fifo.c
new file mode 100644
index 0000000..4069d9b
--- /dev/null
+++ b/drivers/misc/sti/sti-fifo.c
@@ -0,0 +1,117 @@
+/*
+ * STI RX FIFO Support
+ *
+ * Copyright (C) 2005, 2006 Nokia Corporation
+ * Written by:  Paul Mundt <paul.mundt@nokia.com> and
+ *		Roman Tereshonkov <roman.tereshonkov@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General=
 Public
+ * License.  See the file "COPYING" in the main directory of this arch=
ive
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
+ * The return value is < 0 on error, and >=3D 0 for the number of byte=
s
+ * actually read. As per the STI specification, we require a 0xC1 to
+ * indicate the end of the packet, and we don't return the packet unti=
l
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
+		sti_crb->buf[pos] =3D sti_readl(STI_RX_DR);
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
diff --git a/drivers/misc/sti/sti-netlink.c b/drivers/misc/sti/sti-netl=
ink.c
new file mode 100644
index 0000000..ca3533e
--- /dev/null
+++ b/drivers/misc/sti/sti-netlink.c
@@ -0,0 +1,152 @@
+/*
+ * OMAP STI/XTI communications interface via netlink socket.
+ *
+ * Copyright (C) 2004, 2005, 2006 Nokia Corporation
+ * Written by: Paul Mundt <paul.mundt@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General=
 Public
+ * License.  See the file "COPYING" in the main directory of this arch=
ive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/netlink.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/mutex.h>
+#include <net/sock.h>
+#include <asm/arch/sti.h>
+
+static struct sock *sti_sock;
+static DEFINE_MUTEX(sti_netlink_mutex);
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
+ * The ID is encoded into the upper 8 bits of the nlmsg_type, while th=
e
+ * channel number is encoded into the upper 8 bits of the nlmsg_flags.
+ */
+static int sti_netlink_receive_msg(struct sk_buff *skb, struct nlmsghd=
r *nlh)
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
+static void sti_netlink_receive(struct sk_buff *skb)
+{
+	if (!mutex_trylock(&sti_netlink_mutex))
+		return;
+
+	sti_netlink_receive_skb(skb);
+	mutex_unlock(&sti_netlink_mutex);
+}
+
+static int __init sti_netlink_init(void)
+{
+	sti_sock =3D netlink_kernel_create(&init_net, NETLINK_USERSOCK, 0,
+					 sti_netlink_receive, NULL,
+					 THIS_MODULE);
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
diff --git a/drivers/misc/sti/sti.c b/drivers/misc/sti/sti.c
new file mode 100644
index 0000000..e828860
--- /dev/null
+++ b/drivers/misc/sti/sti.c
@@ -0,0 +1,432 @@
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
+ * This file is subject to the terms and conditions of the GNU General=
 Public
+ * License.  See the file "COPYING" in the main directory of this arch=
ive
+ * for more details.
+ */
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
+void sti_channel_write_trace(int len, int id, void *data, unsigned int=
 channel)
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
+int sti_request_irq(unsigned int irq, void *handler, unsigned long arg=
)
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
+static irqreturn_t sti_interrupt(int irq, void *dev_id)
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
+
+	if (cpu_is_omap16xx()) {
+		tmp |=3D event;
+		tmp &=3D ~sti_kern_mask;
+	} else if (cpu_is_omap24xx()) {
+		tmp &=3D ~event;
+		tmp |=3D sti_kern_mask;
+	} else
+		BUG();
+
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
+sti_trace_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
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
+static DEVICE_ATTR(trace, S_IRUGO | S_IWUSR, sti_trace_show, sti_trace=
_store);
+
+static ssize_t
+sti_imask_show(struct device *dev, struct device_attribute *attr, char=
 *buf)
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
+static DEVICE_ATTR(imask, S_IRUGO | S_IWUSR, sti_imask_show, sti_imask=
_store);
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
+			  IRQF_DISABLED, "sti", NULL);
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
--=20
1.5.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
