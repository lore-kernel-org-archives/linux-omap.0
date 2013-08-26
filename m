From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7-evm: add support for sd, eMMC
Date: Mon, 26 Aug 2013 19:23:36 +0530
Message-ID: <1377525218-7655-1-git-send-email-balajitk@ti.com>
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
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: tony@atomide.com, nm@ti.com, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add mmc1, mmc2 dt node to dra7-evm

Balaji T K (2):
  ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
  ARM: dts: dra7-evm: Add mmc2 node for eMMC support

 arch/arm/boot/dts/dra7-evm.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

-- 
1.7.5.4
