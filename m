From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Thu, 11 Apr 2013 11:58:24 +0200
Message-ID: <CAAwP0s3fjTTFTmAdQ3Ru=gECob0-Vinvs4TLQbcb2eZFb+nXWA@mail.gmail.com>
References: <20130409212318.GR10155@atomide.com> <5165A1DB.3020404@ti.com>
 <CAAwP0s395mo58b0Wf5mb7TUS8Jske-RWQMKHV2e5KEGNOXZHDw@mail.gmail.com> <516680C5.9040505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:45198 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab3DKJ6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Apr 2013 05:58:44 -0400
Received: by mail-ie0-f173.google.com with SMTP id 10so1668423ied.4
        for <linux-omap@vger.kernel.org>; Thu, 11 Apr 2013 02:58:44 -0700 (PDT)
In-Reply-To: <516680C5.9040505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Apr 11, 2013 at 11:22 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> Hi Javier,
>
> On 04/11/2013 01:58 AM, Javier Martinez Canillas wrote:
>> On Wed, Apr 10, 2013 at 7:31 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>> Hi Tony,
>>>
>>> On 04/09/2013 04:23 PM, Tony Lindgren wrote:
>>>> Hi Jon,
>>>>
>>>> Looks like at least 4430sdp nfsroot got broken with commit
>>>> ff5c9059 (ARM: dts: OMAP3+: Correct gpio #interrupts-cells
>>>> property).
>>>
>>> Thanks for reporting. I am actually amazed that ethernet is
>>> working on any OMAP board (with device-tree) that requires a
>>> gpio as an interrupt because we have still not come to an
>>> agreement on [1]. Looking at the OMAP4 SDP I believe this is
>>> working by luck because there are other gpios in the same
>>> bank that are active and so the bank is enabled. If that were
>>> not the case then this would not work.
>>>
>>
>> Hi Jon,
>>
>> Ethernet is working on 4430sdp since the optional "gpio" property is
>> specified on the fixed regulator used by the eth device node.
>>
>> From arch/arm/boot/dts/omap4-sdp.dts:
>>
>>         vdd_eth: fixedregulator-vdd-eth {
>>                 compatible = "regulator-fixed";
>>                 regulator-name = "VDD_ETH";
>>                 regulator-min-microvolt = <3300000>;
>>                 regulator-max-microvolt = <3300000>;
>>                 gpio = <&gpio2 16 0>;  /* gpio line 48 */
>>                 enable-active-high;
>>                 regulator-boot-on;
>>         };
>> ...
>> &mcspi1 {
>>         eth@0 {
>>                 compatible = "ks8851";
>>                 spi-max-frequency = <24000000>;
>>                 reg = <0>;
>>                 interrupt-parent = <&gpio2>;
>>                 interrupts = <2>; /* gpio line 34 */
>>                 vdd-supply = <&vdd_eth>;
>>         };
>> };
>>
>> So is the regulator who is calling gpio_request() and enabling the
>> GPIO bank and no the ks881 ethernet driver. That's why it was working
>> although I think is just a DT hack and should be changed once we found
>> a proper solution to fhis.
>
> It is not really a hack. There is a regulator controlled by a GPIO that
> can control the Ethernet chip power. Both gpio48 and gpio34 are used for
> Ethernet. On some SDP version there is even a third line, but I was not
> able to find any evidence in the schematic I was using.
>
> Regards,
> Benoit
>

Hi Benoit,

I (wrongly) assumed that this was made just to bypass the fact that
neither the ks881 driver nor the DT core call omap_gpio_request() to
enable the GPIO bank module.

But now thanks to your explanation I understand that gpio48 is also
necessary to control the regulator and as Jon said the lucky fact is
that both GPIO 48 and 34 are from the same GPIO bank module (gpio2).
If that was not the case, this would probably not work.

I should learn to not comment without looking at the schematic first.

Thanks a lot and best regards,
Javier
