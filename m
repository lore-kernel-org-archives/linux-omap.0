From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 10:38:38 +0100
Message-ID: <20180130093838.GA15195@lenoch>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1141b126-b883-a246-85ad-c5a69acb90bb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Filip =?iso-8859-2?Q?Matijevi=E6?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijeviæ wrote:
> Hi,
> 
> On 01/30/2018 09:53 AM, Pavel Machek wrote:
> > On Tue 2018-01-30 09:34:46, Ladislav Michl wrote:
> >> On Tue, Jan 30, 2018 at 12:33:01AM +0100, Pavel Machek wrote:
> >>> On Tue 2018-01-30 00:20:31, Ladislav Michl wrote:
> >>>> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
> >>>>>
> >>>>> This adds device tree support to tlv320dac33.c.
> >>>>>
> >>>>> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> >>>>> new file mode 100644
> >>>>> index 0000000..6cbd311
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> >>>>> @@ -0,0 +1,32 @@
> >>>>> +Texas Instruments - tlv320dac33 Codec module
> >>>>> +
> >>>>> +The tlv320dac33 serial control bus communicates through I2C protocols.
> >>>>> +
> >>>>> +Required properties:
> >>>>> +
> >>>>> +- compatible - "ti,tlv320dac33"
> >>>>> +- reg - I2C slave address
> >>>>> +
> >>>>> +Optional properties:
> >>>>> +
> >>>>> +- power-gpios - gpio pin to power the device, active high
> >>>>
> >>>> While driver used gpio in platform data, isn't it more likely
> >>>> regulator which powers device?
> >>>
> >>>                 power-gpios = <&gpio2 28 0>; /* gpio_60 */
> >>>
> >>> Looks like GPIO to me -- example is from Nokia N9. So this appears to
> >>> be correct.
> >>
> >> Device datasheet doesn't list any pin which looks like "power-gpio"
> >> http://www.ti.com/lit/ds/symlink/tlv320dac32.pdf
> >> Unfortunately I do not know much about N9, but was able to find Nokia 5610
> >> scheme to get clue how could be tlv320dac33 hardwired (see page 2):
> >> http://mastermobile.spb.ru/service/nokia_5610_rm-242_service_schematics.pdf
> >> Here AVDD is powered by LP3985 voltage regulator which is enabled using
> >> VEN pin which might be connected to gpio. Or there could be completely
> >> different voltage regulator with different controls. And since Linux
> >> already has voltage regulator class, lets not limit ourselves to gpio
> >> pins.
> > 
> > Well, notice I'm converting existing driver to device tree. And that
> > one already has GPIO dependency. It is possible that more work needs
> > to be done there, but that should not be a reason to delay this. Feel
> > free to help.

Adding DT properties that need to be maintained for compatibility reasons
is a bad idea and very good reason to delay merging unfinished stuff.
And meanwhile it turned out it is not power-gpio :)

> According to N9 schematics
> http://www.s-manuals.com/manuals/phone/nokia/nokia_n9_rm-696_service_schematics_v1.pdf
> it's in fact GPIO pin that is connected to reset line (labeled
> CODEC_RST). So calling it "power" might be misleading, but the driver
> code is quite clear as it labels that GPIO as "tlv320dac33 reset"

Thanks a lot! So now it is clear that gpio is connected to codec's nRESET pin,
therefore "reset-gpios" property seems reasonable here.

	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
