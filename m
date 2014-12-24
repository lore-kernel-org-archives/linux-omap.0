From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/3] Convert omap_hsmmc to use common devicetree parsing
 code.
Date: Thu, 25 Dec 2014 08:20:51 +1100
Message-ID: <20141224211653.30499.46669.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This is a resend against latest
  git://git.linaro.org/people/ulf.hansson/mmc next

with requested changes.

My goal is to get omap_hsmmc to use the common code for parsing of,
particularly so that I can set "cap-power-off-card", which omap_hsmmc
doesn't explicitly report.

Thanks,
NeilBrown



---

NeilBrown (3):
      mmc: core: Allow host driver to provide isr for card-detect interrupts.
      mmc: omap_hsmmc: use slot-gpio library for gpio support.
      mmc: omap_hsmmc: use mmc_of_parse to parse common mmc configuration.


 drivers/mmc/core/slot-gpio.c  |   20 ++++++++
 drivers/mmc/host/omap_hsmmc.c |  100 +++++++++--------------------------------
 include/linux/mmc/slot-gpio.h |    2 +
 3 files changed, 43 insertions(+), 79 deletions(-)

--
Signature

