From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/4] [input] tsc2005 cleanup
Date: Wed, 15 Jul 2015 14:13:24 +0200
Message-ID: <1436962408-5206-1-git-send-email-sre@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

The following patches simplify and cleanup the tsc2005 touchscreen driver.
Apart from making the driver more readable, the direct usage of SPI has been
reduced to one function, so that tsc2004 support may be addable now (see [0]).

The driver could be further simplified by making the vio regulator also
mandatory for boardcode and switching boardcode from set_reset callback
to GPIOD API. Since that would result in a patch touching the ARM and
the input subsystem, I suggest to wait until the Nokia N900 boardcode
is gone.

[0] http://permalink.gmane.org/gmane.linux.kernel.input/37513

-- Sebastian

Sebastian Reichel (4):
  Input: tsc2005 - improve readability of register defines
  Input: tsc2005 - convert to regmap
  Input: tsc2005 - simplify drvdata acquisition
  Input: tsc2005 - convert to gpiod

 drivers/input/touchscreen/tsc2005.c | 235 ++++++++++++++----------------------
 1 file changed, 88 insertions(+), 147 deletions(-)

-- 
2.1.4

