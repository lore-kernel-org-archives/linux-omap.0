From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [PATCH] OMAP 2/3 V4L2 display driver on video planes
Date: Thu, 16 Oct 2008 12:39:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D61A1BF8@dbde02.ent.ti.com>
References: <8bf247760810152337w62c47f8ideaf355a0ed08771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbYJPHJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 03:09:52 -0400
In-Reply-To: <8bf247760810152337w62c47f8ideaf355a0ed08771@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ram <vshrirama@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Ram [mailto:vshrirama@gmail.com]
> Sent: Thursday, October 16, 2008 12:08 PM
> To: Shah, Hardik
> Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
> 
> Hi Hardik,
> 
> On Mon, Oct 13, 2008 at 12:26 PM, Shah, Hardik <hardik.shah@ti.com> wrote:
> > Hi Sriram,
> > Yes,
> > Current DSS-libaray is supporting only the Digital overlay manager on the V4L2 pipelines.  LCD
> overlay manager is not supported. We are in process of adding that support to DSS library.  On
> OMAP3_EVM board there is a signal integrity problem on TV out so the picture is too noisy.
> >
> 
> I am trying to port/extend/re-write the display library for video
> pipelines to support both TV and LCD. I am referring to Linux-2.6.22.
> 
> I am also referring to the display lib/V4l2 drivers that you have
> posted to see if i can extend them to support both LCD/TV.
> 
> Currently, as you said the display library does not support facilty to
> use display on the LCD.
> 
> As you are working towards it. I rather use the code developed rather
> than re-doing it.
> 
> when can we expect the patches?
> 
> 
> Thanks you,
> 
> Regards,
> sriram
> 
> 
[Shah, Hardik] Hi Sriram,
We are in process of upgrading the DSS library for supporting LCD and DVI encoders as well as adding the graphics support to it. In a month or two DSS library will be complete feature rich supporting the most of the DSS hardware functionality.  For the LCD part you can expect it around 15th of Next month.  We will post it as additional patches on top of DSS library to support more functionality.

Thanks and Regards,
Hardik  Shah

> 
> 
> > Thanks and Regards,
> > Hardik
> >
> >> -----Original Message-----
> >> From: Ram [mailto:vshrirama@gmail.com]
> >> Sent: Monday, October 13, 2008 12:12 PM
> >> To: Shah, Hardik
> >> Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
> >>
> >> Hi hardik,
> >>
> >> > Hi Sriram,
> >> > Current V4L2 display driver supports only the digital overlay manager that is on TV.  And on TV
> >> also it supports S-VIDEO.  Output of the video planes is already routed to S-Video output so there
> is
> >> no need to change the otuput.  Still I have tested that calling the VIDIOC_S_OUTPUT ioctl with the
> >> index 0  that is s-video works fine but it will again set the output to s-video.
> >> >
> >> >
> >>
> >> The DSS library has references to LCD and TV. Do you mean to say the
> >> V4L2 driver does not use the LCD path or the DSS library is not
> >> complete?
> >>
> >> On 2.6.22, The TV output looks fuzzy - I can see only B&W images and sometimes
> >> it is noisy?.
> >>
> >> Are you seeing this problem?. Is it a hardware bug/software issue?
> >>
> >>
> >> Will try S-Video. Lastweek, when i tried your patches straightaway.
> >> STREAMON ioctl was returning an error. Will look into it and update
> >> you.
> >>
> >>
> >>
> >> Thanks and Regards,
> >> sriram
> >>
> >>
> >> > Thanks and Regards,
> >> > Hardik Shah
> >> >
> >> >
> >> >
> >> >
> >> >
> >
> >

