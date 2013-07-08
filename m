From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] spi changes and ti quad spi controller.
Date: Mon, 8 Jul 2013 19:12:57 +0530
Message-ID: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
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
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add support for calculating message length in spi framework.

Add support for quad spi controller.

Patch 2 of this series had been posted before. Sending along 
with the series along with ather propsed change.

Sourav Poddar (3):
  driver: spi: Modify core to compute the message length
  drivers: spi: Add qspi flash controller
  driver: spi: Add quad spi read support

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   22 +
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-ti-qspi.c                         |  489 +++++++++++++++++++++
 drivers/spi/spi.c                                 |    1 +
 include/linux/spi/spi.h                           |    1 +
 6 files changed, 522 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 create mode 100644 drivers/spi/spi-ti-qspi.c


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
