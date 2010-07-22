From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 0/6] staging: tidspbridge: header cleanup series
Date: Thu, 22 Jul 2010 16:03:44 -0500
Message-ID: <1279832630-11517-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, devel@driverdev.osuosl.org, Guzman Lugo Fernando <fernando.lugo@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

Rebased version of the patches that couldn't be applied.

Original set:
[1] http://marc.info/?l=linux-kernel&m=127897548706686&w=2
[2] http://marc.info/?l=linux-kernel&m=127982129204138&w=2

Fixed unexpected change while replacing IN modifier
[3] http://marc.info/?l=linux-kernel&m=127972475532227&w=2

Menon, Nishanth (6):
  staging: tidspbridge: remove GlobalTypes.h
  staging: tidspbridge: replace CONST with c standard const
  staging: tidspbridge: remove IN modifier
  staging: tidspbridge: remove OPTIONAL
  staging: tidspbridge: remove OUT define
  staging: tidspbridge: remove dbdefs.h

 drivers/staging/tidspbridge/core/_tiomap_pwr.h     |   14 +-
 drivers/staging/tidspbridge/core/chnl_sm.c         |   20 +-
 drivers/staging/tidspbridge/core/dsp-clock.c       |    4 +-
 drivers/staging/tidspbridge/core/io_sm.c           |   26 +-
 drivers/staging/tidspbridge/core/msg_sm.c          |    6 +-
 drivers/staging/tidspbridge/core/tiomap3430.c      |   28 +-
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |   14 +-
 drivers/staging/tidspbridge/core/tiomap_io.c       |    6 +-
 drivers/staging/tidspbridge/core/tiomap_io.h       |   14 +-
 drivers/staging/tidspbridge/dynload/cload.c        |    2 +-
 .../tidspbridge/dynload/tramp_table_c6000.c        |    2 +-
 drivers/staging/tidspbridge/gen/uuidutil.c         |    6 +-
 drivers/staging/tidspbridge/hw/GlobalTypes.h       |  291 --------------------
 drivers/staging/tidspbridge/hw/MMURegAcM.h         |    1 -
 drivers/staging/tidspbridge/hw/hw_defs.h           |    2 -
 drivers/staging/tidspbridge/hw/hw_mmu.c            |   32 ---
 .../staging/tidspbridge/include/dspbridge/cfg.h    |   28 +-
 .../staging/tidspbridge/include/dspbridge/chnl.h   |    4 +-
 .../staging/tidspbridge/include/dspbridge/clk.h    |    4 +-
 .../staging/tidspbridge/include/dspbridge/cmm.h    |   14 +-
 .../staging/tidspbridge/include/dspbridge/cod.h    |   20 +-
 .../staging/tidspbridge/include/dspbridge/dbdcd.h  |   74 +++---
 .../tidspbridge/include/dspbridge/dbdcddef.h       |    6 +-
 .../staging/tidspbridge/include/dspbridge/dbdefs.h |    1 -
 .../staging/tidspbridge/include/dspbridge/dbtype.h |   69 -----
 .../staging/tidspbridge/include/dspbridge/dev.h    |   46 ++--
 .../staging/tidspbridge/include/dspbridge/disp.h   |    8 +-
 .../staging/tidspbridge/include/dspbridge/dmm.h    |    6 +-
 .../staging/tidspbridge/include/dspbridge/drv.h    |   12 +-
 .../tidspbridge/include/dspbridge/dspapi-ioctl.h   |    2 +-
 .../tidspbridge/include/dspbridge/dspchnl.h        |   16 +-
 .../tidspbridge/include/dspbridge/dspdefs.h        |   44 ++--
 .../staging/tidspbridge/include/dspbridge/dspdrv.h |    2 +-
 .../staging/tidspbridge/include/dspbridge/dspio.h  |    8 +-
 .../staging/tidspbridge/include/dspbridge/dspmsg.h |    6 +-
 .../tidspbridge/include/dspbridge/host_os.h        |    1 -
 drivers/staging/tidspbridge/include/dspbridge/io.h |    4 +-
 .../staging/tidspbridge/include/dspbridge/io_sm.h  |   10 +-
 .../staging/tidspbridge/include/dspbridge/mgr.h    |   16 +-
 .../staging/tidspbridge/include/dspbridge/msg.h    |    2 +-
 .../staging/tidspbridge/include/dspbridge/nldr.h   |   12 +-
 .../tidspbridge/include/dspbridge/nldrdefs.h       |   10 +-
 .../staging/tidspbridge/include/dspbridge/node.h   |   40 ++--
 .../tidspbridge/include/dspbridge/nodepriv.h       |    2 +-
 .../staging/tidspbridge/include/dspbridge/proc.h   |   18 +-
 .../staging/tidspbridge/include/dspbridge/pwr.h    |    8 +-
 .../staging/tidspbridge/include/dspbridge/strm.h   |   22 +-
 .../tidspbridge/include/dspbridge/uuidutil.h       |    6 +-
 drivers/staging/tidspbridge/pmgr/chnl.c            |    4 +-
 drivers/staging/tidspbridge/pmgr/cmm.c             |   14 +-
 drivers/staging/tidspbridge/pmgr/cod.c             |   18 +-
 drivers/staging/tidspbridge/pmgr/dev.c             |   36 ++--
 drivers/staging/tidspbridge/pmgr/dmm.c             |    6 +-
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    4 +-
 drivers/staging/tidspbridge/pmgr/io.c              |    4 +-
 drivers/staging/tidspbridge/pmgr/msg.c             |    2 +-
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |   94 ++++----
 drivers/staging/tidspbridge/rmgr/disp.c            |   10 +-
 drivers/staging/tidspbridge/rmgr/drv.c             |    6 +-
 drivers/staging/tidspbridge/rmgr/dspdrv.c          |    2 +-
 drivers/staging/tidspbridge/rmgr/mgr.c             |   14 +-
 drivers/staging/tidspbridge/rmgr/nldr.c            |   22 +-
 drivers/staging/tidspbridge/rmgr/node.c            |   44 ++--
 drivers/staging/tidspbridge/rmgr/proc.c            |   18 +-
 drivers/staging/tidspbridge/rmgr/pwr.c             |    8 +-
 drivers/staging/tidspbridge/rmgr/strm.c            |   18 +-
 drivers/staging/tidspbridge/services/cfg.c         |    8 +-
 67 files changed, 462 insertions(+), 859 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/hw/GlobalTypes.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/dbtype.h
