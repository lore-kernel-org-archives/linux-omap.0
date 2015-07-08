From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/4] ARM: omap2plus_defconfig updates
Date: Wed, 8 Jul 2015 20:57:33 +0530
Message-ID: <cover.1436368740.git.nsekhar@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Here are some defconfig updates for commonly
used drivers on platforms supported by
omap2plus_defconfig.

Applies to v4.2-rc1

Thanks,
Sekhar

Sekhar Nori (4):
  ARM: omap2plus_defconfig: enable support for TI ADC
  ARM: omap2plus_defconfig: enable support for TI touchscreen
  ARM: omap2plus_defconfig: enable support for TI CPTS
  ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR

 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.4.4.408.g16da57c
