From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
 omap3_defconfig
Date: Tue, 4 May 2010 12:23:24 -0700
Message-ID: <20100504192324.GI29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203411.25812.30019.stgit@baageli.muru.com>
 <20100430205003.GG29604@atomide.com>
 <20100504005222.GD29604@atomide.com>
 <1272957963.1978.25.camel@tubuntu.research.nokia.com>
 <20100504144040.GH29604@atomide.com>
 <1272984625.1978.30.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GBuTPvBEOL0MYPgd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58805 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab0EDTXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 15:23:30 -0400
Content-Disposition: inline
In-Reply-To: <1272984625.1978.30.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [100504 07:45]:
> On Tue, 2010-05-04 at 16:40 +0200, ext Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@nokia.com> [100504 00:21]:
> > > Hi,
> > > 
> > > On Tue, 2010-05-04 at 02:52 +0200, ext Tony Lindgren wrote:
> > > > * Tony Lindgren <tony@atomide.com> [100430 13:47]:
> > > > > * Tony Lindgren <tony@atomide.com> [100430 13:32]:
> > > > > > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > > > > > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > > > > > omap FB code is fixed.
> > > > > 
> > > > > This one I'll drop as soon as the problem is sorted out with
> > > > > CONFIG_FB_OMAP.
> > > > 
> > > > This one seems to be something under drivers/video/omap, so
> > > > I'll change CONFIG_FB_OMAP to be a module now. Updated patch
> > > > below.
> > > > 
> > > > I'll update omap for-next accordingly, then Tomi can figure
> > > > it out :)
> > > 
> > > This sounds... interesting... =) Any more info on what happens? Does it
> > > also affect new omapfb driver?
> > 
> > Yeah this is interesting, it seems like the kernel cmdline gets
> > somehow corrupted for zoom3 with the omap3_defconfig if CONFIG_FB_OMAP=y.
> > Some options seem to be there, but for example rootwait option is
> > ignored and the root on MMC never mounts. This is in the current
> > omap for-next branch.
> 
> Ok, so the cmdline parsing in omapfb could be broken. I'll check it out.

OK thanks. Hmm, it could be that it works on n8x0 and n900 because they
are using the kernel built in cmdline.
 
> > Hmm, what do you mean with "new omapfb" driver, the stuff you have
> > queued up?
> 
> No, I mean the DSS2 version. drivers/video/omap is the old one, written
> mostly by Imre, and drivers/video/omap2 is the new one, written mostly
> by me.
> 
> I guess most boards are still using the old omapfb driver.

Ah I see, it does not have CONFIG_FB_OMAP2 set. I did a quick test
with that and the bootloader passed cmdline on zoom3 works just fine.
I used the options below.

Nothing on the LCD panel on zoom or n900 though, I guess some updates
are still needed for that.

Regards,

Tony

--GBuTPvBEOL0MYPgd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fb-omap2.patch"

--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -1385,17 +1385,36 @@ CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-CONFIG_FB_OMAP=y
 CONFIG_FB_OMAP_LCD_VGA=y
 # CONFIG_FB_OMAP_031M3R is not set
 # CONFIG_FB_OMAP_048M3R is not set
-CONFIG_FB_OMAP_079M3R=y
+# CONFIG_FB_OMAP_079M3R is not set
 # CONFIG_FB_OMAP_092M9R is not set
-# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
-# CONFIG_OMAP2_DSS is not set
+CONFIG_OMAP2_VRAM=y
+CONFIG_OMAP2_VRFB=y
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=0
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
+# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=y
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+CONFIG_FB_OMAP2_NUM_FBS=3
+
+#
+# OMAP2/3 Display Device Drivers
+#
+CONFIG_PANEL_GENERIC=y
+CONFIG_PANEL_SHARP_LS037V7DW01=y
+CONFIG_PANEL_SHARP_LQ043T1DG01=y
+CONFIG_PANEL_TOPPOLY_TDO35S=y
+CONFIG_PANEL_TPO_TD043MTEA1=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 # CONFIG_LCD_L4F00242T03 is not set

--GBuTPvBEOL0MYPgd--
