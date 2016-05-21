From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0108/1529] Fix typo
Date: Sat, 21 May 2016 13:50:32 +0200
Message-ID: <20160521115032.4966-1-andrea.gelmini@gelma.net>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andrea.gelmini@gelma.net
Cc: tony@atomide.com, linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/sdrc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 645a2a4..f115006 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -175,8 +175,8 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
  * don't adjust it down as your clock period increases the refresh interval
  * will not be met. Setting all parameters for complete worst case may work,
  * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
+ * unlocked and their value needs run time calibration. A dynamic call is
+ * need for that as no single right value exists across production samples.
  *
  * Only the FULL speed values are given. Current code is such that rate
  * changes must be made at DPLLoutx2. The actual value adjustment for low
-- 
2.8.2.534.g1f66975
