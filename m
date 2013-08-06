From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 0/8] omap mailbox dt
Date: Tue, 6 Aug 2013 16:39:53 -0500
Message-ID: <1375825193-18046-1-git-send-email-s-anna@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Suman Anna <s-anna@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This is an updated series for adding the device tree support to
the OMAP mailbox driver. The series is based on 3.11-rc4 and now
includes the support for AM335 WkupM3 mailbox.

The support for WkupM3 mailbox is essential for achieving the PM
Suspend on AM335 devices, and this series is a dependency for
the AM335 suspend/resume series [1]. The AM335 support patches
required the mailbox DT patches posted previously, so I have
refreshed all of them together.

Tested this on Beagle-XM, Panda4 and OMAP5 uEVM (with
out-of-tree clock patches).

v3:
- Includes 3 new patches on top of the unchanged patches in v2.
- Patches 7 and 8 adds the driver support and DT node for AM335.
- Patch6 is a minor cleanup patch removing omap_mbox_type_t from
  mbox ops.

v2:
- Removed the #ti,mbox-data-cells from DT bindings and node data
- Includes 2 new patches that adds the data for OMAP5.
http://marc.info/?l=linux-omap&m=137452880325361&w=2

v1:
http://marc.info/?l=linux-omap&m=137159523405468&w=2

[1] http://marc.info/?l=linux-omap&m=137581142013093&w=2

Suman Anna (8):
  mailbox/omap: add a parent structure common to all mboxes
  mailbox/omap: add support for parsing dt devices
  ARM: dts: OMAP2+: Add mailbox nodes
  ARM: OMAP5: hwmod data: Add mailbox data
  ARM: dts: OMAP5: Add mailbox dt node
  mailbox/omap: remove omap_mbox_type_t from mailbox ops
  mailbox/omap: add code to support the wkupm3 operations
  ARM: dts: AM33xx: Add mailbox node

 .../devicetree/bindings/mailbox/omap-mailbox.txt   |  43 +++
 arch/arm/boot/dts/am33xx.dtsi                      |  11 +
 arch/arm/boot/dts/omap2420.dtsi                    |  12 +
 arch/arm/boot/dts/omap2430.dtsi                    |  11 +
 arch/arm/boot/dts/omap3.dtsi                       |  11 +
 arch/arm/boot/dts/omap4.dtsi                       |  11 +
 arch/arm/boot/dts/omap5.dtsi                       |  11 +
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  42 +++
 drivers/mailbox/mailbox-omap1.c                    |  54 +++-
 drivers/mailbox/mailbox-omap2.c                    | 315 +++++++++++++++++----
 drivers/mailbox/omap-mailbox.c                     |  58 ++--
 drivers/mailbox/omap-mbox.h                        |  17 +-
 13 files changed, 490 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

-- 
1.8.3.3
