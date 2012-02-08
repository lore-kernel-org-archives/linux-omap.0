From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 14/16] ARM: omap: fix wrapped error messages in omap_hwmod.c
Date: Wed, 08 Feb 2012 16:40:30 +0000
Message-ID: <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
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
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

While trying to debug my OMAP platforms, they emitted this message:

omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state

The following backtrace said it was from a function called '_enable',
which didn't provide much clue.  Grepping didn't find it either.

The message is wrapped, so unwrap the message so grep can find it.  Do
the same for three other messages in this file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap_hwmod.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..eba6cd3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1517,8 +1517,8 @@ static int _enable(struct omap_hwmod *oh)
 	if (oh->_state != _HWMOD_STATE_INITIALIZED &&
 	    oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_DISABLED) {
-		WARN(1, "omap_hwmod: %s: enabled state can only be entered "
-		     "from initialized, idle, or disabled state\n", oh->name);
+		WARN(1, "omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state\n",
+			oh->name);
 		return -EINVAL;
 	}
 
@@ -1600,8 +1600,8 @@ static int _idle(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: idling\n", oh->name);
 
 	if (oh->_state != _HWMOD_STATE_ENABLED) {
-		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
-		     "enabled state\n", oh->name);
+		WARN(1, "omap_hwmod: %s: idle state can only be entered from enabled state\n",
+			oh->name);
 		return -EINVAL;
 	}
 
@@ -1682,8 +1682,8 @@ static int _shutdown(struct omap_hwmod *oh)
 
 	if (oh->_state != _HWMOD_STATE_IDLE &&
 	    oh->_state != _HWMOD_STATE_ENABLED) {
-		WARN(1, "omap_hwmod: %s: disabled state can only be entered "
-		     "from idle, or enabled state\n", oh->name);
+		WARN(1, "omap_hwmod: %s: disabled state can only be entered from idle, or enabled state\n",
+			oh->name);
 		return -EINVAL;
 	}
 
@@ -2240,8 +2240,8 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh)
 	BUG_ON(!oh);
 
 	if (!oh->class->sysc || !oh->class->sysc->sysc_flags) {
-		WARN(1, "omap_device: %s: OCP barrier impossible due to "
-		      "device configuration\n", oh->name);
+		WARN(1, "omap_device: %s: OCP barrier impossible due to device configuration\n",
+			oh->name);
 		return;
 	}
 
-- 
1.7.4.4
