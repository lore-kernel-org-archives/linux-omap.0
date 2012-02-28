From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Mon, 27 Feb 2012 16:24:06 -0800
Message-ID: <87pqczst3t.fsf@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
	<1330003320-17400-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58617 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755820Ab2B1AYJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 19:24:09 -0500
Received: by mail-pz0-f44.google.com with SMTP id l33so1255649dak.3
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 16:24:07 -0800 (PST)
In-Reply-To: <1330003320-17400-4-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 23 Feb 2012 15:21:57 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
>
> Now devices can idle independent of the powerdomain, there can be a
> window where device is idled and corresponding powerdomain can be
> ON/INACTIVE state. In such situations, since both module wake up is
> enabled at padlevel as well as io daisychain sequence is triggered,
> there will be 2 PRCM interrupts (Module async wake up via swakeup and
> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> Padlevel WKST bit in the first interrupt, module specific interrupt
> handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

My review comments from the last version of this patch were not
answered/addressed:

   http://marc.info/?l=linux-omap&m=132621832120535&w=2

[...]

> @@ -64,6 +65,12 @@ static void omap2_init_processor_devices(void)
>  	}
>  }
>  
> +void omap_trigger_wuclk_ctrl(void)
> +{
> +	if (cpu_is_omap44xx())
> +		omap4_trigger_wuclk_ctrl();
> +}

Subject says OMAP3+, but clearly this only works on OMAP4.

Also, no cpu_is* checks at runtime please.  Instead, at init time, use
cpu_is_* to initialize a function pointer.

Kevin
