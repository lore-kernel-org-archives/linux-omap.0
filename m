From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 00/10] staging:ti dspbridge: Remove DSP_FAILED and DSP_SUCCEEDED macros
Date: Wed, 28 Jul 2010 09:45:23 -0500
Message-ID: <1280328333-31336-1-git-send-email-ernesto@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org, Ernesto Ramos <ernesto@ti.com>
List-Id: linux-omap@vger.kernel.org

This series of patches is targetted to remove macros DSP_FAILED
and DSP_SUCCEEDED since bridge driver currently uses standard kernel
error codes.

Ernesto Ramos (10):
  staging:ti dspbridge: remove DSP_SUCCEEDED macro from core
  staging:ti dspbridge: remove DSP_SUCCEEDED macro from pmgr
  staging:ti dspbridge: remove DSP_SUCCEEDED macro from rmgr
  staging:ti dspbridge: remove DSP_SUCCEEDED macro from services
  staging:ti dspbridge: remove DSP_SUCCEEDED macro definition
  staging:ti dspbridge: remove DSP_FAILED macro from core
  staging:ti dspbridge: remove DSP_FAILED macro from pmgr
  staging:ti dspbridge: remove DSP_FAILED macro from rmgr
  staging:ti dspbridge: remove DSP_FAILED macro from services
  staging:ti dspbridge: remove DSP_FAILED macro definition

 drivers/staging/tidspbridge/core/chnl_sm.c         |   42 ++--
 drivers/staging/tidspbridge/core/dsp-clock.c       |    4 +-
 drivers/staging/tidspbridge/core/io_sm.c           |  111 +++++-----
 drivers/staging/tidspbridge/core/msg_sm.c          |   26 ++--
 drivers/staging/tidspbridge/core/tiomap3430.c      |   61 +++---
 drivers/staging/tidspbridge/core/tiomap3430_pwr.c  |    8 +-
 drivers/staging/tidspbridge/core/tiomap_io.c       |   41 ++--
 .../staging/tidspbridge/include/dspbridge/dbdefs.h |    4 -
 drivers/staging/tidspbridge/pmgr/chnl.c            |   10 +-
 drivers/staging/tidspbridge/pmgr/cmm.c             |  137 ++++++-------
 drivers/staging/tidspbridge/pmgr/cod.c             |   18 +-
 drivers/staging/tidspbridge/pmgr/dbll.c            |   32 ++--
 drivers/staging/tidspbridge/pmgr/dev.c             |   79 +++----
 drivers/staging/tidspbridge/pmgr/dmm.c             |   12 +-
 drivers/staging/tidspbridge/pmgr/dspapi.c          |   82 ++++----
 drivers/staging/tidspbridge/pmgr/io.c              |    4 +-
 drivers/staging/tidspbridge/pmgr/msg.c             |    2 +-
 drivers/staging/tidspbridge/rmgr/dbdcd.c           |   48 ++--
 drivers/staging/tidspbridge/rmgr/disp.c            |   62 +++---
 drivers/staging/tidspbridge/rmgr/drv.c             |   39 ++--
 drivers/staging/tidspbridge/rmgr/drv_interface.c   |   10 +-
 drivers/staging/tidspbridge/rmgr/dspdrv.c          |   16 +-
 drivers/staging/tidspbridge/rmgr/mgr.c             |   32 ++--
 drivers/staging/tidspbridge/rmgr/nldr.c            |  106 +++++-----
 drivers/staging/tidspbridge/rmgr/node.c            |  224 ++++++++++----------
 drivers/staging/tidspbridge/rmgr/proc.c            |  137 ++++++------
 drivers/staging/tidspbridge/rmgr/pwr.c             |   26 +--
 drivers/staging/tidspbridge/rmgr/rmm.c             |   12 +-
 drivers/staging/tidspbridge/rmgr/strm.c            |   75 ++++----
 drivers/staging/tidspbridge/services/cfg.c         |   21 +-
 30 files changed, 710 insertions(+), 771 deletions(-)
