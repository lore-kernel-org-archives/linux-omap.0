From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for
	sidetone
Date: Fri, 18 Mar 2016 12:28:46 +0200
Message-ID: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

The series addresses a long standing issue with McBSP2/3 regarding to hwmod
setup. When booting with DT a warning is printed that mcbsp2/3 is using two
hwmod.
The root of the issue is the way how the hwmod data was constructed in the first
place for OMAP3 McBSP2/3.
After re-reading the TRM it is clear that the sidetone should not have it's
own hwmod data as it is not a separate IP, it is part of the McBSP module. It
can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bit is only
sets the autoidle from the internal McBSP_iclk clock to the sidetone block of
the same McBSP.

The first two patch will remove the omap2/3_sidetone hwmod and it's use from DT.
The ASoC patch is clear the autoidle bit in McBSP sidetone as it is adviced in
the TRM.

Mark: The ASoC patch can be safely merged via ASoC tree.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: DTS: omap3: Remove mcbsp2/3_sidetone hwmod reference for McBSP2/3
  ARM: OMAP3: hwmod data: Merge and remove the McBSP sidetone related
    data
  ASoC: omap-mcbsp: Enable/disable sidetone block auto clock gating for
    omap3

 arch/arm/boot/dts/omap3.dtsi               |   4 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 120 ++++-------------------------
 sound/soc/omap/mcbsp.c                     |   8 ++
 3 files changed, 24 insertions(+), 108 deletions(-)

-- 
2.7.3
