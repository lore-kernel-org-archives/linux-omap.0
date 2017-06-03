From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/9] ARM: OMAP2+: Delete an error message for a failed memory
 allocation in two functions
Date: Sat, 3 Jun 2017 20:28:30 +0200
Message-ID: <9e8c21ba-0c34-7a7b-2583-59d7a8c19af6@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 17:24:27 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/hsmmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index cb754c46747e..be517b048762 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -155,5 +155,4 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	if (!hc_name) {
-		pr_err("Cannot allocate memory for controller slot name\n");
 		kfree(hc_name);
 		return -ENOMEM;
 	}
@@ -318,7 +317,5 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
-	if (!mmc_data) {
-		pr_err("Cannot allocate memory for mmc device!\n");
+	if (!mmc_data)
 		return;
-	}
 
 	res = omap_hsmmc_pdata_init(hsmmcinfo, mmc_data);
 	if (res < 0)
-- 
2.13.0
