From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
Date: Tue, 29 Mar 2011 10:41:48 -0700
Message-ID: <87mxkdygbn.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222134.4046.53842.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:56789 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab1C2Rlw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 13:41:52 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so489737iwn.5
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 10:41:51 -0700 (PDT)
In-Reply-To: <20110328222134.4046.53842.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

[...]

> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 330bd17..66c4b34 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -92,5 +92,130 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
>  
>  int omap_dm_timers_active(void);
>  
> +/*
> + * Do not the defines below, they are not needed. They should be only

Do not what?    ;)

Kevin
