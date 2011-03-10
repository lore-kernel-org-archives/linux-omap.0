From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Thu, 10 Mar 2011 14:30:45 +0530
Message-ID: <AANLkTin4Uzt8Np9hgbZDSA7UBQo1dC9E7qxOa3W19JjH@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<1299671118-20839-6-git-send-email-mythripk@ti.com>
	<1299671118-20839-7-git-send-email-mythripk@ti.com>
	<1299743573.2017.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:48928 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751853Ab1CJJAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:00:46 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so1324979vws.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:00:45 -0800 (PST)
In-Reply-To: <1299743573.2017.16.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Thu, Mar 10, 2011 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
>> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controll=
er
>> to manage the enable and disable requests and synchronize audio and =
video.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>
> <snip>
>
>> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 DSSDBG("ENTER hdmi_panel_probe\n");
>> +
>> + =A0 =A0 dssdev->panel.config =3D OMAP_DSS_LCD_TFT |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IVS | OMAP_DS=
S_LCD_IHS;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Initialize the timings to 1920 * 1080
>> + =A0 =A0 =A0* This is only for framebuffer update not for TV timing=
 setting
>> + =A0 =A0 =A0* Setting TV timing will be done only on enable
>> + =A0 =A0 =A0*/
>> + =A0 =A0 dssdev->panel.timings.x_res =3D 1920;
>> + =A0 =A0 dssdev->panel.timings.y_res =3D 1080;
>
> This will cause the framebuffer to be initialized to 1920x1080,
> regardless of the timings the hdmi driver will select.

I have set it to VGA , But anyways we need to fix FB to take the
feedback from the driver
for the timing , atleast when you disable the overlay set manager and
enable it again.

>
> I think you should either probe the display here to find what it
> supports, and initialize the size accordingly, or if the display is n=
ot
> connected, use some safe resolution most of the displays should suppo=
rt.
> VGA probably.
>
> And the timings selected here should also be used by the hdmi driver.
> What happens now with my monitor is that I get a fb of 1920x1028, but
> the hdmi driver doesn't like the modes my monitor gives via EDID, and
> falls back to VGA -> messed up display.
>
> Also, I'm getting "timeout waiting for EVSYNC" when I load or unload =
the
> driver.
>
This is ok, I have not seen any issue because of this warning,
Also we need to understand the rationale as to why the wait_timeout was=
 added
in the code "dispc_enable_digit_out", It seems more like a hack, and
not necessarily needed?

> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
