From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 30 Oct 2014 08:55:03 -0500
Message-ID: <54524337.8050608@ti.com>
References: <20141027200008.GR2560@atomide.com> <20141027230138.GB7805@drone.musicnaut.iki.fi> <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com> <20141029185957.GA3723@earth.universe> <20141029193915.GB2542@atomide.com> <20141029214541.GA21790@kahuna> <20141029223104.GA23366@drone.musicnaut.iki.fi>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:45400 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaJ3NzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2014 09:55:06 -0400
Received: by mail-oi0-f46.google.com with SMTP id g201so4011870oib.33
        for <linux-omap@vger.kernel.org>; Thu, 30 Oct 2014 06:55:05 -0700 (PDT)
In-Reply-To: <20141029223104.GA23366@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/29/2014 05:31 PM, Aaro Koskinen wrote:
> Also, you cannot expect all kernel users to know what you have been
> talking about. E.g. OMAP DMA API deprecation may have been discussed
> before, but I only learned it after the WARN appeared in the kernel tree.
> So you should start counting from that.
>
> Personally I don't mind if you delete OMAP3 legacy boot support already
> tomorrow morning, but if you want to give ~1 year transition period it
> should end somewhere in the end of 2015. Of course if there are no legacy
> boot users you can do it faster.

How about the following?

>
> +	WARN(!of_have_populated_dt(),
> +		"legacy booting deprecated(proposed removal in December 2015), please update to boot with .dts\n");
> +

Regards,
Nishanth Menon
