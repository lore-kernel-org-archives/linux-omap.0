From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 2/2] arm/dts: Configure pinmuxs for user leds control
 on Bone
Date: Tue, 24 Jul 2012 09:11:09 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA026D0@DBDE01.ent.ti.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
 <1342769508-24810-3-git-send-email-anilkumar@ti.com>
 <20120724083007.GU6522@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120724083007.GU6522-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thanks for the review.

On Tue, Jul 24, 2012 at 14:00:08, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> [120720 00:36]:
> > Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> > user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index a4d4415..452ce3f 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -28,3 +28,18 @@
> >  };
> >  
> >  /include/ "tps65217.dtsi"
> > +
> > +&am3358_pinmux {
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&userled_pins>;
> > +
> > +	userled_pins: pinmux_userled_pins {
> > +		pinctrl-single,pins = <
> > +			0x54 0x7	/* gpmc_a5.gpio1_21, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> > +			0x58 0x17	/* gpmc_a6.gpio1_22, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> > +			0x5C 0x7	/* gpmc_a7.gpio1_23, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> > +			0x60 0x17	/* gpmc_a8.gpio1_24, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> > +		>;
> > +	};
> > +};
> 
> Let's standardize on the following minimal commenting as those can be
> search and replaced the same way when we have preprocessing available:
> 
> 		pinctrl-single,pins = <
> 			0x54 0x7	/* gpmc_a5.gpio1_21  OUTPUT | MODE7 */
> 			0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> 			0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> 			0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> 		>;
> 

Point taken, I thought the same after v2 submission. I will send the updated
version with this fix.

Thanks
AnilKumar
