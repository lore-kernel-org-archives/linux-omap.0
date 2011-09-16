From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Fri, 16 Sep 2011 18:11:53 +0530
Message-ID: <CAP5A+B9upB3VUaRme84Fm6ewx9KkyOu4hCavMetkEeKcSHORXw@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
 <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
 <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
 <CAF6AEGuhjZgH9zFuigjfvHGM9r7jSLY2TTCD0LjZbT+Ubrb12A@mail.gmail.com>
 <CAP5A+B87w6Hir-0+SNnckQaDcO=ixgq-U8pFo2U42dwQgtUrZQ@mail.gmail.com>
 <1315984468.2172.10.camel@deskari> <CAP5A+B9uDj4kCowbEKgX1J74zWvBarp64Cn4YVom-a8BYtab4w@mail.gmail.com>
 <1315989282.2172.36.camel@deskari> <CAP5A+B-GWN+oJhcVbB24swfmH=-dE4sViNqF+hX6=D1owzOLzA@mail.gmail.com>
 <1315990630.2172.51.camel@deskari> <CAP5A+B9Me0RX3PY7Uwf=VuaHzaPtoNY0q9gxFg9H-Q3N2giC2Q@mail.gmail.com>
 <1316009509.2118.6.camel@deskari> <CAP5A+B-_19gPDmjJGBHpcDcGPGyt9QvFXFwgjGPUqr-QY9SPJg@mail.gmail.com>
 <1316066265.1880.6.camel@deskari> <CAP5A+B_WvtNTi9ckyor-+5bo7n6GkeTSAvhDsrGQxhPZWgXO0w@mail.gmail.com>
 <1316068371.1880.25.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52972 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900Ab1IPMmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 08:42:14 -0400
In-Reply-To: <1316068371.1880.25.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <robdclark@gmail.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

Hi,

On Thu, Sep 15, 2011 at 12:02 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Thu, 2011-09-15 at 11:54 +0530, K, Mythri P wrote:
>> Hi,
>>
>> On Thu, Sep 15, 2011 at 11:27 AM, Tomi Valkeinen <tomi.valkeinen@ti.=
com> wrote:
>> > On Thu, 2011-09-15 at 11:11 +0530, K, Mythri P wrote:
>> >> Hi,
>> >>
>> >> On Wed, Sep 14, 2011 at 7:41 PM, Tomi Valkeinen <tomi.valkeinen@t=
i.com> wrote:
>> >
>> >> > Yes, you are right, detect() does not "know" if the monitor has=
 changed
>> >> > between polls, so both notification and polling are needed. I
>> >> > implemented only polling as there's no HPD event mechanism yet =
in
>> >> > omapdss, and also because this was simple and gives DRM basic a=
bility to
>> >> > detect a monitor.
>> >> >
>> >> If it is needed for DRM then it is fine, but with detect renamed =
to
>> >> poll. By next week i should have a patch ready for HPD event
>> >> mechanism.
>> >
>> > What is wrong with "detect"? It detects if there's a display conne=
cted.
>> > It can be used in polling manner, trying it every n seconds, but i=
t
>> > should also be used even if you use HPD event. I think the normal
>> > sequence would be something like:
>> >
>> > 1) register HPD event
>> > 2) use detect() to see if a monitor is already connected
>> >
>> I guess polling ever few seconds to detect would be waste of CPU
>> cycles when there is already a mechanism in the H/w to detect the
>> connection.
>
> Obviously. Polling is only used if hot-plug-detect is not available. =
But
> detect function can be used even when HPD is available.
>
>> Current sequence :
>> Enable display ( Irrespective of whether the cable is connected on n=
ot)
>>
>> Sequence with HPD:
>> 1.Register for HPD connect.
>> 2.Enable display
>> 3.Notify DRM/Audio/Kernel component that wants to listen to this eve=
nt.
>
> Why would you enable the display even if there's no monitor connected=
?
>
> And when the DRM starts, how does DRM know if the display was already
> connected? Would you send a HPD event when DRM registers to the event
> even if there's no actual plug-in event done (i.e. user actually
> connecting the cable)?
>
HPD event would be triggered only when the cable is connected , and
the EDID is ready to be read by the monitor. So the question enabling
display doesnt exist. When HDMI is enabled in the HPD mode it will be
in minimal power mode.
Yes then the driver will notify DRM/any module that cable(monitor)  is
now connected.

> And just to clarify, my sequence example was from DRM's point of view=
=2E
> The HDMI driver shouldn't do anything before DRM/omapfb asks it to do
> something.
>
> =A0Tomi
>
>
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
