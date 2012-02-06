From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH 0/4] staging: tidspbridge: remove desgin-by-contract macros
Date: Tue,  7 Feb 2012 00:39:33 +0100
Message-ID: <cover.1328563908.git.vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
List-Id: linux-omap@vger.kernel.org

These patches removes all the design-by-contract (DBC) macros in the
tidspbridge.

Also it removes the config option CONFIG_TIDSPBRIDGE_DEBUG.

The patches are applied above these submitted patches:
http://thread.gmane.org/gmane.linux.kernel/1246081

The main reasons to remove these DBC macros are

* The kernel in general doesn't follow the DBC approach

* They only provide a needless verbosity, since they are available only
  when CONFIG_TIDSPBRIDGE_DEBUG is enabled. If they were useful they
  should be left for the dynamic debugging always. So, if they are not
  used, is dead code at the end, and should be removed.

* Deleting them means less code to maintain

As the Emperor Joseph II told to Mozart in the motion picture Amadeus:
"It's quality work. And there are simply too many notes, that's
all. Just cut a few and it will be perfect."

vmjl


V=C3=ADctor Manuel J=C3=A1quez Leal (4):
  staging: tidspbridge: remove DBC_ENSURE and DBC_REQUIRED
  staging: tidspbridge: remove DBC_ASSERT macro
  staging: tidspbridge: remove dbc.h
  staging: tidspbridge: remove CONFIG_TIDSPBRIDGE_DEBUG

 drivers/staging/tidspbridge/Kconfig                |    6 -
 drivers/staging/tidspbridge/core/chnl_sm.c         |   34 +-----
 drivers/staging/tidspbridge/core/dsp-clock.c       |    3 -
 drivers/staging/tidspbridge/core/io_sm.c           |   29 +----
 drivers/staging/tidspbridge/core/msg_sm.c          |    3 -
 drivers/staging/tidspbridge/core/tiomap3430.c      |    9 --
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |    1 -
 drivers/staging/tidspbridge/core/tiomap_io.c       |   18 ---
 drivers/staging/tidspbridge/gen/uuidutil.c         |    7 -
 .../staging/tidspbridge/include/dspbridge/dbc.h    |   46 -------
 .../staging/tidspbridge/include/dspbridge/io_sm.h  |    2 -
 drivers/staging/tidspbridge/pmgr/chnl.c            |   19 ---
 drivers/staging/tidspbridge/pmgr/cmm.c             |   68 +----------
 drivers/staging/tidspbridge/pmgr/cod.c             |   74 -----------
 drivers/staging/tidspbridge/pmgr/dbll.c            |  113 +-----------=
------
 drivers/staging/tidspbridge/pmgr/dev.c             |  132 ------------=
--------
 drivers/staging/tidspbridge/pmgr/dmm.c             |   14 --
 drivers/staging/tidspbridge/pmgr/dspapi.c          |    7 -
 drivers/staging/tidspbridge/pmgr/io.c              |   17 ---
 drivers/staging/tidspbridge/pmgr/msg.c             |   17 ---
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |   88 ------------=
-
 drivers/staging/tidspbridge/rmgr/disp.c            |   44 -------
 drivers/staging/tidspbridge/rmgr/drv.c             |   48 -------
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |    6 -
 drivers/staging/tidspbridge/rmgr/dspdrv.c          |    5 -
 drivers/staging/tidspbridge/rmgr/mgr.c             |   36 ------
 drivers/staging/tidspbridge/rmgr/nldr.c            |   71 -----------
 drivers/staging/tidspbridge/rmgr/node.c            |   98 ------------=
---
 drivers/staging/tidspbridge/rmgr/proc.c            |   91 ------------=
--
 drivers/staging/tidspbridge/rmgr/rmm.c             |   36 ------
 drivers/staging/tidspbridge/rmgr/strm.c            |   86 +-----------=
--
 31 files changed, 11 insertions(+), 1217 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/dbc.h

--=20
1.7.8.3
