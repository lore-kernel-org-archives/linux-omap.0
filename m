From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] omap: McBSP: Fix incorrect receiver stop in
	omap_mcbsp_stop
Date: Tue, 13 Oct 2009 17:14:53 -0700
Message-ID: <20091014001453.6116.76836.stgit@localhost>
References: <20091014001233.6116.84749.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014001233.6116.84749.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

This small typo written by author causes that McBSP receiver is disabled on
OMAP2430 and OMAP3430 even if only transmitter is stopped. This was noted
with ALSA SoC where simultaneous recording halted if playback was stopped
first.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 88ac976..e664b91 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -595,7 +595,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int rx)
 	rx &= 1;
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		w = OMAP_MCBSP_READ(io_base, RCCR);
-		w |= (tx ? RDISABLE : 0);
+		w |= (rx ? RDISABLE : 0);
 		OMAP_MCBSP_WRITE(io_base, RCCR, w);
 	}
 	w = OMAP_MCBSP_READ(io_base, SPCR1);
