From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/14] Remove sysdev suspend/resume and shutdown operations
Date: Sun, 17 Apr 2011 23:01:53 +0200
Message-ID: <201104172301.54115.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57591 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab1DQVQA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 17 Apr 2011 17:16:00 -0400
In-Reply-To: <201103280125.11750.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Mike Frysinger <vapier@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Hi,

The following series of patches fixes bugs related to the introduction
of struct syscore_ops later in this cycle, replaces sysdev suspend/resume
operations in all of the architectures still using them with struct
syscore_ops-based PM callbacks and finally removes the suspend/resume
and shutdown operations from struct sysdev_class and struct sysdev_driver.

Patches [1/14] and [2/14] are important bug fixes targeted at 2.6.39.
The remaining patches are regareded as 2.6.40 material, but I'd like to
put them into linux-next shortly, if there are no objections, to catch
problems that they may introduce before they hit the mainline.  Again,
if there are no objections I'd like to merge these patches through the
suspend-2.6 tree.

[1/14] - Fix error code paths executed after failing syscore_suspend()
[2/14] - Add missing syscore_suspend() and syscore_resume() calls to
         subsystems that should use them in addition to sysdev calls.

[3/14] - Use struct syscore_ops for core PM (instead of sysdevs) in the
         common ARM code.
[4/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM OMAP
         code.
[5/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM
         Integrator code.
[6/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM SA1100
         code.
[7/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM PXA
         code.
[8/14] - Use struct syscore_ops for core PM (instead of sysdevs) in ARM Samsung
         code.
[9/14] - Use struct syscore_ops for core PM (instead of sysdevs) in Blackfin
         arch code.
[10/14] - Use struct syscore_ops for core PM (instead of sysdevs) in MIPS
         arch code.
[11/14] - Use struct syscore_ops for core PM (instead of sysdevs) in AVR32
         arch code.
[12/14] - Use struct syscore_ops for core PM (instead of sysdevs) in Unicore32
         arch code.
[13/14] - Use struct syscore_ops for core PM (instead of sysdevs) in PowerPC
         arch code.
[14/14] - Remove sysdev suspend/resume and shutdown operations.

Thanks,
Rafael

