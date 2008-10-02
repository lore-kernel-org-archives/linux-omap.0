From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
Date: Thu, 02 Oct 2008 11:24:52 +0300
Message-ID: <1222935892.6387.52.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E739403DC1A6657@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39038 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYJBI0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 04:26:05 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403DC1A6657@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>

Hi Vaibhav,

On Wed, 2008-10-01 at 16:21 +0530, ext Hiremath, Vaibhav wrote:
> Tomi,
> 
> Have you got a chance to review the DSS library and V4l2 driver which we have posted?

Unfortunately not very much. I've been glancing the DSS side of the
driver, but not the v4l side as I don't know much about it.

There seems to be awfully lot ifdefs for board/cpu types in the code.
Also there are strange things defined, like L4_VIRT

My biased and superficial view of the differences between my DSS and
yours is that:
- My implementation is cleaner, better organized and more generic
- My implementation has support for DSI, SDI, RFBI, L4 updates
- Your implementation has better support for "extra" things like VRFB,
color conversions, alpha etc.
- Your implementation most likely has better power management support.
- And of course what is most visible to the user, my version uses only
framebuffers, and yours uses also v4l2 devices.

As for the future, I have no choice but to keep using my DSS as we need
the features it has. I feel it would be quite a big job to get those in
to your driver. And even if I had a choice, I (unsurprisingly =) think
that my version is better and would stick to it.

Have you had time to look at my code after I changed the overlay
handling? I've put the most recent version to a public git tree at
http://www.bat.org/~tomba/git/linux-omap-dss.git/ and I'll try to keep
that up to date. 

 Tomi

