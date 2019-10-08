From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 06/11] ARM: OMAP2+: do not export am43xx_control functions
Date: Tue,  8 Oct 2019 13:34:48 +0100
Message-ID: <20191008123453.1651-6-ben.dooks@codethink.co.uk>
References: <20191008123453.1651-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191008123453.1651-1-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-omap@vger.kernel.org

Do not export am43xx_control_{save,restore}_context to avoid
the foloowing warnings:

arch/arm/mach-omap2/control.c:687:6: warning: symbol 'am43xx_control_save_context' was not declared. Should it be static?
arch/arm/mach-omap2/control.c:701:6: warning: symbol 'am43xx_control_restore_context' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap2/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c84b5e260617..73338cf80d76 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -684,7 +684,7 @@ static u32 am33xx_control_vals[ARRAY_SIZE(am43xx_control_reg_offsets)];
  *
  * Save the wkup domain registers
  */
-void am43xx_control_save_context(void)
+static void am43xx_control_save_context(void)
 {
 	int i;
 
@@ -698,7 +698,7 @@ void am43xx_control_save_context(void)
  *
  * Restore the wkup domain registers
  */
-void am43xx_control_restore_context(void)
+static void am43xx_control_restore_context(void)
 {
 	int i;
 
-- 
2.23.0
