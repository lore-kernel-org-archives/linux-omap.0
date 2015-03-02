From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 0/3] Add support for HDQ-1W on AM43XX
Date: Mon, 2 Mar 2015 16:19:31 +0530
Message-ID: <1425293374-30878-1-git-send-email-vigneshr@ti.com>
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
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, Benoit Cousson <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch series adds support for HDQ-1W interface on AM43XX.
The first patch adds hwmod entries for HDQ-1W on AM43xx.

The existing omap_hdq driver does not support 1-wire operations.
The second patch enables 1-wire support in the omap_hdq driver. Support
to Search ROM addresses and automatically load slave drivers is added
for 1-wire mode.

I have tested this on am437x-gp-evm using DS18B20 as 1-wire slave.


Poddar, Sourav (1):
  ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W

Vignesh R (2):
  w1: masters: omap_hdq: Add support for 1-wire mode
  ARM: dts: AM4372: update hdq compatible property

 Documentation/devicetree/bindings/w1/omap-hdq.txt |   7 +-
 Documentation/w1/masters/omap-hdq                 |   6 +
 arch/arm/boot/dts/am4372.dtsi                     |   2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c        |  36 ++++
 arch/arm/mach-omap2/prcm43xx.h                    |   1 +
 drivers/w1/masters/omap_hdq.c                     | 209 ++++++++++++++++++----
 6 files changed, 226 insertions(+), 35 deletions(-)

-- 
1.9.1
