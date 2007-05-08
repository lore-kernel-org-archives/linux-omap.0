From: Kevin Hilman <khilman@mvista.com>
Subject: Re: ARM: OMAP: Select GENERIC_CLOCKEVENTS patch
Date: Tue, 08 May 2007 14:01:28 -0700
Message-ID: <1178658088.18074.25.camel@vence.hilman.org>
References: <5d5443650705080007v3bb5a154p6883082280e8de47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705080007v3bb5a154p6883082280e8de47@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, 2007-05-08 at 12:37 +0530, Trilok Soni wrote:

> "select GENERIC_CLOCKEVENTS" patch makes H4 build with default MPU
> timer selected to fail because timer_tick() is only available if
> CLOCKEVENTS is not defined.
> 
> Do we really need to select GENERIC_CLOCKEVENTS by default? Other
> solution is then to add !GENERIC_CLOCKEVENT as dependency in MPU_TIMER
> KConfig.

GENERIC_CLOCKEVENTS is not quite ready for OMAP2.  I will have it ready
in a week or so.  In the mean time, this patch will only enable
GENERIC_CLOCKEVENTS for OMAP1.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: dev/arch/arm/Kconfig
===================================================================
--- dev.orig/arch/arm/Kconfig
+++ dev/arch/arm/Kconfig
@@ -380,7 +380,6 @@ config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
 	select GENERIC_TIME
-	select GENERIC_CLOCKEVENTS
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
Index: dev/arch/arm/plat-omap/Kconfig
===================================================================
--- dev.orig/arch/arm/plat-omap/Kconfig
+++ dev/arch/arm/plat-omap/Kconfig
@@ -11,6 +11,7 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+	select GENERIC_CLOCKEVENTS
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
