From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 0/5] TI Ethernet driver warnings fixes
Date: Mon, 21 May 2018 11:45:50 -0700
Message-ID: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

This patch series attempts to fix properly the warnings observed with turning
on COMPILE_TEST and TI Ethernet drivers on 64-bit hosts.

Since I don't have any of this hardware, please review carefully for possible
breakage!

Thank you!

Florian Fainelli (5):
  ti: ethernet: cpdma: Use correct format for genpool_*
  net: ethernet: ti: cpts: Fix timestamp print
  net: ethernet: ti: cpsw: Fix cpsw_add_ch_strings() printk format
  net: ethernet: davinci_emac: Fix printing of base address
  ti: ethernet: davinci: Fix cast to int warnings

 drivers/net/ethernet/ti/cpsw.c          |  4 ++--
 drivers/net/ethernet/ti/cpts.c          |  3 ++-
 drivers/net/ethernet/ti/davinci_cpdma.c | 10 +++++-----
 drivers/net/ethernet/ti/davinci_emac.c  |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.14.1
