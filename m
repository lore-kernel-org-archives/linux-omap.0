From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Two bq24190 PM improvments
Date: Fri, 20 Jan 2017 14:04:38 -0800
Message-ID: <20170120220440.1971-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are the two bq24190 patches rebased against current power-supply
tree now that Liam's changes are applied.

I've kept Mark's acks as the changes were minor and mostly limited to
bq24190_probe() basedon Liam's changes.

Regards,

Tony


Changes from earlier set:

- Separated from Liam's changes that are now in the power-supply tree

- Moved bdi->initialized before devm_request_threaded_irq() as suggested
  by Liam

- Added missing return value check for pm_runtime_get() as suggested by
  Liam

- Updated against current power-supply tree, mostly for the probe error
  handling

Tony Lindgren (2):
  power: bq24190_charger: Check the interrupt status on resume
  power: bq24190_charger: Use PM runtime autosuspend

 drivers/power/supply/bq24190_charger.c | 180 ++++++++++++++++++++++++++-------
 1 file changed, 143 insertions(+), 37 deletions(-)

-- 
2.11.0
