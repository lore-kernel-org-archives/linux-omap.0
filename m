From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 0/6] memory: remove modular usage from non-modular drivers
Date: Thu, 16 Jun 2016 20:37:42 -0400
Message-ID: <20160617003748.12188-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Roger Quadros <rogerq@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

It seems that drivers/memory/ doesn't have a single maintainer, so please
feel free to pick up just one or two patches from this as appropriate.

For anyone new to the underlying goal of this cleanup, we are trying to
not use module support for code that can never be built as a module since:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

Changes seen here cover the following categories:

  -just replacement of modular macros with their non-modular
   equivalents that CPP would have inserted anyway

  -the removal of including module.h ; replaced with init.h
   as required based on whether the file already had it.

  -the removal of any/all unused/orphaned __exit functions
   that would never be called/exercised.

  -the removal of any ".remove" functions that were hooked into
   the driver struct.   This ".remove" function would of
   course not be called from the __exit function since that was
   never run.  However in theory, someone could have triggered it
   via sysfs unbind, even though there isn't a sensible use case
   for doing so.  So to cover that possibility, we've also disabled
   sysfs unbind in these drivers.

There are no initcall level changes here; everything continues to
use the level of initcall it had before.  So no risk of regressions
from that exists here.

Build tested for several different key arch on a recent linux-next
tree to ensure no silly typos crept in.

 FAQ: Why not make it tristate?
 ------------------------------
Upon detecting a non-modular driver making modular references, I don't
immediately convert them to tristate, since it increases functionality
that I can't readily test, and it may not have a sensible use case (e.g.
in the case of core arch support relating to timer ticks or similar.)
So instead the modular references are removed w/o changing the existing
functionality by default.

However there is no reason the original author or an interested user
with the capability to test can't nominate a driver to be tristate
either as the original intent, or as a functional and tested use case.

Paul.
---

Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org

Paul Gortmaker (6):
  memory: atmel-sdramc: make it explicitly non-modular
  memory: mvebu-devbus: make it explicitly non-modular
  memory: omap-gpmc: make it explicitly non-modular
  memory: tegra20-mc: make it explicitly non-modular
  memory: samsung/exynos-srom: make it explicitly non-modular
  memory: atmel-ebi: make it explicitly non-modular

 drivers/memory/atmel-ebi.c           |  9 ++-------
 drivers/memory/atmel-sdramc.c        | 11 ++++-------
 drivers/memory/mvebu-devbus.c        | 11 ++++-------
 drivers/memory/omap-gpmc.c           | 10 ----------
 drivers/memory/samsung/exynos-srom.c | 21 +++------------------
 drivers/memory/tegra20-mc.c          | 11 ++++-------
 6 files changed, 17 insertions(+), 56 deletions(-)

-- 
2.8.4
