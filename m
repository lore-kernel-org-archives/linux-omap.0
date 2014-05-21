From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
Date: Wed, 21 May 2014 10:14:58 +0200
Message-ID: <537C6082.2000405@epfl.ch>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch> <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:49265 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbaEUIPD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 May 2014 04:15:03 -0400
In-Reply-To: <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org


On 05/20/2014 08:09 PM, Joachim Eastwood wrote:
> On 20 May 2014 16:25, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
>> Add the necessary DTS nodes to enable the micro-HDMI output on Parlor
>> board.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>  arch/arm/boot/dts/omap4-duovero-parlor.dts | 42 ++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
>> index 96f51d8..3b234b8 100644
>> --- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
>> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
>> @@ -15,6 +15,10 @@
>>         model = "OMAP4430 Gumstix Duovero on Parlor";
>>         compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
>>
>> +       aliases {
>> +               display0 = &hdmi0;
>> +       };
>> +
>>         leds {
>>                 compatible = "gpio-leds";
>>                 led0 {
>> @@ -35,6 +39,19 @@
>>                         gpio-key,wakeup;
>>                 };
>>         };
>> +
>> +       hdmi0: connector@0 {
>> +               compatible = "hdmi-connector";
>> +               label = "hdmi";
>> +
>> +               type = "d";
>> +
>> +               port {
>> +                       hdmi_connector_in: endpoint {
>> +                               remote-endpoint = <&hdmi_out>;
>> +                       };
>> +               };
>> +       };
>>  };
> 
> No, HPD (hotplug) pin?
> 
> I think Parlor has one and the "hdmi-connector" binding now supports
> it. See Tomi's 3.16/fbdev-omap branch.
> 

Looking into the details, the HPD pin of the parlor board is connected
to the OMAP4 HDMI IP. The LINK_CONNECT and LINK_DISCONNECT events are
managed by hdmi_irq_handler() in hdmi4.c to turn on/off the PHY's power.
So there is no need to use the hgp-gpios binding of "hdmi-connector"
IMHO. Correct me if I am wrong, as the public TRM is pretty thin
regarding the OMAP4 HDMI IP.

Regards,
Florian
