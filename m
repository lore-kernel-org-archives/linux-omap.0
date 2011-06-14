From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Tue, 14 Jun 2011 05:34:00 -0700
Message-ID: <20110614123359.GB23145@atomide.com>
References: <y>
 <1308053788-25937-1-git-send-email-shahar@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:52094 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751369Ab1FNMeC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:34:02 -0400
Content-Disposition: inline
In-Reply-To: <1308053788-25937-1-git-send-email-shahar@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shahar Lev <shahar@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

* Shahar Lev <shahar@wizery.com> [110614 05:12]:
>  
> +config OMAP3EVM_MISTRAL_WL12XX
> +	bool "Enable Mistral WL12XX daughter board support"
> +	depends on MACH_OMAP3EVM
> +	help
> +	  Support for the Mistral WL12XX daughter board.
> +	  This extension board which supports both WLAN and Bluetooth.
> +	  Specifically, for WL1271, more info can be found at
> +	  http://mistralsolutions.com/component/jumi/Download_Common_Code.html?docid=298
> +
> +config OMAP3EVM_MISTRAL_WL12XX_REFCLOCK
> +	int "Ref clock value"
> +	range 0 5
> +	depends on OMAP3EVM_MISTRAL_WL12XX
> +	default 2
> +	help
> +	  Set ref clock value for the Mistral WL12XX daughter board.
> +	  Select 0 for 19.2 MHz.
> +	  Select 1 for 26 MHz.
> +	  Select 2 for 38.4 MHz.
> +	  Select 3 for 52 MHz.
> +	  Select 4 for 38.4 MHz, XTAL.
> +	  Select 5 for 26 MHz, XTAL.
> +

This your should try to remove as it won't work nicely for supporting
various boards with the same kernel as we already do with
omap2plus_defconfig.

Can you somehow detect the daughter board dynamically and then
set the flags?

Tony
