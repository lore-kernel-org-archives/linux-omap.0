From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Wed, 9 May 2012 08:45:43 -0700
Message-ID: <20120509154543.GK5088@atomide.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
 <20120507174657.GF5088@atomide.com>
 <1336550949.3962.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16115 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760040Ab2EIPpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:45:46 -0400
Content-Disposition: inline
In-Reply-To: <1336550949.3962.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120509 01:12]:
> 
> Below is the pull request for board file related changes. Tested on
> panda & 4430sdp.

Thanks, I've merged that into clenaup-dss branch and will send it
along with other still pending cleanup branches.
 
> How should I manage my tree related to this... Should I rebase my
> original DT preparation series on top of this new branch, or can I just
> ignore the new branch for now, as long as I merge it at some point
> before sending a pull request to mainline?

Yes you need to rebase on this now. And not touch these commits.

Otherwise we'll end up with duplicate commits in the mainline tree,
which is a big no-no. If something shows up that needs fixing in this
series, it must now be separate patches on top of this series.

When doing pull requests we both just have to make note that there's
a dependency to this branch, and it will find it's way to mainline
via arm-soc pull request. Or if no conflicts need sorting out, then
it will just get merged with your pull request.

Regards,

Tony


 
>  Tomi
> 
> The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:
> 
>   Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5
> 
> for you to fetch changes up to e4a9e94cc58ed6e4efb02b80be3a9bf57f448d07:
> 
>   OMAPDSS: DSI: implement generic DSI pin config (2012-05-09 10:53:05 +0300)
> 
> ----------------------------------------------------------------
> Tomi Valkeinen (6):
>       OMAPDSS: panel-dvi: add PD gpio handling
>       OMAP: board-files: remove custom PD GPIO handling for DVI output
>       OMAPDSS: TFP410: rename dvi -> tfp410
>       OMAPDSS: TFP410: rename dvi files to tfp410
>       OMAPDSS: Taal: move reset gpio handling to taal driver
>       OMAPDSS: DSI: implement generic DSI pin config
> 
>  arch/arm/mach-omap2/board-3430sdp.c                |   38 +-----
>  arch/arm/mach-omap2/board-4430sdp.c                |   37 ++----
>  arch/arm/mach-omap2/board-am3517evm.c              |   25 +---
>  arch/arm/mach-omap2/board-cm-t35.c                 |   30 +----
>  arch/arm/mach-omap2/board-devkit8000.c             |   30 +----
>  arch/arm/mach-omap2/board-igep0020.c               |   32 +----
>  arch/arm/mach-omap2/board-omap3beagle.c            |   37 +-----
>  arch/arm/mach-omap2/board-omap3evm.c               |   29 +----
>  arch/arm/mach-omap2/board-omap3stalker.c           |   29 +----
>  arch/arm/mach-omap2/board-omap4panda.c             |   39 +-----
>  arch/arm/mach-omap2/board-overo.c                  |   25 +---
>  drivers/video/omap2/displays/Kconfig               |    8 +-
>  drivers/video/omap2/displays/Makefile              |    2 +-
>  drivers/video/omap2/displays/panel-taal.c          |   22 ++++
>  .../omap2/displays/{panel-dvi.c => panel-tfp410.c} |  134 +++++++++++---------
>  drivers/video/omap2/dss/dsi.c                      |  133 +++++++++----------
>  include/video/omap-panel-nokia-dsi.h               |    3 +
>  .../{omap-panel-dvi.h => omap-panel-tfp410.h}      |   18 ++-
>  include/video/omapdss.h                            |   28 ++--
>  19 files changed, 251 insertions(+), 448 deletions(-)
>  rename drivers/video/omap2/displays/{panel-dvi.c => panel-tfp410.c} (63%)
>  rename include/video/{omap-panel-dvi.h => omap-panel-tfp410.h} (63%)
> 


