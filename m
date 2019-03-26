From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] drop selected platform data for omap5
Date: Tue, 26 Mar 2019 11:30:50 -0700
Message-ID: <20190326183054.7598-1-tony@atomide.com>
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

With the pending patches for ti-sysc interconnect target module driver,
we can now drop legacy platform data for selected devices.

This series depends on the following pathces:

[PATCH 0/7] omap changes to allocate struct omap_hwmod dynamically
[PATCH 00/14] ti-sysc changes to probe devices with dts data only


Tony Lindgren (4):
  ARM: OMAP2+: Drop mmc platform data for omap5
  ARM: OMAP2+: Drop i2c platform data for omap5
  ARM: OMAP2+: Drop gpio platform data for omap5
  ARM: OMAP2+: Drop uart platform data for omap5

 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 746 ---------------------
 1 file changed, 746 deletions(-)

-- 
2.21.0
