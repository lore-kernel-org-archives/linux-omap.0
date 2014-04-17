From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: HDMI on OMAP4460: clk rate mismatch warning
Date: Thu, 17 Apr 2014 10:56:48 +0200
Message-ID: <CAGhQ9Vwksj+w_XmHj9_=bpT1egCU4LUFTWp8ZcNsHJeKgeJCAA@mail.gmail.com>
References: <CAGhQ9Vx-3H3yCzMv-8Mp83FWv94gOHvHP9hMiaPWHthZR_ezTQ@mail.gmail.com>
	<534E17B3.5050109@ti.com>
	<CAGhQ9Vx0RojsC=c8L_Dhg0u3uGRP3boiEtuq9XZPNMmEVtHWBg@mail.gmail.com>
	<534F81AA.8060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:43481 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaDQI4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2014 04:56:50 -0400
Received: by mail-la0-f44.google.com with SMTP id c6so136688lan.3
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2014 01:56:48 -0700 (PDT)
In-Reply-To: <534F81AA.8060805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, "Sarha, Jyri" <jsarha@ti.com>

On 17 April 2014 09:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 16/04/14 19:11, Joachim Eastwood wrote:
>> On 16 April 2014 07:40, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 15/04/14 20:36, Joachim Eastwood wrote:
>>>> Hello,
>>>>
>>>> I am trying to get HDMI work with DT on my VAR-STK-OM44 (4460) board.
>>>> But during kernel boot I get the following message:
>>>>
>>>> [ 0.953796] ------------[ cut here ]------------
>>>> [ 0.953826] WARNING: CPU: 0 PID: 1 at
>>>> drivers/video/omap2/dss/dss.c:483 dss_set_fck_rate+0x7c/0x8c()
>>>> [ 0.953826] clk rate mismatch: 153600000 != 170666666
>>>
>>> I have a fix (attached) for this in fbdev-fixes, which I'll probably be
>>> sending to Linus today. I couldn't send it in the main fbdev pull
>>> request, as it depended on clk driver changes. And it's not fatal, most
>>> likely things work fine even with the warning.
>>
>> The warning disappeared after the patch. Thanks.
>> Feel free to add: Tested-By: Joachim Eastwood <manabian@gmail.com>
>
> Thanks. It should be in -rc2.
>
>> This board (VAR-STK-OM44) has a TPD12S521 which has no controllable
>> settings so adding a driver for it would be pretty meaningless. I
>> think it's the same situation with Gumstix Parlor. That board also
>> just have a very simple HDMI transmitter which shouldn't require a
>> driver.
>>
>> But never the less I got HDMI working on my board adding the tpd21s015
>> nodes and providing a dummy gpio for "CT CP HPD". This works but it's
>> a bit hacky.
>
> Remove the tpd21s015 nodes and try the attached patch. It adds HPD
> support to the hdmi connector. You also need something like this for the
> hdmi-connector node:
>
>
> pinctrl-names = "default";
> pinctrl-0 = <&hdmi_conn_pins>;
>
> hpd-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>; /* GPIO 193, HPD */
>
>
> And the respective pinctrl node:
>
> hdmi_conn_pins: pinmux_hdmi_conn_pins {
>         pinctrl-single,pins = <
>                 0x0fe (PIN_INPUT_PULLDOWN | MUX_MODE6)
>         >;
> };
>
> Note that I tested this yesterday on one board, but I couldn't get it
> working yet, so no promises =). But that may be an issue with the HPD
> pin on the board.

Works like a charm here :)
Replugging the HDMI monitor and everything.

But I notice something strange on the monitor. Around the white login
text there are small blinking green dots. So maybe there is a timing
issue here?

