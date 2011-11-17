From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Add a new state to handle hwmods left
 enabled at init
Date: Thu, 17 Nov 2011 11:39:23 +0100
Message-ID: <4EC4E45B.5080106@ti.com>
References: <1321524690-10302-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48224 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab1KQKjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 05:39:39 -0500
In-Reply-To: <1321524690-10302-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, robherring2@gmail.com, Paul Walmsley <paul@pwsan.com>

+ Paul

On 11/17/2011 11:11 AM, Rajendra Nayak wrote:
> A hwmod with a 'HWMOD_INIT_NO_IDLE' flag set, is left in
> enabled state by the hwmod framework post the initial setup.
> Once a real user of the device (a driver) tries to enable it
> at a later point, the hmwod framework throws a WARN() about

typo: -------------------^

> the device being already in enabled state.
>
> Fix this by introducing a new state '_HWMOD_STATE_ENABLED_AT_INIT'
> to identify such devices/hwmods, so nothing but just a state
> change to '_HWMOD_STATE_ENABLED' can be done when the device/hwmod
> is requested to be enabled (the first time) by its driver/user.
>
> A good example of a such a device is an UART used as debug console.
> The UART module needs to be kept enabled through the boot, until the
> UART driver takes control of it, for debug prints to appear on
> the console.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   16 ++++++++++++++--
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>   2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index d7f4623..7d94cc3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1441,6 +1441,17 @@ static int _enable(struct omap_hwmod *oh)
>
>   	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
>
> +	/*
> +	 * hwmods' with HWMOD_INIT_NO_IDLE flag set, are left

Is the ' needed here? But I'm not an expert in English grammar...

> +	 * in enabled state at init.
> +	 * Now that someone is really trying to enable them,
> +	 * just update the state.
> +	 */
> +	if (oh->_state == _HWMOD_STATE_ENABLED_AT_INIT) {
> +		oh->_state = _HWMOD_STATE_ENABLED;
> +		return 0;
> +	}
> +
>   	if (oh->_state != _HWMOD_STATE_INITIALIZED&&
>   	oh->_state != _HWMOD_STATE_IDLE&&
>   	oh->_state != _HWMOD_STATE_DISABLED) {
> @@ -1449,7 +1460,6 @@ static int _enable(struct omap_hwmod *oh)
>   		return -EINVAL;
>   	}
>
> -

Not related to the patch changelog but that make senses to do it, so 
just update the changelog.

>   	/*
>   	 * If an IP contains only one HW reset line, then de-assert it in order
>   	 * to allow the module state transition. Otherwise the PRCM will return
> @@ -1744,8 +1754,10 @@ static int _setup(struct omap_hwmod *oh, void *data)
>   	 * it should be set by the core code as a runtime flag during startup
>   	 */
>   	if ((oh->flags&  HWMOD_INIT_NO_IDLE)&&
> -	    (postsetup_state == _HWMOD_STATE_IDLE))
> +	    (postsetup_state == _HWMOD_STATE_IDLE)) {
> +		oh->_state = _HWMOD_STATE_ENABLED_AT_INIT;
>   		postsetup_state = _HWMOD_STATE_ENABLED;
> +	}
>
>   	if (postsetup_state == _HWMOD_STATE_IDLE)
>   		_idle(oh);
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1b81dfb..cd49d60 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -436,6 +436,7 @@ struct omap_hwmod_omap4_prcm {
>   #define _HWMOD_STATE_ENABLED			4
>   #define _HWMOD_STATE_IDLE			5
>   #define _HWMOD_STATE_DISABLED			6
> +#define _HWMOD_STATE_ENABLED_AT_INIT		7

You should update the comment before... yeah I know, the other states 
are not documented, but they are much more understandable than this new one.

>   /**
>    * struct omap_hwmod_class - the type of an IP block

+1 Looks good to me but someone else must approve...
Oops, sorry its not Gerrit :-)

Acked-by: Benoit Cousson <b-cousson@ti.com>

Thanks,
Benoit
