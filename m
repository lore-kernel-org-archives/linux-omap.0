From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 57/66] arch/arm/plat-omap/include/plat/blizzard.h: Checkpatch
	cleanup
Date: Sat, 27 Feb 2010 17:51:38 +0100
Message-ID: <1267289508-31031-58-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Andrea Gelmini <andrea.gelmini@gelma.net>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

arch/arm/plat-omap/include/plat/blizzard.h:9: ERROR: spaces prohibited around that ':' (ctx:WxW)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/plat-omap/include/plat/blizzard.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/blizzard.h b/arch/arm/plat-omap/include/plat/blizzard.h
index 8d160f1..56e7f2e 100644
--- a/arch/arm/plat-omap/include/plat/blizzard.h
+++ b/arch/arm/plat-omap/include/plat/blizzard.h
@@ -6,7 +6,7 @@ struct blizzard_platform_data {
 	void		(*power_down)(struct device *dev);
 	unsigned long	(*get_clock_rate)(struct device *dev);
 
-	unsigned	te_connected : 1;
+	unsigned	te_connected:1;
 };
 
 #endif
-- 
1.7.0.90.g251a4
