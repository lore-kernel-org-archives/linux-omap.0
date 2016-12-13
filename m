From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 0/3] ARM: dts: dra7-evm: pinmuxing updates
Date: Tue, 13 Dec 2016 16:59:44 +0530
Message-ID: <cover.1481628266.git.nsekhar@ti.com>
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
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

This patch series drops most of the pinmuxing from dra7-evm
to satisfy erratum i869 and adds missing eMMC and SD card pinmuxing.

The patches apply to latest linux-next. Tested on DRA74x EVM Rev H
using U-Boot 2016.11. Boot tested using NFS and basic testing carried
out on SD card, eMMC, Audio capture and playback.

NAND on DRA72 EVM is already unusable due to a similar patch. A patch
included here disables the GPMC node.

v1 -> v2:
- Add a patch to disable GPMC node on DRA72x EVM
- Disable GPMC node on DRA74x EVM

Kishon Vijay Abraham I (1):
  ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Sekhar Nori (2):
  ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869
  ARM: dts: dra72-evm: drop NAND support

 arch/arm/boot/dts/dra7-evm.dts          | 282 ++++----------------------------
 arch/arm/boot/dts/dra72-evm-common.dtsi |   7 +-
 2 files changed, 35 insertions(+), 254 deletions(-)

-- 
2.9.0
