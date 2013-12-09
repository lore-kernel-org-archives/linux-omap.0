From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 18/26] ARM: omap3-beagle.dts: add display information
Date: Mon, 9 Dec 2013 13:16:31 +0100
Message-ID: <CABxcv=nZCrNpfmhHd8JaAD4CPg9E2wPuL8HgSCzfDeidHCCi6Q@mail.gmail.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
	<1386160133-24026-19-git-send-email-tomi.valkeinen@ti.com>
	<CABxcv=mgQM6oHf7=-EbryAcmgJm3vf+xXqHW6BCdW8ovS29O0g@mail.gmail.com>
	<52A5B248.5050303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33485 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933272Ab3LIMQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 07:16:34 -0500
Received: by mail-wi0-f178.google.com with SMTP id bz8so3494307wib.17
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 04:16:32 -0800 (PST)
In-Reply-To: <52A5B248.5050303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Tomi,

On Mon, Dec 9, 2013 at 1:06 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-12-06 10:41, Javier Martinez Canillas wrote:
>> Hi Tomi,
>>
>> On Wed, Dec 4, 2013 at 1:28 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>>  arch/arm/boot/dts/omap3-beagle.dts | 67 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 67 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
>>> index fa532aaacc68..1ca1932d02aa 100644
>>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>>> @@ -178,3 +178,70 @@
>>>         mode = <3>;
>>>         power = <50>;
>>>  };
>>> +
>>> +&dpi {
>>> +       vdds_dsi-supply = <&vpll2>;
>>> +
>>> +       dpi_out: endpoint {
>>> +               remote-endpoint = <&tfp410_in>;
>>> +               data-lines = <24>;
>>> +       };
>>> +};
>>> +
>>> +&venc {
>>> +       vdda_dac-supply = <&vdac>;
>>> +
>>> +       venc_out: endpoint {
>>> +               remote-endpoint = <&tv_connector_in>;
>>> +       };
>>> +};
>>> +
>>> +/ {
>>> +       aliases {
>>> +               display0 = &dvi0;
>>> +               display1 = &tv0;
>>> +       };
>>> +
>>> +       tfp410: encoder@0 {
>>> +               compatible = "ti,tfp410";
>>> +               gpios = <&gpio5 10 0>;  /* 170, power-down */
>>> +
>>
>> Shouldn't this be gpio6 instead since OMAP GPIO banks start counting
>> from 1 so gpio5 + 10 is GPIO 138.
>
> Yes, you're right. Good catch.
>
>>> +               ports {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +
>>> +                       port@0 {
>>> +                               reg = <0>;
>>> +
>>> +                               tfp410_in: endpoint@0 {
>>> +                                       remote-endpoint = <&dpi_out>;
>>> +                               };
>>> +                       };
>>> +
>>> +                       port@1 {
>>> +                               reg = <1>;
>>> +
>>> +                               tfp410_out: endpoint@1 {
>>> +                                       remote-endpoint = <&dvi_connector_in>;
>>> +                               };
>>> +                       };
>>> +               };
>>> +       };
>>> +
>>> +       dvi0: connector@0 {
>>> +               compatible = "ti,dvi_connector";
>>> +               i2c-bus = <&i2c3>;
>>> +
>>> +               dvi_connector_in: endpoint {
>>> +                       remote-endpoint = <&tfp410_out>;
>>> +               };
>>> +       };
>>> +
>>> +       tv0: connector@1 {
>>> +               compatible = "ti,svideo_connector";
>>> +
>>> +               tv_connector_in: endpoint {
>>> +                       remote-endpoint = <&venc_out>;
>>> +               };
>>> +       };
>>> +};
>>> --
>>> 1.8.3.2
>>>
>>
>> Also I don't see the DSS pinmux set for this board. I guess you need
>> something like the following on top:
>>
>> 0x0a4 (PIN_OUTPUT | MUX_MODE0)   /* dss_pclk.dss_pclk */
>> 0x0a6 (PIN_OUTPUT | MUX_MODE0)   /* dss_hsync.dss_hsync */
>> 0x0a8 (PIN_OUTPUT | MUX_MODE0)   /* dss_vsync.dss_vsync */
>> 0x0aa (PIN_OUTPUT | MUX_MODE0)   /* dss_acbias.dss_acbias */
>> 0x0ac (PIN_OUTPUT | MUX_MODE0)   /* dss_data0.dss_data0 */
>> 0x0ae (PIN_OUTPUT | MUX_MODE0)   /* dss_data1.dss_data1 */
>> 0x0b0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data2.dss_data2 */
>> 0x0b2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data3.dss_data3 */
>> 0x0b4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data4.dss_data4 */
>> 0x0b6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data5.dss_data5 */
>> 0x0b8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data6.dss_data6 */
>> 0x0ba (PIN_OUTPUT | MUX_MODE0)   /* dss_data7.dss_data7 */
>> 0x0bc (PIN_OUTPUT | MUX_MODE0)   /* dss_data8.dss_data8 */
>> 0x0be (PIN_OUTPUT | MUX_MODE0)   /* dss_data9.dss_data9 */
>> 0x0c0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data10.dss_data10 */
>> 0x0c2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data11.dss_data11 */
>> 0x0c4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data12.dss_data12 */
>> 0x0c6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data13.dss_data13 */
>> 0x0c8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data14.dss_data14 */
>> 0x0ca (PIN_OUTPUT | MUX_MODE0)   /* dss_data15.dss_data15 */
>> 0x0cc (PIN_OUTPUT | MUX_MODE0)   /* dss_data16.dss_data16 */
>> 0x0ce (PIN_OUTPUT | MUX_MODE0)   /* dss_data17.dss_data17 */
>> 0x0d0 (PIN_OUTPUT | MUX_MODE0)   /* dss_data18.dss_data18 */
>> 0x0d2 (PIN_OUTPUT | MUX_MODE0)   /* dss_data19.dss_data19 */
>> 0x0d4 (PIN_OUTPUT | MUX_MODE0)   /* dss_data20.dss_data20 */
>> 0x0d6 (PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
>> 0x0d8 (PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
>> 0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
>
> True. I need to add something like this to all the dts files.
>
> You didn't have muxing in the omap3-igep0020 patch you gave. Is the
> muxing already set in some other patch?
>

Your patch-set is based on v3.13-rc1 but I sent a patch-set [0] to fix
a few regressions for IGEPv2 when we moved to DT-only boot. One of
these patches added the needed DSS pinmuxing and these were included
in v3.13-rc2.

So to test your branch I cherry-picked:

d526daeb ("ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices")
50592dc3 ("ARM: dts: omap3-igep0020: Add pinmuxing for DVI output")

Also, for 3.13 I added a DT hack to make dpi_init_regulator() succeed
and find the VDDS_DSI regulator. That patch is mainline comit

2f2befd82 ("ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_dsi")

Now that I think about it, you may want to add a revert for that patch
on your series too since this hack is not needed anymore with your DSS
bindings.

>  Tomi
>

Thanks a lot and best regards,
Javier
>

[0]: http://www.spinics.net/lists/linux-omap/msg99970.html
