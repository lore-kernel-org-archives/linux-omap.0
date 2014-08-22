From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: OMAP5+: pdata quirks for pinctrl
Date: Fri, 22 Aug 2014 08:55:22 -0500
Message-ID: <1408715725-25919-1-git-send-email-nm@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following series are various fixes and improvements for daisychain
support in OMAP5+ using pinctrl framework similar to that done for
OMAP3+

This is part 3/6 series which eventually enables framework for
suspend-to-ram and cpuidle for OMAP5 and DRA7

Each of series is based on v3.17-rc1 and this specific series is available:
weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/prm-pdata-quirks

git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/prm-pdata-quirks

An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework

Minor note: thanks to existing style in pdata-quirks, new entries
continue to possess 'over 80 character' checkpatch warnings

Keerthy (1):
  ARM: AM437x: use pdata quirks for pinctrl information

Nishanth Menon (2):
  ARM: OMAP5: use pdata quirks for pinctrl information
  ARM: DRA7: use pdata quirks for pinctrl information

 arch/arm/mach-omap2/pdata-quirks.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
1.7.9.5
