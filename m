From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PREVIEW] New display subsystem for OMAP2/3
Date: Sat, 13 Sep 2008 22:47:40 +0100
Message-ID: <yw1xbpyr3egz.fsf@thrashbarg.mansr.com>
References: <1221144955.12281.6.camel@tubuntu> <5A47E75E594F054BAF48C5E4FC4B92AB02C42B43C8@dbde02.ent.ti.com> <20080912152937.GP31563@intune.research.nokia.com> <92846148-6506-47F1-8643-7333FB5E146A@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55237 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbYIMVsB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Sep 2008 17:48:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KecyB-0002QD-Kr
	for linux-omap@vger.kernel.org; Sat, 13 Sep 2008 21:47:55 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 13 Sep 2008 21:47:55 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 13 Sep 2008 21:47:55 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: video4linux-list@redhat.com

Koen Kooi <k.kooi@student.utwente.nl> writes:

> Op 12 sep 2008, om 17:29 heeft Daniel Stone het volgende geschreven:
>
>> On Fri, Sep 12, 2008 at 07:59:44PM +0530, ext Shah, Hardik wrote:
>>> It's time to re-design DSS frame buffer driver for the OMAP2/3.
>>> Current frame buffer driver is not covering the most of the
>>> functionality of the OMAP2/3 DSS Hardware like multiple outputs and
>>> multiple overlay managers supported by OMAP2/3 class of SoC. Again
>>> there is no V4L2 interface exposed by the DSS drivers for
>>> controlling the video pipelines of the DSS which is highly
>>> desirable feature as the video pipelines of the DSS hardware is a
>>> natural fit to the V4L2 architecture.
>>
>> If you want to use v4l for video output, don't let me stop you, but =
I
>> don't see that it has much actual wide use beyond TI PowerPoint
>> presentations about their graphical architecture.
>
> That was my thought as well, but I've encountered at least 2 products
> this weekend at IBC using the v4l way on omap3. One of the engineers
> was complaining about the lack of synchronous updates if you move
> various videoplanes around (think resizing video windows) which makes
> the video picture end up outside your nice cairo-drawn borders. So
> yes, it is getting used outside of TI :)

I'm thinking the best solution is probably to have a low-level
internal driver providing access to various planes, exposing as much
functionality as is practical.  Various user-space interfaces, such as
fbdev and v4l, could then be implemented on top of this with very
little code.  If I've understood things correctly, this is essentially
what the patch in this thread is doing.  This approach should let the
TI people and Koen's mythical friends from IBC use the v4l2 interface,
while still allowing the less masochistic among us to use a simpler
interface.

What I don't like about the patch posted is its size.  I'm sure the
transition could be done in a sequence of smaller patches.  At the
very least, it should be possible to move existing functionality to
the new architecture, then add the new parts afterwards.  I also see
little value in keeping the old model around, as is done in the patch.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
