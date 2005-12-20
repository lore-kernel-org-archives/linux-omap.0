From: "George G. Davis" <gdavis@mvista.com>
Subject: [PATCH] Disable DEBUG_LL in omap_h3_1710_defconfig
Date: Tue, 20 Dec 2005 12:53:41 -0500
Message-ID: <20051220175341.GY435@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Greetings,

Some folks have reported "serial console corruption" issues when using
the current omap_h3_1710_defconfig due to CONFIG_DEBUG_LL=y. This patch
disables CONFIG_DEBUG_LL since it's rarely required and only serves to
confuse some folks when they observe "serial console corruption"
while using the defconfig:

Index: linux-omap-2.6.git/arch/arm/configs/omap_h3_1710_defconfig
===================================================================
--- linux-omap-2.6.git.orig/arch/arm/configs/omap_h3_1710_defconfig
+++ linux-omap-2.6.git/arch/arm/configs/omap_h3_1710_defconfig
@@ -1021,7 +1021,7 @@ CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_WAITQ is not set
 CONFIG_DEBUG_ERRORS=y
-CONFIG_DEBUG_LL=y
+# CONFIG_DEBUG_LL is not set
 # CONFIG_DEBUG_ICEDCC is not set
 
 #


Please apply. TIA!

--
Regards,
George
