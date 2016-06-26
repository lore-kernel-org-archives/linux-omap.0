From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/6] mfd: Fine-tuning for three function implementations
Date: Sun, 26 Jun 2016 15:34:34 +0200
Message-ID: <e4eaf0b4-e539-b400-c8a2-70f210cee1fa@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <de3598c4-f85a-6807-303a-55ee0ac707f2@users.sourceforge.net>
 <20160608111442.GB14888@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608111442.GB14888@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Jun 2016 15:25:43 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  twl-core: Return directly after a failed platform_device_alloc()
    in add_numbered_child()
  twl-core: Refactoring for add_numbered_child()
  dm355evm_msp: Return directly after a failed platform_device_alloc()
    in add_child()
  dm355evm_msp: Refactoring for add_child()
  smsc-ece1099: Delete an unnecessary variable initialisation
    in smsc_i2c_probe()
  smsc-ece1099: Return directly after a function failure
    in smsc_i2c_probe()

 drivers/mfd/dm355evm_msp.c | 25 ++++++++++++-------------
 drivers/mfd/smsc-ece1099.c | 11 ++++-------
 drivers/mfd/twl-core.c     | 28 +++++++++++++---------------
 3 files changed, 29 insertions(+), 35 deletions(-)

-- 
2.9.0
