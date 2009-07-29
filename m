From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: OMAP: CAM ISP: looking for a good start point
Date: Wed, 29 Jul 2009 12:01:03 -0500
Message-ID: <A24693684029E5489D1D202277BE89444A2D90F2@dlee02.ent.ti.com>
References: <200907291559.41265.linz@li-pro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59034 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755789AbZG2Q5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 12:57:21 -0400
In-Reply-To: <200907291559.41265.linz@li-pro.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Linz <linz@li-pro.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>



> -----Original Message-----
> From: Stephan Linz [mailto:linz@li-pro.net]
> Sent: Wednesday, July 29, 2009 9:00 AM
> To: linux-omap@vger.kernel.org
> Cc: Aguirre Rodriguez, Sergio Alberto;
> sakari.ailus@maxwell.research.nokia.com
> Subject: OMAP: CAM ISP: looking for a good start point
> 
> Hi Sergio, Hi Sakari,
> Hello OMAP devel team,

Hi Stephan,

> 
> as far as I can see you are working on a V4L2 driver set for the OMAP3
> Camera
> Interface Subsystem (ISP) at this time. Just I'm looking for a good start
> point to integrate your ongoing work in my own devel git tree and further
> expand it with my own sensor and board specific code. But, there are two
> different git trees hosted by gitorious:
>   * http://www.gitorious.org/omap3-linux-camera-driver
>   * http://www.gitorious.org/omap3camera/
> 
> Which of them is the latest and active development tree?

The latest OMAP Camera-ISP code is hosted by Sakari's gitorious repository here:

	http://www.gitorious.org/omap3camera/

But his repository is currently based on this commit in linux-omap:

commit f6ea2bbc8d4346c3a263ed86a92435d67f652809
Author: Roger Quadros <ext-roger.quadros@nokia.com>
Date:   Thu May 14 13:48:27 2009 -0700

    RX51: Remove multiple definition of MACH_NOKIA_RX51 in Kconfig
    
    This patch prevents "Nokia RX-51 board" from being shown twice in
    'System Type' within Menuconfig.
    
    Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

Which is somewhere around v2.6.30-rc5 kernel.

I'm currently trying to rebase this code on top of latest Kevin Hilman's linux-omap-pm Power Management branch, and I'll be publishing it here:

	http://dev.omapzoom.org/?p=saaguirre/linux-omap-camera.git;a=shortlog;h=refs/heads/devel

NOTE: I'm trying to put some sensor drivers there aswell for my 3430SDP/Zoom1 (and coming soon also for Zoom2), but I'm still trying to make it work.

The other gitorious repository was a first try to do that with an older ISP development codebase, but as I had better control under the new dev.omapzoom.org tree, I'm dropping the gitorious one.

> 
> Are there any thirt party dependencies to other kernel development? I know
> the
> IOMMU patch set by Hiroshi Doyu (http://lwn.net/Articles/321692/), it is
> all?

There's a version of the IOMMU already merged in mainline for 2.6.30 stable AFAIK, so this dependency should be no more in latest kernel.

> 
> Is there a short README or TODO list (status)?

In the works...

Thanks for the interest!

Regards,
Sergio
> 
> 
> 
> Thank you and
> Best Regards
> Stephan Linz
> 

