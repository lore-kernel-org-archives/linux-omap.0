From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 00/13] mfd: menelaus: a few cleanups
Date: Wed, 27 Nov 2013 13:06:44 -0600
Message-ID: <1385579217-20127-1-git-send-email-balbi@ti.com>
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
To: sameo@linux.intel.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, lee.jones@linaro.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

few cleanups on the old menelaus driver. I don't have
HW to test these patches, maybe Aaro can help here ?

cheers

Felipe Balbi (13):
  mfd: menelaus: drop __exit section annotation
  mfd: menelaus: switch over to module_i2c_driver
  mfd: menelaus: convert to threaded irq
  mfd: menelaus: remove unnecessary loop
  mfd: menelaus: use for_each_set_bit()
  mfd: menelaus: pass menelaus pointer as argument to enable/disable irq
  mfd: menelaus: limit the usage of the_menelaus
  mfd: menelaus: pass menelaus_chip pointer to add/remove irq functions
  mfd: menelaus: pass menelaus_chip pointer to get/set voltage
  mfd: menelaus: pass menelaus_chip argument to menelaus <-> time
    helpers
  mfd: menelaus: start to use irqdomain
  mfd: menelaus: switch all children to threaded_irq
  mfd: menelaus: remove unnecessary definition

 drivers/mfd/menelaus.c | 616 +++++++++++++++++++++++++------------------------
 1 file changed, 319 insertions(+), 297 deletions(-)

-- 
1.8.4.GIT
