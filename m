From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [Linux-fbdev-devel] [REVIEW  PATCH 0/9] DSS: Series description
Date: Tue, 18 Nov 2008 12:10:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E228767B@dbde02.ent.ti.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49105 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbYKRGkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 01:40:23 -0500
In-Reply-To: <20081104160946.19071.44903.stgit@tubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, November 04, 2008 9:40 PM
> To: linux-fbdev-devel@lists.sourceforge.net
> Cc: linux-omap@vger.kernel.org
> Subject: [Linux-fbdev-devel] [REVIEW PATCH 0/9] DSS: Series description
> 
> New Display Subsystem for OMAP2/3
> ---------------------------------
> 
> This patch set implements new Display Subsystem (DSS) for OMAP2/3 processors.
> The DSS is still under work and these patches are for review. Note that there
> is also another new DSS implementation from TI.
> 
> The DSS has been tested on OMAP3 SDP board, Beagle Board and on two unreleased
> boards with DSI and SDI displays. The DSS used to work on OMAP2 board also,
> but
> it's been a while since I was able to test with OMAP2 board.
> 
> The first patch is a doc file that tries to explain a bit how the drivers
> work.
> 
> The patch set is based on the current linux-omap tree.
> 
> You can find the patches also from a git tree at
> http://www.bat.org/~tomba/git/linux-omap-dss.git/
> 
> Note that you also need two patches from Mans Rullgard to make things work.
> These
> are needed to be able to reconfigure DSS functional clock.
> http://git.mansr.com/?p=linux-
> omap;a=commit;h=e2de5e5578fbaa9b4b75074796da0608fc93e6ae
> http://git.mansr.com/?p=linux-
> omap;a=commit;h=2b7b958dc79e51127d7a4ecf88ce12dbc6c31426
> 
> Questions/problems
> ------------------
> 
> Perhaps the biggest problems I have is the interface to user space. OMAP
> hardware doesn't quite fit in to the framebuffer framework. The problem is
> that
> a framebuffer can go to multiple overlays, and also the target display, to
> which a framebuffer goes, can change.  In addition, the framebuffer size is
> used as overlay size, not display resolution. So a framebuffer != display.
> 
> I believe DRM modesetting could be of help here, at least partially, but I
> haven't tried that approach yet.
> 
> But DRM modesetting wouldn't solve all the problems. For example, we still
> need
> to configure overlays and overlay managers, and they don't quite belong to
> either the framebuffer side or the display side. Currently you configure them
> via a hackish sysfs interface, but I've been wondering if a /dev/omap-dss
> device with ioctls would be a better choice.
> 
> There's currently no V4L2 support, but I have been thinking about that. I
> don't
> want to make any hardcoded configuration for those, because sometimes you want
> to use framebuffer devices for video overlays. So what I'd like to have is a
> way, compile time or run time, to configure which overlays go to framebuffer
> devices and which go to V4L2 devices.
>
[Shah, Hardik] Hi Tomi,
We are successful to bring up the basic functionality of the V4L2 driver onto your patches.  We will be posting those patches in a day or two. Based on our V4L2 driver development we have few questions/suggestions on DSS patches you submitted. 
1.	Display enable function is returning false if the display is already 	enabled.  Instead it should just return without error if display is 	already enabled as V4L2 and fbdev both may be enabling it without each 	other's knowledge.

2.	Second display enable/disable should maintain the reference count as 	disabling of the display by one driver will leave other driver without 	display.

3.	I think the row increment value should not be calculate inside the dispc.c 	file instead high level driver will pass the value it requires based on 	his buffer requirement and dispc.c should program it dumbly.  This is 	mainly due to the odd row_inc_value requirement for the VRFB space.

4.    There is API in dispc.c file to change pixel increment value.

5.	We need separate API to enable the plane and enable the clocks. 	Once 	the clock is enabled driver can directly go and program registers 	through low level dispc APIs instead of dispc APIs enabling the clock for 	each register programming and then disabling it. 
	
	This will avoid the enabling and disabling of the clocks for each 	frame displayed.  As for V4L2 interface driver will enable 	planes and 	clocks during VIDIOC_STREAMON ioctls and during the streaming it will 	just change the buffer address for displaying frames. This way delay 	between the enabling/disabling of the clocks can also be saved.  It 	would be driver's responsibility to enable the clocks before programming 	any registers.  Same may be true for setting the GO bit of the respective 	overlay managers.

6.	We also need a public API to program the color conversion values.  Some 	application may need to program it differently than standard values.



Thanks and Regards,
Hardik Shah
Vaibhav Hiremath


 
> --
>  Tomi Valkeinen
> 
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

