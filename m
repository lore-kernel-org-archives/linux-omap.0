From: <jgq516@gmail.com>
Subject: [PATCH 2/3] OMAP: avoid build wdt platform device if with dt support
Date: Fri, 25 May 2012 18:42:31 +0800
Message-ID: <1337942552-28218-3-git-send-email-jgq516@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

If provided dt support, then skip add wdt platform device as usual.

Signed-off-by: Xiao Jiang <jgq516@gmail.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index ae62ece..80d7e3f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -759,7 +759,7 @@ static int __init omap_init_wdt(void)
 	char *oh_name = "wd_timer2";
 	char *dev_name = "omap_wdt";
 
-	if (!cpu_class_is_omap2())
+	if (!cpu_class_is_omap2() || of_have_populated_dt())
 		return 0;
 
 	oh = omap_hwmod_lookup(oh_name);
-- 
1.7.3
