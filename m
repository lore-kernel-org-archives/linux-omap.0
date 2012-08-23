From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2+: twl-common: Fix compile time error when omap-twl4030 audio is not enabled
Date: Thu, 23 Aug 2012 09:35:01 +0300
Message-ID: <1345703701-27283-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

=46ixes:
CC      arch/arm/mach-omap2/twl-common.o arch/arm/mach-omap2/twl-common=
=2Ec:562: error: conflicting types for =E2=80=98omap_twl4030_audio_init=
=E2=80=99
arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of =E2=
=80=98omap_twl4030_audio_init=E2=80=99 was here
make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

When building the kernel with !SND_OMAP_SOC_OMAP_TWL4030

Reported-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl=
-common.c
index 1c6045a..2919d7a 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -544,7 +544,7 @@ void __init omap_twl4030_audio_init(char *card_name=
)
 }
=20
 #else /* SOC_OMAP_TWL4030 */
-void __init omap_twl4030_audio_init(char *card_name, int codec_sysclk)
+void __init omap_twl4030_audio_init(char *card_name)
 {
 	return;
 }
--=20
1.7.8.6
