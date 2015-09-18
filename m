From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Fix omap5-uevm WLAN regressions
Date: Fri, 18 Sep 2015 09:29:03 -0700
Message-ID: <1442593745-16725-1-git-send-email-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are two fixes for omap5-uevm WLAN.

Regards,

Tony

Tony Lindgren (2):
  mfd: twl6040: Fix deferred probe handling for clk32k
  ARM: dts: Fix WLAN regression on omap5-uevm

 arch/arm/boot/dts/omap5-uevm.dts | 51 +++++++++++++++++++++++++++++++---------
 drivers/mfd/twl6040.c            |  2 ++
 2 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.1.4
