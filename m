From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] remoteproc for 3.7
Date: Thu, 4 Oct 2012 11:36:44 +0200
Message-ID: <CAK=Wgbb4uxRQPioho_sGZ2ycrfqzadLgnYQZfQMasRzfo6ohyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52509 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293Ab2JDJhF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 05:37:05 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so503300iea.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 02:37:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?ISO-8859-1?Q?Sjur_Br=E6ndeland?= <sjur.brandeland@stericsson.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, "Gutierrez, Juan" <jgutierrez@ti.com>, linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Emil Goode <emilgoode@gmail.com>

Hi Linus,

Please pull remoteproc 3.7 material, thanks.

PS - I recently found an annoying typo in the subject of one of the
patches, but I decided to accept it over doing a rebase.

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd0=
8217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-for-3.7

for you to fetch changes up to d09f53a735bae43806a77754312a45d3f1198342=
:

  remoteproc: Fix use of format specifyer (2012-10-02 10:14:43 +0200)

----------------------------------------------------------------
- Remoteproc Recovery - by Fernando Guzman Lugo - when a remote process=
or
  crash is detected, this mechanism will remove all virtio children
  devices, wait until their drivers let go, hard reset the remote
  processor and reload the firmware (resulting in the relevant virtio
  children devices re-added). Essentially the entire software stack
  is reset, together with the relevant hardware, so users don't have
  to reset the entire phone.
- STE Modem driver is added - by Sjur Br=E6ndeland
- OMAP DSP boot address support is added - by Juan Gutierrez
- A handful of fixes/cleanups - Sjur Br=E6ndeland, Dan Carpenter, Emil =
Goode

----------------------------------------------------------------
Dan Carpenter (3):
      remoteproc: snprintf() can return more than was printed
      remoteproc: return -EFAULT on copy_from_user failure
      remoteproc: fix a potential NULL-dereference on cleanup

Emil Goode (1):
      remoteproc: Fix use of format specifyer

=46ernando Guzman Lugo (3):
      remoteproc: add rproc_report_crash function to notify rproc crash=
es
      remoteproc: add actual recovery implementation
      remoteproc: create a 'recovery' debugfs entry

Juan Gutierrez (1):
      remoteproc/omap: set bootaddr support

Ohad Ben-Cohen (1):
      remoteproc: select VIRTIO to avoid build breakage

Sjur Br=E6ndeland (3):
      remoteproc: Add dependency to HAS_DMA
      remtoteproc: maintain max notifyid
      remoteproc: Add STE modem driver

 Documentation/remoteproc.txt                 |   7 +
 arch/arm/plat-omap/include/plat/remoteproc.h |   2 +
 drivers/remoteproc/Kconfig                   |  14 ++
 drivers/remoteproc/Makefile                  |   1 +
 drivers/remoteproc/omap_remoteproc.c         |   3 +
 drivers/remoteproc/remoteproc_core.c         | 209 +++++++++++++----
 drivers/remoteproc/remoteproc_debugfs.c      |  85 ++++++-
 drivers/remoteproc/remoteproc_internal.h     |   1 +
 drivers/remoteproc/ste_modem_rproc.c         | 322 +++++++++++++++++++=
++++++++
 include/linux/remoteproc.h                   |  24 ++
 include/linux/ste_modem_shm.h                |  56 +++++
 11 files changed, 682 insertions(+), 42 deletions(-)
 create mode 100644 drivers/remoteproc/ste_modem_rproc.c
 create mode 100644 include/linux/ste_modem_shm.h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
