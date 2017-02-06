From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] regulator: cpcap: Add basic regulator support
Date: Mon, 6 Feb 2017 15:26:40 -0600
Message-ID: <CAL_JsqKg8LfGpMFuM2vwT35ODFrHf2TYDbw3CQm-U9s7eFUWPw@mail.gmail.com>
References: <20170202234357.2405-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170202234357.2405-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 2, 2017 at 5:43 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
> or 6556002. This PMIC is used with several SoCs, I've noticed at least
> omap3, omap4 and Tegra2 based Motorola phones and tablets using it.
>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>
> With the cpcap core MFD driver now in Linux next as commit
> 3d66c8abc13e ("mfd: cpcap: Add minimal support"), here's a related
> regulator driver. This is needed to support more devices on droid 4,
> such as the LCD and touchscreen.
>
> Changes since v1:
>
> - Use standard regulator sel_regmap functions and drop the pointless
>   custom implementations as commented by Mark Brown
>
> - Fix unit-address with no reg property as commented by Rob Herring
>
> ---
>  .../bindings/regulator/cpcap-regulator.txt         |  34 ++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/regulator/Kconfig                          |   7 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/cpcap-regulator.c                | 464 +++++++++++++++++++++
>  4 files changed, 506 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
>  create mode 100644 drivers/regulator/cpcap-regulator.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
