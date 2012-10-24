From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Tue, 23 Oct 2012 18:54:19 -0700
Message-ID: <20121024015418.GC5605@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <CAK=Wgba087mdaYhvKNUAy6H8rAb+owTAz1yqexEtDg+f06kJdg@mail.gmail.com>
 <20121016181038.GC15569@atomide.com>
 <20121016182642.GF15569@atomide.com>
 <CAK=WgbaQ-0V2htnmyCAzBco-sZVWN3WR2mhABGZNaYU6uM1wgg@mail.gmail.com>
 <507EA7DB.3070207@compulab.co.il>
 <CAK=Wgba_-k0kCHah6t6L4=qt838j30ZRVRbgAdJ1yzHDyA8frw@mail.gmail.com>
 <20121019170759.GK4730@atomide.com>
 <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:17864 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754694Ab2JXByY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 21:54:24 -0400
Content-Disposition: inline
In-Reply-To: <CAK=WgbbPmuOgssRRSinsV3rXg7TUa9fpOP-Zg+VatZgqgVYixw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Ohad Ben-Cohen <ohad@wizery.com> [121021 07:56]:
> On Fri, Oct 19, 2012 at 7:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1401,13 +1401,9 @@ static __init int da850_wl12xx_init(void)
>  		goto free_wlan_en;
>  	}
> 
> -	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> -
> -	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> -	if (ret) {
> -		pr_err("Could not set wl12xx data: %d\n", ret);
> +	ret = wl12xx_board_init(&da850_wl12xx_wlan_data, DA850_WLAN_IRQ);
> +	if (ret)
>  		goto free_wlan_irq;
> -	}
> 
>  	return 0;

I don't think mach-davinci has wl12xx_board_init() available?
Maybe leave this out or define also also somewhere for mach-davinci?

Regards,

Tony
