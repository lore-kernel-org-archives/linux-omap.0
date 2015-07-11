From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: sparse fixes
Date: Sat, 11 Jul 2015 20:29:14 +0530
Message-ID: <cover.1436622578.git.nsekhar@ti.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Here are some sparse fixes for mach-omap2.
After this series mach-omap2 is sparse clean.

Thanks,
Sekhar

Sekhar Nori (2):
  ARM: OMAP2+: sparse: add missing static declaration
  ARM: OMAP2+: sparse: add missing function declarations

 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  2 +-
 arch/arm/mach-omap2/omap3-restart.c                |  1 +
 arch/arm/mach-omap2/omap4-restart.c                |  1 +
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         | 34 +++++++++++-----------
 arch/arm/mach-omap2/pdata-quirks.c                 |  6 ++--
 7 files changed, 25 insertions(+), 23 deletions(-)

-- 
2.4.4.408.g16da57c
