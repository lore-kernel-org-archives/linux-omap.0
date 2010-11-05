From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 00/12] staging: tidspbridge: various cleanups
Date: Fri,  5 Nov 2010 17:13:04 +0200
Message-ID: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48253 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0KEPNy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:13:54 -0400
Received: by ywc21 with SMTP id 21so2204710ywc.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:13:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

This set of patches replaces some of the redundant components of
the tidspbridge driver, such as:

* wrapper functions for kmalloc/kfree
* custom bitmap implementation
* custom linked list implementation (list_head wrapper)

with the standard linux kernel interfaces.

The patches also do some code reorganization for increasing readability.
Most of the changes reduce the code indentation level and simplify the code.
No functional changes were done.

There are many places in this driver that need this kind of cleanup, but
these patches only fix the functions that were touched while converting
the code to use linux bitmap and list_head.

Changes since v1:

* Split the bitmap patch into multiple patches
* Split the list_head patch into multiple patches

Ionut Nicu (12):
  staging: tidspbridge: remove gs memory allocator
  staging: tidspbridge: remove utildefs
  staging: tidspbridge: switch to linux bitmap API
  staging: tidspbridge: remove gb bitmap implementation
  staging: tidspbridge: rmgr/node.c code cleanup
  staging: tidspbridge: convert core to list_head
  staging: tidspbridge: convert pmgr to list_head
  staging: tidspbridge: convert rmgr to list_head
  staging: tidspbridge: remove custom linked list
  staging: tidspbridge: core code cleanup
  staging: tidspbridge: pmgr code cleanup
  staging: tidspbridge: rmgr code cleanup

 drivers/staging/tidspbridge/Makefile               |    2 +-
 drivers/staging/tidspbridge/TODO                   |    1 -
 drivers/staging/tidspbridge/core/_msg_sm.h         |   12 +-
 drivers/staging/tidspbridge/core/chnl_sm.c         |  634 +++++++---------
 drivers/staging/tidspbridge/core/io_sm.c           |  266 +++----
 drivers/staging/tidspbridge/core/msg_sm.c          |  601 ++++++---------
 drivers/staging/tidspbridge/gen/gb.c               |  166 -----
 drivers/staging/tidspbridge/gen/gh.c               |   38 +-
 drivers/staging/tidspbridge/gen/gs.c               |   88 ---
 .../tidspbridge/include/dspbridge/_chnl_sm.h       |    8 +-
 .../tidspbridge/include/dspbridge/cmmdefs.h        |    1 -
 drivers/staging/tidspbridge/include/dspbridge/gb.h |   79 --
 drivers/staging/tidspbridge/include/dspbridge/gs.h |   59 --
 .../staging/tidspbridge/include/dspbridge/list.h   |  225 ------
 .../staging/tidspbridge/include/dspbridge/sync.h   |    1 +
 .../tidspbridge/include/dspbridge/utildefs.h       |   39 -
 drivers/staging/tidspbridge/pmgr/cmm.c             |  531 +++++---------
 drivers/staging/tidspbridge/pmgr/dev.c             |   73 +--
 drivers/staging/tidspbridge/rmgr/drv.c             |  238 ++----
 drivers/staging/tidspbridge/rmgr/node.c            |  773 +++++++++-----------
 drivers/staging/tidspbridge/rmgr/proc.c            |    2 -
 drivers/staging/tidspbridge/rmgr/rmm.c             |  313 ++++-----
 22 files changed, 1449 insertions(+), 2701 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/gen/gb.c
 delete mode 100644 drivers/staging/tidspbridge/gen/gs.c
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/gb.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/gs.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/list.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/utildefs.h

-- 
1.7.2.3

