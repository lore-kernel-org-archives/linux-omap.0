From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2 0/5] Add generic pinctrl helpers for managing groups and function
Date: Tue, 27 Dec 2016 09:19:58 -0800
Message-ID: <20161227172003.6517-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some changes to add generic helpers for managing pinctrl groups and
functions.

Regards,

Tony

Changes since v1:

- Updates to the first patch in the series to use delayed work for pinctrl
  hogs based on what was discussed on the mailing list, mostly to pass
  pctldev to the parsers and add pinctrl_dt_has_hogs() check

Tony Lindgren (5):
  pinctrl: core: Use delayed work for hogs
  pinctrl: core: Add generic pinctrl functions for managing groups
  pinctrl: core: Add generic pinctrl functions for managing groups
  pinctrl: single: Use generic pinctrl helpers for managing groups
  pinctrl: single: Use generic pinmux helpers for managing functions

 drivers/pinctrl/Kconfig          |  11 +-
 drivers/pinctrl/core.c           | 270 +++++++++++++++++++++++++++++++-----
 drivers/pinctrl/core.h           |  67 +++++++++
 drivers/pinctrl/devicetree.c     |  28 +++-
 drivers/pinctrl/devicetree.h     |  12 +-
 drivers/pinctrl/pinctrl-single.c | 290 ++++-----------------------------------
 drivers/pinctrl/pinmux.c         | 173 +++++++++++++++++++++++
 drivers/pinctrl/pinmux.h         |  42 ++++++
 8 files changed, 591 insertions(+), 302 deletions(-)

-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
