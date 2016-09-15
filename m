From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Improve regmap support for more exotic devices
Date: Thu, 15 Sep 2016 13:56:09 -0700
Message-ID: <20160915205611.14046-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are few patches that make it possible to use little endian
SPI devices with regmap-spi without custom read or write
functions.

Regards,

Tony

Tony Lindgren (2):
  regmap: Allow longer flag masks for read and write
  regma: Add missing little endian functions

 drivers/base/regmap/internal.h |  4 ++--
 drivers/base/regmap/regmap.c   | 41 ++++++++++++++++++++++++++++-------------
 include/linux/regmap.h         |  8 ++++----
 3 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.9.3
