From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 00/13] ARM: dts: omap3-gta04: Various DT fixes
Date: Thu, 22 Jan 2015 21:38:06 +0100
Message-ID: <1421959099-28319-1-git-send-email-marek@goldelico.com>
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
To: bcousson@baylibre.com, tony@atomide.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, neilb@suse.de, hns@goldelico.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series contains fixes for gta04 devicetree. I collected patches
from H. Nikolaus Schaller + NeilBrown and myself. Patches contains mostly fixes
+ adding new nodes and comments. All changes tested on gta04a4 board.

H. Nikolaus Schaller (5):
  ARM: dts: omap3-gta04: Fix backup-battery charging in devicetree file.
  ARM: dts: omap3-gta04: Fix audio node malformatting
  ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
  ARM: dts: omap3-gta04: Enable twl audio vibra support
  ARM: dts: omap3-gta04: Enable power-off using twl4030

Marek Belisko (2):
  ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
  ARM: dts: omap3-gta04: Add ramp value for twl4030 audio

NeilBrown (6):
  ARM: dts: omap3-gta04: add comments about gpios
  ARM: dts: omap3-gta04: enable power-off for wifi card.
  ARM: dts: omap3-gta04: add gyroscope
  ARM: dts: omap3-gta04: only power DSS when necessary.
  ARM: dts: omap3-gta04: uart4 is not connected, so mark it "disabled"
  ARM: dts: omap3-gta04: Disable keypad

 arch/arm/boot/dts/omap3-gta04.dtsi | 54 +++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 15 deletions(-)

-- 
1.9.1
