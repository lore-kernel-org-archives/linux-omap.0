From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: issue with panel drivers in DSS2
Date: Fri, 15 Jan 2010 22:16:22 +0200
Message-ID: <6ed0b2681001151216h44fa7d02pe0a19ba6b801fa5c@mail.gmail.com>
References: <6ed0b2681001141259o3d81b949s69d44ab37f54c936@mail.gmail.com>
	 <1263550029.2087.242.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:57545 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184Ab0AOUQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 15:16:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so395470fga.1
        for <linux-omap@vger.kernel.org>; Fri, 15 Jan 2010 12:16:23 -0800 (PST)
In-Reply-To: <1263550029.2087.242.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jan 15, 2010 at 12:07 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Thu, 2010-01-14 at 21:59 +0100, ext Grazvydas Ignotas wrote:
>> Hi,
>>
>> there is an issue related to panel drivers:
>> even if panel driver provides get_rotate/set_rotate and/or
>> get_mirror/set_mirror functions, those cannot be accessed over sysfs=
,
>> even though corresponding entries are created in omapdss/displayX.
>> This is because panel driver fills omap_dss_driver structure, but
>> sysfs entries are created for omap_dss_device when it probes. So
>> perhaps those pointers need to be copied from omap_dss_driver to
>> omap_dss_device somewhere in dss_driver_probe().
>
> If you look at dsi.c, you'll see how it currently works. So it's the =
job
> of the interface (dpi, sdi, rfbi or dsi) to act as a intermediary, an=
d
> call the functions in the driver.
>
> Rotate and mirror aren't implemented in dpi and sdi, as I don't know =
any
> displays that could use them. But if there are such displays, dpi.c c=
an
> either just copy the driver's function in to the device struct, or
> implement an intermediary function of its own.

Pandora's TPO display supports mirroring (vertical and horizontal),
and also several resolutions. It would be nice to have this
functionality accessible somehow.

> That said, I'm actually in the process of changing the driver/device
> model a bit. My aim is that all the calls (from omapfb, sysfs etc) go
> directly to the driver code, which then will call necessary functions=
 in
> the dss to accomplish its goal.
>
> It was foolish of me to design the model the way it's now, but my
> reasoning was that all the displays of certain type must be very
> similar, and thus it's easier for everyone if the dss driver is in
> control. I coulnd't have been more wrong =3D). Especially the more co=
mplex
> DSI peripherals are unique, and the only solution is to let the drive=
r
> be in total control.
>
> But more of that later, when I have something working.

Good luck then, I should be able to do some testing as needed.

>
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
