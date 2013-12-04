From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/1] gpio: twl4030: gpio LED regression fix for 3.13 rc
Date: Wed, 4 Dec 2013 13:34:30 +0200
Message-ID: <1386156871-7639-1-git-send-email-rogerq@ti.com>
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
To: linus.walleij@linaro.org
Cc: nm@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, balbi@ti.com, peter.ujfalusi@ti.com, linux-gpio@vger.kernel.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Commit 0b2aa8be that went into 3.13-rc2 introduced a regression
that causes failure in setting LED GPO direction to OUT.

This causes USB Host to fail probe on Beagleboard.

The following patch fixes this issue.

I've tried to higlight the issue in the original patch here
http://www.spinics.net/lists/linux-omap/msg100858.html

cheers,
-roger

Roger Quadros (1):
  gpio: twl4030: Fix regression for twl gpio LED output

 drivers/gpio/gpio-twl4030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
1.8.3.2
