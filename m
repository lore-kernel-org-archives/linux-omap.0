From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] ARM: OMAP: Fix typos in two comment lines in
 _omap_dm_timer_request()
Date: Tue, 3 Oct 2017 22:16:45 +0200
Message-ID: <fba4ace8-a277-fb08-7a6b-89d518ada080@users.sourceforge.net>
References: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b196ffac-4bd1-4465-cee9-e46b7405633d@users.sourceforge.net>
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
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 3 Oct 2017 21:24:00 +0200

Adjust three words in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-omap/dmtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 14779d6f425d..d443e481c3e9 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -254,8 +254,8 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 			if (cap == (t->capability & cap)) {
 				/*
 				 * If timer is not NULL, we have already found
-				 * one timer but it was not an exact match
-				 * because it had more capabilites that what
+				 * one timer. But it was not an exact match
+				 * because it had more capabilities than what
 				 * was required. Therefore, unreserve the last
 				 * timer found and see if this one is a better
 				 * match.
-- 
2.14.2
