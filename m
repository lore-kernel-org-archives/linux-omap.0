From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [Linux-fbdev-devel] [REVIEW  PATCH 0/9] DSS: Series description
Date: Mon, 10 Nov 2008 17:33:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02DF3030A2@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.0811101313400.11080@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41428 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbYKJMET convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 07:04:19 -0500
In-Reply-To: <alpine.DEB.2.00.0811101313400.11080@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <valkeine@nokia.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:valkeine@nokia.com]
> Sent: Monday, November 10, 2008 5:01 PM
> To: Shah, Hardik
> Cc: Tomi Valkeinen; linux-fbdev-devel@lists.sourceforge.net; linux-
> omap@vger.kernel.org
> Subject: RE: [Linux-fbdev-devel] [REVIEW PATCH 0/9] DSS: Series description
> 
> Hi,
> 
> On Mon, 10 Nov 2008, ext Shah, Hardik wrote:
> 
> >>
> > [Shah, Hardik] We have reviewed the patches in detail and even made
> modifications to make it work on the OMAP3EVM. Here are our observations:
> >
> > 1) The overall implementation is very much in line with our earlier proposal
> to provide generic API that supports both V4L2 and FBDEV.
> > 2) The implementation supports multiple output interfaces e.g. RFBI, SDI,
> DSI, ... that we did not have in our plans
> > 3) You have also validated it on lot many platforms that we do not have
> access.
> >
> > We believe patches are a good step in right direction.
> >
> > We plan to use this patchset as base for supporting these additional use
> cases:
> >
> > a) Adding the V4L2 user interface to the video pipelines (I believe video
> pipelines are natural fit for the V4L2 frame work.  If use case is there for
> FBDEV interface we can have compile time option to expose the video pipelines
> as the either FBDEV or v4L2 interface).
> > b) Modification of the DSS/DISPC library for supporting V4L2 user interface.
> > c) Supporting the functionality like alpha blending, global alpha blending,
> setting of various TV standards etc.
> > d) Supporting the mirroring and rotation in both FBDEV and V4L2 driver.
> >
> > Do let us know if you aren't already working on any of these.
> 
> This sounds very good. I am not currently working on any of those items
> you mentioned. A couple of comments/thoughts about them:
> 
> a) Yes, V4L2 interface would be nice. But there are use cases for FB
> devices also, and sometimes you don't want V4L2 devices at all. So as you
> suggested, a compile time option to select this is necessary. Or, better
> yet, a runtime option.
> 
> One way to implement simultaneous FB and V4L2 devices is to have to
> separate drivers. But then this needs more locking support to DSS, and
> pobably some kind of event mechanism. For example, if both FB and V4L2
> have overlays on the same display, and one of them changes the screen
> resolution, the other one needs to know about this also.
> 
> So what I have been thinking is to have both FB and V4L2 in the same
> driver. This would make things easier. But then again, I don't know how
> much code V4L2 needs, and if the combined driver would get too complex.
> 
[Shah, Hardik] As long as the screen resolutions and timings are concerned, V4L2 driver will always take into account resolution before setting the format. Same is true for frame buffer driver before panning the display it should get the fscreen info and vscreen info and then start panning. While panning/streaming is going on any of the V4L2/FBDEV driver application has to take care of not changing the screen resolution/timing.

> b) Do you already have ideas what features V4L2 needs that are not present
> in DSS currently?
> 
[Shah, Hardik] We are working on that. We will be providing the comments on changes/modification in the DSS/DISPC in next two/three days.
> c) Yes, these would be nice.
> 
> d) These would be nice also. About rotation, I think there are three kinds
> of rotation that are handled by different entities:
> - DMA rotation, for framebuffers in SRAM. Handled by DSS.
> - External framebuffer rotation, handled by the external framebuffer
> controller.
> - VRFB rotation. This is basically a memory handling configuration, and is
> transparent to the end user (in this case, DSS) of the memory. Should be
> handled by the entity that allocates the memory, ie. omapfb.
[Shah, Hardik] so how are you planning to take care of rotation/mirroring.  We have board that only supports VRFB rotation. 

Hardik
Vaibhav

> 
>   Tomi

