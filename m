From: Laurent Navet <laurent.navet@gmail.com>
Subject: GPIO - Fix checkpatch errors
Date: Wed, 20 Mar 2013 13:15:54 +0100
Message-ID: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This series fix almost all checkpatch errors in drivers/gpio/

 drivers/gpio/gpio-mvebu.c      |   26 +++++++++++++-------------
 drivers/gpio/gpio-omap.c       |    2 +-
 drivers/gpio/gpio-pca953x.c    |    3 +--
 drivers/gpio/gpio-pxa.c        |    4 ++--
 drivers/gpio/gpio-sch.c        |   74 +++++++++++++++++++++++++++++++++++---------------------------------------
 drivers/gpio/gpio-stp-xway.c   |    2 +-
 drivers/gpio/gpio-tc3589x.c    |    8 ++++----
 drivers/gpio/gpio-timberdale.c |    3 +--
 drivers/gpio/gpio-tps65910.c   |    2 +-
 drivers/gpio/gpiolib-of.c      |    2 +-
 10 files changed, 60 insertions(+), 66 deletions(-)

Regards,
Laurent Navet.
