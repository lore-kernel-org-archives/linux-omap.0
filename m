From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/18] omap1: amsdelta: defconfig updates
Date: Wed, 05 May 2010 12:32:39 -0700
Message-ID: <20100505193239.21568.9650.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

The patch provides the following ams_delta_defconfig updates:
- explicitly select preemptable RCU,
- replace outdated CONFIG_LBD and CONFIG_LSF options with CONFIG_LBDAF,
- activate support for LCD contrast setting (new in 2.6.34),
- turn off verbose bug reporting for smaller kernel.

Created and tested against linux-2.6.34-rc3.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/ams_delta_defconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index ecf45fb..6d8a0c8 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -47,6 +47,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_TASKSTATS is not set
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+CONFIG_TREE_PREEMPT_RCU=y
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
@@ -95,9 +96,8 @@ CONFIG_KMOD=y
 # Block layer
 #
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -836,7 +836,8 @@ CONFIG_DAB=y
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
 
 #
 # Display device support
@@ -1284,7 +1285,7 @@ CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
