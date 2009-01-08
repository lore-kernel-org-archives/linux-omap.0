From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: Extended driver private controls?
Date: Thu, 8 Jan 2009 10:30:47 -0600
Message-ID: <A24693684029E5489D1D202277BE8944163AAC8E@dlee02.ent.ti.com>
References: <49661FEA.5020409@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59524 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbZAHQbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 11:31:10 -0500
In-Reply-To: <49661FEA.5020409@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@nokia.com>, ext Hans Verkuil <hverkuil@xs4all.nl>
Cc: v4l <video4linux-list@redhat.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sakari Ailus
> Sent: Thursday, January 08, 2009 9:47 AM
> ext Hans Verkuil wrote:
> > Hi Sakari,
> 
> Hello,
> 
> ...
> > What I did to support private controls is to allow drivers to add their
> own
> > controls to the various classes, as long as the low 16 bits are >=
> 0x1000.
> >
> > You add them to videodev2.h (see the CX2341X private controls), and you
> just
> > pick a starting base such as 'V4L2_CTRL_CLASS_MPEG | 0x1100'.
> >
> > This way the controls are together in one header, they have unique IDs,
> and
> > you can assign them to a specific class.
> ...
> > So, to summarize: for new drivers I recommend using
> V4L2_CTRL_FLAG_NEXT_CTRL
> > and adding the private controls to videodev2.h and to prepare
> documentation
> > for inclusion with the v4l2 spec. If you really must support old apps,
> then
> > you might have to make duplicate PRIVATE_BASE controls (yuck!), but I
> hope
> > that won't be necessary.
> 
> Thanks, Hans, for the definitive answer. This is what we'll do then.
> 


Hi,

Just for clarifying: So this replaces the use of PRIVATE_BASE?:

CLASS_MPEG + 0x1000 + Custom number

Or its like:

PRIVATE_BASE + CLASS_MPEG + 0x1000 + Custom number ?

Thanks,
Sergio

> Cheers,
> 
> --
> Sakari Ailus
> sakari.ailus@nokia.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

