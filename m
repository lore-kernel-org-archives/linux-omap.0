From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH 0/3] new input keycodes, gpio-keys for RX-51
Date: Fri, 30 Oct 2009 15:38:25 +0200
Message-ID: <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
References: <20091027162040.GB22541@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20091027162040.GB22541@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: tony@atomide.com, dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org, ext-jani.1.nikula@nokia.com
List-Id: linux-omap@vger.kernel.org

Hi Dmitry and Tony -

These patches expose some RX-51 input GPIO lines to user space through
gpio-keys, and introduce a few new relevant keycodes.

Dmitry, I hope you don't think I'm being too stubborn, but I'd prefer
SW_FRONT_PROXIMITY over SW_EARPIECE_MODE. IMHO front proximity
activation describes better what has actually occured; earpiece mode
is just one use case for that. The front proximity sensor can be
activated by for example shoving the device in pocket or placing it
upside down on a surface (an actual use case with accelerometer) in
addition to holding the device against your ear. And I know of at
least one game that uses the said proximity sensor as fire
button. Anyway, in the end it's your call, and I can change it if
necessary.

These have been tested with RX-51, vanilla linux-omap, minimal console
and evtest.


BR,
Jani.


Jani Nikula (3):
  Input: add new keycodes useful in mobile devices
  ARM OMAP3: RX-51 board: add initialization of gpio keys
  ARM OMAP3: rx51_defconfig: enable support for gpio keys

 arch/arm/configs/rx51_defconfig  |    2 +-
 arch/arm/mach-omap2/board-rx51.c |   84 ++++++++++++++++++++++++++++++++++++++
 include/linux/input.h            |    5 ++
 3 files changed, 90 insertions(+), 1 deletions(-)