> 
> Thanks,
> Vaibhav Hiremath
> Senior Software Engg.
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
> 
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Monday, September 15, 2008 9:51 PM
> > To: 'Tomi Valkeinen'
> > Cc: Shah, Hardik; linux-omap@vger.kernel.org; video4linux-list@redhat.com
> > Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
> > 
> > 
> > 
> > Thanks,
> > Vaibhav Hiremath
> > Senior Software Engg.
> > Platform Support Products
> > Texas Instruments Inc
> > Ph: +91-80-25099927
> > TI IP Ph: 509-9927
> > http://dbdwss01.india.ti.com/pspproducts/
> > 
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tomi
> > > Valkeinen
> > > Sent: Monday, September 15, 2008 8:08 PM
> > > To: Hiremath, Vaibhav
> > > Cc: Shah, Hardik; linux-omap@vger.kernel.org; video4linux-list@redhat.com
> > > Subject: RE: [PREVIEW] New display subsystem for OMAP2/3
> > >
> > > On Mon, 2008-09-15 at 19:02 +0530, ext Hiremath, Vaibhav wrote:
> > >
> > > > We more concentrated on TV and LCD interface, out design doesn't support DSI as of now. As
> > > mentioned earlier it is easily extendible to support DSI.
> > > >
> > > > If I understand your implementation correctly, right now there is no way you can switch the
> > > outputs, I mean to say from LCD to DVI. The frame buffer driver gets the handle with API
> > > omap_dss_get_display, which will return pointer to omap_display for panel-sdp3430. Henceforth all
> > > your functions will use omap_display configuring for LCD panel. How are you planning to add support
> > > for this? Through some ioctls or sysfs entry? How about switching between multiple overlay
> > managers?
> > >
> > > You can switch the outputs in the DSS driver. You can enable/disable
> > > displays individually, and configure the planes and or L4 pixel source
> > > for the display.
> > >
> > > But yes, the fb driver does not support that currently.
> > >
> > > One idea I had was to present each display with one framebuffer, so
> > > let's say we have 3 displays, we would have fb[0-2]. In addition to
> > > that, we would have two framebuffers for the video overlays. Only one of
> > > the displays can be updated with DISPC, so the overlays would appear
> > > there.
> > >
> > > Then the display that is updated with DISPC could be changed on the fly
> > > to another one, but the framebuffer arrangement would stay the same (so
> > > fb0 would still be seen on display0, even if it's now updated with L4).
> > >
> > > There's still the question how to manage the video overlays, in this
> > > scenario they would automatically move to other LCD's as the DISPC
> > > target is changed. Also the TV-out is problematic.
> > >
> > > > This issue has been addresses with our design, you can change the output either to TV, LCD or to
> > > DVI through sysfs entry. Switching between multiple overlay managers is very well supported in DSS
> > > library. Currently SYSFS is the user interface layer to control the overlay managers. But in future
> > > DSS library will easily be suitable to support media processor interface which is in concept phase
> > > right now.  RFC for the media processor is at
> > >
> > > Does your design support displays that are not updated with DISPC?
> > 
> > Yes, it should. I don't see any reason why it should fail if the display is completely independent.
> > 
> > >
> > > Your design has good points. I have to think about the overlay managers
> > > a bit more. Especially if in some future hardware there were more
> > > overlay managers instead of the current two.
> > >
> > 
> > Let me take this opportunity, shortly I will post the DSS library and V4L2 driver. We can work
> > together to add support for DSI, RFBI and SDI support to it.
> > 
> > > > http://lists-archives.org/video4linux/23652-rfc-add-support-to-query-and-change-connections-
> > inside-
> > > a-media-device.html
> > > >
> > > >
> > > > > I also wanted to be able to change the configuration on the fly,
> > > > > changing where DISPC output is going and which displays are updated with
> > > > > CPU or sDMA.
> > > > >
> > > > > This is why I have the display-concept in my design.
> > > > >
> > > >
> > > >
> > > > Here we both are on same page, you have broken the displays and modes supported into multiple
> > files
> > > registering functions to the display.c file, there are many loopholes though.
> > > >
> > > > > I haven't made support for multiple users of the displays (like separate
> > > > > fb and v4l drivers), but I don't immediately see why it couldn't be
> > > > > done.
> > > > >
> > > >
> > > > How are you going to handle the concurrency between these two?
> > >
> > > In the simple case of just an LCD and a TV-out, what are the concurrency
> > > problems? Each plane is independent of each other. Sure you need to
> > > check that the output is on if there's a plane enabled there and basic
> > > things like that. Are there some other issues I'm not seeing?
> > >
> > 
> > Yes some of the features of the DSS are tied to overlay managers and not the individual planes like
> > global alpha, alpha blending enabling and timing parameters. So while programming of these parameters
> > DSS library will have to maintain the data structures for the same and then any high level drivers
> > can query those data structures.
> > 
> > > > > However, there are some questions regarding that, as the planes do not
> > > > > represent displays, but just overlay planes. What happens when both fb
> > > > > and v4l drivers want to change the resolution or timings of the display?
> > > > >
> > > > > Also I still don't quite know how to present displays to user space.
> > > > > Currently my omapfb just uses the first display, and that's it. I think
> > > > > in the end the user (be it X server, or perhaps some entity over it),
> > > > > needs to have some understanding of what OMAP offers and how it can use
> > > > > the displays. And there probably needs to be some product spesific
> > > > > configuration regarding this in userspace.
> > > > >
> > > >
> > > > Here are you saying application will have hardware specific support? Is this feasible?
> > > >
> > >
> > > I don't see any other way. The displays are not independent of each
> > > other.  For example the OMAP3 SDP has LCD and DVI outputs. They can't be
> > > switched programmatically, but let's say it was possible. Only one of
> > > those displays can be enabled at time. If an application wants to use
> > > them both, it has to understand that they will not both work at the same
> > > time.
> > >
> > > Or if there are two DSI displays, and one is updated with DISPC and the
> > > other via L4. The application has to know that a video overlay can only
> > > be used on the first display, or it has to exchange the DISPC/L4
> > > updating order.
> > >
> > > Of course this is product specific software and configuration, not
> > > something I'm planning to put in the driver. A normal application does
> > > not have to know anything about it. I was just bringing it up to
> > > demonstrate what must be possible.
> > >
> > >  Tomi
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

