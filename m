From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 00/28] ARM: OMAP2+: hwmod module clock type support
Date: Thu, 14 Apr 2016 14:07:49 +0300
Message-ID: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
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
To: tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

v2 contains following changes in comparison to v1:

- Patch ordering changed a bit, clk/ti, mach-omap2, dts patches are now
  mostly grouped together, with the exception of the introduction of
  clock helper API, which is needed by everything else. Please note
  that the ordering must be preserved between mach-omap2/clk-driver/dts
  to avoid boot problems.
- Dropped hwmod data removal patches for now, this allows booting with
  either new or old DTS data.
- Fixed a typo in the hwmod clock driver timeout handling, the comparison
  for timeout against ktime_us_delta was wrong causing too short
  timeouts, this was apparent with cpuidle enabled on OMAP4
- Added patch #6 to fetch hwmod main clock based on the hwmod name itself,
  if found, ignore main_clk / clkctrl setup for the hwmod
- Added patch #7 to fix issue in omap2 timer caused by patch #6, with
  dynamic parsing of main clock, the hwmod must be setup before attempting
  to access main_clk.

Boot tested on am335x-evm, am335x-evmsk, am3517-evm, am37x-evm, am437x-sk,
am437x-gp-evm, am57xx-evm, omap3-beagle-xm, omap3-beagle, am335x-boneblack,
am335x-bone, omap3-crane, dra72x-ev, dra7xx-evm, ldp3430, omap4-panda-es,
omap4-panda, omap2430-sdp, omap3430-sdp, omap4-sdp-es23plus, omap5-uevm.

Suspend-resume tested on omap3-beagle, omap4-panda-es.

Cpuidle tested on omap4-panda-es. For some reason cpuidle is not functional
for me on omap3-beagle, even on plain 4.6-rc2.

Branch pushed at:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.6-rc2-hwmod-clks-v2

-Tero
