From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Sun, 27 Oct 2013 14:26:31 +0100
Message-ID: <CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost> <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk> <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk> <20130708093410.GT5523@atomide.com>
 <20130708142103.GX21614@n2100.arm.linux.org.uk> <51ECFDFD.60102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33668 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3J0N0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Oct 2013 09:26:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id as1so9690551iec.13
        for <linux-omap@vger.kernel.org>; Sun, 27 Oct 2013 06:26:51 -0700 (PDT)
In-Reply-To: <51ECFDFD.60102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tomi,

On Mon, Jul 22, 2013 at 11:40 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 08/07/13 17:21, Russell King - ARM Linux wrote:
>
>> Also looks like the nonfunctional video stuff is even more nonfunctional
>> than usual:
>>
>> omapdss DSI error: can't get VDDS_DSI regulator
>> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator

I have the same issue when trying to get VDI output working on a IGEPv2 board.

>
> Those should be followed by "...requests probe deferral", and the driver
> is probed again later.
>

When booting with DT the omapfb's probe is deferred several times but
it always fails on dpi_connect() due not being able to get the
VDDS_DSI regulator:

[    3.186035] OMAPFB: omapfb_probe
[    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
[    3.196594] omapfb omapfb: failed to connect default display
[    3.202667] omapfb omapfb: failed to init overlay connections
[    3.208892] OMAPFB: free_resources
[    3.212493] OMAPFB: free all fbmem
[    3.216735] omapfb omapfb: failed to setup omapfb
[    3.221832] platform omapfb: Driver omapfb requests probe deferral
[    3.231689] OMAPFB: omapfb_probe
[    3.236175] omapdss DPI error: can't get VDDS_DSI regulator
[    3.242248] omapfb omapfb: failed to connect default display
[    3.248291] omapfb omapfb: failed to init overlay connections
[    3.254394] OMAPFB: free_resources
[    3.258026] OMAPFB: free all fbmem
[    3.262268] omapfb omapfb: failed to setup omapfb
[    3.267303] platform omapfb: Driver omapfb requests probe deferral

My complete boot log is [1]

I tracked down to dpi_init_regulator in drivers/video/omap2/dss/dpi.c

static int dpi_init_regulator(void)
{
....
        vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
        if (IS_ERR(vdds_dsi)) {
                DSSERR("can't get VDDS_DSI regulator\n");
                return PTR_ERR(vdds_dsi);
        }
....
}

So I tried adding this to my DT with no luck.

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
b/arch/arm/boot/dts/omap3-igep0020.dts
index 17a6fc1..eaae935 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -256,3 +256,8 @@
 &usbhsehci {
        phys = <&hsusb1_phy>;
 };
+
+&vpll2 {
+        supply-dev = "omapdss_dpi.0";
+        supply = "vdds_dsi";
+};


Now what you said does indeed happen when booting with the legacy
board file. omapfb fails the first time with "can't get VDDS_DSI
regulator"
but the driver is probed again and it succeeds.

I tried to spot a difference but didn't find it...

> The log
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=946
> shows "taal display2: panel revision e3.83.7d" which hints that the
> panel (and DSS) was initialized properly.
>
> Those error prints should probably be tuned down a bit now that the
> driver uses probe deferral.
>
>  Tomi
>
>

fwiw, my wip branch is [2]:

Javier Martinez Canillas (3):
      ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
      ARM: dts: omap3-igep0020: Add pinmuxig for DVI output
      ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus

Any hints will be highly appreciated.

Thanks a lot and best regards,
Javier

[1]: http://fpaste.org/49736/79384138/raw/
[2]: https://github.com/martinezjavier/linux/commits/igep-video-wip
