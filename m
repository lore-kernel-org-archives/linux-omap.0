From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 02/12] DSS: Display subsystem for
	OMAP2/3
Date: Mon, 12 Jan 2009 15:02:00 +0200
Message-ID: <20090112130158.GF9373@atomide.com>
References: <20090112114718.1003.23643.stgit@tubuntu> <20090112114732.1003.6162.stgit@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65110 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZALNCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 08:02:05 -0500
Content-Disposition: inline
In-Reply-To: <20090112114732.1003.6162.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090112 14:37]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> 
>  arch/arm/plat-omap/Kconfig                |    2 
>  arch/arm/plat-omap/Makefile               |    2 
>  arch/arm/plat-omap/dss/Kconfig            |   71 +
>  arch/arm/plat-omap/dss/Makefile           |    6 
>  arch/arm/plat-omap/dss/dispc.c            | 2113 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/dss/display.c          |  787 +++++++++++
>  arch/arm/plat-omap/dss/dpi.c              |  344 +++++
>  arch/arm/plat-omap/dss/dss.c              |  774 +++++++++++
>  arch/arm/plat-omap/dss/dss.h              |  274 ++++
>  arch/arm/plat-omap/dss/sdi.c              |  174 ++
>  arch/arm/plat-omap/include/mach/display.h |  462 ++++++
>  11 files changed, 5009 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/dss/Kconfig
>  create mode 100644 arch/arm/plat-omap/dss/Makefile
>  create mode 100644 arch/arm/plat-omap/dss/dispc.c
>  create mode 100644 arch/arm/plat-omap/dss/display.c
>  create mode 100644 arch/arm/plat-omap/dss/dpi.c
>  create mode 100644 arch/arm/plat-omap/dss/dss.c
>  create mode 100644 arch/arm/plat-omap/dss/dss.h
>  create mode 100644 arch/arm/plat-omap/dss/sdi.c
>  create mode 100644 arch/arm/plat-omap/include/mach/display.h

Sorry, no subdirectories allowed under arch/arm/*omap*. Please move
these to live under drivers/video somewhere.

Also, you should not need to use cpu_is_omapxxxx() macros under
drivers, please separate out the low-level init to happen under
arch/arm/*omap* and pass the necessary things to the driver in
the platform_data. See how usb and mmc are doing it for example.

Regards,

Tony
