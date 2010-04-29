From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/21] OMAP: DSS2: Taal panel driver updates
Date: Thu, 29 Apr 2010 08:42:53 -0700
Message-ID: <20100429154252.GI7225@atomide.com>
References: <cover.1272457052.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56780 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757624Ab0D3Qt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 12:49:57 -0400
Content-Disposition: inline
In-Reply-To: <cover.1272457052.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

* Jani Nikula <ext-jani.1.nikula@nokia.com> [100429 05:28]:
> Hi -
> 
> This set of patches, on top of [1], contains assorted fixes and cleanups to the
> Taal panel driver (01-14), configures board/platform specific things in a new
> Nokia DSI command mode panel specific struct instead of DSS structs (15-17), and
> makes it feasible to add support for similar DSI command mode panels in the same
> driver (18-21).
> 
> Tony, please note that patch 15 touches your turf.

Ack, it should be OK to merge just fine through Tomi.

Note that some of your patches are missing descriptions,
please add those to the missing ones.

Regards,

Tony

 
> [1] git://gitorious.org/linux-omap-dss2/linux.git
> 
> BR,
> Jani.
> 
> 
> Jani Nikula (20):
>   OMAP: DSS2: Taal: Add panel hardware reset
>   OMAP: DSS2: Taal: Add locks to protect taal data access
>   OMAP: DSS2: Taal: Cosmetic improvement to backlight properties
>     initialization
>   OMAP: DSS2: Taal: Remove platform enable/disable
>   OMAP: DSS2: Taal: Fix request_irq() error handling
>   OMAP: DSS2: Taal: Remove ESD work cancel from driver probe error
>     handling
>   OMAP: DSS2: Taal: Improve taal_power_on() error handling
>   OMAP: DSS2: Taal: Bail out from taal_run_test() if panel is not
>     enabled
>   OMAP: DSS2: Taal: Change DSI bus locking to avoid deadlock in ESD
>     work
>   OMAP: DSS2: Taal: Check taal_power_on() return value in taal_resume()
>   OMAP: DSS2: Taal: Change ESD work management
>   OMAP: DSS2: Taal: Change probe error handling labels
>   OMAP: DSS2: Taal: Add proper external TE support
>   OMAP: DSS2: Add Nokia DSI command mode panel configuration struct
>   OMAP: DSS2: Taal: Use Nokia DSI panel data
>   OMAP: DSS2: Taal: Configure ESD check in DSI panel data
>   OMAP: DSS2: Taal: Add panel specific configuration structure
>   OMAP: DSS2: Taal: Print panel name in addition to revision
>   OMAP: DSS2: Taal: Add regulator configuration support
>   OMAP: DSS2: Taal: CABC workaround is Taal specific
> 
> Valkeinen Tomi (Nokia-D/Helsinki) (1):
>   OMAP: DSS2: Taal: add locks to taal_bl_update_status
> 
>  arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 ++
>  drivers/video/omap2/displays/panel-taal.c         |  538 ++++++++++++++++-----
>  2 files changed, 452 insertions(+), 117 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
> 
