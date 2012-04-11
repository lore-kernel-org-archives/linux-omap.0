From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: arm: omap3: am35x: Powerdomain, EMIF4, etc. fixups
Date: Wed, 11 Apr 2012 12:05:35 -0700
Message-ID: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:49856 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761109Ab2DKTsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com

The am35x family of SoCs has several differences from
standard OMAP3 SoCs that haven't been accounted for in
Linux ARM code.  These differences include:

- There is no IVA.
- The device doesn't not support RETENTION & OFF
  power states.
- The SDRC *module* has an EMIF4 submodule instead
  of an SDRC submodule.

This series of patches tries to account for those changes.
They do the following:

- Prevent the cpu_idle thread and cpu_idle driver from
  sleeping because there are no I/O wake-ups to wake
  things back up again.
- Add a new cpu feature that indicates whether the device
  supports RETENTION & OFF power states.  Add code to
  support devices that only have INACTIVE & ON states.
- Add a parallel set of clockdomain dependencies that
  don't include the IVA.
- Add a new cpu feature that indicates whether the device
  has an EMIF4 or SDRC submodule of the SDRC module (the
  SDRC term/acronym is overloaded).  Add a minimal amount
  of code to support the EMIF4 submodule.
- Some miscellaneous patches to fix issues found while
  developing & testing the changes outlined above.

With these patches, the am3517 EVM boots and suspend-to-RAM
functions.  Unfortunately, though, after all of this, I still
can't manage to get the CORE power domain to enter the INACTIVE
state (at least according to /sys/kernel/debug/pm_debug/count
with debugfs mounted under /sys/kernel/debug).

The EMIF4 support is fairly minimal because there is an
EMIF driver working its way to mainline.  If more changes
are necessary, they can be made once the final version of
that driver is in mainline.

Please note that the SDRC submodule mapping is used by the
EMIF4 code.  They are at the same physical addresses and are
the same size so it works okay.  The reason I left the
mapping alone is because when those mappings are made, its
too early to use cpu_is_xxx() or omap3_has_sdrc_emif4() and
I didn't want to bloat the kernel with something that's
not strictly necessary.  I already have the code for the
separate mappings, so adding it in is easy, if that's
preferred.  I tried to make the mapping reuse clear with the
commit log and by adding a comment in am35xx_init_early().

These patches are based on the latest mainline kernel as
of this writing, commit 258f742635360175564e9470eb060ff4d4b984e7,
(modpost: Fix modpost license checking of vmlinux.o).  That
kernel with these patches was tested on an am35x EVM, am37x EVM,
and a Beagleboard-xM.  Testing included suspend-to-RAM
(i.e., "echo mem > /sys/power/state") with a rootfs mounted from
mmc and nfs (except for the Beagleboard-xM).

Mark
--
