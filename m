From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: add dtsi for palmas
Date: Mon, 10 Jun 2013 11:29:47 +0200
Message-ID: <51B59C8B.9000405@ti.com>
References: <1370604504-32310-1-git-send-email-j-keerthy@ti.com>,
 <51B23AD5.8060006@wwwdotorg.org>
 <DC88CAD03C0052499C1907B327FC63229EAA39@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229EAA39-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "J, KEERTHY" <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Keerthy,

On 06/10/2013 06:03 AM, J, KEERTHY wrote:
> Hi Stephen,
> 
> Thanks for the review comments.
> 
> ________________________________________
> From: Stephen Warren [swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org]
> Sent: Saturday, June 08, 2013 1:26 AM
> To: J, KEERTHY
> Cc: Cousson, Benoit; devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org; lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Subject: Re: [PATCH] ARM: dts: add dtsi for palmas
> 
> On 06/07/2013 05:28 AM, J Keerthy wrote:
>> Adds palmas mfd and palmas regulator nodes. This is
>> based on the patch series:
>>
>> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg89957.html
>>
>> The device tree nodes are based on:
>> https://lkml.org/lkml/2013/6/6/25
> 
>> diff --git a/arch/arm/boot/dts/palmas.dtsi b/arch/arm/boot/dts/palmas.dtsi
> 
>> +&palmas {
> 
> Hmmm. That (i.e. requiring the board file to declare the node, then
> setting up all the content by later including this file) is an
> interesting approach. I guess it's reasonable. The one issue is that it
> makes it a little harder for the board file to override any of the
> properties in this file., although it certainly is possible by including
> those overrides after the include.
> 
> Irrespective of that, some comments on this:
> 
>> +     palmas_pmic {
> 
>> +             ti,ldo6-vibrator;
> 
> For example, what if the board doesn't want to have the property set?
> 
>> +
>> +             regulators {
>> +                     smps123_reg: smps123 {
>> +                             regulator-name = "smps123";
>> +                             regulator-min-microvolt = < 600000>;
>> +                             regulator-max-microvolt = <1500000>;
> 
> Or what if the board wants to limit the voltage range of this regulator
> due to what it's used for on the board.
> 
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
> 
> And those two properties are almost certainly board-specific policy.
> 
> Totally agree to all the above concerns. So can we have a custom .dtsi file
> for a board+pmic combination? Or have only the required properties over ridden
> in the board file?

Yes, you can do that potentially if most OMAP5 boards will reuse the
same kind of settings. Kevin has just done that for OMAP3 + twl4030.

In this case, since we do have only one board, I'm not sure it worth the
effort.

Regards,
Benoit
