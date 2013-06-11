From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ARM: dts: Protect pinctrl headers against multiple inclusions
Date: Tue, 11 Jun 2013 22:57:56 +0100
Message-ID: <20130611215756.9B0CA3E0D8D@localhost>
References: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:58769 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab3FKV6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 17:58:00 -0400
Received: by mail-wg0-f52.google.com with SMTP id z12so5795484wgg.7
        for <linux-omap@vger.kernel.org>; Tue, 11 Jun 2013 14:57:59 -0700 (PDT)
In-Reply-To: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Benoit Cousson <b-cousson@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org

On Tue, 11 Jun 2013 16:50:50 +0200, Florian Vaussard <florian.vaussard@epfl.ch> wrote:
> Pinctrl headers were not protected with #ifndef.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>

Obviously this needs to go in via whatever tree added the modified
header files.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  include/dt-bindings/pinctrl/am33xx.h |    5 +++++
>  include/dt-bindings/pinctrl/omap.h   |    5 +++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
> index a3fddd4..469e032 100644
> --- a/include/dt-bindings/pinctrl/am33xx.h
> +++ b/include/dt-bindings/pinctrl/am33xx.h
> @@ -2,6 +2,9 @@
>   * This header provides constants specific to AM33XX pinctrl bindings.
>   */
>  
> +#ifndef _DT_BINDINGS_PINCTRL_AM33XX_H
> +#define _DT_BINDINGS_PINCTRL_AM33XX_H
> +
>  #include <include/dt-bindings/pinctrl/omap.h>
>  
>  /* am33xx specific mux bit defines */
> @@ -35,3 +38,5 @@
>  #undef PIN_OFF_INPUT_PULLDOWN
>  #undef PIN_OFF_WAKEUPENABLE
>  
> +#endif
> +
> diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
> index 370df3f..edbd250 100644
> --- a/include/dt-bindings/pinctrl/omap.h
> +++ b/include/dt-bindings/pinctrl/omap.h
> @@ -5,6 +5,9 @@
>   * Copyright (C) 2009-2010 Texas Instruments
>   */
>  
> +#ifndef _DT_BINDINGS_PINCTRL_OMAP_H
> +#define _DT_BINDINGS_PINCTRL_OMAP_H
> +
>  /* 34xx mux mode options for each pin. See TRM for options */
>  #define MUX_MODE0	0
>  #define MUX_MODE1	1
> @@ -48,3 +51,5 @@
>  #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
>  #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
>  
> +#endif
> +
> -- 
> 1.7.5.4
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
