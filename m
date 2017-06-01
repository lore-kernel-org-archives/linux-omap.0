From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3 0/2] Add cpcap battery driver
Date: Wed, 31 May 2017 17:19:19 -0700
Message-ID: <20170601001921.11091-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's v3 cpcap pmic battery driver.

Regards,

Tony

Changes since v2:

- Fix binding doc as noted by Rob Herring

- Separate the binding doc into a separate patch

Changes since v1:                                                                                                                                                                             - Add support for battery low interrupts                                                                                                                                                      - Fix POWER_SUPPLY_STATUS during charging to not flip constantly                                 by using average current

Tony Lindgren (2):
  dt-bindings: cpcap-battery: Add binding
  power: supply: cpcap-battery: Add a battery driver

 .../bindings/power/supply/cpcap-battery.txt        |  27 +
 drivers/power/supply/Kconfig                       |   8 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/cpcap-battery.c               | 808 +++++++++++++++++++++
 4 files changed, 844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
 create mode 100644 drivers/power/supply/cpcap-battery.c

-- 
2.13.0
