From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH] omapfb: In omapfb_probe return -EPROBE_DEFER when display
 driver is not loaded yet
Date: Thu, 11 Jul 2013 14:08:49 +0530
Message-ID: <51DE6F19.6050606@ti.com>
References: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373461739-10168-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 10 July 2013 06:38 PM, Pali Roh=C3=A1r wrote:
> * On RX-51 probing for acx565akm driver is later then for omapfb whic=
h cause that omapfb probe fail and framebuffer is not working
> * EPROBE_DEFER causing that kernel try to probe for omapfb later agai=
n which fixing this problem
>
> * Without this patch display on Nokia RX-51 (N900) phone not working
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>   drivers/video/omap2/omapfb/omapfb-main.c |    9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video=
/omap2/omapfb/omapfb-main.c
> index 856917b..93e7c84 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2419,6 +2419,15 @@ static int omapfb_probe(struct platform_device=
 *pdev)
>   	if (omapdss_is_initialized() =3D=3D false)
>   		return -EPROBE_DEFER;
>
> +	dssdev =3D NULL;
> +	for_each_dss_dev(dssdev) {
> +		if (!dssdev->driver) {
> +			dev_warn(&pdev->dev, "no driver for display: %s\n",
> +				dssdev->name);
> +			return -EPROBE_DEFER;

This will make omapfb probe defer till the time every panel has a=20
driver. It's possible that all the panel driver modules are never=20
interested by userspace. This will lead to the panels having drivers=20
also not work.

I think Tomi was working on this, it was something like making omapfb=20
defer only if the default display doesn't have a driver. We can wait fo=
r=20
his comment.

Archit

> +		}
> +	}
> +
>   	if (pdev->num_resources !=3D 0) {
>   		dev_err(&pdev->dev, "probed for an unknown device\n");
>   		r =3D -ENODEV;
>
