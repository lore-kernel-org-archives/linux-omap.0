From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/4] rtc: omap: Add support for regulator supply
Date: Thu, 25 Sep 2014 15:02:05 +0530
Message-ID: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
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
To: rtc-linux@googlegroups.com, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series cleans up the OMAP RTC driver to use per device data structure.
And adds support for regulator supply.

Testing:
RTC functionality test on:
DRA742-evm: http://hastebin.com/avowiyegut.xml
DRA722-evm: http://hastebin.com/hujuyuyato.xml
Beagle Bone Black: http://hastebin.com/fawahapuyi.rb
AM4372-GP-evm: http://hastebin.com/iyitiqeyev.rb (Used an out of tree patch for enabling rtc)

Tested rtc wake using an internal tree with these patches applied:
DRA742-evm: http://hastebin.com/banejadaci.coffee
DRA722-evm: http://hastebin.com/adifefetax.vhdl
Beagle Bone Black: http://hastebin.com/uxezamokiy.coffee
AM4372-GP-evm: http://hastebin.com/ruvetigico.coffee

Lokesh Vutla (3):
  rtc: omap: Introduce rtc_omap_dev structure to include per device data
  rtc: omap: Adopt driver to support probe deferral
  rtc: omap: Support regulator supply for RTC

Tero Kristo (1):
  rtc: omap: Update Kconfig for OMAP RTC

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |   3 +
 drivers/rtc/Kconfig                                |   6 +-
 drivers/rtc/rtc-omap.c                             | 290 +++++++++++++--------
 3 files changed, 182 insertions(+), 117 deletions(-)

-- 
1.9.1
