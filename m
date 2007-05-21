From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] Clean up omap24xx.h symbolic constants
Date: Mon, 21 May 2007 16:59:23 -0600
Message-ID: <20070521225923.223790635@pwsan.com>
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

These patches clean up the symbolic constants defined in
include/asm-arm/arch-omap/omap24xx.h.  The names of some constants,
like OMAP24XX_SDRC_BASE, denote that their values are the same on all
OMAP24XX platforms.  This isn't so - the constant is defined to
different values depending on the Kconfig architecture parameters.
Also, we'd eventually like to create kernels that can be used on
both 2420 or 2430, with runtime CPU detection.  These types of
defines prevent that from happening.

Fix these defines by explicitly defining separate constants for both
architectures, when the values are different.  Use ifdefs to control
which value is assigned to the "base name" of the constant.

So, to continue the example above, the OMAP24XX_SDRC_BASE constant
will be removed, and replaced with two defines: OMAP2420_SDRC_BASE and
OMAP243X_SDRC_BASE.  Depending on which CONFIG_ARCH_OMAP* Kconfig
parameter is specified, we then set an OMAP_SDRC_BASE define to point
to one of the two architecture-specific values.

These patches are necessary prerequisites for the forthcoming PRCM
cleanup series.


- Paul

-- 
