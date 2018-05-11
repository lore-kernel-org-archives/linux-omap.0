From: Roger Quadros <rogerq@ti.com>
Subject: [GIT PULL] omap-gpmc updates for v4.18
Date: Fri, 11 May 2018 07:28:51 +0300
Message-ID: <75040f4e-9499-55a4-fad6-f27cab0bb224@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-GB
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Olof/Arnd,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.18

for you to fetch changes up to d507178f2ebb7bde5b3f64557f1c8f80e7b82541:

  memory: omap-gpmc: Avoid redundant NULL check (2018-04-24 10:30:52 +0300)

----------------------------------------------------------------
OMAP-GPMC: driver updates for v4.18
* get rid of a redundant NULL check in gpmc_probe_dt_children()

----------------------------------------------------------------
Roger Quadros (1):
      memory: omap-gpmc: Avoid redundant NULL check

 drivers/memory/omap-gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
