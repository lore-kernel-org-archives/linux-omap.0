From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition in
 the DSS
Date: Thu, 10 Mar 2011 15:17:08 +0530
Message-ID: <AANLkTik33xNuqSi91=jobb46pMC1UJtJvQqcCt38fD8n@mail.gmail.com>
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
	<AANLkTi=xCtzgnP8e0NOWu6PZu3qB9FKbe34YYX36e1+U@mail.gmail.com>
	<19F8576C6E063C45BE387C64729E739404E1F5296F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42166 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752049Ab1CJJrJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:47:09 -0500
Received: by mail-vx0-f174.google.com with SMTP id 39so1347308vxi.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 01:47:08 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404E1F5296F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Vaibhav,

On Thu, Mar 10, 2011 at 3:09 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wr=
ote:
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Thursday, March 10, 2011 3:03 PM
>> To: Valkeinen, Tomi
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver
>> addition in the DSS
>>
>> Hi Tomi,
>>
>> On Thu, Mar 10, 2011 at 2:49 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om>
>> wrote:
>> > On Thu, 2011-03-10 at 03:00 -0600, K, Mythri P wrote:
>> >> Hi Tomi,
>> >>
>> >> On Thu, Mar 10, 2011 at 1:22 PM, Tomi Valkeinen <tomi.valkeinen@t=
i.com>
>> wrote:
>> >> > On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
>> >> >> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a
>> controller
>> >> >> to manage the enable and disable requests and synchronize audi=
o and
>> video.
>> >> >>
>> >> >> Signed-off-by: Mythri P K <mythripk@ti.com>
>> >> >
>> >> > <snip>
>> >> >
> <snip>
>> >>
>> >> I have set it to VGA , But anyways we need to fix FB to take the
>> >> feedback from the driver
>> >> for the timing , atleast when you disable the overlay set manager=
 and
>> >> enable it again.
>> >
>> > No, the FB cannot do anything with that information. FB driver can=
't
>> > change the resolution by itself. It has to happen on some upper le=
vel,
>> > in the user space.
>> >
>> > The only case when the FB can select the resolution is when the dr=
iver
>> > is loading. At that point nobody is using the framebuffer, as it d=
idn't
>> > even exist earlier. That's why I suggested reading the EDID in the
>> > probe.
>>
>> Reading the EDID during probe is not feasible ,
>> 1. To read EDID we have to enable clocks and configure HDMI , which
>> may not be intended - as probe does not mean
>> that the user would want to enable HDMI.
>> 2. If HDMI is =A0not connected at boot up , but the cable is plugged=
 in
>> later on we will run into issues.
>> There are mechanisms in v4l2 to reconfigure the overlay size and its
>> own parameters , Even if a notification is sent there is no
>> mechanism today in FB to do it.
>> What happens if FB is switched from one manager to other with
>> resolution ?
> [Hiremath, Vaibhav] Isn't we get interrupt on HDMI connection back to=
 CPU?
>
>> There is not neat way to do it today, So i think a more reasonable w=
ay
>> is to find a way to atleast
>> let the user space change the virtual size of FB dynamically given
>> there is enough VRAM allocated.
>>
> [Hiremath, Vaibhav] I think let default VRAM allocation be minimal an=
d let user configure omapfb.vram using bootargs (or IOCTL) based on his=
 requirement.
>
yes  I agree , so as Tomi also suggested i'm now setting it to VGA FB
, But it would be nice to have a sysfs to do the same,
ie FB should be able to look for the resolution of the driver it is
connected to and realloc if enough memory is present else default to
original , if there is a change in the manager.
Just a nice to have intelligence i would think.

Thanks and regards,
Mythri.
> Thanks,
> Vaibhav
>
>>
>> >
>> >> > I think you should either probe the display here to find what i=
t
>> >> > supports, and initialize the size accordingly, or if the displa=
y is
>> not
>> >> > connected, use some safe resolution most of the displays should
>> support.
>> >> > VGA probably.
>> >> >
>> >> > And the timings selected here should also be used by the hdmi d=
river.
>> >> > What happens now with my monitor is that I get a fb of 1920x102=
8, but
>> >> > the hdmi driver doesn't like the modes my monitor gives via EDI=
D, and
>> >> > falls back to VGA -> messed up display.
>> >> >
>> >> > Also, I'm getting "timeout waiting for EVSYNC" when I load or u=
nload
>> the
>> >> > driver.
>> >> >
>> >> This is ok, I have not seen any issue because of this warning,
>> >
>> > It's an error, it's not ok =3D).
>> >
>> >> Also we need to understand the rationale as to why the wait_timeo=
ut was
>> added
>> >> in the code "dispc_enable_digit_out", It seems more like a hack, =
and
>> >> not necessarily needed?
>> >
>> > When disabling, the point is to wait until the DISPC has really tu=
rned
>> > off the output. For VENC this needed waiting for EVSYNC_EVEN and O=
DD. I
>> > don't remember why the same code is ran when enabling.
>> >
>> > HDMI may work differently, so it is possible that the function nee=
ds to
>> > be fixed. But I wonder why it gives timeouts when enabling HDMI al=
so...
>> > Shouldn't the EVSYNCs happen with HDMI too?
>> >
>> > We can look at that later, presuming the timeout doesn't cause any
>> > problems.
>> >
>> HDMI is not dependent on the EVSYNC_ODD , but on EVSYNC EVEN,
>> it has never needed to wait and has not caused any issue for last 8-=
10
>> months it is being used :).
>> Why the same function was used ? Because it is a generic digit_out
>> function to do a TVENABLE.
>>
>> > =A0Tomi
>> >
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
