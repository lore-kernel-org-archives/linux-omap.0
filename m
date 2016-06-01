From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/5] ARM: OMAP5: add support for fref-xtal-clk
Date: Wed, 1 Jun 2016 20:35:21 +0300
Message-ID: <1464802526-16372-1-git-send-email-t-kristo@ti.com>
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
To: linux-omap@vger.kernel.org, tony@atomide.com, peter.ujfalusi@ti.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

fref_xtal_clk is a clock going out from omap5 chip, sourced directly
from the system oscillator. fref_xtal_clk can be used to provide a
high frequency clock to some external component, in omap5 setups,
typically twl6040 audio chip.

Testing done (number of boards on the test farm are currently out of order):

am335x-evm      : BOOT FAIL!
am335x-evmsk    : boot
am37x-evm       : boot
am437x-sk       : boot
am43x-epos-evm  : boot
am437x-gp-evm   : boot
am57xx-evm      : boot
omap3-beagle-xm : boot
am335x-boneblack: boot
am335x-bone     : boot
dra72x-evm      : boot
dra7xx-evm      : boot
omap5-uevm      : boot

On omap5, also verified that the new clock node appears under debugfs.

am335x-evm failure is due to inability to mount NFS rootfs on the board
in question the boot goes fine until that. There are some issues with
the u-boot installed on this board currently.

-Tero
