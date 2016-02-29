From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] omap gpmc enhancements for v4.6
Date: Mon, 29 Feb 2016 20:07:44 +0200
Message-ID: <56D488F0.8070406@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd/Olof,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git@github.com:rogerq/linux.git tags/gpmc-omap-for-v4.6

for you to fetch changes up to e116c0545d17be6cc95a559aa5a68c221330501b:

  dt-bindings: bus: ti-gpmc: Add AAD timings properties (2016-02-08 16:22:03 +0200)

----------------------------------------------------------------
OMAP-GPMC: Add address/data muxed timings

* Add support for the GPMC Advanced AAD (address/data muxed) timings
on hardware supporting the feature like the AM335x and DM816X.

----------------------------------------------------------------
Neil Armstrong (2):
      memory: omap-gpmc: Add support for AAD timings
      dt-bindings: bus: ti-gpmc: Add AAD timings properties

 Documentation/devicetree/bindings/bus/ti-gpmc.txt |  5 +++++
 drivers/memory/omap-gpmc.c                        | 30 ++++++++++++++++++++++++++++++
 include/linux/omap-gpmc.h                         |  5 +++++
 3 files changed, 40 insertions(+)

--
cheers,
-roger
