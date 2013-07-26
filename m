From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv5 0/2] Add qspi controller
Date: Fri, 26 Jul 2013 22:45:20 +0530
Message-ID: <1374858922-14637-1-git-send-email-sourav.poddar@ti.com>
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
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, Sourav, Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series add support for ti qspi controller.

The previous version link is here:
https://lkml.org/lkml/2013/7/18/154

patch 1 of the previous version already picked.

Resending other two with comments fixed.

Sourav Poddar (2):
  drivers: spi: Add qspi flash controller
  driver: spi: Add quad spi read support

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   22 +
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-ti-qspi.c                         |  559 +++++++++++++++++++++
 4 files changed, 590 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 create mode 100644 drivers/spi/spi-ti-qspi.c


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
