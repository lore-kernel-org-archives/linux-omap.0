From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: omap3camera and linux-omap
Date: Mon, 9 Aug 2010 11:51:31 -0500
Message-ID: <A24693684029E5489D1D202277BE894456EA2D90@dlee02.ent.ti.com>
References: <4C5C129A.3020808@matrix-vision.de>
 <A24693684029E5489D1D202277BE894456DF59A3@dlee02.ent.ti.com>
 <4C6021AF.5010104@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757121Ab0HIQvm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 12:51:42 -0400
In-Reply-To: <4C6021AF.5010104@matrix-vision.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>

Hi Michael,

> -----Original Message-----
> From: Michael Jones [mailto:michael.jones@matrix-vision.de]
> Sent: Monday, August 09, 2010 10:42 AM
> To: Aguirre, Sergio
> Cc: linux-omap@vger.kernel.org; sakari.ailus@maxwell.research.nokia.com
> Subject: Re: omap3camera and linux-omap
> 
> Aguirre, Sergio wrote:
> > Hi Michael,
> >
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Michael Jones
> >> Sent: Friday, August 06, 2010 8:48 AM
> >> To: linux-omap@vger.kernel.org
> >> Cc: sakari.ailus@maxwell.research.nokia.com
> >> Subject: omap3camera and linux-omap
> >>
> >> I am currently using Sakari's omap3camera repository (branch 'devel').
> >> 'git merge-base linux-omap omap3camera' tells me that the last commit
> >> omap3camera has in common with linux-omap is 40a0c47, from July 7 2010.
> >> But there are >1000 commits which are only in omap3camera, dating back
> to
> >> 2008.
> >>
> >> Is this destined to stay this way?
> >
> > This is because devel branch keeps a detailed development history since
> we started working on the camera driver. At the end, the patches submitted
> will be a consolidated set, which should end in something around ~12
> patches or so..
> >
> >> Or will the omap3camera tree be merged into linux-omap at some point?
> >
> > The omap3camera submission is on hold, because the camera driver is
> dependant on Media controller framework, which is holding for merge in
> linux-media mailing list.
> >
> >> When proposing a patch for the omap3camera tree, should it be sent to
> this
> >> list?
> >
> > You should preferably send the patches to linux-media (at)
> vger.kernel.org mailing with cc to Sakari Ailus and Laurent Pinchart.
> >
> > So far we have been keeping patch review internally, because we didn't
> want to pollute the mailing list with patches to unsubmitted code.
> >
> > Regards,
> > Sergio
> >
> >> Thanks,
> >> Michael
> >>
> 
> Hi Sergio,
> 
> Thanks for the helpful reply.  Can you also clarify for me the difference
> between omap3camera and your linux-omap-camera
> (http://dev.omapzoom.org/?p=saaguirre/linux-omap-camera.git;a=summary)
> repositories?

No problem.

The difference is that, in my 'omap-devel' branch, you'll find:

1. Latest linux-omap master.
2. Some yet unmerged OMAP Zoom3 patches (Touchscreen, NEC LCD panel)
3. Some patches to support Beagleboard xM (OMAP3730)
4. Merged Sakari's 'devel' branch.
5. Some omap3 camera driver unmerged "legacy nodes" removal patches from Laurent Pinchart.
6. Some patches to add support for different RAW Patterns, which I'm still working on.
7. Sony IMX046 8MP CSI-2 Sensor driver, present in Zoom3.
8. LV8093 Lens actuator driver, present on Zoom3 and in tandem with IMX046 sensor

> 
> I assume this development has mainly happened on the "board-rx51*"
> platform?

Yeah, Sakari and Laurent maintain the rx51 (a.k.a. Nokia N900) camera
support.

> 
> Ultimately I want to get raw sensor data to memory.  Do you foresee any
> problems doing that with the current state of omap3camera?

It shouldn't be a problem, as soon as you configure the pipeline adequately.

Please see this Media controller testapp, maintained by Laurent Pinchart, for help on how to do that:

http://git.ideasonboard.org/?p=media-ctl.git;a=summary

 Might I be
> better off going with a kernel with v4l2_int_device at first?

I won't recommend that. You probably noticed that my tree still keeps some branches with support for that old driver, but it was for some maintenance support for a code mainline for Texas Instruments.

I'll definitely recommend to stick with the latest code, and most preferably base your work on Sakari's tree (i.e. gitorious.org/omap3camera tree), so we can all reference to a standard codebase.

I appreciate your interest in contributing with the camera driver development, and definitely looking forward for any patches you may want to share with us.

Regards,
Sergio

> 
> 
> thanks,
> Michael
> 
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-
> Joachim Reich
