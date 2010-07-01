From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC 0/6] Introducing OMAP Remote Processor module
Date: Fri,  2 Jul 2010 01:23:08 +0300
Message-ID: <1278022994-28476-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39213 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518Ab0GAWXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 18:23:24 -0400
Received: by bwz1 with SMTP id 1so1212641bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Jul 2010 15:23:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

This is a preliminary version of OMAP's remoteproc module,
submitted for RFC purposes.

The purpose of the remoteproc module is to decouple
hw-specific code from generic IPC drivers (such as
dspbridge and syslink), in order to eventually make
those IPC drivers platform-independent.

Currently the supported operations are starting and stopping
the remote processor, but in the future additional functionality
might be added.

Both OMAP3 and OMAP4 are supported; OMAP3 supports the dsp
remote processor, and OMAP4 supports ducati (tesla support
is planned as well).

The code was tested on both OMAP3 (using dspbridge) and OMAP4
(using syslink).

The code is preliminary: we plan to add much more extensive
hwmod support, ideally squashing as much hw-specific code
as possible (including RST and PRCM manipulations).
In addition, a rebase to recent code bases is needed.

While dspbridge accesses remoteproc's interface via pdata
pointers, syslink accesses it from user space, via character
device interface, so both kernel and user space interfaces
are supported.

A few words on the char device interface:

* Each remote processor is represented by a different
  character device: /dev/omap-rproc0, /dev/omap-rproc1, ...
* A rproc character device can only be opened by a single user
  (e.g. the syslink daemon)
* The start/stop/get_state functionality is exposed via ioctl's
* We plan to add automatic stop() invokation in case the user
  closes the device after starting a remote processor (for
  resource cleanup purposes. Thus the user will be required
  to hold the device open as long as it lives).

Thanks,

Hari Kanigeri (1):
  omap: introduce OMAP4 remoteproc module

Ohad Ben-Cohen (5):
  omap: add iva2 hwmod support to omap3
  omap: introduce OMAP3 remoteproc module
  omap: introduce common remoteproc module
  omap: add remoteproc device(s)
  omap: enable remoteproc building

 arch/arm/mach-omap2/Makefile                 |    6 +
 arch/arm/mach-omap2/devices.c                |   86 +++++++
 arch/arm/mach-omap2/omap_hwmod_34xx.h        |   23 ++
 arch/arm/mach-omap2/remoteproc3xxx.c         |  226 ++++++++++++++++++
 arch/arm/mach-omap2/remoteproc44xx.c         |  196 ++++++++++++++++
 arch/arm/plat-omap/Kconfig                   |    7 +
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 arch/arm/plat-omap/include/plat/remoteproc.h |   75 ++++++
 arch/arm/plat-omap/remoteproc.c              |  316 ++++++++++++++++++++++++++
 10 files changed, 937 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/remoteproc3xxx.c
 create mode 100644 arch/arm/mach-omap2/remoteproc44xx.c
 create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
 create mode 100644 arch/arm/plat-omap/remoteproc.c

