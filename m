From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Update TSC2301 touchscreen config name
 in board-n800.c
Date: Mon, 2 Apr 2007 10:05:11 +0300
Message-ID: <20070402100511.7f18c104.jarkko.nikula@nokia.com>
References: <20070322111502.8988f08a.jarkko.nikula@nokia.com>
	<20070330191344.GJ18375@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__2_Apr_2007_10_05_11_+0300__aSwVUPieap6wjzT"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070330191344.GJ18375@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__2_Apr_2007_10_05_11_+0300__aSwVUPieap6wjzT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Mar 2007 15:13:46 -0400
"ext Tony Lindgren" <tony@atomide.com> wrote:

> * Jarkko Nikula <jarkko.nikula@nokia.com> [070322 05:17]:
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > ---
> >  arch/arm/mach-omap2/board-n800.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> This is already applied now too.
> 
Not correctly :-)

It seems that you took "commit
64e78a98859a4ce028121a6b5d462b504f9b9343" from my first patchset
changing also TSC2301-mixer config name which was not required for
latter set.

This could be corrected by either reverting whole
64e78a98859a4ce028121a6b5d462b504f9b9343 and applying only this one:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009402.html

or by applying audio config name revert patch I'm attaching here.


-- 
Jarkko

--Multipart=_Mon__2_Apr_2007_10_05_11_+0300__aSwVUPieap6wjzT
Content-Type: text/plain;
	name="0001-ARM-OMAP-Revert-TSC2301-audio-config-name-change-in-board-n800-audio.c.txt"
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Revert-TSC2301-audio-config-name-change-in-board-n800-audio.c.txt"
Content-Transfer-Encoding: 7bit

>From 5ce8f5744d8ec067389a67f83adb53545f95e0ad Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Mon, 2 Apr 2007 09:59:38 +0300
Subject: [PATCH] ARM: OMAP: Revert TSC2301 audio config name change in board-n800-audio.c

Commit 64e78a98859a4ce028121a6b5d462b504f9b9343 was accidentally took
from older patchset where with the newer set TSC2301 audio config name
didn't change.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800-audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-audio.c b/arch/arm/mach-omap2/board-n800-audio.c
index 6bdf1c8..fa6ab86 100644
--- a/arch/arm/mach-omap2/board-n800-audio.c
+++ b/arch/arm/mach-omap2/board-n800-audio.c
@@ -31,7 +31,7 @@
 
 #include "../plat-omap/dsp/dsp_common.h"
 
-#if defined(CONFIG_SND_SOC_TSC2301) && defined(CONFIG_SND_OMAP24XX_EAC)
+#if defined(CONFIG_SPI_TSC2301_AUDIO) && defined(CONFIG_SND_OMAP24XX_EAC)
 #define AUDIO_ENABLED
 
 static struct clk *sys_clkout2;
-- 
1.4.4.4


--Multipart=_Mon__2_Apr_2007_10_05_11_+0300__aSwVUPieap6wjzT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Multipart=_Mon__2_Apr_2007_10_05_11_+0300__aSwVUPieap6wjzT--
