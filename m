From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Add generic pinctrl helpers for managing groups and functions
Date: Tue, 25 Oct 2016 14:02:16 -0700
Message-ID: <20161025210221.9150-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some changes to add generic helpers for managing pinctrl groups and
functions.

Regards,

Tony


Tony Lindgren (5):
  pinctrl: core: Use delayed work for hogs
  pinctrl: core: Add generic pinctrl functions for managing groups
  pinctrl: core: Add generic pinctrl functions for managing groups
  pinctrl: single: Use generic pinctrl helpers for managing groups
  pinctrl: single: Use generic pinmux helpers for managing functions

 drivers/pinctrl/Kconfig          |  11 +-
 drivers/pinctrl/core.c           | 233 ++++++++++++++++++++++++++++---
 drivers/pinctrl/core.h           |  67 +++++++++
 drivers/pinctrl/pinctrl-single.c | 289 ++++-----------------------------------
 drivers/pinctrl/pinmux.c         | 173 +++++++++++++++++++++++
 drivers/pinctrl/pinmux.h         |  42 ++++++
 6 files changed, 532 insertions(+), 283 deletions(-)

-- 
2.9.3
