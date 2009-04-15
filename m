From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
 	Valkeinen, I have some questions about dss2 driver.]
Date: Wed, 15 Apr 2009 15:37:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB1A208D@dbde02.ent.ti.com>
References: <792f5f410904131400v3199fa09w14c24f01f468d1c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbZDOKHw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2009 06:07:52 -0400
In-Reply-To: <792f5f410904131400v3199fa09w14c24f01f468d1c2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tim Yamin <plasm@roo.me.uk>
Cc: "gregoire@gentil.com" <gregoire@gentil.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>



> -----Original Message-----
> From: plasmaroo@gmail.com [mailto:plasmaroo@gmail.com] On Behalf Of Tim Yamin
> Sent: Tuesday, April 14, 2009 2:30 AM
> To: Shah, Hardik
> Cc: gregoire@gentil.com; tomi.valkeinen@nokia.com; linux-omap@vger.kernel.org;
> beagleboard@googlegroups.com
> Subject: Re: YUV rotation support for DSS2 - 2.6.29 [WAS Re: Hello Tomi
> Valkeinen, I have some questions about dss2 driver.]
> 
> Hi Hardik,
> 
> Thanks for fixing up the patch. I can confirm that YUV rotation is
> fine and patches are ready to be merged -- although the attached fix
> is needed as well for the userspace layer to know the correct row
> strides when writing YUV to the framebuffer.
> 
> I'm still having VID1_FIFO_UNDERFLOW errors when I try to play rotated
> video on plane 1 and plane 0 is rotated as well. Do you have any ideas
> how to debug this further?
[Shah, Hardik] Hi Tim,
Try to increase the pixel clock to functional clock ratio to 6 or 8.  This may help as you are getting under run errors.

Thanks,
Hardik 
> 
> Thanks,
> 
> Tim
> 
> > Hi Tomi,
> > If YUV rotation with frame buffer passes can you please review the patch and
> merge it to your latest.
> >
> > Regards,
> > Hardik
