From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Wed, 22 Sep 2010 22:43:14 +0200
Message-ID: <4C9A6A62.5000100@ti.com>
References: <1285201816-26516-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab0IVUnU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 16:43:20 -0400
In-Reply-To: <1285201816-26516-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

Hi Hema,

On 9/23/2010 2:30 AM, Kalliguddi, Hema wrote:
> OMAP USBOTG modules has a requirement to set the auto idle bit only after
> setting smart idle bit. Modified the _sys_enable api to set the smart idle
> first and then the autoidle bit. Setting this will not have any impact on the
> other modules.

I think you should change the subject, because it does not reflect 
accurately the patch.

Just a little bit of nitpicking...
For me, an API change is a change in the signature of the API, not a 
change inside an API. Otherwise, since 99% of the code is inside a 
function, we can call most patches like that...
Moreover I don't think _sysc_enable can be considered as an API since it 
is a pure static helper function not exported to the outside.

Something like that seems more accurate for my point of view:

OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

>
> Signed-off-by: Hema HK<hemahk@ti.com>
> Signed-off-by: Basak, Partha<p-basak2@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod.c
> +++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod.c
> @@ -654,12 +654,6 @@ static void _sysc_enable(struct omap_hwm
>   		_set_master_standbymode(oh, idlemode,&v);
>   	}
>
> -	if (sf&  SYSC_HAS_AUTOIDLE) {
> -		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
> -			0 : 1;
> -		_set_module_autoidle(oh, idlemode,&v);
> -	}
> -
>   	/* XXX OCP ENAWAKEUP bit? */
>
>   	/*
> @@ -672,6 +666,19 @@ static void _sysc_enable(struct omap_hwm
>   		_set_clockactivity(oh, oh->class->sysc->clockact,&v);
>
>   	_write_sysconfig(v, oh);
> +
> +	/*
> +	 * Set the auto idle bit only after setting the smartidle bit

Typo: autoidle without space

> +	 * as this is requirement for some modules like USBOTG

The new official name is usb_otg_hs.

> +	 * setting this will not have any impact on the other modues.

Typo: modules

> +	 */
> +

You can remove that blank line.

> +	if (sf&  SYSC_HAS_AUTOIDLE) {
> +		idlemode = (oh->flags&  HWMOD_NO_OCP_AUTOIDLE) ?
> +			0 : 1;
> +		_set_module_autoidle(oh, idlemode,&v);
> +	}
> +	_write_sysconfig(v, oh);

You should move that inside the if, it will save an useless call in case 
SYSC_HAS_AUTOIDLE is not set.

Beside these minors comments this patch looks fine to me.
Acked-by: Benoit Cousson <b-cousson@ti.com>

I had some concern about the extra overhead added for every IPs that 
does not need that at all, meaning every IPs beside the usb_otg_hs...

But then I realized that autoidle is anyway enabled by default, and 
since the sysconfig value is cached, it should not generate any write 
access to most IPs that will not try to disable the autoidle.

Regards,
Benoit

