From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix workqueue and set_pte in DSP code
Date: Fri, 22 Dec 2006 11:03:02 +0100
Message-ID: <458BAD56.9080503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080702050407090102050605"
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
--------------080702050407090102050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix workqueue and set_pte in DSP code to make it
compile again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------080702050407090102050605
Content-Type: text/plain;
 name="dsp_fixes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsp_fixes.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/ipbuf.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/ipbuf.c
+++ linux-osk/arch/arm/plat-omap/dsp/ipbuf.c
@@ -245,7 +245,7 @@ static int try_yld(struct ipbuf_head *ip
 /*
  * balancing ipbuf lines with DSP
  */
-static void do_balance_ipbuf(void)
+static void do_balance_ipbuf(struct work_struct *unused)
 {
 	while (ipbcfg.bsycnt <= ipbcfg.ln / 4) {
 		struct ipbuf_head *ipb_h;
@@ -257,8 +257,7 @@ static void do_balance_ipbuf(void)
 	}
 }
 
-static DECLARE_WORK(balance_ipbuf_work, (void (*)(void *))do_balance_ipbuf,
-		    NULL);
+static DECLARE_WORK(balance_ipbuf_work, do_balance_ipbuf);
 
 void balance_ipbuf(void)
 {
Index: linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_mem.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -507,7 +507,7 @@ exmap_alloc_pte(unsigned long virt, unsi
 	}
 
 	pte = pte_offset_kernel(pmd, virt);
-	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, prot));
+	set_pte_ext(pte, pfn_pte(phys >> PAGE_SHIFT, prot), 0);
 }
 
 #if 0
@@ -2009,7 +2009,7 @@ static int dsp_mem_open(struct inode *in
  * fbupd_cb() is called when fb update is done, in interrupt context.
  * mbox_fbupd() is called when KFUNC:FBCTL:UPD is received from DSP.
  */
-static void fbupd_response(void *arg)
+static void fbupd_response(struct work_struct *unused)
 {
 	int status;
 
@@ -2022,8 +2022,7 @@ static void fbupd_response(void *arg)
 	}
 }
 
-static DECLARE_WORK(fbupd_response_work, (void (*)(void *))fbupd_response,
-		    NULL);
+static DECLARE_WORK(fbupd_response_work, fbupd_response);
 
 static void fbupd_cb(void *arg)
 {
@@ -2283,7 +2282,7 @@ static ssize_t mempool_show(struct devic
 	 DSP_MMU_FAULT_ST_TRANS)
 #endif /* CONFIG_ARCH_OMAP1 */
 
-static void do_mmu_int(void)
+static void do_mmu_int(struct work_struct *unused)
 {
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -2417,7 +2416,7 @@ static void do_mmu_int(void)
 	enable_irq(omap_dsp->mmu_irq);
 }
 
-static DECLARE_WORK(mmu_int_work, (void (*)(void *))do_mmu_int, NULL);
+static DECLARE_WORK(mmu_int_work, do_mmu_int);
 
 /*
  * DSP MMU interrupt handler


--------------080702050407090102050605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080702050407090102050605--
