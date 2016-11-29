From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/2] ARM: dts: dra7-evm: pinmuxing updates
Date: Tue, 29 Nov 2016 14:54:46 +0530
Message-ID: <cover.1480411308.git.nsekhar@ti.com>
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

Kishon Vijay Abraham I (1):
  ARM: dts: dra7-evm: add pinmux configuration for mmc1/2

Sekhar Nori (1):
  ARM: dts: dra7-evm: Remove pinmux configurations for erratum i869

 arch/arm/boot/dts/dra7-evm.dts | 275 ++++-------------------------------------
 1 file changed, 23 insertions(+), 252 deletions(-)

-- 
2.9.0
