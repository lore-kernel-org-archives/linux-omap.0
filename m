From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Mon, 15 Sep 2008 15:05:34 +0300
Message-ID: <1221480334.6312.54.camel@tubuntu>
References: <1221144955.12281.6.camel@tubuntu>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com>
	 <20080912152937.GP31563@intune.research.nokia.com>
	 <92846148-6506-47F1-8643-7333FB5E146A@student.utwente.nl>
	 <yw1xbpyr3egz.fsf@thrashbarg.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63794 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYIOMHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2008 08:07:21 -0400
In-Reply-To: <yw1xbpyr3egz.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: linux-omap@vger.kernel.org, video4linux-list@redhat.com

On Sat, 2008-09-13 at 22:47 +0100, ext M=C3=A5ns Rullg=C3=A5rd wrote:
> Koen Kooi <k.kooi@student.utwente.nl> writes:
>=20
> > Op 12 sep 2008, om 17:29 heeft Daniel Stone het volgende geschreven=
:
> >
> >> On Fri, Sep 12, 2008 at 07:59:44PM +0530, ext Shah, Hardik wrote:
> >>> It's time to re-design DSS frame buffer driver for the OMAP2/3.
> >>> Current frame buffer driver is not covering the most of the
> >>> functionality of the OMAP2/3 DSS Hardware like multiple outputs a=
nd
> >>> multiple overlay managers supported by OMAP2/3 class of SoC. Agai=
n
> >>> there is no V4L2 interface exposed by the DSS drivers for
> >>> controlling the video pipelines of the DSS which is highly
> >>> desirable feature as the video pipelines of the DSS hardware is a
> >>> natural fit to the V4L2 architecture.
> >>
> >> If you want to use v4l for video output, don't let me stop you, bu=
t I
> >> don't see that it has much actual wide use beyond TI PowerPoint
> >> presentations about their graphical architecture.
> >
> > That was my thought as well, but I've encountered at least 2 produc=
ts
> > this weekend at IBC using the v4l way on omap3. One of the engineer=
s
> > was complaining about the lack of synchronous updates if you move
> > various videoplanes around (think resizing video windows) which mak=
es
> > the video picture end up outside your nice cairo-drawn borders. So
> > yes, it is getting used outside of TI :)
>=20
> I'm thinking the best solution is probably to have a low-level
> internal driver providing access to various planes, exposing as much
> functionality as is practical.  Various user-space interfaces, such a=
s
> fbdev and v4l, could then be implemented on top of this with very
> little code.  If I've understood things correctly, this is essentiall=
y
> what the patch in this thread is doing.  This approach should let the
> TI people and Koen's mythical friends from IBC use the v4l2 interface=
,
> while still allowing the less masochistic among us to use a simpler
> interface.

Yes, that was my idea while implementing the driver.

> What I don't like about the patch posted is its size.  I'm sure the
> transition could be done in a sequence of smaller patches.  At the
> very least, it should be possible to move existing functionality to
> the new architecture, then add the new parts afterwards.  I also see
> little value in keeping the old model around, as is done in the patch=
=2E

I don't like the size either. However, I have no idea how the old drive=
r
could be transformed to include this functionality with a reasonable
effort. The implementations are quite different.

Any suggestions how I could approach this task? Only thing that comes t=
o
my mind is that there are very similar low level functions in both DSS1
and DSS2 (for dispc and rfbi), that I could remove from the old place
and move to arch/arm/plat-omap/dss/, but that doesn't take us very far.

I wanted to keep the old driver because it works and contains drivers
for many displays. At some point my driver could of course include
these, but it may take time. Also, the old driver supports OMAP1, mine
doesn't.

 Tomi

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
