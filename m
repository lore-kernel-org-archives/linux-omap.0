From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Make OMAP1 work again
Date: Fri, 06 Oct 2006 11:58:33 +0200
Message-ID: <452628C9.1020603@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000307080507070609050404"
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
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307080507070609050404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


In mach-omap1/mailbox.c the mailbox name is .name = "DSP"
while in plat-omap/dsp/dsp_core.c function  dsp_mbox_init()
asks for "dsp". This results in a strcmp() mismatch and then
OMAP1 system crashes due to NULL pointer. OMAP2 is correct,
there .name is "dsp". Correct OMAP1 name to "dsp" as well.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------000307080507070609050404
Content-Type: text/plain;
 name="omap1_dsp_mailbox_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1_dsp_mailbox_patch.txt"

--- ./arch/arm/mach-omap1/mailbox.c_orig	2006-10-06 11:08:50.000000000 +0200
+++ ./arch/arm/mach-omap1/mailbox.c	2006-10-06 11:09:13.000000000 +0200
@@ -136,7 +136,7 @@ static struct omap_mbox1_priv omap1_mbox
 };
 
 struct omap_mbox mbox_dsp_info = {
-	.name = "DSP",
+	.name = "dsp",
 	.ops  = &omap1_mbox_ops,
 	.priv = &omap1_mbox_dsp_priv,
 };



--------------000307080507070609050404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000307080507070609050404--
