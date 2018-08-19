From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
Date: Sun, 19 Aug 2018 17:07:34 +0300
Message-ID: <6854891.0j5LuaEH9O@avalon>
References: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

Thank you for the patch.

On Friday, 27 July 2018 17:24:32 EEST H. Nikolaus Schaller wrote:
> The opa362 amplifier has two ports, an input (usually connected
> to the OMAP3 VENC) and an output port connected to the external
> connector.
> 
> These are usually defined as input port@0 and outpt port@1 in
> the DT and really distinguished by the reg = <port_num> property
> of these nodes.
> 
> But we are missing to define the output port as number 1 so
> it does not match the DT entry.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I think this patch is superseded by "[PATCH v3 36/61] drm/omap: dss: Replace 
omap_dss_device port number with bitmask" which should get merged in v4.20.

> ---
>  drivers/gpu/drm/omapdrm/displays/encoder-opa362.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c index
> afee1b8b457a..296d46f060b2 100644
> --- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> +++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> @@ -208,6 +208,7 @@ static int opa362_probe(struct platform_device *pdev)
>  	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
>  	dssdev->output_type = OMAP_DISPLAY_TYPE_VENC;
>  	dssdev->owner = THIS_MODULE;
> +	dssdev->port_num = 1;	/* second port */
> 
>  	r = omapdss_register_output(dssdev);
>  	if (r) {

-- 
Regards,

Laurent Pinchart
