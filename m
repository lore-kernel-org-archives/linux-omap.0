From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] omap: hwmod: add default reset handling support
Date: Mon, 8 Feb 2016 16:42:18 +0530
Message-ID: <1454929941-23949-1-git-send-email-kishon@ti.com>
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
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, bhelgaas@google.com, richardcochran@gmail.com, s-anna@ti.com
Cc: Russell King <linux@arm.linux.org.uk>, nsekhar@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a new hwmod flag to indicate custom reset handling and use it
for devices that require custom reset handling (like dsp, ipu, iva).

Tested PCIe on dra7-evm and dra72-evm.
I need help in testing DSP, IPU, IVA, PRU, GFX, M3 in other platforms.
Or a way to test these cores to see if reset is not broken. Suman?

I'll post this series once again after performing these tests.

Paul Walmsley (3):
  ARM: omap2+: omap_hwmod: introduce hwmod flag for custom reset
    handling
  ARM: OMAP2+: hwmod: use HWMOD_CUSTOM_HARDRESET for custom reset
    handling
  ARM: OMAP2+: hwmod: Add default reset handling

 arch/arm/mach-omap2/omap_hwmod.c                   |   16 +++++++++++-----
 arch/arm/mach-omap2/omap_hwmod.h                   |   12 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |    2 ++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    2 ++
 10 files changed, 41 insertions(+), 5 deletions(-)

-- 
1.7.9.5
