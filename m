From: Tony Lindgren <tony@atomide.com>
Subject: Re: [v2, 3/3] ARM: dts: AM33XX: Add NAND flash device tree data to
 am335x-evm
Date: Wed, 8 May 2013 16:54:06 -0700
Message-ID: <20130508235404.GX32546@atomide.com>
References: <ebfab3e9123b3e50b9a9678c1480191addd86d59.1359007746.git.avinashphilip@ti.com>
 <517F5126.5000509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <517F5126.5000509@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, linux-mtd@lists.infradead.org, b-cousson@ti.com, linux@arm.linux.org.uk, avinash philip <avinashphilip@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gururaja.hebbar@ti.com, hvaibhav@ti.com, zonque@gmail.com, jacmet@sunsite.dk
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [130429 22:11]:
> 
> On 4/29/2013 1:25 PM, Gupta, Pekon wrote:
> > From: avinash philip <avinashphilip@ti.com>
> > 
> > NAND flash connected in am335x-evm on GPMC controller. This patch adds
> > device tree node in am3355-evm with GPMC contoller timing for NAND flash
> > interface, NAND partition table, ECC scheme, elm handle id.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > Tested-by: Pekon Gupta <pekon@ti.com>
> > 
> > ---
> > arch/arm/boot/dts/am335x-evm.dts |   98 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index 0423298..1c2fd89 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -26,7 +26,8 @@
> >  
> >  	am33xx_pinmux: pinmux@44e10800 {
> >  		pinctrl-names = "default";
> > -		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0>;
> > +		pinctrl-0 = <&matrix_keypad_s0 &volume_keys_s0
> > +			&nandflash_pins_s0>;
> 
> Why add this to the board level fallback (called pinctrl hogs, I think)?
> This can be part of nand node you added below so that the pinctrl will
> take effect when nand gets probed instead of all the time.

Yes we should have all the pinctrl entries under the related drivers.
This makes it easy remux pins during runtime if needed, and also
allows unloading pinctrl-single.ko for development.

Regards,

Tony
