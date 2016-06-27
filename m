From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] omap-gpmc changes for v4.8 merge window
Date: Mon, 27 Jun 2016 11:34:35 +0300
Message-ID: <5770E51B.8040206@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd/Olof,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git gpmc-omap-for-v4.8

for you to fetch changes up to 32dd625a9f3541ee6d390f12f810f28531d016c7:

  memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF (2016-06-17 10:26:48 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.8

* Make GPMC driver non modular as it is going to
be built-in only till arch/arm/mach-omap2 users
are removed.

* Fix build if CONFIG_OF is not defined.

----------------------------------------------------------------
Paul Gortmaker (1):
      memory: omap-gpmc: make it explicitly non-modular

Roger Quadros (1):
      memory: omap-gpmc: Move gpio functions out of #ifdef CONFIG_OF

 drivers/memory/omap-gpmc.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 1 file changed, 63 insertions(+), 73 deletions(-)
