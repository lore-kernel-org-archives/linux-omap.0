From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2] usb: musb: debugfs: allow forcing host mode together with speed in testmode
Date: Sun, 18 Dec 2016 00:54:40 +0100
Message-ID: <1482018880-1740-1-git-send-email-pali.rohar@gmail.com>
References: <20161216040319.GA18350@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161216040319.GA18350@uda0271908>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Based on the musb ug, force_host bit is allowed to be set along with
force_hs or force_fs bit.

It could help to implement forced host mode via testmode on Nokia N900.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
Changes in v2:
* Use == instead of & for comparison of testmode
---
 drivers/usb/musb/musb_debugfs.c |   44 +++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 9b22d94..5308cea 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -147,28 +147,34 @@ static int musb_test_mode_show(struct seq_file *s, void *unused)
 
 	test = musb_readb(musb->mregs, MUSB_TESTMODE);
 
-	if (test & MUSB_TEST_FORCE_HOST)
+	if (test == (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS))
+		seq_printf(s, "force host full-speed\n");
+
+	else if (test == (MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS))
+		seq_printf(s, "force host high-speed\n");
+
+	else if (test == MUSB_TEST_FORCE_HOST)
 		seq_printf(s, "force host\n");
 
-	if (test & MUSB_TEST_FIFO_ACCESS)
+	else if (test == MUSB_TEST_FIFO_ACCESS)
 		seq_printf(s, "fifo access\n");
 
-	if (test & MUSB_TEST_FORCE_FS)
+	else if (test == MUSB_TEST_FORCE_FS)
 		seq_printf(s, "force full-speed\n");
 
-	if (test & MUSB_TEST_FORCE_HS)
+	else if (test == MUSB_TEST_FORCE_HS)
 		seq_printf(s, "force high-speed\n");
 
-	if (test & MUSB_TEST_PACKET)
+	else if (test == MUSB_TEST_PACKET)
 		seq_printf(s, "test packet\n");
 
-	if (test & MUSB_TEST_K)
+	else if (test == MUSB_TEST_K)
 		seq_printf(s, "test K\n");
 
-	if (test & MUSB_TEST_J)
+	else if (test == MUSB_TEST_J)
 		seq_printf(s, "test J\n");
 
-	if (test & MUSB_TEST_SE0_NAK)
+	else if (test == MUSB_TEST_SE0_NAK)
 		seq_printf(s, "test SE0 NAK\n");
 
 	return 0;
@@ -206,30 +212,36 @@ static ssize_t musb_test_mode_write(struct file *file,
 	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
 
-	if (strstarts(buf, "force host"))
+	if (strstarts(buf, "force host full-speed"))
+		test = MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
+
+	else if (strstarts(buf, "force host high-speed"))
+		test = MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_HS;
+
+	else if (strstarts(buf, "force host"))
 		test = MUSB_TEST_FORCE_HOST;
 
-	if (strstarts(buf, "fifo access"))
+	else if (strstarts(buf, "fifo access"))
 		test = MUSB_TEST_FIFO_ACCESS;
 
-	if (strstarts(buf, "force full-speed"))
+	else if (strstarts(buf, "force full-speed"))
 		test = MUSB_TEST_FORCE_FS;
 
-	if (strstarts(buf, "force high-speed"))
+	else if (strstarts(buf, "force high-speed"))
 		test = MUSB_TEST_FORCE_HS;
 
-	if (strstarts(buf, "test packet")) {
+	else if (strstarts(buf, "test packet")) {
 		test = MUSB_TEST_PACKET;
 		musb_load_testpacket(musb);
 	}
 
-	if (strstarts(buf, "test K"))
+	else if (strstarts(buf, "test K"))
 		test = MUSB_TEST_K;
 
-	if (strstarts(buf, "test J"))
+	else if (strstarts(buf, "test J"))
 		test = MUSB_TEST_J;
 
-	if (strstarts(buf, "test SE0 NAK"))
+	else if (strstarts(buf, "test SE0 NAK"))
 		test = MUSB_TEST_SE0_NAK;
 
 	musb_writeb(musb->mregs, MUSB_TESTMODE, test);
-- 
1.7.9.5
