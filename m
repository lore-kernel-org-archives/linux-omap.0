From: David Rivshin <drivshin@awxrd.com>
Subject: [PATCH 0/2] gpio: omap: set_debounce fixes
Date: Thu, 16 Mar 2017 21:48:54 -0400
Message-ID: <20170317014856.31449-1-drivshin@awxrd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: David Rivshin <drivshin@allworx.com>

This series fixes a couple of issues in the gpio-omap set_debounce logic.

Patches based ontop of v4.11-rc1, but apply cleanly to linux-gpio/fixes
and linux-next.

Tested on a (custom) AM335x board via gpio-keys.

(Apologies if anyone received this series twice, it seemed to fail
the first time due to a typo. Please ignore the any previous copy.)


David Rivshin (2):
  gpio: omap: return error if requested debounce time is not possible
  gpio: omap: compute debounce-time from actual debounce-clock rate

 drivers/gpio/gpio-omap.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.9.3

base-commit: c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201
