From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] OMAP: Add temporary NOKIA_N810 machine type
Date: Fri, 23 Nov 2007 02:38:37 +0200
Message-ID: <1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch should be dropped once the official machine type
is available in the tree.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/tools/mach-types |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 71555a5..02fc824 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -16,6 +16,7 @@
 #
 # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
 #
+nokia_n810		MACH_NOKIA_N810		NOKIA_N810		5555
 ebsa110			ARCH_EBSA110		EBSA110			0
 riscpc			ARCH_RPC		RISCPC			1
 nexuspci		ARCH_NEXUSPCI		NEXUSPCI		3
-- 
1.5.3.4
