From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH 0/4] staging: tidspbridge: various cleanups
Date: Fri, 22 Oct 2010 15:57:27 +0300
Message-ID: <1287752251-5847-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38988 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab0JVNDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 09:03:08 -0400
Received: by bwz11 with SMTP id 11so493616bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 06:03:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

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
these patches only fix the functions that were touched while switching
to struct list_head instead of struct lst_list.

Ionut Nicu (4):
  staging: tidspbridge: remove gs memory allocator
  staging: tidspbridge: remove utildefs
  staging: tidspbridge: remove gb bitmap implementation
  staging: tidspbridge: remove custom linked list

 drivers/staging/tidspbridge/Makefile               |    2 +-
 drivers/staging/tidspbridge/TODO                   |    1 -
 drivers/staging/tidspbridge/core/_msg_sm.h         |   12 +-
 drivers/staging/tidspbridge/core/chnl_sm.c         |  631 ++++++++----------
 drivers/staging/tidspbridge/core/io_sm.c           |  250 +++----
 drivers/staging/tidspbridge/core/msg_sm.c          |  600 +++++++----------
 drivers/staging/tidspbridge/gen/gb.c               |  166 -----
 drivers/staging/tidspbridge/gen/gh.c               |   38 +-
 drivers/staging/tidspbridge/gen/gs.c               |   88 ---
 .../tidspbridge/include/dspbridge/_chnl_sm.h       |    8 +-
 .../tidspbridge/include/dspbridge/cmmdefs.h        |    2 -
 drivers/staging/tidspbridge/include/dspbridge/gb.h |   79 ---
 drivers/staging/tidspbridge/include/dspbridge/gs.h |   59 --
 .../staging/tidspbridge/include/dspbridge/list.h   |  225 -------
 .../staging/tidspbridge/include/dspbridge/sync.h   |    1 +
 .../tidspbridge/include/dspbridge/utildefs.h       |   39 --
 drivers/staging/tidspbridge/pmgr/cmm.c             |  538 ++++++---------
 drivers/staging/tidspbridge/pmgr/dev.c             |   65 +--
 drivers/staging/tidspbridge/rmgr/drv.c             |  240 +++-----
 drivers/staging/tidspbridge/rmgr/node.c            |  702 +++++++++-----------
 drivers/staging/tidspbridge/rmgr/proc.c            |    3 +-
 drivers/staging/tidspbridge/rmgr/rmm.c             |  314 ++++------
 22 files changed, 1408 insertions(+), 2655 deletions(-)
 delete mode 100644 drivers/staging/tidspbridge/gen/gb.c
 delete mode 100644 drivers/staging/tidspbridge/gen/gs.c
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/gb.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/gs.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/list.h
 delete mode 100644 drivers/staging/tidspbridge/include/dspbridge/utildefs.h

-- 
1.7.2.3

