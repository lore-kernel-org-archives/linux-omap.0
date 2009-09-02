From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/18] OMAP: DSS2: Intro
Date: Wed, 2 Sep 2009 15:11:26 -0700
Message-ID: <20090902151126.f465bb15.akpm@linux-foundation.org>
References: <1251462337-12531-1-git-send-email-tomi.valkeinen@nokia.com>
	<4A9B96A7.5040005@gmail.com>
	<5e088bd90908310720p290ba68dwd6106a778fd7c740@mail.gmail.com>
	<0680EC522D0CC943BC586913CF3768C0037CE48136@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E73940436A4A9B6@dbde02.ent.ti.com>
	<20090831155518.GC16876@atomide.com>
	<4A9CC8DB.2050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753577AbZIBWLh@vger.kernel.org>
In-Reply-To: <4A9CC8DB.2050803@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: tony@atomide.com, hvaibhav@ti.com, khasim@ti.com, sakoman@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, 01 Sep 2009 10:10:19 +0300
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> Andrew,
> 
> could you please help with merging this piece of (well written) code?
> Could you give your blessing to include it into linux-next now, and
> merge this during the next merge window?

I'll merge them (after I've looked through them, which I'll do now).  

But there are more rejects than I'm prepared to cope with.  The various
arch/arm files have undergone some changes in linux-next which yield
more breakage than I'm prepared to try to fix.  For example,
arch/arm/mach-omap2/board-3430sdp.c:sdp3430_config[] ends up being an
empty array!

Then there's the matter of these patches, already in -mm:

omapfb-add-support-for-the-apollon-lcd.patch
omapfb-add-support-for-mipi-dcs-compatible-lcds.patch
omapfb-add-support-for-the-amstrad-delta-lcd.patch
omapfb-add-support-for-the-2430sdp-lcd.patch
omapfb-add-support-for-the-omap2evm-lcd.patch
omapfb-add-support-for-the-3430sdp-lcd.patch
omapfb-add-support-for-the-omap3-evm-lcd.patch
omapfb-add-support-for-the-omap3-beagle-dvi-output.patch
omapfb-add-support-for-the-gumstix-overo-lcd.patch
omapfb-add-support-for-the-zoom-mdk-lcd.patch
omapfb-add-support-for-rotation-on-the-blizzard-lcd-ctrl.patch
n770-enable-lcd-mipi-dcs-in-kconfig.patch
omapfb-dispc-various-typo-fixes.patch
omapfb-dispc-disable-iface-clocks-along-with-func-clocks.patch
omapfb-dispc-enable-wake-up-capability.patch
omapfb-dispc-allow-multiple-external-irq-handlers.patch
omapfb-suspend-resume-only-if-fb-device-is-already-initialized.patch
omapfb-fix-coding-style-remove-dead-line.patch
omapfb-add-fb-manual-update-option-to-kconfig.patch
omapfb-hwa742-fix-pointer-to-be-const.patch
