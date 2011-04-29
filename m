From: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Subject: [PATCH 0/3] omap : nand : omap2 nand driver fixes
Date: Fri, 29 Apr 2011 12:31:07 +0200
Message-ID: <1304073070-24526-1-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Bryan DE FARIA <bdefaria@adeneo-embedded.com>, jjhiblot@adetelgroup.com, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Theses patches make the omap2 nand driver able to compile as a module and fix 
an issue when the module is reinserted. The last patch corrects an issue when 
using the software ecc with prefecth.

Bryan DE FARIA (3):
  omap : nand : fix omap2 module compilation
  omap : nand : fix omap2 module reinsertion
  omap : nand : fix subpage ecc issue with prefetch

 arch/arm/mach-omap2/gpmc.c |    2 ++
 drivers/mtd/nand/omap2.c   |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
