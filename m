From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] omap: rx51: Set regulator V28_A always on
Date: Thu, 12 May 2011 14:28:22 +0300
Message-ID: <1305199703-32589-1-git-send-email-jhnikula@gmail.com>
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
To: linux-omap@vget.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The V28_A domain in Nokia N900 that supplies VDD voltages to TLV320AIC34 and
TPA6130A2 should not be shutdown. This is because otherwise there will be
leak from VIO to VDD in TLV320AIC34 and this leak consumes more battery
current that is saved from keeping V28_A off. With this patch the battery
current consumption is approximately 1.5 mA lower.

Thanks to Kalle Jokiniemi <kalle.jokiniemi@nokia.com> for noticing the issue.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index bbcb677..8242e99 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -464,6 +464,7 @@ static struct regulator_init_data rx51_vmmc2 = {
 		.name			= "V28_A",
 		.min_uV			= 2800000,
 		.max_uV			= 3000000,
+		.always_on		= true, /* due VIO leak to AIC34 VDDs */
 		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
-- 
1.7.4.4
