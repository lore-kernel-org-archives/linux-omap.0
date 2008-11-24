From: "Arun KS" <getarunks@gmail.com>
Subject: Re: [REVIEW PATCH 0/9] DSS: Series description
Date: Mon, 24 Nov 2008 11:56:56 +0530
Message-ID: <dfeb90390811232226v2235e241tf0f353aa7703b14d@mail.gmail.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:26908 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYKXG06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 01:26:58 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1193915tic.23
        for <linux-omap@vger.kernel.org>; Sun, 23 Nov 2008 22:26:56 -0800 (PST)
In-Reply-To: <20081104160946.19071.44903.stgit@tubuntu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tue, Nov 4, 2008 at 9:39 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> New Display Subsystem for OMAP2/3
> ---------------------------------
>
> This patch set implements new Display Subsystem (DSS) for OMAP2/3 processors.
> The DSS is still under work and these patches are for review. Note that there
> is also another new DSS implementation from TI.
>
> The DSS has been tested on OMAP3 SDP board, Beagle Board and on two unreleased
> boards with DSI and SDI displays. The DSS used to work on OMAP2 board also, but
> it's been a while since I was able to test with OMAP2 board.
>
> The first patch is a doc file that tries to explain a bit how the drivers work.
>
> The patch set is based on the current linux-omap tree.
>
> You can find the patches also from a git tree at
> http://www.bat.org/~tomba/git/linux-omap-dss.git/
>
> Note that you also need two patches from Mans Rullgard to make things work. These
> are needed to be able to reconfigure DSS functional clock.
> http://git.mansr.com/?p=linux-omap;a=commit;h=e2de5e5578fbaa9b4b75074796da0608fc93e6ae
> http://git.mansr.com/?p=linux-omap;a=commit;h=2b7b958dc79e51127d7a4ecf88ce12dbc6c31426
>
> Questions/problems
> ------------------
>
> Perhaps the biggest problems I have is the interface to user space. OMAP
> hardware doesn't quite fit in to the framebuffer framework. The problem is that
> a framebuffer can go to multiple overlays, and also the target display, to
> which a framebuffer goes, can change.  In addition, the framebuffer size is
> used as overlay size, not display resolution. So a framebuffer != display.
>
> I believe DRM modesetting could be of help here, at least partially, but I
> haven't tried that approach yet.
>
> But DRM modesetting wouldn't solve all the problems. For example, we still need
> to configure overlays and overlay managers, and they don't quite belong to
> either the framebuffer side or the display side. Currently you configure them
> via a hackish sysfs interface, but I've been wondering if a /dev/omap-dss
> device with ioctls would be a better choice.
>
> There's currently no V4L2 support, but I have been thinking about that. I don't
> want to make any hardcoded configuration for those, because sometimes you want
> to use framebuffer devices for video overlays. So what I'd like to have is a
> way, compile time or run time, to configure which overlays go to framebuffer
> devices and which go to V4L2 devices.
>
> ---
>
> Tomi Valkeinen (9):
>      DSS: support for OMAP3 SDP board
>      DSS: support for Beagle Board
>      DSS: Add generic DVI panel
>      DSS: OMAPFB: fb driver for new display subsystem
>      DSS: DSI support for OMAP2/3 DSS
>      DSS: TV-out support for OMAP2/3 DSS
>      DSS: RFBI support for OMAP2/3 DSS
>      DSS: New display subsystem driver for OMAP2/3
>      DSS: Documentation for OMAP2/3 display subsystem
>
>
>  Documentation/arm/OMAP/DSS                |  240 ++
>  arch/arm/mach-omap2/board-3430sdp.c       |  234 ++
>  arch/arm/mach-omap2/board-omap3beagle.c   |  121 +
>  arch/arm/plat-omap/Kconfig                |    2
>  arch/arm/plat-omap/Makefile               |    2
>  arch/arm/plat-omap/dss/Kconfig            |   66 +
>  arch/arm/plat-omap/dss/Makefile           |    6
>  arch/arm/plat-omap/dss/dispc.c            | 1667 ++++++++++++++++
>  arch/arm/plat-omap/dss/display.c          |  781 +++++++
>  arch/arm/plat-omap/dss/dpi.c              |  303 +++
>  arch/arm/plat-omap/dss/dsi.c              | 3027 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/dss/dss.c              |  547 +++++
>  arch/arm/plat-omap/dss/dss.h              |  240 ++
>  arch/arm/plat-omap/dss/rfbi.c             | 1234 ++++++++++++
>  arch/arm/plat-omap/dss/sdi.c              |  154 +
>  arch/arm/plat-omap/dss/venc.c             |  499 +++++
>  arch/arm/plat-omap/fb.c                   |    9
>  arch/arm/plat-omap/include/mach/display.h |  458 ++++
>  arch/arm/plat-omap/include/mach/omapfb.h  |    7
>  drivers/video/Kconfig                     |    1
>  drivers/video/Makefile                    |    1
>  drivers/video/omap/Kconfig                |    5
>  drivers/video/omap2/Kconfig               |   54 +
>  drivers/video/omap2/Makefile              |    5
>  drivers/video/omap2/omapfb-ioctl.c        |  428 ++++
>  drivers/video/omap2/omapfb-main.c         | 1247 ++++++++++++
>  drivers/video/omap2/omapfb-sysfs.c        |  833 ++++++++
>  drivers/video/omap2/omapfb.h              |  104 +
>  drivers/video/omap2/panel-dvi.c           |  121 +
>  drivers/video/omap2/panel-sdp3430.c       |  110 +
>  30 files changed, 12479 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/arm/OMAP/DSS
>  create mode 100644 arch/arm/plat-omap/dss/Kconfig
>  create mode 100644 arch/arm/plat-omap/dss/Makefile
>  create mode 100644 arch/arm/plat-omap/dss/dispc.c
>  create mode 100644 arch/arm/plat-omap/dss/display.c
>  create mode 100644 arch/arm/plat-omap/dss/dpi.c
>  create mode 100644 arch/arm/plat-omap/dss/dsi.c
>  create mode 100644 arch/arm/plat-omap/dss/dss.c
>  create mode 100644 arch/arm/plat-omap/dss/dss.h
>  create mode 100644 arch/arm/plat-omap/dss/rfbi.c
>  create mode 100644 arch/arm/plat-omap/dss/sdi.c
>  create mode 100644 arch/arm/plat-omap/dss/venc.c
>  create mode 100644 arch/arm/plat-omap/include/mach/display.h
>  create mode 100644 drivers/video/omap2/Kconfig
>  create mode 100644 drivers/video/omap2/Makefile
>  create mode 100644 drivers/video/omap2/omapfb-ioctl.c
>  create mode 100644 drivers/video/omap2/omapfb-main.c
>  create mode 100644 drivers/video/omap2/omapfb-sysfs.c
>  create mode 100644 drivers/video/omap2/omapfb.h
>  create mode 100644 drivers/video/omap2/panel-dvi.c
>  create mode 100644 drivers/video/omap2/panel-sdp3430.c
>
> --
>  Tomi Valkeinen
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Is [REVIEW PATCH 2/9] missing?

Regards,
Arun
