From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] Documentation: regulator: tps65218: Update examples
Date: Mon, 16 May 2016 09:48:47 -0500
Message-ID: <20160516144847.GA26659@rob-hp-laptop>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462945691-904-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2016 at 11:18:05AM +0530, Keerthy wrote:
> This updates the device tree according to the preferred way of parsing
> the nodes using the regulator framework.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/regulator/tps65218.txt     | 87 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 16 deletions(-)

It wasn't exactly clear that the compatible string "added" here is 
already used, so it looked like you were breaking compatibility at 
first. Otherwise,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
