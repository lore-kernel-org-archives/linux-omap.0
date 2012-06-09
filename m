From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS for v3.5-rc2
Date: Sat, 09 Jun 2012 12:39:24 +0000
Message-ID: <4FD343FC.8020701@gmx.de>
References: <1338909099.4456.13.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:48104 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752491Ab2FIMj1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jun 2012 08:39:27 -0400
In-Reply-To: <1338909099.4456.13.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, Archit Taneja <archit@ti.com>

Hi Tomi,

On 06/05/2012 03:11 PM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are 5 small fixes for omapdss. The most important is the "fix
> registration..." patch, without which omapdss crashes when
> suspending/resuming. The compilation bug ("fix build...") is also rather
> annoying for those users not interested in debug outputs. The rest are
> quite minor small fixes.
> 
> It'd be great if these made it in for -rc2, as the crash bug is quite
> bad, but -rc3 is good also.

I merged this some days ago. Sorry that I didn't realize that rc2 would
be released early and hence didn't manage to get it in.


Best regards,

Florian Tobias Schandinat

> 
>  Tomi
> 
> 
> The following changes since commit e92a5b28f71aea01b281f9c89d97a4bc5b24748f:
> 
>   OMAPDSS: HDMI: OMAP4: Update IRQ flags for the HPD IRQ request (2012-05-22 11:00:09 +0300)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-omap-dss2/linux.git tags/omapdss-for-3.5-rc2
> 
> for you to fetch changes up to c3a21fc79b6bc097d8b0e47498903a649a111127:
> 
>   OMAPDSS: fix registration of DPI and SDI devices (2012-06-05 17:15:24 +0300)
> 
> ----------------------------------------------------------------
> Small fixes for omapdss driver. Most importantly, fixes a build problem when
> debugfs or omapdss debug support is turned off, and fixes a suspend related
> crash.
> 
> ----------------------------------------------------------------
> Archit Taneja (1):
>       OMAPDSS: DSI: Fix bug when calculating LP command interleaving parameters
> 
> Tomi Valkeinen (4):
>       OMAPDSS: fix build when DEBUG_FS or DSS_DEBUG_SUPPORT disabled
>       OMAPDSS: Taal: fix compilation warning
>       OMAPDSS: fix bogus WARN_ON in dss_runtime_put()
>       OMAPDSS: fix registration of DPI and SDI devices
> 
>  arch/arm/mach-omap2/display.c             |    4 ++--
>  drivers/video/omap2/displays/panel-taal.c |    2 +-
>  drivers/video/omap2/dss/core.c            |    3 +--
>  drivers/video/omap2/dss/dsi.c             |    2 +-
>  drivers/video/omap2/dss/dss.c             |    2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)
> 

