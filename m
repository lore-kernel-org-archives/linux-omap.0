From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [GIT PULL] OMAP DSS fixes for 3.3-rc
Date: Mon, 30 Jan 2012 05:22:42 +0000
Message-ID: <4F262922.5090109@gmx.de>
References: <1327579651.1895.34.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57965 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751556Ab2A3FWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 00:22:53 -0500
In-Reply-To: <1327579651.1895.34.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-omap mailing list <linux-omap@vger.kernel.org>

Hi Tomi,

On 01/26/2012 12:07 PM, Tomi Valkeinen wrote:
> Hi Florian,
> 
> Here are two major fixes for OMAP DSS driver.
> 
> The first (OMAPDSS: use sync versions...) fixes problem with system
> suspend, which causes omapdss power management to give WARNs and
> generally malfunction on system suspend/resume.
> 
> The second (the rest of the patches) implements a workaround for HW bug,
> which causes physical damage to the board if the HDMI cable is
> disconnected at a "wrong" time. The actual fix is in the last patch, but
> the board files needed some cleanups and a new GPIO, which is what the
> smaller patches do.
> 
> The branch is based on fbdev/fbdev-next. Is that ok?

Yes, that worked well, as I didn't start to collect 3.4 material there. Merged.


Thanks,

Florian Tobias Schandinat

> 
>  Tomi
> 
> 
> The following changes since commit f787f32e67e00b072f46b2ae3c454d2c0a1fcdb7:
> 
>   module_param: make bool parameters really bool (drivers/video/i810) (2012-01-12 23:28:59 +0000)
> 
> are available in the git repository at:
>   git://gitorious.org/linux-omap-dss2/linux.git for-3.3-rc
> 
> Tomi Valkeinen (7):
>       OMAPDSS: use sync versions of pm_runtime_put
>       OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
>       OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
>       OMAPDSS: remove wrong HDMI HPD muxing
>       OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
>       OMAP: 4430SDP/Panda: add HDMI HPD gpio
>       OMAPDSS: HDMI: PHY burnout fix
> 
>  arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++--
>  arch/arm/mach-omap2/board-omap4panda.c    |   18 ++++++--
>  arch/arm/mach-omap2/display.c             |    4 --
>  drivers/video/omap2/dss/dispc.c           |    2 +-
>  drivers/video/omap2/dss/dsi.c             |    2 +-
>  drivers/video/omap2/dss/dss.c             |    2 +-
>  drivers/video/omap2/dss/hdmi.c            |    5 ++-
>  drivers/video/omap2/dss/rfbi.c            |    2 +-
>  drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   68 +++++++++++++++++++++++++++--
>  drivers/video/omap2/dss/venc.c            |    2 +-
>  include/video/omapdss.h                   |    5 ++
>  12 files changed, 110 insertions(+), 22 deletions(-)
> 

