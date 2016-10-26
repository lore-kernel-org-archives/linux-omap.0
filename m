From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Minimal cpuidle fixes for omap5 and dra7
Date: Wed, 26 Oct 2016 08:16:58 -0700
Message-ID: <20161026151703.24730-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>, Dave Gerlach <d-gerlach@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Pau Pajuel <ppajuel@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are some fixes to get minimal cpuidle support working with omap5
and dra7. Not sure if there are still some unsorted issues on enabling
this on dra7, but at least omap5 has been behving for me for few
weeks with these.

Regards,

Tony


Santosh Shilimkar (1):
  ARM: DRA7: PM: cpuidle MPU CSWR support

Tony Lindgren (4):
  ARM: OMAP5: Fix build for PM code
  ARM: OMAP5: Fix mpuss_early_init
  ARM: OMAP4+: Fix bad fallthrough for cpuidle
  ARM: OMAP5: Enable minimal cpuidle for omap5 retention

 arch/arm/mach-omap2/Makefile              |  2 +-
 arch/arm/mach-omap2/cpuidle44xx.c         | 80 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/io.c                  |  3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 33 +++++++++----
 arch/arm/mach-omap2/omap4-sar-layout.h    |  2 +
 arch/arm/mach-omap2/pm44xx.c              |  2 +-
 6 files changed, 108 insertions(+), 14 deletions(-)

-- 
2.9.3
