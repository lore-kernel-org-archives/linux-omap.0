From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] Immutable branch between MFD, GPIO, Input and Regulator
 due for the v4.10 merge window
Date: Wed, 26 Oct 2016 10:34:38 +0100
Message-ID: <20161026093438.GO8574@dell>
References: <1474270746-11568-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1474270746-11568-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input-regulator-v4.10

for you to fetch changes up to 2dc4940360d4c0c38aa9275532c7c0d7542f6258:

  regulator: tps65218: Remove all the compatibles (2016-10-26 10:30:39 +0100)

----------------------------------------------------------------
Immutable branch between MFD, GPIO, Input and Regulator due for the v4.10 merge window

----------------------------------------------------------------
Keerthy (5):
      mfd: tps65218: Remove redundant read wrapper
      Documentation: regulator: tps65218: Update examples
      input: tps65218-pwrbutton: Add platform_device_id table
      mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
      regulator: tps65218: Remove all the compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  87 +++++++++---
 drivers/gpio/gpio-tps65218.c                       |   3 +-
 drivers/input/misc/tps65218-pwrbutton.c            |   8 ++
 drivers/mfd/tps65218.c                             |  34 ++---
 drivers/regulator/tps65218-regulator.c             | 153 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   3 +-
 6 files changed, 157 insertions(+), 131 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
