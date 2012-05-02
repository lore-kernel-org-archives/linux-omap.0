From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4-alt 0/6] GPMC driver migrate one
Date: Wed, 2 May 2012 14:15:19 +0530
Message-ID: <cover.1335941443.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34079 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319Ab2EBJCH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:02:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Afzal Mohammed <afzal@ti.com>

Hi Tony,

As you would have already seen, v4 of GPMC driver conversion has been
posted (this is v4-alt). I undertand the risk involved in converting
all board files to use new interface in a single patch series. But to
have a decent set of patches, I feel this is required. But this may
bring us to a point where GPMC may not work on some boards.

To resolve this and as per your earlier question on whether old along
with new interface can be made to work parallely, here is suggestion
from my end to deal with it.

This series converts to driver, as an example provides new interface
for smsc911x, while keeping the old interface. As an example omap3evm
has been tested. With this patch series omap3evm will work with new
interface, and if 6/6 is not included, it will work with old
interface. But this necessitates some ugly patches which are present
in this series.

So the suggestion is, enhance v4-alt to handle new interface parallely
for others (GPMC peripherals & boards), hence creating vX-alt (I will
do it if you feel is required, but have not proceeded too much in this
dierction as of now as not sure whether you want to take this path),
have vX-alt in one of your branches, also preferably merged to master,
have the original series also in a separate branch. Let all the boards
be tested, by those who have (I have only omap3evm, beagle board that
is supported in mainline, in addition to beaglebone, am335x evm, but
these won't boot on mainline), add fixes due to problems on
boards (if), incorporate review comments onto vX-alt branch, once we
are sure that all boards work, revert hacks in vX-alt branch and
finally revise proper v4 to vX having decent set of patches such that,

git diff vX-alt..vX is zero.

If with v4 directly, all boards work properly, we may not have to
go through all these, but I realize, that may not happen in the first
try itself. But I am not so pessimistic though, as all the test were
initially done on omap3evm (SMSC911x, NAND & OneNAND, last two were
tested using private patches on new & old omap3evm), and upon adding
board modification for beagleboard, NAND directly worked, in addition
to the surprise that HWMOD on OMAP3 did work properly first time.

I would prefer directly using single patch series for converting all
the boards, but if you prefer an alternative path to be on safer side,
above is my suggestion, or if you have any other plans, let me know.

Please let me know whether you are fine in taking patch series
as in v4 (that converts all boards at once, with further revisions
based on review comments).

Both v4 & v4-alt series are available as tags gpmc-v4 & gpmc-v4-alt,
repectively @git://gitorious.org/x0148406-public/linux-kernel.git

Regards
Afzal


Afzal Mohammed (6):
  ARM: OMAP2+: gpmc: driver conversion
  ARM: OMAP2+: gpmc: Adapt to HWMOD
  ARM: OMAP3: hwmod data: add gpmc
  ARM: OMAP2+: gpmc: driver migration hack
  ARM: OMAP2+: gpmc-smsc911x: Add helper for driver conversion
  ARM: OMAP2+: board omap3evm: gpmc driver adaptation

 arch/arm/mach-omap2/board-omap3evm.c            |   14 +-
 arch/arm/mach-omap2/gpmc-smsc911x.c             |   70 ++
 arch/arm/mach-omap2/gpmc.c                      |  951 ++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |   52 ++
 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    9 +
 arch/arm/plat-omap/include/plat/gpmc.h          |   94 ++-
 6 files changed, 1078 insertions(+), 112 deletions(-)

-- 
1.7.10

