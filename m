From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] MAINTAINERS: add Kevin Hilman as the omap_device
 maintainer
Date: Sat, 9 Jul 2011 15:52:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091551350.15984@utopia.booyaka.com>
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
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org


Currently, plat-omap/omap_device.c is used as the interface between
the core Linux PM code (such as the system suspend and PM runtime
code) and the internal OMAP power management infrastructure (such as
the hwmod code, clockdomains, powerdomains, clocks, etc.)

Kevin's doing most of the interaction with the core Linux PM people on
this, so it makes sense for him to be the maintainer.

Later, if we add some omap_bus code and convert omap_device into a proper 
Linux device, I suggest that maintainership of this piece should return to 
Tony.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae563fa..4b5a5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4534,6 +4534,7 @@ M:	Kevin Hilman <khilman@ti.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
+F:	arch/arm/plat-omap/omap_device.c
 
 OMAP POWERDOMAIN/CLOCKDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Rajendra Nayak <rnayak@ti.com>
-- 
1.7.5.4
