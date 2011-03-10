From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Thu, 10 Mar 2011 15:03:08 +0530
Message-ID: <AANLkTi=xCtzgnP8e0NOWu6PZu3qB9FKbe34YYX36e1+U@mail.gmail.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	<1299671118-20839-2-git-send-email-mythripk@ti.com>
	<1299671118-20839-3-git-send-email-mythripk@ti.com>
	<1299671118-20839-4-git-send-email-mythripk@ti.com>
	<1299671118-20839-5-git-send-email-mythripk@ti.com>
	<1299671118-20839-6-git-send-email-mythripk@ti.com>
	<1299671118-20839-7-git-send-email-mythripk@ti.com>
	<1299743573.2017.16.camel@deskari>
	<AANLkTin4Uzt8Np9hgbZDSA7UBQo1dC9E7qxOa3W19JjH@mail.gmail.com>
	<1299748745.2017.66.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48222 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054Ab1CJJdK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:33:10 -0500
Received: by vxg33 with SMTP id 33so1260362vxg.3
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:33:08 -0800 (PST)
In-Reply-To: <1299748745.2017.66.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Thu, Mar 10, 2011 at 2:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Thu, 2011-03-10 at 03:00 -0600, K, Mythri P wrote:
>> Hi Tomi,
>>
>> On Thu, Mar 10, 2011 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
>> >> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a contr=
oller
>> >> to manage the enable and disable requests and synchronize audio a=
nd video.
>> >>
>> >> Signed-off-by: Mythri P K <mythripk@ti.com>
>> >
>> > <snip>
>> >
>> >> +static int hdmi_panel_probe(struct omap_dss_device *dssdev)
>> >> +{
>> >> + =A0 =A0 DSSDBG("ENTER hdmi_panel_probe\n");
>> >> +
>> >> + =A0 =A0 dssdev->panel.config =3D OMAP_DSS_LCD_TFT |
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_LCD_IVS | OMAP=
_DSS_LCD_IHS;
>> >> +
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* Initialize the timings to 1920 * 1080
>> >> + =A0 =A0 =A0* This is only for framebuffer update not for TV tim=
ing setting
>> >> + =A0 =A0 =A0* Setting TV timing will be done only on enable
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 dssdev->panel.timings.x_res =3D 1920;
>> >> + =A0 =A0 dssdev->panel.timings.y_res =3D 1080;
>> >
>> > This will cause the framebuffer to be initialized to 1920x1080,
>> > regardless of the timings the hdmi driver will select.
>>
>> I have set it to VGA , But anyways we need to fix FB to take the
>> feedback from the driver
>> for the timing , atleast when you disable the overlay set manager an=
d
>> enable it again.
>
> No, the FB cannot do anything with that information. FB driver can't
> change the resolution by itself. It has to happen on some upper level=
,
> in the user space.
>
> The only case when the FB can select the resolution is when the drive=
r
> is loading. At that point nobody is using the framebuffer, as it didn=
't
> even exist earlier. That's why I suggested reading the EDID in the
> probe.

Reading the EDID during probe is not feasible ,
1. To read EDID we have to enable clocks and configure HDMI , which
may not be intended - as probe does not mean
that the user would want to enable HDMI.
2. If HDMI is  not connected at boot up , but the cable is plugged in
later on we will run into issues.
There are mechanisms in v4l2 to reconfigure the overlay size and its
own parameters , Even if a notification is sent there is no
mechanism today in FB to do it.
What happens if FB is switched from one manager to other with  resoluti=
on ?
There is not neat way to do it today, So i think a more reasonable way
is to find a way to atleast
let the user space change the virtual size of FB dynamically given
there is enough VRAM allocated.


>
>> > I think you should either probe the display here to find what it
>> > supports, and initialize the size accordingly, or if the display i=
s not
>> > connected, use some safe resolution most of the displays should su=
pport.
>> > VGA probably.
>> >
>> > And the timings selected here should also be used by the hdmi driv=
er.
>> > What happens now with my monitor is that I get a fb of 1920x1028, =
but
>> > the hdmi driver doesn't like the modes my monitor gives via EDID, =
and
>> > falls back to VGA -> messed up display.
>> >
>> > Also, I'm getting "timeout waiting for EVSYNC" when I load or unlo=
ad the
>> > driver.
>> >
>> This is ok, I have not seen any issue because of this warning,
>
> It's an error, it's not ok =3D).
>
>> Also we need to understand the rationale as to why the wait_timeout =
was added
>> in the code "dispc_enable_digit_out", It seems more like a hack, and
>> not necessarily needed?
>
> When disabling, the point is to wait until the DISPC has really turne=
d
> off the output. For VENC this needed waiting for EVSYNC_EVEN and ODD.=
 I
> don't remember why the same code is ran when enabling.
>
> HDMI may work differently, so it is possible that the function needs =
to
> be fixed. But I wonder why it gives timeouts when enabling HDMI also.=
=2E.
> Shouldn't the EVSYNCs happen with HDMI too?
>
> We can look at that later, presuming the timeout doesn't cause any
> problems.
>
HDMI is not dependent on the EVSYNC_ODD , but on EVSYNC EVEN,
it has never needed to wait and has not caused any issue for last 8-10
months it is being used :).
Why the same function was used ? Because it is a generic digit_out
function to do a TVENABLE.

> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
