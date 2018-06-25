From: Adam Ford <aford173@gmail.com>
Subject: [RFC 0/5] Migrate AM35xx MUSB glue to device tree and enable MUSB
Date: Sun, 24 Jun 2018 19:12:28 -0500
Message-ID: <20180625001233.9785-1-aford173@gmail.com>
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
To: adam.ford@logicpd.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently, the AM3517.dtsi uses the omap2430 glue to connect
the MUSB controller when it should use the AM35x glue.  This
series attempts to convert the AM35x glue to device tree,
fix the clock references to the AM35X can enable/disable
them correctly, and then use pdata-quirks.c to enable the
register that isn't yet available using device tree to enable
MSUB, then finally modifies the AM3517 and AM3517-EVM to use
the updated AM35x glue to support MUSB.

It currently doesnt' work, but I am looking for ideas on
what I may have missed or done incorrectly.  

Adam Ford (5):
  usb: musb: am35x: Add device tree support
  usb: musb: am35x: Match clock assignements to hwmods
  ARM: OMAP2+: Add AM3517 MUSB setup to pdata quirks.
  ARM: dts: AM35x: Change MUSB from omap2430 to am35xx
  ARM: dts: am3517-evm: Enable MUSB on AM3517-evm

 arch/arm/boot/dts/am3517-evm.dts   | 12 ++++++++++++
 arch/arm/boot/dts/am3517.dtsi      |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c | 19 +++++++++++++++++++
 drivers/usb/musb/am35x.c           | 15 +++++++++++++--
 4 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.17.1
