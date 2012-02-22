From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] adding rpmsg and remoteproc to 3.4
Date: Wed, 22 Feb 2012 19:14:54 +0200
Message-ID: <CAK=WgbZ2vfyiR0kXa4+-3y9etxQLBfD8b7QRR+r8VCpbOuBruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, "Grosen, Mark" <mgrosen@ti.com>, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>, akpm@linux-foundation.org, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "Shah, Bhavin" <bshah@ti.com>, Iliyan Malchev <malchev@google.com>, "Anna, Suman" <s-anna@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Loic PALLARDY <loic.pallardy@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, Ludovic BARRE <ludovic.barre@stericsson.com>, Michal Simek <monstr@monstr.eu>, "Clark, Rob" <rob@ti.com>, John Williams <john.williams@petalogix.com>, Saravana Kannan <skannan@co>
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

Please pull:

git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git rpmsg-for-3.4

To get the very basic rpmsg+remoteproc core functionality for 3.4.

This is basically the same stuff I sent for 3.3, with an additional
fix and cleanup which were reported by Grant (and of course the two
patches that fixed the 3.3 merge conflicts).

This entire patch set has been sitting in linux-next for quite some
time. I'm not sure if it'd conflict with your tree when you pull it,
but I can of course ask Stephen to remove my tree if things look ok to
you.

Please tell me if there are any problems,

Thanks a lot!
Ohad.

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
rpmsg-for-3.4

for you to fetch changes up to e12bc14b88d44e5c1456dccb59ff58103f6c6edc:

  remoteproc: s/big switch/lookup table/ (2012-02-22 18:28:49 +0200)

----------------------------------------------------------------
Adding the rpmsg and remoteproc frameworks, together with
several bug fixes and clean ups that were collected along the way.

Only very basic functionality is merged at this point (boot a remote
processor, possibly after configuring its iommu, and then be able to talk
with it).

And there's a small rpmsg driver sample that shows how easy it is
now to talk with a service running on a remote processor.

At this point only OMAP4 is supported (but note that we're not populating
OMAP's platform device yet, since it depends on CMA), but support for other
platforms is coming soon too.

----------------------------------------------------------------
Axel Lin (1):
      rpmsg: rename virtqueue_add_buf_gfp to virtqueue_add_buf

Mark Grosen (2):
      remoteproc: do not require an iommu
      remoteproc: avoid registering a virtio device if not supported

Ohad Ben-Cohen (16):
      remoteproc: add framework for controlling remote processors
      remoteproc: add debugfs entries
      remoteproc: create rpmsg virtio device
      remoteproc/omap: add a remoteproc driver for OMAP4
      rpmsg: add virtio-based remote processor messaging bus
      samples/rpmsg: add an rpmsg driver sample
      remoteproc: remove unused resource type
      remoteproc/omap: utilize module_platform_driver
      remoteproc: look for truncated firmware images
      remoteproc: add Kconfig menu
      rpmsg: add Kconfig menu
      remoteproc: depend on EXPERIMENTAL
      rpmsg: depend on EXPERIMENTAL
      remoteproc: don't use virtio's weak barriers
      remoteproc: bail out if firmware has different endianess
      remoteproc: s/big switch/lookup table/

 Documentation/ABI/testing/sysfs-bus-rpmsg    |   75 ++
 Documentation/remoteproc.txt                 |  324 ++++++
 Documentation/rpmsg.txt                      |  293 ++++++
 MAINTAINERS                                  |    7 +
 arch/arm/plat-omap/include/plat/remoteproc.h |   57 +
 drivers/Kconfig                              |    4 +
 drivers/Makefile                             |    2 +
 drivers/remoteproc/Kconfig                   |   29 +
 drivers/remoteproc/Makefile                  |    9 +
 drivers/remoteproc/omap_remoteproc.c         |  238 +++++
 drivers/remoteproc/omap_remoteproc.h         |   69 ++
 drivers/remoteproc/remoteproc_core.c         | 1450 ++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_debugfs.c      |  179 ++++
 drivers/remoteproc/remoteproc_internal.h     |   44 +
 drivers/remoteproc/remoteproc_rpmsg.c        |  299 ++++++
 drivers/rpmsg/Kconfig                        |   10 +
 drivers/rpmsg/Makefile                       |    1 +
 drivers/rpmsg/virtio_rpmsg_bus.c             | 1026 ++++++++++++++++++
 include/linux/mod_devicetable.h              |    9 +
 include/linux/remoteproc.h                   |  271 +++++
 include/linux/rpmsg.h                        |  326 ++++++
 include/linux/virtio_ids.h                   |    1 +
 samples/Kconfig                              |    8 +
 samples/Makefile                             |    2 +-
 samples/rpmsg/Makefile                       |    1 +
 samples/rpmsg/rpmsg_client_sample.c          |  100 ++
 26 files changed, 4833 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-rpmsg
 create mode 100644 Documentation/remoteproc.txt
 create mode 100644 Documentation/rpmsg.txt
 create mode 100644 arch/arm/plat-omap/include/plat/remoteproc.h
 create mode 100644 drivers/remoteproc/Kconfig
 create mode 100644 drivers/remoteproc/Makefile
 create mode 100644 drivers/remoteproc/omap_remoteproc.c
 create mode 100644 drivers/remoteproc/omap_remoteproc.h
 create mode 100644 drivers/remoteproc/remoteproc_core.c
 create mode 100644 drivers/remoteproc/remoteproc_debugfs.c
 create mode 100644 drivers/remoteproc/remoteproc_internal.h
 create mode 100644 drivers/remoteproc/remoteproc_rpmsg.c
 create mode 100644 drivers/rpmsg/Kconfig
 create mode 100644 drivers/rpmsg/Makefile
 create mode 100644 drivers/rpmsg/virtio_rpmsg_bus.c
 create mode 100644 include/linux/remoteproc.h
 create mode 100644 include/linux/rpmsg.h
 create mode 100644 samples/rpmsg/Makefile
 create mode 100644 samples/rpmsg/rpmsg_client_sample.c
