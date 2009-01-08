From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Extended driver private controls?
Date: Thu, 8 Jan 2009 18:15:44 +0100
Message-ID: <200901081815.45074.hverkuil@xs4all.nl>
References: <A24693684029E5489D1D202277BE8944163AAC8E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:4754 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZAHRRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 12:17:00 -0500
In-Reply-To: <A24693684029E5489D1D202277BE8944163AAC8E@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, v4l <video4linux-list@redhat.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 08 January 2009 17:30:47 Aguirre Rodriguez, Sergio Alberto 
wrote:
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Sakari Ailus
> > Sent: Thursday, January 08, 2009 9:47 AM
> >
> > ext Hans Verkuil wrote:
> > > Hi Sakari,
> >
> > Hello,
> >
> > ...
> >
> > > What I did to support private controls is to allow drivers to add
> > > their
> >
> > own
> >
> > > controls to the various classes, as long as the low 16 bits are
> > > >=
> >
> > 0x1000.
> >
> > > You add them to videodev2.h (see the CX2341X private controls),
> > > and you
> >
> > just
> >
> > > pick a starting base such as 'V4L2_CTRL_CLASS_MPEG | 0x1100'.
> > >
> > > This way the controls are together in one header, they have
> > > unique IDs,
> >
> > and
> >
> > > you can assign them to a specific class.
> >
> > ...
> >
> > > So, to summarize: for new drivers I recommend using
> >
> > V4L2_CTRL_FLAG_NEXT_CTRL
> >
> > > and adding the private controls to videodev2.h and to prepare
> >
> > documentation
> >
> > > for inclusion with the v4l2 spec. If you really must support old
> > > apps,
> >
> > then
> >
> > > you might have to make duplicate PRIVATE_BASE controls (yuck!),
> > > but I
> >
> > hope
> >
> > > that won't be necessary.
> >
> > Thanks, Hans, for the definitive answer. This is what we'll do
> > then.
>
> Hi,
>
> Just for clarifying: So this replaces the use of PRIVATE_BASE?:
>
> CLASS_MPEG + 0x1000 + Custom number

Yes, this is the right one.


>
> Or its like:
>
> PRIVATE_BASE + CLASS_MPEG + 0x1000 + Custom number ?

No, forget about PRIVATE_BASE.

Regards,

	Hans

>
> Thanks,
> Sergio
>
> > Cheers,
> >
> > --
> > Sakari Ailus
> > sakari.ailus@nokia.com
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
