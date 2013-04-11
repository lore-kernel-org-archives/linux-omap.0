From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: 4430sdp nfsroot broken with ff5c9059
Date: Thu, 11 Apr 2013 02:50:07 +0200
Message-ID: <CAAwP0s20cEWAPhCC-T6TSC=n55HcevkTpKQ5HGMYRVU-tgFxAA@mail.gmail.com>
References: <20130409212318.GR10155@atomide.com> <5165A1DB.3020404@ti.com>
 <CAAwP0s395mo58b0Wf5mb7TUS8Jske-RWQMKHV2e5KEGNOXZHDw@mail.gmail.com> <516603B9.4080308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63939 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935274Ab3DKAua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 20:50:30 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so1369755iea.10
        for <linux-omap@vger.kernel.org>; Wed, 10 Apr 2013 17:50:29 -0700 (PDT)
In-Reply-To: <516603B9.4080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, Apr 11, 2013 at 2:28 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 04/10/2013 06:58 PM, Javier Martinez Canillas wrote:
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
> Right, in the above I mentioned it is working because of other gpios in
> the bank that are enabled. So I understand why it works, but wanted to
> point out that this is lucky :-)
>
> Jon
>

Indeed :-)

I just thought it could be good to explain this so others will
understand why it was working.

Sorry for the noise and I hope we find a solution for this soon

Javier
