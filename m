From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 03/20] OMAP: McBSP: Use appropriate value for
	startup delay
Date: Mon, 17 Aug 2009 17:09:03 +0300
Message-ID: <1250518143-13336-1-git-send-email-eduardo.valentin@nokia.com>
References: <20090817135632.GW7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090817135632.GW7278@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Eduardo Valentin <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Increasing startup delay value as worst case:
 CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec

Although, 100us may give enough time for two CLKSRG,
due to some unknown PM related, clock gating etc. reason,
this patch increases it to 500us.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0aa2524..e9dd703 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -365,7 +365,13 @@ void omap_mcbsp_start(unsigned int id, int tx, int rx)
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
 	OMAP_MCBSP_WRITE(io_base, SPCR1, w | (rx & 1));
 
-	udelay(100);
+	/*
+	 * Worst case: CLKSRG*2 = 8000khz: (1/8000) * 2 * 2 usec
+	 * REVISIT: 100us may give enough time for two CLKSRG, however
+	 * due to some unknown PM related, clock gating etc. reason it
+	 * is now at 500us.
+	 */
+	udelay(500);
 
 	if (idle) {
 		/* Start frame sync */
-- 
1.6.2.GIT

