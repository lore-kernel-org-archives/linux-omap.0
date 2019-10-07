From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] drm: panels: fix spi aliases of former omap panels
Date: Mon, 7 Oct 2019 19:14:28 +0200
Message-ID: <20191007191428.016ddcd4@aktux>
References: <20191007164130.31534-1-andreas@kemnade.info>
        <20191007170446.yotb24s6jhe6nx3r@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007170446.yotb24s6jhe6nx3r@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, omi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Oct 2019 19:04:46 +0200
Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
> 
> On Mon, Oct 07, 2019 at 06:41:30PM +0200, Andreas Kemnade wrote:
> > When the panels were moved from omap/displays/ to panel/
> > omapdss prefix was stripped, which cause spi modalias
> > to not contain the vendor-prefix anymore.
> > 
> > so we had e.g. in former times:
> > compatible=omapdss,tpo,td028ttec1 -> modalias=spi:tpo,td028ttec1
> > now:
> > compatible=tpo,td028ttec1 -> modalias=spi:td028ttec1
> > 
> > This is consistent with other drivers. Tested the td028ttec.c
> > only, but the pattern looks the same for the other ones.
> > 
> > Fixes: 45f16c82db7e8 ("drm/omap: displays: Remove unused panel drivers")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---  
> 
> Patch looks good to me, but you have one false positive.
> 
> > [...]
> >
> > diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > index 46cd9a2501298..838d39a263f53 100644
> > --- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > +++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
> > @@ -204,7 +204,7 @@ static int ls037v7dw01_remove(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id ls037v7dw01_of_match[] = {
> > -	{ .compatible = "sharp,ls037v7dw01", },
> > +	{ .compatible = "ls037v7dw01", },
> >  	{ /* sentinel */ },
> >  };
> >    
> 
> The DT compatible should have a vendor prefix.
> 

oops, sorry, but I it seems that Laurent already has submitted a fix.

Regards,
Andreas
