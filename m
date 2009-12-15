From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
	non-dss2)
Date: Tue, 15 Dec 2009 19:01:32 +0300
Message-ID: <48239d390912150801y70da9d46k637c01d8da3a5595@mail.gmail.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:32707 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654AbZLOQBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 11:01:34 -0500
Received: by ey-out-2122.google.com with SMTP id d26so23091eyd.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 08:01:32 -0800 (PST)
In-Reply-To: <1260890578.6017.11.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 15, 2009 at 6:22 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Hi,
>
> On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
>> dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
>> OMAP: OMAPFB: add omapdss device
>>
>>     The upcoming new display subsystem driver is divided to two devices,
>>     omapdss and omapfb, of which omapdss handles the actual hardware.
>>
>>     This patch adds a dummy omapdss platform device for the current omapfb
>>     driver, which is then used to get the clocks. This will make it possible
>>     for the current and the new display drivers to co-exist.
>>
>>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>>     Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> breaks old omapfb.
>
> I didn't look at this further, but I quickly tested with OMAP3 SDP
> board, reverting the patch that makes SDP use DSS2, and it seems to work
> fine with the old omapfb.

I have to patch like this to make it work without reverting:

diff --git a/arch/arm/mach-omap2/clock34xx_data.c
b/arch/arm/mach-omap2/clock34xx_data.c
index 8bdcc9c..2848a87 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3137,6 +3137,13 @@ static struct omap_clk omap34xx_clks[] = {
        CLK("omapdss",  "dss2_fck",     &dss2_alwon_fck, CK_343X),
        CLK("omapdss",  "ick",          &dss_ick_3430es1,       CK_3430ES1),
        CLK("omapdss",  "ick",          &dss_ick_3430es2,       CK_3430ES2),
+       CLK("omapfb",   "dss1_fck",     &dss1_alwon_fck_3430es1, CK_3430ES1),
+       CLK("omapfb",   "dss1_fck",     &dss1_alwon_fck_3430es2, CK_3430ES2),
+       CLK("omapfb",   "tv_fck",       &dss_tv_fck,    CK_343X),
+       CLK("omapfb",   "video_fck",    &dss_96m_fck,   CK_343X),
+       CLK("omapfb",   "dss2_fck",     &dss2_alwon_fck, CK_343X),
+       CLK("omapfb",   "ick",          &dss_ick_3430es1,       CK_3430ES1),
+       CLK("omapfb",   "ick",          &dss_ick_3430es2,       CK_3430ES2),
        CLK(NULL,       "cam_mclk",     &cam_mclk,      CK_343X),
        CLK(NULL,       "cam_ick",      &cam_ick,       CK_343X),
        CLK(NULL,       "csi2_96m_fck", &csi2_96m_fck,  CK_343X),


Thanks a lot,
S.
