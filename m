From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/4] ARM: OMAP5/DRA7: minor fixes
Date: Wed, 9 Sep 2015 16:18:10 -0500
Message-ID: <1441833494-32450-1-git-send-email-nm@ti.com>
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
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

While doing a SoC only build for DRA7, a few bugs did pop up. The
following series provides necessary fixups for the same.

Nishanth Menon (4):
  ARM: OMAP4+: PM: erratum is used by OMAP5 and DRA7 as well
  ARM: omap2+: board-generic: Remove stale of_irq macros
  ARM: DRA7: Select missing options for SoC only build
  ARM: OMAP5: Cleanup options for SoC only build

 arch/arm/mach-omap2/Kconfig         |    6 +++++-
 arch/arm/mach-omap2/board-generic.c |    7 -------
 arch/arm/mach-omap2/pm.h            |    3 ++-
 3 files changed, 7 insertions(+), 9 deletions(-)

-- 
1.7.9.5
