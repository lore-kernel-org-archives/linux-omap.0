From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/7] OMAPDSS: use components (fix probing problems)
Date: Tue, 16 Jun 2015 17:36:41 +0300
Message-ID: <358618591.Y41I6t5qpX@avalon>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Thank for the patches.

On Tuesday 16 June 2015 13:16:22 Tomi Valkeinen wrote:
> Hi,
> 
> I noticed that on some platforms omapdss did not probe successfully. Some
> resource was not available yet, but omapdss did not manage to handle
> deferred probing. The reason was the use of platform_driver_probe() in
> combination with how the omapdss module handles the drivers.
> 
> To fix this properly, the component system felt fine for the job, and it
> seems to work nicely.
> 
>  Tomi
> 
> Tomi Valkeinen (7):
>   OMAPDSS: move 'dss_initialized' to dss driver
>   OMAPDSS: refactor dss probe function
>   OMAPDSS: fix dss_init_ports error handling
>   OMAPDSS: remove uses of __init/__exit
>   OMAPDSS: reorder uninit calls
>   OMAPDSS: componentize omapdss
>   OMAPDSS: simplify submodule reg/unreg code

I've quickly reviewed the whole series and it looks good to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/video/fbdev/omap2/dss/core.c  |  80 ++++--------
>  drivers/video/fbdev/omap2/dss/dispc.c |  42 +++++--
>  drivers/video/fbdev/omap2/dss/dpi.c   |  36 ++++--
>  drivers/video/fbdev/omap2/dss/dsi.c   |  27 +++-
>  drivers/video/fbdev/omap2/dss/dss.c   | 223 ++++++++++++++++++++-----------
>  drivers/video/fbdev/omap2/dss/dss.h   |  32 ++---
>  drivers/video/fbdev/omap2/dss/hdmi4.c |  28 ++++-
>  drivers/video/fbdev/omap2/dss/hdmi5.c |  28 ++++-
>  drivers/video/fbdev/omap2/dss/rfbi.c  |  32 ++++-
>  drivers/video/fbdev/omap2/dss/sdi.c   |  35 ++++--
>  drivers/video/fbdev/omap2/dss/venc.c  |  31 +++--
>  11 files changed, 396 insertions(+), 198 deletions(-)

-- 
Regards,

Laurent Pinchart