Log below shows a monitor replug.
[ 63.158966] DISPC: dispc_runtime_get
[ 63.159027] DISPC: dispc_runtime_get
[ 63.159057] DISPC: dispc_runtime_put
[ 63.159057] DISPC: dispc_runtime_get
[ 63.159088] DISPC: dispc_runtime_put
[ 63.164459] DISPC: dispc_runtime_get
[ 63.164550] DISPC: dispc_runtime_put
[ 63.164550] DISPC: dispc_runtime_get
[ 63.164581] DISPC: dispc_runtime_put
[ 63.164581] DISPC: dispc_enable_plane 0, 0
[ 63.165069] DISPC: dispc_runtime_put
[ 63.165069] DISPC: dispc_runtime_get
[ 63.165069] DISPC: dispc_runtime_put
[ 83.292205] HDMI: hdmi_runtime_get
[ 83.320678] HDMI: hdmi_runtime_put
[ 83.326477] DISPC: dispc_runtime_get
[ 83.326538] DISPC: dispc_ovl_setup 0, pa 7f6a0000, pa_uv 0, sw 2048,
0,0, 1920x1200 -> 1920x1200, cmode 800, rot 0, mir 0, chan 1 repl 0
[ 83.326568] DISPC: calc_rot(0): scrw 2048, 1920x1200
[ 83.326568] DISPC: offset0 0, offset1 0, row_inc 513, pix_inc 1
[ 83.326599] DISPC: 0,0 1920x1200 -> 1920x1200
[ 83.326599] DISPC: dispc_enable_plane 0, 1
[ 83.326599] HDMI: Enter hdmi_display_disable
[ 83.328613] HDMI: hdmi_runtime_put
[ 83.328643] DISPC: dispc_runtime_put
[ 83.329010] HDMI: hdmi_get_code
[ 83.329010] HDMI: timing1_hsync = 160 timing1_vsync = 35timing2_hsync
= 160 timing2_vsync = 35
[ 83.329132] HDMI: using mode: DVI, code 68
[ 83.329132] HDMI: hdmi_get_code
[ 83.329162] HDMI: timing1_hsync = 160 timing1_vsync = 35timing2_hsync
= 160 timing2_vsync = 35
[ 83.329162] HDMI: using mode: DVI, code 68
[ 83.329162] HDMI: ENTER hdmi_display_enable
[ 83.330017] HDMI: hdmi_runtime_get
[ 83.330078] DISPC: dispc_runtime_get
[ 83.330078] HDMI: hdmi_power_on x_res= 1920 y_res = 1200
[ 83.330078] HDMIPLL: M = 641 Mf = 174762
[ 83.330139] HDMIPLL: range = 1 sd = 6
[ 83.330139] HDMIPLL: PLL locked!
[ 83.330566] HDMICORE: Enter hdmi_core_init
[ 83.330657] HDMIWP: Enter hdmi_wp_video_init_format
[ 83.330657] HDMIWP: Enter hdmi_wp_video_config_timing
[ 83.330657] HDMIWP: Enter hdmi_wp_video_config_interface
[ 83.330688] HDMICORE: Enter hdmi_core_swreset_assert
[ 83.330688] HDMICORE: Enter hdmi_core_powerdown_disable
[ 83.330718] HDMICORE: Enter hdmi_core_swreset_release
[ 83.330718] DISPC: channel 1 xres 1920 yres 1200
[ 83.330749] DISPC: dispc_runtime_get
[ 83.330749] DISPC: dispc_runtime_put
[ 83.330780] DISPC: dispc_runtime_get
[ 83.330780] DISPC: dispc_runtime_put
[ 83.330780] DISPC: dispc_runtime_get
[ 83.330810] DISPC: dispc_runtime_put
[ 83.330810] DISPC: GO DIGIT
[ 83.330841] DISPC: dispc_runtime_put
[ 83.330902] DISPC: dispc_runtime_get
[ 83.330902] DISPC: dispc_runtime_put


>> One other thing.
>> Does HDMI audio work with DT or is that a still TODO?
>> I am only getting probe deferral's from omap-hdmi-audio. Haven't look
>> to far into it.
>
> It's still on the works. If you volunteer for testing it (and Jyri needs
> someone to test), you can ask Jyri Sarha.

Jyri Sarha:

I get these messages in my log:
[ 4.290710] omap-hdmi-audio omap-hdmi-audio: ASoC: CODEC
hdmi-audio-codec not registered
[ 4.290710] omap-hdmi-audio omap-hdmi-audio: snd_soc_register_card failed (-517)
[ 4.290710] platform omap-hdmi-audio: Driver omap-hdmi-audio requests
probe deferral

"hdmi-audio-codec" should come from sound/soc/codecs/hdmi.c so added
these nodes to my DT.

hdmi_audio: hdmi_audio@0 {
    compatible = "linux,hdmi-audio";
    status = "okay";
};

But I still get the same message.

So if you have some patches you would like to have tested just tell me.


regards
Joachim Eastwood
