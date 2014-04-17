From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: HDMI on OMAP4460: clk rate mismatch warning
Date: Thu, 17 Apr 2014 11:11:47 +0200
Message-ID: <CAGhQ9VyQmFwiam05Aghsc0MLTa+XnuWuxLD4v2wqJU+3jnvq+w@mail.gmail.com>
References: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
	<534E17B3.5050109@ti.com>
	<CAGhQ9Vx0RojsC=c8L_Dhg0u3uGRP3boiEtuq9XZPNMmEVtHWBg@mail.gmail.com>
	<534F81AA.8060805@ti.com>
	<CAGhQ9Vwksj+w_XmHj9_=bpT1egCU4LUFTWp8ZcNsHJeKgeJCAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37667 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbaDQJLt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 05:11:49 -0400
Received: by mail-lb0-f182.google.com with SMTP id n15so142505lbi.41
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2014 02:11:47 -0700 (PDT)
In-Reply-To: <CAGhQ9Vwksj+w_XmHj9_=bpT1egCU4LUFTWp8ZcNsHJeKgeJCAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, "Sarha, Jyri" <jsarha@ti.com>

On 17 April 2014 10:56, Joachim  Eastwood <manabian@gmail.com> wrote:
> On 17 April 2014 09:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 16/04/14 19:11, Joachim Eastwood wrote:
>>> On 16 April 2014 07:40, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>> On 15/04/14 20:36, Joachim Eastwood wrote:
>>>>> Hello,
>>>>>
>>>>> I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.
>>>>> But during kernel boot I get the following message:
>>>>>
>>>>> [ 0.953796] ------------[ cut here ]------------
>>>>> [ 0.953826] WARNING: CPU: 0 PID: 1 at
>>>>> drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
>>>>> [ 0.953826] clk rate mismatch: 153600000 != 170666666
>>>>
>>>> I have a fix (attached) for this in fbdev-fixes, which I'll probably be
>>>> sending to Linus today. I couldn't send it in the main fbdev pull
>>>> request, as it depended on clk driver changes. And it's not fatal, most
>>>> likely things work fine even with the warning.
>>>
>>> The warning disappeared after the patch. Thanks.
>>> Feel free to add: Tested-By: Joachim Eastwood <manabian@gmail.com>
>>
>> Thanks. It should be in -rc2.
>>
>>> This board (VAR-STK-OM44) has a TPD12S521 which has no controllable
>>> settings so adding a driver for it would be pretty meaningless. I
>>> think it's the same situation with Gumstix Parlor. That board also
>>> just have a very simple HDMI transmitter which shouldn't require a
>>> driver.
>>>
>>> But never the less I got HDMI working on my board adding the tpd21s015
>>> nodes and providing a dummy gpio for "CT CP HPD". This works but it's
>>> a bit hacky.
>>
>> Remove the tpd21s015 nodes and try the attached patch. It adds HPD
>> support to the hdmi connector. You also need something like this for the
>> hdmi-connector node:
>>
>>
>> pinctrl-names = "default";
>> pinctrl-0 = <&hdmi_conn_pins>;
>>
>> hpd-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>; /* GPIO 193, HPD */
>>
>>
>> And the respective pinctrl node:
>>
>> hdmi_conn_pins: pinmux_hdmi_conn_pins {
>>         pinctrl-single,pins = <
>>                 0x0fe (PIN_INPUT_PULLDOWN | MUX_MODE6)
>>         >;
>> };
>>
>> Note that I tested this yesterday on one board, but I couldn't get it
>> working yet, so no promises =). But that may be an issue with the HPD
>> pin on the board.
>
> Works like a charm here :)
> Replugging the HDMI monitor and everything.
>
> But I notice something strange on the monitor. Around the white login
> text there are small blinking green dots. So maybe there is a timing
> issue here?

That turned out to be my HDMI cable...
Changed to shorter cable and the green dots disappeared. Sorry for the
false alarm.

regards
Joachim Eastwood
