From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc for 3.10
Date: Tue, 7 May 2013 15:19:52 +0300
Message-ID: <CAK=WgbYBk=ut8M_Mn5hQ8V_b+gUijFz8RrOkyfKaC1Xk8p4+Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:52394 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758310Ab3EGMUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 May 2013 08:20:15 -0400
Received: by mail-la0-f43.google.com with SMTP id ea20so490465lab.16
        for <linux-omap@vger.kernel.org>; Tue, 07 May 2013 05:20:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjurbren@gmail.com>, "Tivy, Robert" <rtivy@ti.com>, =?ISO-8859-1?Q?Vincent_Stehl=E9?= <v-stehle@ti.com>, Suman Anna <s-anna@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

There's a trivial merge conflict with a Kconfig typo that got fixed
during the rc cycle,
but otherwise:

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b=
6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-3.10

for you to fetch changes up to b9777859ec015a78dae1476e317d04f851bfdd0d=
:

  remoteproc: fix kconfig dependencies for VIRTIO (2013-04-21 16:30:22 =
+0300)

----------------------------------------------------------------
This pull request contains:
- Some refactoring, cleanups and small improvements
  from Sjur Br=E6ndeland. The improvements are mainly
  about better supporting varios virtio properties
  (such as virtio's config space, status and features).
  I now see that I messed up while commiting one of Sjur's
  patches and erroneously put myself as the author, as well
  as letting a nasty typo sneak in. I will not fix this in
  order to avoid rebasing the patches. Sjur - sorry!
- A new remoteproc driver for OMAP-L13x (technically a
  DaVinci platform) from Robert Tivy.
- Extend OMAP support to OMAP5 as well, from Vincent Stehl=E9.
- Fix Kconfig VIRTUALIZATION dependency, from Suman Anna
  (a non-critical fix which arrived late during the rc cycle).

----------------------------------------------------------------
Ohad Ben-Cohen (1):
      remoteproc: perserve resource table data

Robert Tivy (2):
      remoteproc: support default firmware name in rproc_alloc()
      remoteproc/davinci: add a remoteproc driver for OMAP-L13x DSP

Sjur Br=E6ndeland (7):
      remoteproc: refactor rproc_elf_find_rsc_table()
      remoteproc: add find_loaded_rsc_table firmware ops
      remoteproc: parse STE-firmware and find resource table address
      remoteproc: code cleanup of resource parsing
      remoteproc: calculate max_notifyid by counting vrings
      remoteproc: support virtio config space.
      remoteproc: set vring addresses in resource table

Suman Anna (1):
      remoteproc: fix kconfig dependencies for VIRTIO

Vincent Stehl=E9 (1):
      remoteproc/omap: support OMAP5 too

 drivers/remoteproc/Kconfig                 |  27 ++-
 drivers/remoteproc/Makefile                |   1 +
 drivers/remoteproc/da8xx_remoteproc.c      | 324 +++++++++++++++++++++=
++++++++
 drivers/remoteproc/remoteproc_core.c       | 211 ++++++++++++-------
 drivers/remoteproc/remoteproc_elf_loader.c | 100 ++++++---
 drivers/remoteproc/remoteproc_internal.h   |  15 +-
 drivers/remoteproc/remoteproc_virtio.c     |  79 +++++--
 drivers/remoteproc/ste_modem_rproc.c       |  45 ++--
 include/linux/remoteproc.h                 |  13 +-
 9 files changed, 677 insertions(+), 138 deletions(-)
 create mode 100644 drivers/remoteproc/da8xx_remoteproc.c
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
