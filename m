From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/4] DTS: GTA04: fix panel compatibility string
Date: Tue, 28 Nov 2017 07:10:39 -0800
Message-ID: <20171128151039.GZ28152@atomide.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <09d975dd62afa1dfa43d94079cc9a44731af4b3b.1510822218.git.hns@goldelico.com>
 <20171128145727.GY28152@atomide.com>
 <C108B0B6-FED7-44DB-9A18-39E3BE93E586@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C108B0B6-FED7-44DB-9A18-39E3BE93E586@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171128 15:04]:
> Hi Tony,
> 
> > Am 28.11.2017 um 15:57 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [171116 08:53]:
> >> Vendor string is "tpo" and not "toppoly".
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> index 4504908c23fe..ec27ed67a22a 100644
> >> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> >> @@ -86,7 +86,7 @@
> >> 
> >> 		/* lcd panel */
> >> 		lcd: td028ttec1@0 {
> >> -			compatible = "toppoly,td028ttec1";
> >> +			compatible = "tpo,td028ttec1";
> >> 			reg = <0>;
> >> 			spi-max-frequency = <100000>;
> >> 			spi-cpol;
> > 
> > Applying into omap-for-v4.15/fixes thanks. The other dts patch seems
> > like it can wait for v4.16 merge window.
> 
> Hm. Not really. It needs the panel driver to match. So either both or
> none should be applied or it will break the panel from working.
> 
> I am just 1-2 hours away from submitting a -v3 (rebased and tested
> on top of 4.15-rc1).

OK fine dropping both. Please update the description in both dts
patches to make it clear they are needed as a fix. Preferrably
with a proper fixes tag.

Having "We can remove the "omapdss," prefix" in the description sure
does not sounds like it's needed as a fix :)

Sounds like maybe these two should be just a single patch for
a proper fix?

Regards,

Tony
