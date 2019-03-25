From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] simplify idle gpio handling for omaps
Date: Mon, 25 Mar 2019 15:43:15 -0700
Message-ID: <20190325224318.15076-1-tony@atomide.com>
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
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Based on some comments from Grygorii I noticed that parts of old 24xx
errata 1.101 handling has become part of the GPIO idle handling over
the years. Here are few patches to clarify and simplify the handling
a bit.

Regards,

Tony


Tony Lindgren (3):
  gpio: gpio-omap: limit errata 1.101 handling to wkup domain gpios only
  gpio: gpio-omap: always scan for triggered non-wakeup capable
    interrupts
  gpio: gpio-omap: add check for off wake capable gpios

 drivers/gpio/gpio-omap.c | 61 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

-- 
2.21.0
