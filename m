From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl contex
Date: Wed, 16 May 2018 11:10:28 +0530
Message-ID: <1526449230-27618-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, linus.walleij@linaro.org, t-kristo@ti.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The series adds save/restore functions to pinctrl-single driver.
This is specially needed in case of RTC only mode with
DDR in self refresh where the register contents are lost.

Tested on am437x-gp-evm.

Keerthy (2):
  arm: mach-omap2: pdata-quirks: Add a quirk function to convey off mode
    state
  pinctrl: pinctrl-single: Add functions to save and restore pinctrl
    context

 arch/arm/mach-omap2/pdata-quirks.c           |  6 ++
 drivers/pinctrl/pinctrl-single.c             | 95 +++++++++++++++++++++++++++-
 include/linux/platform_data/pinctrl-single.h |  1 +
 3 files changed, 101 insertions(+), 1 deletion(-)

-- 
1.9.1
