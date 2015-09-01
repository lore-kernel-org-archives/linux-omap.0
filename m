From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Documentation: DT: cpsw: document missing compatible
Date: Tue, 1 Sep 2015 08:18:18 -0500
Message-ID: <CAL_JsqLgouhnOHM5q3wO9kk9W62k8E--JDh9t1K=k3Dcn9wOMA@mail.gmail.com>
References: <1441002089-28656-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441002089-28656-1-git-send-email-mugunthanvnm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 31, 2015 at 1:21 AM, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org> wrote:
> CPSW driver has multiple compatibles for errata implentations but not
> documented, add necessary documentation.
>
> Signed-off-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

Applied. Thanks.

Rob
> ---
>
> The compatibles are added in the commit 7da1160002f1 ('drivers:
> net: cpsw: add am335x errata workarround for interrutps') which
> is present in linux-next/master
>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index 33fe846..a9df21a 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -2,7 +2,11 @@ TI SoC Ethernet Switch Controller Device Tree Bindings
>  ------------------------------------------------------
>
>  Required properties:
> -- compatible           : Should be "ti,cpsw"
> +- compatible           : Should be one of the below:-
> +                         "ti,cpsw" for backward compatible
> +                         "ti,am335x-cpsw" for AM335x controllers
> +                         "ti,am4372-cpsw" for AM437x controllers
> +                         "ti,dra7-cpsw" for DRA7x controllers
>  - reg                  : physical base address and size of the cpsw
>                           registers map
>  - interrupts           : property with a value describing the interrupt
> --
> 2.5.0.474.g3a9835b
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
