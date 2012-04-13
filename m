From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2PLUS: DSS hwmod fixes
Date: Fri, 13 Apr 2012 13:31:54 +0530
Message-ID: <1334304116-18872-1-git-send-email-archit@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tomi.valkeinen@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This set makes changes related to the OCPIF_SWSUP_IDLE flag for DSS slave
interfaces. This is required since the clocks of these interfaces were changed
recently with the patches below for OMAP2, OMAP3 and OMAP4 respectively:

b8ac10d8b75843c9ddd6aadf70a0cdf8aa783659
ARM: OMAP2xxx: HWMOD: fix DSS clock data

6c3d7e34d68ffae888d33bf364f447e0b415591f
ARM: OMAP3: HWMOD: fix DSS clock data

da7cdfac1b0c58d6863532dd3b432c3fbc034978
OMAP4: hwmod data: Change DSS main_clk scheme

Tested on beagle and OMAP4 SDP over 3.4-rc2 kernel.

Archit Taneja (2):
  ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC
    slave interface
  ARM: OMAP4: DSS hwmods: Add OCPIF_SWSUP_IDLE to all DSS L3 slave
    interfaces

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    7 +++++++
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
1.7.5.4
