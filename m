From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
 Valkeinen, I have some questions about dss2 driver.]
Date: Thu, 16 Apr 2009 13:06:29 +0300
Message-ID: <1239876389.6696.127.camel@tubuntu>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A2058@dbde02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52971 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbZDPKGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 06:06:51 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A2058@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Shah, Hardik" <hardik.shah@ti.com>
Cc: Tim Yamin <plasm@roo.me.uk>, "gregoire@gentil.com" <gregoire@gentil.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

Hi Hardik and Tim,

Thanks for the patches. They look fine to me, and are applied to my
tree.

 Tomi

On Wed, 2009-04-15 at 11:35 +0200, ext Shah, Hardik wrote:
> Hi Tomi,
> Can you please merge the YUV rotation patches with your latest?
> 
> Thanks and Regards,
> Haardik
> 
> > -----Original Message-----
> > From: plasmaroo@gmail.com [mailto:plasmaroo@gmail.com] On Behalf Of Tim Yamin
> > Sent: Tuesday, April 14, 2009 2:30 AM
> > To: Shah, Hardik
> > Cc: gregoire@gentil.com; tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org;
> > beagleboard@googlegroups.com
> > Subject: Re: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
> > Valkeinen, I have some questions about dss2 driver.]
> > 
> > Hi Hardik,
> > 
> > Thanks for fixing up the patch. I can confirm that YUV rotation is
> > fine and patches are ready to be merged -- although the attached fix
> > is needed as well for the userspace layer to know the correct row
> > strides when writing YUV to the framebuffer.
> > 
> > I'm still having VID1_FIFO_UNDERFLOW errors when I try to play rotated
> > video on plane 1 and plane 0 is rotated as well. Do you have any ideas
> > how to debug this further?
> > 
> > Thanks,
> > 
> > Tim
> > 
> > > Hi Tomi,
> > > If YUV rotation with frame buffer passes can you please review the patch and
> > merge it to your latest.
> > >
> > > Regards,
> > > Hardik

