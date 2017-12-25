From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] Pinctrl-single: Adjustments for two function
 implementations
Date: Mon, 25 Dec 2017 14:05:12 +0100
Message-ID: <6bc679d1-c1ee-52fe-9ece-b28095f653ec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2017 14:01:23 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in pcs_probe()
  Delete an unnecessary return statement in pcs_irq_chain_handler()

 drivers/pinctrl/pinctrl-single.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.15.1

