From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/7] ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate
 only valid clkdms
Date: Fri, 22 Aug 2014 08:49:29 -0500
Message-ID: <1408715373-25791-4-git-send-email-nm@ti.com>
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

No need to invoke callback when the clkdm pointer is NULL.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index faebd5f..f391948 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -546,7 +546,8 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 		return -EINVAL;
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
-		ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
+		if (pwrdm->pwrdm_clkdms[i])
+			ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
 
 	return ret;
 }
-- 
1.7.9.5
