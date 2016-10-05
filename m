From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Date: Wed, 5 Oct 2016 17:17:04 +0200
Message-ID: <20161005171704.18fe1b9f@endymion>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>Ale
List-Id: linux-omap@vger.kernel.org

On Tue,  9 Aug 2016 13:36:17 +0200, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-amd756.c         | 5 +----
>  drivers/i2c/busses/i2c-at91.c           | 2 --
>  drivers/i2c/busses/i2c-axxia.c          | 8 +-------
>  drivers/i2c/busses/i2c-bcm-iproc.c      | 8 +-------
>  drivers/i2c/busses/i2c-bcm-kona.c       | 4 +---
>  drivers/i2c/busses/i2c-bfin-twi.c       | 4 +---
>  drivers/i2c/busses/i2c-brcmstb.c        | 4 +---
>  drivers/i2c/busses/i2c-cadence.c        | 4 +---
>  drivers/i2c/busses/i2c-cpm.c            | 4 +---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 +---
>  drivers/i2c/busses/i2c-davinci.c        | 4 +---
>  drivers/i2c/busses/i2c-diolan-u2c.c     | 4 +---
>  drivers/i2c/busses/i2c-dln2.c           | 4 +---
>  drivers/i2c/busses/i2c-efm32.c          | 1 -
>  drivers/i2c/busses/i2c-exynos5.c        | 4 +---
>  drivers/i2c/busses/i2c-hix5hd2.c        | 4 +---
>  drivers/i2c/busses/i2c-i801.c           | 1 -
>  drivers/i2c/busses/i2c-ibm_iic.c        | 4 +---
>  drivers/i2c/busses/i2c-img-scb.c        | 4 +---
>  drivers/i2c/busses/i2c-imx.c            | 4 +---
>  drivers/i2c/busses/i2c-isch.c           | 4 +---
>  drivers/i2c/busses/i2c-ismt.c           | 4 +---
>  drivers/i2c/busses/i2c-jz4780.c         | 4 +---
>  drivers/i2c/busses/i2c-lpc2k.c          | 4 +---
>  drivers/i2c/busses/i2c-meson.c          | 1 -
>  drivers/i2c/busses/i2c-mpc.c            | 4 +---
>  drivers/i2c/busses/i2c-mt65xx.c         | 4 +---
>  drivers/i2c/busses/i2c-mxs.c            | 1 -
>  drivers/i2c/busses/i2c-nforce2.c        | 1 -
>  drivers/i2c/busses/i2c-nomadik.c        | 4 +---
>  drivers/i2c/busses/i2c-ocores.c         | 4 +---
>  drivers/i2c/busses/i2c-octeon.c         | 4 +---
>  drivers/i2c/busses/i2c-omap.c           | 4 +---
>  drivers/i2c/busses/i2c-piix4.c          | 1 -
>  drivers/i2c/busses/i2c-pmcmsp.c         | 4 +---
>  drivers/i2c/busses/i2c-pnx.c            | 4 +---
>  drivers/i2c/busses/i2c-puv3.c           | 5 +----
>  drivers/i2c/busses/i2c-pxa.c            | 4 +---
>  drivers/i2c/busses/i2c-rcar.c           | 4 +---
>  drivers/i2c/busses/i2c-riic.c           | 4 +---
>  drivers/i2c/busses/i2c-rk3x.c           | 4 +---
>  drivers/i2c/busses/i2c-s3c2410.c        | 1 -
>  drivers/i2c/busses/i2c-sh7760.c         | 4 +---
>  drivers/i2c/busses/i2c-sh_mobile.c      | 1 -
>  drivers/i2c/busses/i2c-sirf.c           | 4 +---
>  drivers/i2c/busses/i2c-st.c             | 4 +---
>  drivers/i2c/busses/i2c-stu300.c         | 5 +----
>  drivers/i2c/busses/i2c-tegra.c          | 4 +---
>  drivers/i2c/busses/i2c-uniphier-f.c     | 7 +------
>  drivers/i2c/busses/i2c-uniphier.c       | 7 +------
>  drivers/i2c/busses/i2c-wmt.c            | 4 +---
>  drivers/i2c/busses/i2c-xgene-slimpro.c  | 1 -
>  drivers/i2c/busses/i2c-xiic.c           | 1 -
>  drivers/i2c/busses/i2c-xlp9xx.c         | 4 +---
>  drivers/i2c/busses/i2c-xlr.c            | 4 +---
>  55 files changed, 44 insertions(+), 161 deletions(-)
> (...)

I like the idea.

For i2c-amd756, i2c-diolan-u2c, i2c-i801, i2c-isch, i2c-ismt,
i2c-nforce and i2c-piix4:

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

-- 
Jean Delvare
SUSE L3 Support
