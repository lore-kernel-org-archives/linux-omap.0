From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/6] mfd: trivial demodularization of non-modular drivers.
Date: Mon, 4 Jul 2016 21:25:38 -0400
Message-ID: <20160705012544.14143-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Florian Lobmaier <florian.lobmaier@ams.com>, Laxman Dewangan <ldewangan@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Sourav Poddar <sourav.poddar@ti.com>, Thor Thayer <tthayer@opensource.altera.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I grouped this little series of mfd commits together because of the
common theme of their relatively trivial use of modular infrastructure
in these non-modular drivers.

What that means is there are no orphaned __exit functions to remove;
no unused ".remove" functions linked into the driver struct to be
deleted -- so in the end we have binary equivalence between the
pre-patched code and the post-patched code.

Easy to review and low risk as we approach the end of the development
window.  Seems like a good choice for sending at this point in time.

More specifically - the only thing we are doing here is mapping the
initcall that binds in the driver from the module variant to the
built-in variant ; something that CPP would do for us anyway -- and
then throwing away any MODULE_ tags which are no-ops in non-modular
builds (while preserving any author/desc. info they had in comments).
And in doing that, we can toss the include of module.h in favour of
init.h (asssuming it wasn't included already).

For anyone new to the underlying goal of this cleanup, we are trying to
make driver code consistent with the Makefiles/Kconfigs that control them.

This means not using modular functions/macros for drivers that can never
be built as a module.  Some of the other downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other drivers and spreads like weeds.

As usual, we can consider making some of these tristate if an author
has strong feelings about extending support into the modular realm,
but I won't be able to run-time test any of that.  And since I can't
even know if a modular use case makes sense, I won't extend the
functionality into the modular realm by default for anything.

Build tested on linux-next for arm, arm64 and x86-64 to ensure no typos
or similar issues crept in.

Paul.
---

Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Florian Lobmaier <florian.lobmaier@ams.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>
Cc: Thor Thayer <tthayer@opensource.altera.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Paul Gortmaker (6):
  mfd: altera-a10sr: make it explicitly non-modular
  mfd: as3722: Make it explicitly non-modular
  mfd: intel_msic: Make it explicitly non-modular
  mfd: smsc-ece1099: Make it explicitly non-modular
  mfd: sun6i-prcm: Make it explicitly non-modular
  mfd: twl-core: Make it explicitly non-modular

 drivers/mfd/altera-a10sr.c | 14 ++++++--------
 drivers/mfd/as3722.c       | 12 ++----------
 drivers/mfd/intel_msic.c   |  9 ++-------
 drivers/mfd/smsc-ece1099.c | 11 ++---------
 drivers/mfd/sun6i-prcm.c   |  8 ++------
 drivers/mfd/twl-core.c     |  9 +--------
 6 files changed, 15 insertions(+), 48 deletions(-)

-- 
2.8.4
