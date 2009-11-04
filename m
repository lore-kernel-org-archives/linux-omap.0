From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 0/2] new input keycodes, gpio-keys for RX-51
Date: Wed,  4 Nov 2009 17:13:56 +0200
Message-ID: <cover.1257345114.git.ext-jani.1.nikula@nokia.com>
References: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: james@mastros.biz, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Dmitry and Tony -

These patches expose some RX-51 input GPIO lines to user space through
gpio-keys, and introduce a few new relevant keycodes. Second round.

BR,
Jani.


Changes in v2:

 * SW_CAMERA_LENS_COVER typo fixed (thanks to James Mastros).

 * Use board-rx51-peripherals.c instead of board-rx51.c as suggested
   by Tony.

 * Merge rx51_defconfig change into patch 2/2 as suggested by Tony.


Jani Nikula (2):
  Input: add new keycodes useful in mobile devices
  ARM OMAP3: RX-51 board: add initialization of gpio keys

 arch/arm/configs/rx51_defconfig              |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   82 ++++++++++++++++++++++++++
 include/linux/input.h                        |    5 ++
 3 files changed, 88 insertions(+), 1 deletions(-)

