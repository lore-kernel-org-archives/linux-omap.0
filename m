From: Andray Kaganovsky <andrayk@m-sys.com>
Subject: linux-2.6.14-omap2-v3.tgz won't compile for OMAP2420
Date: Wed, 27 Jun 2007 13:32:06 -0400
Message-ID: <1866982549.20070627133206@m-sys.com>
References: <1775705074.20070627125646@m-sys.com>
Reply-To: Andray Kaganovsky <andrayk@m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1775705074.20070627125646@m-sys.com>
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

Hello,

I got compilation errors when I tried to compile linux-2.6.14-omap2-v3.tgz
(from http://linux.omap.com/pub/kernel/2430sdp/source/ ) for OMAP2420
H4 board.

I did:

    make omap_h4_2420_defconfig
    make uImage
    
and I got:

arch/arm/mach-omap2/prcm_lib1.c: In function `prcm_set_idlemode_handshake':
arch/arm/mach-omap2/prcm_lib1.c:2133: error: `OMAP243X_CORE_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2133: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/prcm_lib1.c:2133: error: for each function it appears in.)
arch/arm/mach-omap2/prcm_lib1.c:2162: error: `OMAP243X_WAKEUP_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2225: error: `GPIO5_SYSCONFIG' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c: In function `prcm_wakeup_ctrl':
arch/arm/mach-omap2/prcm_lib1.c:2446: error: `OMAP243X_CORE_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2457: error: `GPIO5_SYSCONFIG' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c: In function `prcm_softreset_ctrl':
arch/arm/mach-omap2/prcm_lib1.c:2529: error: `OMAP243X_CORE_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2609: error: `OMAP243X_WAKEUP_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2704: error: `GPIO5_SYSCONFIG' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c: In function `prcm_autoidle_ctrl':
arch/arm/mach-omap2/prcm_lib1.c:2772: error: `OMAP243X_WAKEUP_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2781: error: `OMAP243X_CORE_L4_IO_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/prcm_lib1.c:2932: error: `GPIO5_SYSCONFIG' undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap2/prcm_lib1.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Where do I go from here ? I would appreciate any advice.

Thanks and regards,
Andray
