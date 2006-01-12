From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: build error on Linux-2.6.15-omap1
Date: Thu, 12 Jan 2006 13:51:42 +0900 (JST)
Message-ID: <20060112.135142.74755663.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,

I'm building linux 2.6.15, and applied Linux-2.6.15-omap1.
When I tried to build for OSK5912, with CONFIG_PM=y (this is default),
following error was emitted.

--
make[2]: *** No rule to make target `arch/arm/mach-omap1/pm.o', needed by `arch/arm/mach-omap1/built-in.o'.  Stop.
make[1]: *** [arch/arm/mach-omap1] Error 2
--

I'm not sure which is better way to fix,

1) mv pm.c (and Sleep.S) from plat-omap/ to mach-omap1/, or
2) move `obj-$(CONFIG_PM) += pm.o sleep.o' line from mach-omap1/Makefile to
   plat-omap/Makefile


Best Regards,

HK.
--
