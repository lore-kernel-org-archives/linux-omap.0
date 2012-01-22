From: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sun, 22 Jan 2012 13:11:22 +0200
Message-ID: <CAP16Ss=jRTmfp+EmuiUUFP6J23fYJiQQEYnfCcKB9rp+kOy9BQ@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari>
	<alpine.DEB.2.00.1201210042030.28153@utopia.booyaka.com>
	<1327161427.1863.5.camel@lappy>
	<alpine.DEB.2.00.1201211344240.28153@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:34517 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab2AVLLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Jan 2012 06:11:24 -0500
Received: by mail-qy0-f180.google.com with SMTP id p15so1428402qcs.39
        for <linux-omap@vger.kernel.org>; Sun, 22 Jan 2012 03:11:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201211344240.28153@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Sat, Jan 21, 2012 at 10:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sat, 21 Jan 2012, Tomi Valkeinen wrote:
>
>> On Sat, 2012-01-21 at 00:47 -0700, Paul Walmsley wrote:
>> > On Fri, 20 Jan 2012, Tomi Valkeinen wrote:
>> >
>> > > Third, when I load the DSS modules, I see only ON state increasi=
ng for
>> > > dss_pwrdm, as it should be. However, I'm getting constant stream=
 of sync
>> > > losts from DSS, and the display doesn't basically work at all.
>> > >
>> > > I can see MPU pwrdm going into RET a lot, and if I do "while tru=
e; do
>> > > echo foo; done", which I presume basically prevents RET for MPU,=
 the
>> > > display becomes stable.
>> >
>> > If this particular problem persists after you apply the patch set =
that I
>> > sent earlier, it suggests that something in the DSS is sensitive t=
o the
>> > amount of time it takes the MPU to wake up and service an interrup=
t when
>> > the MPU powerdomain is in a low-power state. =A0Total guess, but p=
erhaps
>> > omap_dispc_irq_handler() is getting called after each frame and ne=
eds to
>> > run within a certain bounded time when that happens?
>>
>> No. After the DSS has been configured and started (by the MPU), it r=
uns
>> by itself, reading the pixels from the memory displaying them on the
>> screen. Only when the user wants to change the configs or the frame,=
 the
>> MPU does something. And interrupts are only needed to handle the
>> changing of configs or frame data using VSYNCs as the interval. The =
user
>> probably doesn't like it if the VSYNC irq is handled a few seconds
>> later, but the DSS HW doesn't care, and functions normally.
>>
>> In this case something is affecting the DSS (clocks? powers?), or th=
e
>> memory, or the process of reading the pixels. I really don't see the=
 MPU
>> or IRQs affecting this problem, except indirectly.
>
> Okay, thanks for the quick response.
>
> Would you expect to see these "sync lost" messages if the DSS FIFO(s)=
 are
> underflowing? =A0Or would that return a different error? =A0Am wonder=
ing if
> CORE may be entering some low power state, so DSS FIFO refill may be
> taking too long.

I would expect to see FIFO_UNDERFLOW errors. Then again, I have to
admit I'm not totally sure what SYNC LOST error means. My
understanding is that it's about DSS internal timings and fifos, for
example when DSS is scaling the image and if the scaler cannot get
pixels fast enough from the preceding HW block.

 Tomi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
