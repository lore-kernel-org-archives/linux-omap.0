From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sat, 16 Nov 2013 18:28:00 +0100
Message-ID: <5287AB20.9070407@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk> <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk> <20131116141853.GF10317@atomide.com> <5287908C.3040602@collabora.co.uk> <20131116154507.GL10317@atomide.com> <20131116160234.GB5104@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60493 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3KPR25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 12:28:57 -0500
In-Reply-To: <20131116160234.GB5104@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sebastian,

On 11/16/2013 05:02 PM, Sebastian Reichel wrote:
> On Sat, Nov 16, 2013 at 07:45:07AM -0800, Tony Lindgren wrote:
>> Well let's see what Tomi prefers.
>> 
>> > > &vaux1 {
>> > > 	/* Needed for ads7846 */
>> > > 	regulator-name = "vcc";
>> > > };
>> > > 
>> > > &vpll2 {
>> > > 	/* Needed for DSS */
>> > > 	regulator-name = "vdds_dsi";
>> > > };
>> 
>> In the long we'll use regulator phandles anyways in the DSS related
>> nodes, so from that point of view fixing dpi.c makes sense.
> 
> The hack, as being sent by Javier, will result in the wrong
> regulator being used on the Nokia N900, which is using vaux1.
> It must depend on the machine.
>

I see, so this hack is not generic enough to be usable for all OMAP3 boards so I
think is better to just add the hack on the DTS.

I was more found about adding a hack on dpi.c since the DTB is an stable ABI
while the dpi.c implementation is not. But I guess is not that bad to change the
DTS later once DSS DT bindings are added to mainline.

> At the same time the N900 device tree file uses V28 as
> regulator-name for vaux1 (which is the same one as legacy boot
> used). Nothing depends on this, but I don't think it's a
> good idea to use this property. Apparently it does not work
> if multiple drivers need the same regulator under different
> names.
> 
> -- Sebastian
> 

So, what do you think about the following patch instead?

>From 99f1c60f6db6cac07ea2c0398a9cbb3525dfdd72 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Sat, 16 Nov 2013 17:59:08 +0100
Subject: [PATCH 1/1] ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as
 vdds_dsi

On Device Tree boot the VDDS_DSI regulator is not linked to
the DPI device so omapfb driver probing fails with:

[    3.186035] OMAPFB: omapfb_probe
[    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
[    3.196594] omapfb omapfb: failed to connect default display
[    3.202667] omapfb omapfb: failed to init overlay connections
[    3.208892] OMAPFB: free_resources
[    3.212493] OMAPFB: free all fbmem
[    3.216735] omapfb omapfb: failed to setup omapfb

As a workaround name the VPLL2 regulator from twl4030 as "vdds_dsi"
so getting the VDDS_DSI regulator will succeed on dpi_init_regulator().

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
b/arch/arm/boot/dts/omap3-igep0020.dts
index b9a9e17..1c7e74d 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -215,3 +215,8 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&vpll2 {
+        /* Needed for DSS */
+        regulator-name = "vdds_dsi";
+};
-- 
1.8.4.2
