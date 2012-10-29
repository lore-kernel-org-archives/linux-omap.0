From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH 0/2] ARM: OMAP: mailbox out of plat code
Date: Mon, 29 Oct 2012 12:06:19 -0500
Message-ID: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, Juan Gutierrez <jgutierrez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>
List-Id: linux-omap@vger.kernel.org

From: Omar Ramirez Luna <omar.ramirez@copitl.com>

Move Mailbox's headers and driver out of platform code as
per current plat-omap cleanup activities.

While at it move mailbox code out of platform and to drivers/
folder, given that this is an OMAP specific framework, some people
might frown upon this, however it seemed worth to try to move it now.
I was expecting this could also pull out the mailbox code from
ux-500 platform, but the platform with a similar mailbox mechanism
has been deleted during 3.5 rc cycle.

So, are there any other mailbox-like drivers out there?

Omar Ramirez Luna (2):
  ARM: OMAP2+: move mailbox.h out of plat-omap headers
  mailbox: OMAP: introduce mailbox framework

 arch/arm/mach-omap2/mailbox.c                      |    2 +-
 arch/arm/plat-omap/Kconfig                         |   16 -
 arch/arm/plat-omap/Makefile                        |    3 -
 arch/arm/plat-omap/include/plat/mailbox.h          |  105 -----
 arch/arm/plat-omap/mailbox.c                       |  435 --------------------
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/mailbox/Kconfig                            |   28 ++
 drivers/mailbox/Makefile                           |    1 +
 drivers/mailbox/mailbox.c                          |  435 ++++++++++++++++++++
 .../tidspbridge/include/dspbridge/host_os.h        |    2 +-
 include/linux/platform_data/omap_mailbox.h         |  105 +++++
 12 files changed, 574 insertions(+), 561 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/mailbox.h
 delete mode 100644 arch/arm/plat-omap/mailbox.c
 create mode 100644 drivers/mailbox/Kconfig
 create mode 100644 drivers/mailbox/Makefile
 create mode 100644 drivers/mailbox/mailbox.c
 create mode 100644 include/linux/platform_data/omap_mailbox.h

-- 
1.7.9.5
