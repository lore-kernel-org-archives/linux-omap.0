From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Tue, 15 Mar 2011 10:08:14 +0530
Message-ID: <AANLkTinFx9WjyEWUyX9fZmU1h6HF6ZU2M2gWW9iT38pH@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299764643.2017.177.camel@deskari> <AANLkTi=CKaUAXtLgFOSVmhrHm2Kdt8yUzY2_07Bijqi-@mail.gmail.com>
 <1300161975.1946.7.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47192 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863Ab1COEig convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 00:38:36 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so301798bwz.5
        for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 21:38:34 -0700 (PDT)
In-Reply-To: <1300161975.1946.7.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Jan, Sebastien" <s-jan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,Sebastien,

On Tue, Mar 15, 2011 at 9:36 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Mon, 2011-03-14 at 05:37 -0500, Jan, Sebastien wrote:
>> Hi Tomi,
>>
>> On Thu, Mar 10, 2011 at 2:44 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > I think this version is good. It works for me, at least =3D).
>> >
>> > Any Panda or Blaze owners reading this want to give this a try?
>>
>> Tested on my pandaboard, with these patches applied on top of your
>> dss2 tree: I get a working display on my DVI or my HDMI screen. =3D>=
 I
>> tested by running the Ubuntu UI.
>>
>> I have a couple of these traces from times to times (seems linked to
>> screen saver enabling/disabling the screen):
>> omapdss DISPC error: timeout waiting for EVSYNC
>
> Yes, I get those every time I enable or disable the HDMI output. That
> shouldn't cause any problems, but it's something that needs to be fix=
ed
> at some point.
>
>> The best screen resolution is properly selected on both of my screen=
s,
>> but the frame-buffer is sized to 640x480. So the display works but t=
he
>> usable surface when going though /dev/fb0 is quite reduced.
>> Is there a way to get the FB sized according to the screen resolutio=
n
>> (in the init sequence, it appears that the FBs are allocated before
>> the init of the HDMI)?
>
> Currently the resolution has to be configured by the user manually. I
> haven't tried, but I think giving the resolution with boot parameters
> should also work. Mythri, have you tried that?
>
You could configure the timings later on with the sysfs ( set_timings )=
 or
HDMI driver would pick the best timing (as suggested by standard) , but
yes framebuffer would have picked the timing on probe so it will not up=
date.

> I don't think it is possible for the omapdss, panel or omapfb drivers=
 to
> configure the resolution automatically, except at boot time. After we
> have booted up, there may be users for the framebuffer and changing i=
t
> "secretly" would cause problems.
>
> I think the best way here is that the HDMI/omapdss driver gives hotpl=
ug
> event, which is conveyed through omapfb to an userspace application.
> This application can then query the available resolutions via some
> mechanism, and select one of those.
>
>> Fyi, I have also tested with the patches for DVI support and can get
>> both outputs working simultaneously (my tree is here:
>> http://dev.omapzoom.org/?p=3Dsebjan/kernel.git;a=3Dshortlog;h=3Drefs=
/tags/topic-display-iv1-2.6.38-rc7).
>
> Thanks. I'll also set up a "test" branch in DSS2 tree shortly, to whi=
ch
> I'll add DVI and HDMI patches for easier testing.
>
> =A0Tomi
>

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
