From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 00/11] Drop unnecessary static
Date: Sat, 15 Jul 2017 22:07:35 +0200
Message-ID: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, keescook@chromium.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

These patches fix cases where there is a static on a local variable, but
the variable is initialized before any possible use.  Thus, the static has
no benefit.

---

 drivers/ata/sata_gemini.c                     |    2 +-
 drivers/clk/clk-moxart.c                      |    4 ++--
 drivers/clk/mmp/clk.c                         |    2 +-
 drivers/iio/orientation/hid-sensor-rotation.c |    2 +-
 drivers/irqchip/irq-digicolor.c               |    2 +-
 drivers/irqchip/irq-gic-realview.c            |    2 +-
 drivers/irqchip/irq-mips-cpu.c                |    2 +-
 drivers/mfd/max8925-i2c.c                     |    2 +-
 drivers/mfd/twl4030-irq.c                     |    2 +-
 drivers/mtd/maps/physmap_of_versatile.c       |    2 +-
 drivers/video/fbdev/da8xx-fb.c                |    2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)
