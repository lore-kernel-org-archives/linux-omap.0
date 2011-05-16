From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 01/19] Make clocksource name const
Date: Mon, 16 May 2011 18:25:54 +0100
Message-ID: <E1QM1YI-0003DJ-BQ@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

As nothing should be writing to the clocksource name string, make the
clocksource name pointer const.  Build-tested on ARM Versatile Express.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Colin Cross <ccross@android.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Erik Gilling <konkers@android.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Olof Johansson <olof@lixom.net>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/clocksource.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index c37b21a..94c1f38 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -161,7 +161,7 @@ struct clocksource {
 	/*
 	 * First part of structure is read mostly
 	 */
-	char *name;
+	const char *name;
 	struct list_head list;
 	int rating;
 	cycle_t (*read)(struct clocksource *cs);
-- 
1.7.4.4
