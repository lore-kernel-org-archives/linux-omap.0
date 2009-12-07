From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Add spi100k driver and arch support
Date: Sun,  6 Dec 2009 20:48:16 -0800
Message-ID: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch set implements the spi100k driver we use in the linwizard
and wing-linux projects.  This SPI driver is used for many omap7xx
devices, particularly omap850 HTC smartphones.

The first patch is directed at the SPI subsystem mailing list primarily
for review.  The other two are directed primarily at linux-omap for
review.  All three are sent to both to preserve complete context for
all to see.

Cory Maccarrone (3):
  [SPI] [OMAP] Add OMAP spi100k driver
  [OMAP] Add spi100k configuration to OMAP1
  [OMAP] Add OMAP 7xx pin muxes for SPI

 arch/arm/mach-omap1/clock.c               |    4 +
 arch/arm/mach-omap1/devices.c             |   70 ++++
 arch/arm/mach-omap1/mux.c                 |    8 +
 arch/arm/plat-omap/include/plat/mux.h     |    8 +
 arch/arm/plat-omap/include/plat/omap7xx.h |    3 +
 arch/arm/plat-omap/include/plat/spi100k.h |   15 +
 drivers/spi/Kconfig                       |    6 +
 drivers/spi/Makefile                      |    1 +
 drivers/spi/omap_spi_100k.c               |  642 +++++++++++++++++++++++++++++
 9 files changed, 757 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/spi100k.h
 create mode 100644 drivers/spi/omap_spi_100k.c


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
