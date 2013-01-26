From: Christoffer Dall <chris@cloudcar.com>
Subject: [RFC PATCH] ARM: mm: Fix alloc_init_section bug on LPAE
Date: Fri, 25 Jan 2013 19:31:58 -0500
Message-ID: <1359160318-27068-1-git-send-email-chris@cloudcar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Christoffer Dall <chris@cloudcar.com>, "Jeremy C. Andrus" <jeremya@cs.columbia.edu>
List-Id: linux-omap@vger.kernel.org

When using LPAE the call to alloc_init_pte is passed then end address
for the entire 1st level page table region, and the code unluckily ends
up going over the bounds of the single allocated PTE, which is sad.

This caused LPAE boot on omap5 to crash.

There may be some hidden mystery in the boot code that I'm unaware of
or it may be assumed that all mappings are always mappable as sections
on LPAE and therefore omap5 just does something bad, in which case this
patch isn't the right fix, but I'd be happy to be told the reason.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Jeremy C. Andrus <jeremya@cs.columbia.edu>
Signed-off-by: Christoffer Dall <chris@cloudcar.com>
---
 arch/arm/mm/mmu.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce328c7..1cecc99 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -603,11 +603,13 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 
 		flush_pmd_entry(p);
 	} else {
-		/*
-		 * No need to loop; pte's aren't interested in the
-		 * individual L1 entries.
-		 */
-		alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
+		unsigned long next;
+
+		do {
+			next = pmd_addr_end(addr, end);
+			alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys), type);
+			phys += next - addr;
+		} while (pmd++, addr = next, addr != end);
 	}
 }
 
-- 
1.7.9.5
