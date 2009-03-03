From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
Date: Tue, 3 Mar 2009 09:23:01 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427BC9B86@dbde02.ent.ti.com>
References: <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58240 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbZCCDxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 22:53:19 -0500
In-Reply-To: <5e9665e10903021848u328e0cd4m5186344be15b817@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ailus Sakari (Nokia-D/Helsinki)" <Sakari.Ailus@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of DongSoo(Nathaniel) Kim
> Sent: Tuesday, March 03, 2009 8:18 AM
> To: Tuukka.O Toivonen
> Cc: Aguirre Rodriguez, Sergio Alberto; linux-omap@vger.kernel.org;
> Ailus Sakari (Nokia-D/Helsinki); Nagalla, Hari
> Subject: Re: [REVIEW PATCH 11/14] OMAP34XXCAM: Add driver
> 
> Hi Tuukka,
> 
> I understand that it is a huge thing to support VIDIOC_S_INPUT.
> But without that, we don't have any proper "V4L2" api to get
> information about how many devices are attached to camera interface,
> and names of input devices...and so on. Because VIDIOC_ENUMINPUT and
> VIDIOC_G_INPUT needs VIDIOC_S_INPUT for prior. Of course we can
> refer
> to sysfs, but using only single set of APIs like V4L2 looks more
> decent.
> 
> What do you think about this?
> If you think that it is a big burden, can I make a patch for this?
> Cheers,
> 
[Hiremath, Vaibhav] You may want to refer to the thread on this subject.

http://marc.info/?l=linux-omap&m=122772175002777&w=2
http://marc.info/?l=linux-omap&m=122823846806440&w=2

> Nate
> 
> On Mon, Feb 23, 2009 at 5:50 PM, Tuukka.O Toivonen
> <tuukka.o.toivonen@nokia.com> wrote:
> > On Monday 23 February 2009 10:08:54 ext DongSoo(Nathaniel) Kim
> wrote:
> >> So, logically it does not make sense with making device nodes of
> every
> >> single slave attached with OMAP3camera interface. Because they
> can't
> >> be opened at the same time,even if it is possible it should not
> work
> >> properly.
> >>
> >> So.. how about making only single device node like /dev/video0
> for
> >> OMAP3 camera interface and make it switchable through V4L2 API.
> Like
> >> VIDIOC_S_INPUT?
> >
> > You are right that if the OMAP3 has several camera sensors
> attached
> > to its camera interface, generally just one can be used at once.
> >
> > However, from user's perspective those are still distinct
> > cameras. Many v4l2 applications don't support VIDIOC_S_INPUT
> > or at least it will be more difficult to use than just pointing
> > an app to the correct video device. Logically they are two
> > independent cameras, which can't be used simultaneously
> > due to HW restrictions.
> >
> > - Tuukka
> >
> 
> 
> 
> --
> ========================================================
> DongSoo(Nathaniel), Kim
> Engineer
> Mobile S/W Platform Lab. S/W centre
> Telecommunication R&D Centre
> Samsung Electronics CO., LTD.
> e-mail : dongsoo.kim@gmail.com
>           dongsoo45.kim@samsung.com
> ========================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

