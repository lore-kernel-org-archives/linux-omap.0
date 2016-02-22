From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Fix l4_ls interface clock and enable RTC
Date: Mon, 22 Feb 2016 15:04:01 -0800
Message-ID: <1456182245-1843-1-git-send-email-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few ti81xx related improvments for v4.6 merge window.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Fix hwmod clock for l4_ls
  ARM: OMAP2+: Add rtc hwmod configuration for ti81xx
  ARM: dts: Add RTC entry for dm814x and dra62x
  ARM: dts: Add RTC entry for dm816x

 arch/arm/boot/dts/dm814x.dtsi              |  7 +++++
 arch/arm/boot/dts/dm816x.dtsi              |  7 +++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 47 ++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.7.0
