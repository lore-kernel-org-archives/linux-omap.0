From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 09:34:46 +0100
Message-ID: <20180130083446.GA13498@lenoch>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994701AbeA3IetGEIUk (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Tue, 30 Jan 2018 09:34:49 +0100
Content-Disposition: inline
In-Reply-To: <20180129233301.GA18104@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?iso-8859-2?Q?Matijevi=E6?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 30, 2018 at 12:33:01AM +0100, Pavel Machek wrote:
> On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> > On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> > > 
> > > This adds device tree support to tlv320dac33.c.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > new file mode 100644
> > > index 0000000..6cbd311
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> > > @@ -0,0 +1,32 @@
> > > +Texas Instruments - tlv320dac33 Codec module
> > > +
> > > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible - "ti,tlv320dac33"
> > > +- reg - I2C slave address
> > > +
> > > +Optional properties:
> > > +
> > > +- power-gpios - gpio pin to power the device, active high
> > 
> > While driver used gpio in platform data, isn't it more likely
> > regulator which powers device?
> 
>                 power-gpios = <&gpio2 28 0>; /* gpio_60 */
> 
> Looks like GPIO to me -- example is from Nokia N9. So this appears to
> be correct.

Device datasheet doesn't list any pin which looks like "power-gpio"
http://www.ti.com/lit/ds/symlink/tlv320dac32.pdf
Unfortunately I do not know much about N9, but was able to find Nokia 5610
scheme to get clue how could be tlv320dac33 hardwired (see page 2):
http://mastermobile.spb.ru/service/nokia_5610_rm-242_service_schematics.pdf
Here AVDD is powered by LP3985 voltage regulator which is enabled using
VEN pin which might be connected to gpio. Or there could be completely
different voltage regulator with different controls. And since Linux
already has voltage regulator class, lets not limit ourselves to gpio
pins.

See also here about deprecated power-gpios:
Documentation/devicetree/bindings/mmc/cavium-mmc.txt
so it seems others already fallen into that trap.

	ladis
