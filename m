From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc changes for ti81xx for v5.1
Date: Thu, 31 Jan 2019 08:23:54 -0800
Message-ID: <pull-1548951676-587288@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/soc-ti-81xx-signed

for you to fetch changes up to d27cda291b2341d39692421b4e64940879ff9dd8:

  ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals (2019-01-24 08:43:38 -0800)

----------------------------------------------------------------
SoC updates for ti81xx for v5.1 merge window

Two changes to add legacy hwmod data for gpio and spi peripherals on
ti81xx. We have not yet updated ti81xx to probe devices with ti-sysc
interconnect target module driver, so these changes are still needed
to make devices usable for the related device tree changes.

----------------------------------------------------------------
Graeme Smecher (2):
      ARM: ti81xx: Move I2C entries in omap_hwmod_81xx to maintain grouping
      ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals

 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 131 +++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 7 deletions(-)
