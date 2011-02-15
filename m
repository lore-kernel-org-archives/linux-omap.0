From: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Subject: [PATCH 3/8] ARM: etm: Don't try to clear the buffer full status after reading the buffer
Date: Mon, 14 Feb 2011 22:11:11 -0800
Message-ID: <1297750276-12475-3-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40737 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab1BOGLv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 01:11:51 -0500
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Russell King <linux@arm.linux.org.uk>, Alexander Shishkin <virtuoso@slind.org>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org

If the write address was at the end of the buffer, toggling the trace
capture bit would set the RAM-full status instead of clearing it, and
if any of the stop bits in the formatter is set toggling the trace
capture bit may not do anything.

Instead use the read position to find out if the data has already
been returned.

This also fixes the read function so it works when the trace buffer is
larger than the buffer passed in from user space. The old version
would reset the trace buffer pointers after every read, so the second
call to read would always return 0.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
---
 arch/arm/kernel/etm.c |   58 ++++++++++++++++++++++-------------------=
--------
 1 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 6e15c48..bc7d8f2 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -91,6 +91,7 @@ static int trace_start(struct tracectx *t)
=20
 	etb_unlock(t);
=20
+	etb_writel(t, 0, ETBR_WRITEADDR);
 	etb_writel(t, 0, ETBR_FORMATTERCTRL);
 	etb_writel(t, 1, ETBR_CTRL);
=20
@@ -184,24 +185,15 @@ static int trace_stop(struct tracectx *t)
 static int etb_getdatalen(struct tracectx *t)
 {
 	u32 v;
-	int rp, wp;
+	int wp;
=20
 	v =3D etb_readl(t, ETBR_STATUS);
=20
 	if (v & 1)
 		return t->etb_bufsz;
=20
-	rp =3D etb_readl(t, ETBR_READADDR);
 	wp =3D etb_readl(t, ETBR_WRITEADDR);
-
-	if (rp > wp) {
-		etb_writel(t, 0, ETBR_READADDR);
-		etb_writel(t, 0, ETBR_WRITEADDR);
-
-		return 0;
-	}
-
-	return wp - rp;
+	return wp;
 }
=20
 /* sysrq+v will always stop the running trace and leave it at that */
@@ -234,14 +226,6 @@ static void etm_dump(void)
 		printk("%08x", cpu_to_be32(etb_readl(t, ETBR_READMEM)));
 	printk(KERN_INFO "\n--- ETB buffer end ---\n");
=20
-	/* deassert the overflow bit */
-	etb_writel(t, 1, ETBR_CTRL);
-	etb_writel(t, 0, ETBR_CTRL);
-
-	etb_writel(t, 0, ETBR_TRIGGERCOUNT);
-	etb_writel(t, 0, ETBR_READADDR);
-	etb_writel(t, 0, ETBR_WRITEADDR);
-
 	etb_lock(t);
 }
=20
@@ -275,6 +259,10 @@ static ssize_t etb_read(struct file *file, char __=
user *data,
 	struct tracectx *t =3D file->private_data;
 	u32 first =3D 0;
 	u32 *buf;
+	int wpos;
+	int skip;
+	long wlength;
+	loff_t pos =3D *ppos;
=20
 	mutex_lock(&t->mutex);
=20
@@ -289,28 +277,34 @@ static ssize_t etb_read(struct file *file, char _=
_user *data,
 	if (total =3D=3D t->etb_bufsz)
 		first =3D etb_readl(t, ETBR_WRITEADDR);
=20
+	if (pos > total * 4) {
+		skip =3D 0;
+		wpos =3D total;
+	} else {
+		skip =3D (int)pos % 4;
+		wpos =3D (int)pos / 4;
+	}
+	total -=3D wpos;
+	first =3D (first + wpos) % t->etb_bufsz;
+
 	etb_writel(t, first, ETBR_READADDR);
=20
-	length =3D min(total * 4, (int)len);
-	buf =3D vmalloc(length);
+	wlength =3D min(total, DIV_ROUND_UP(skip + (int)len, 4));
+	length =3D min(total * 4 - skip, (int)len);
+	buf =3D vmalloc(wlength * 4);
=20
-	dev_dbg(t->dev, "ETB buffer length: %d\n", total);
+	dev_dbg(t->dev, "ETB read %ld bytes to %lld from %ld words at %d\n",
+		length, pos, wlength, first);
+	dev_dbg(t->dev, "ETB buffer length: %d\n", total + wpos);
 	dev_dbg(t->dev, "ETB status reg: %x\n", etb_readl(t, ETBR_STATUS));
-	for (i =3D 0; i < length / 4; i++)
+	for (i =3D 0; i < wlength; i++)
 		buf[i] =3D etb_readl(t, ETBR_READMEM);
=20
-	/* the only way to deassert overflow bit in ETB status is this */
-	etb_writel(t, 1, ETBR_CTRL);
-	etb_writel(t, 0, ETBR_CTRL);
-
-	etb_writel(t, 0, ETBR_WRITEADDR);
-	etb_writel(t, 0, ETBR_READADDR);
-	etb_writel(t, 0, ETBR_TRIGGERCOUNT);
-
 	etb_lock(t);
=20
-	length -=3D copy_to_user(data, buf, length);
+	length -=3D copy_to_user(data, (u8 *)buf + skip, length);
 	vfree(buf);
+	*ppos =3D pos + length;
=20
 out:
 	mutex_unlock(&t->mutex);
--=20
1.7.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
