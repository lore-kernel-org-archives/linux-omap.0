From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH 7/8] staging: tidspbridge - fix some issues after iommu patches
Date: Mon, 25 Oct 2010 19:51:45 -0500
Message-ID: <1288054306-4361-8-git-send-email-x0095840@ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
	<1288054306-4361-3-git-send-email-x0095840@ti.com>
	<1288054306-4361-4-git-send-email-x0095840@ti.com>
	<1288054306-4361-5-git-send-email-x0095840@ti.com>
	<1288054306-4361-6-git-send-email-x0095840@ti.com>
	<1288054306-4361-7-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1288054306-4361-7-git-send-email-x0095840@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@suse.de
Cc: Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, felipe.contreras@nokia.com, andy.shevchenko@gmail.com, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch fixes:

* In delete_node() we need to check for udsp_heap_addr in order
  to unmap the head instead of udsp_heap_res_addr which used
  to be the reserved memory a not valid anymore.

* Fix in get_io_pages() as pointed by Felipe Contreras in this
  mail:

http://marc.info/?l=linux-kernel&m=128735502205183&w=2

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/staging/tidspbridge/core/dsp-mmu.c |    2 +-
 drivers/staging/tidspbridge/rmgr/node.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/dsp-mmu.c b/drivers/staging/tidspbridge/core/dsp-mmu.c
index 3a00087..54f3ba4 100644
--- a/drivers/staging/tidspbridge/core/dsp-mmu.c
+++ b/drivers/staging/tidspbridge/core/dsp-mmu.c
@@ -196,7 +196,7 @@ static int get_io_pages(struct mm_struct *mm, u32 uva, unsigned pages,
 	int i;
 	struct page *pg;
 
-	for (i = 0; i < pages; i++) {
+	for (i = 0; i < pages; i++, uva += PAGE_SIZE) {
 		pa = user_va2_pa(mm, uva);
 
 		if (!pfn_valid(__phys_to_pfn(pa)))
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
index 3f5abcf..f7fe6c0 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -2541,7 +2541,7 @@ static void delete_node(struct node_object *hnode,
 			kfree(task_arg_obj.strm_out_def);
 			task_arg_obj.strm_out_def = NULL;
 		}
-		if (task_arg_obj.udsp_heap_res_addr) {
+		if (task_arg_obj.udsp_heap_addr) {
 			status = proc_un_map(hnode->hprocessor, (void *)
 					     task_arg_obj.udsp_heap_addr,
 					     pr_ctxt);
-- 
1.6.3.3
