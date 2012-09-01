From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RESEND v4 2/3] arm/dts: AM33XX: Configure pinmuxs for
 user leds control on Bone
Date: Sat, 1 Sep 2012 12:51:04 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA23682@DBDE01.ent.ti.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
 <1346141454-18786-3-git-send-email-anilkumar@ti.com>
 <20120830203505.GB1303@atomide.com>
 <C1D7B7D4-D576-4256-83F3-09689B4087C3@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA234A9@DBDE01.ent.ti.com>
 <6D25CE9A-4FA3-4F1E-9549-6A512F2FDCEC@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <6D25CE9A-4FA3-4F1E-9549-6A512F2FDCEC-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
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
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Koen,

On Sat, Sep 01, 2012 at 16:17:35, Koen Kooi wrote:
> 
> 
> Op 1 sep. 2012 om 09:01 heeft "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org> het volgende geschreven:
> 
> > Hi Koen,
> > 
> > On Fri, Aug 31, 2012 at 21:23:18, Koen Kooi wrote:
> >> 
> >> Op 30 aug. 2012, om 22:35 heeft Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> het volgende geschreven:
> >> 
> >>> * AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org> [120828 01:11]:
> >>>> Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> >>>> user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> >>>> 
> >>>> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> >>>> ---
> >>>> arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
> >>>> 1 file changed, 14 insertions(+)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> >>>> index a7906cb..58f5042 100644
> >>>> --- a/arch/arm/boot/dts/am335x-bone.dts
> >>>> +++ b/arch/arm/boot/dts/am335x-bone.dts
> >>>> @@ -18,6 +18,20 @@
> >>>>        reg = <0x80000000 0x10000000>; /* 256 MB */
> >>>>    };
> >>>> 
> >>>> +    am3358_pinmux: pinmux@44E10800 {
> >>>> +        pinctrl-names = "default";
> >>>> +        pinctrl-0 = <&userled_pins>;
> >>>> +
> >>>> +        userled_pins: pinmux_userled_pins {
> >>>> +            pinctrl-single,pins = <
> >>>> +                0x54 0x7    /* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
> >>>> +                0x58 0x17    /* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> >>>> +                0x5C 0x7    /* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> >>>> +                0x60 0x17    /* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> >>>> +            >;
> >>>> +        };
> >>>> +    };
> >>>> +
> >>> 
> >>> Looks like this patch should also claim these pins by the led driver.
> >>> Then the led driver should just do pinctrl_get_select_default(&pdev->dev)
> >>> in it's probe function to set the pins.
> >> 
> >> FWIW, I've been using this for a while now:
> >> 
> >> +       leds {
> >> +               compatible = "gpio-leds";
> >> +               heartbeat {
> >> +                       label = "beaglebone::usr0";
> >> +                       gpios = <&gpio2 21 0>;
> >> +                       linux,default-trigger = "heartbeat";
> >> +               };
> >> +
> >> +               mmc {
> >> +                       label = "beaglebone:usr1";
> >> +                       gpios = <&gpio2 22 0>;
> >> +                       linux,default-trigger = "mmc0";
> >> +               };
> > 
> > Thanks for the inputs, similar data but not exact is added to
> > v5 series.
> > 
> > +        gpio-leds {
> > +            compatible = "gpio-leds";
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&userled_pins>;
> > +
> > +            led0 {
> > +                label = "status:green:user0";
> > +                gpios = <&gpio2 21 0>;
> > +                default-state = "off";
> > +            };
> > +
> > +            led1 {
> > +                label = "status:green:user1";
> > +                gpios = <&gpio2 22 0>;
> > +                default-state = "off";
> > +            };
> > +
> > +            led2 {
> > +                label = "status:green:user2";
> > +                gpios = <&gpio2 23 0>;
> > +                default-state = "off";
> > +            };
> > +
> > +            led3 {
> > +                label = "status:green:user3";
> > +                gpios = <&gpio2 24 0>;
> > +                default-state = "off";
> > +            };
> > +        };
> > +
> > 
> > Can you review my v5 patches and tell me if there are any
> > modifications/changes required?
> 
> It would be nice to keep de heartbeat and mmc triggers like we have in the 3.2 kernel that ships with the bone
> 

I will merge your changes and repost the patches.

Thanks
AnilKumar
