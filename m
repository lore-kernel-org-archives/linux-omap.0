From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] omap-gpmc fixes for v4.7 rc cycle
Date: Thu, 16 Jun 2016 12:14:26 +0300
Message-ID: <57626DF2.70907@ti.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, SebastienOcquidant@Eaton.com, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd/Olof,

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-fixes-for-v4.7

for you to fetch changes up to 8f50b8e57442d28e41bb736c173d8a2490549a82:

  memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing (2016-06-16 11:43:48 +0300)

----------------------------------------------------------------
OMAP-GPMC: Fixes for for v4.7-rc cycle:

- Fix omap gpmc EXTRADELAY timing. The DT provided timings
were wrongly used causing devices requiring extra delay timing
to fail.

----------------------------------------------------------------
Ocquidant, Sebastien (1):
      memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing

 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
