From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Fri, 5 Feb 2016 11:12:29 +0530
Message-ID: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

This series implements lock and unlock functions for RTC and hooks
the same to DRA7 and AMx3xx hwmod.

Tested RTC functionality on:
DRA74-EVM: http://pastebin.ubuntu.com/14885542/
BeagleBoard-X15: http://pastebin.ubuntu.com/14885568/
AM437x-GP EVM: http://pastebin.ubuntu.com/14885589/
AM335x BeagleBoneBlack: http://pastebin.ubuntu.com/14885600/

Changes since v3:
- Rebased on top of latest Mainline.
Link to v3 series: https://www.mail-archive.com/linux-omap%40vger.kernel.org/msg118342.html

Lokesh Vutla (3):
  ARM: hwmod: RTC: Add lock and unlock functions
  ARM: DRA7: RTC: Add lock and unlock functions
  ARM: AMx3xx: RTC: Add lock and unlock functions

 arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 65 ++++++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.1.4
