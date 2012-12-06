From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/3] gpio: twl4030: Correct status reporting for outputs
Date: Thu, 6 Dec 2012 11:52:04 +0100
Message-ID: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

As Grant commneted on the first version:
https://lkml.org/lkml/2012/12/5/53

Introduce bitfields to cache the directionand output status of the pins so we
can report them correctly.
To do this I did some cleanup within the driver to get rid of the global
variables and moved them under a private structure, changed the locking as well
to protect the bitfield operation.
As a last patch I added a note that the PWMA/B handling should not be in this
driver at all.

Regards,
Peter
---
Peter Ujfalusi (3):
  gpio: twl4030: Introduce private structure to store variables needed
    runtime
  gpio: twl4030: Cache the direction and output states in private data
  gpio: twl4030: TODO comment to remove the PWMA/B (LEDA/B) handling

 drivers/gpio/gpio-twl4030.c | 177 ++++++++++++++++++++++++++++----------------
 1 file changed, 115 insertions(+), 62 deletions(-)

-- 
1.8.0
