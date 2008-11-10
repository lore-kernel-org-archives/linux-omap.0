From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [Linux-fbdev-devel] [REVIEW  PATCH 0/9] DSS: Series description
Date: Mon, 10 Nov 2008 09:33:41 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02DF302D4D@dbde02.ent.ti.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58240 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbYKJEEF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Nov 2008 23:04:05 -0500
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
> ---
> 
> Tomi Valkeinen (9):
>       DSS: support for OMAP3 SDP board
>       DSS: support for Beagle Board
>       DSS: Add generic DVI panel
>       DSS: OMAPFB: fb driver for new display subsystem
>       DSS: DSI support for OMAP2/3 DSS
>       DSS: TV-out support for OMAP2/3 DSS
>       DSS: RFBI support for OMAP2/3 DSS
>       DSS: New display subsystem driver for OMAP2/3
>       DSS: Documentation for OMAP2/3 display subsystem
> 
[Shah, Hardik] We have reviewed the patches in detail and even made modifications to make it work on the OMAP3EVM. Here are our observations:

1) The overall implementation is very much in line with our earlier proposal to provide generic API that supports both V4L2 and FBDEV.
2) The implementation supports multiple output interfaces e.g. RFBI, SDI, DSI, ... that we did not have in our plans
3) You have also validated it on lot many platforms that we do not have access.

We believe patches are a good step in right direction.

We plan to use this patchset as base for supporting these additional use cases:

 a) Adding the V4L2 user interface to the video pipelines (I believe video pipelines are natural fit for the V4L2 frame work.  If use case is there for FBDEV interface we can have compile time option to expose the video pipelines as the either FBDEV or v4L2 interface).
 b) Modification of the DSS/DISPC library for supporting V4L2 user interface.
 c) Supporting the functionality like alpha blending, global alpha blending, setting of various TV standards etc.
 d) Supporting the mirroring and rotation in both FBDEV and V4L2 driver.

Do let us know if you aren't already working on any of these.

BTW, patch for supporting omap3evm will be submitted shortly.

Regards,
Vaibhav Hiremath <hvaibhav@ti.com>
Hardik Shah <hardik.shah@ti.com>
> 
> 
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

