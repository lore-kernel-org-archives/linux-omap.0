From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] gpio: davinci: Add a separate compatible for k2g
Date: Wed, 26 Oct 2016 16:08:51 -0500
Message-ID: <20161026210851.jt2xoo2ap6zijowg@rob-hp-laptop>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
 <1476855239-32730-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476855239-32730-6-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lokeshvutla-l0cyMroinI0@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 19, 2016 at 11:03:59AM +0530, Keerthy wrote:
> In the case of k2g the clocks are handled differently as when compared
> with other keystones. Hence adding a separate compatible and match tables
> accordingly.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/gpio/gpio-davinci.txt      |  2 +-
>  drivers/gpio/gpio-davinci.c                        | 45 ++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> index 5079ba7..a76abd2 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
> @@ -1,7 +1,7 @@
>  Davinci/Keystone GPIO controller bindings
>  
>  Required Properties:
> -- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
> +- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio", "ti,k2g-gpio"

Is this "one of" or all? Seems line the former in which case please 
reformat to one per line.

>  
>  - reg: Physical base address of the controller and the size of memory mapped
>         registers.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
