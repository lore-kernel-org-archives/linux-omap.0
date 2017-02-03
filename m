From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3 0/2] Two bq24190 PM improvments
Date: Fri,  3 Feb 2017 15:09:48 -0800
Message-ID: <20170203230950.24176-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's a repost of the two bq24190 patches against current power-supply
tree.

Regards,

Tony

Changes from v2:
- Several improvments for error handling and cosmetic issues based
  on comments by Liam Breck

Changes from v1:

- Call pm_runtime_dont_use_autosuspend() and pm_runtime_put_sync()
  unconditionally in bq24190_remove() as suggested by Liam

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

 drivers/power/supply/bq24190_charger.c | 213 +++++++++++++++++++++++++--------
 1 file changed, 163 insertions(+), 50 deletions(-)

-- 
2.11.0
