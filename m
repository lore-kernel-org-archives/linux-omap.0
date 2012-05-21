From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP: Beagle: fix DVI GPIO request
Date: Mon, 21 May 2012 13:28:12 +0200
Message-ID: <8607C2E0-C1C0-49C6-9563-4CE1BF291E82@dominion.thruhere.net>
References: <1337593277-13822-1-git-send-email-tomi.valkeinen@ti.com> <1337593277-13822-2-git-send-email-tomi.valkeinen@ti.com> <4DA41490-EF90-40A5-B3EE-E6281B4F1313@dominion.thruhere.net> <1337598763.2078.28.camel@lappyti>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52794 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab2EUL2Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 07:28:16 -0400
Received: by wibhn6 with SMTP id hn6so2303106wib.1
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 04:28:15 -0700 (PDT)
In-Reply-To: <1337598763.2078.28.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


Op 21 mei 2012, om 13:12 heeft Tomi Valkeinen het volgende geschreven:

> On Mon, 2012-05-21 at 12:59 +0200, Koen Kooi wrote:
>> Op 21 mei 2012, om 11:41 heeft Tomi Valkeinen het volgende geschreven:
>> 
>>> Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
>>> remove custom PD GPIO handling for DVI output") moved TFP410 chip's
>>> powerdown-gpio handling from the board files to the tfp410 driver. One
>>> gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
>>> the Beagle board file. This causes the tfp410 driver to fail to request
>>> the gpio on Beagle, causing the driver to fail and thus the DVI output
>>> doesn't work.
>>> 
>>> This patch removes the gpio_request_one() from the board file.
>>> 
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> ---
>>> arch/arm/mach-omap2/board-omap3beagle.c |    3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>> 
>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>>> index 8ede8d2..72ad1f6 100644
>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>> @@ -510,9 +510,8 @@ static void __init omap3_beagle_init(void)
>>> 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
>>> 				  mt46h32m32lf6_sdrc_params);
>>> 
>>> +	/* DVI power down GPIO */
>>> 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
>> 
>> Wouldn't it be an output rather than an input?
> 
> Indeed. Note that I didn't change the line above =).
> 
> It seems this was changed last December:
> 
> -       omap_cfg_reg(J25_34XX_GPIO170);
> +       omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> 
> I wonder if the mux init is even necessary. Shouldn't the bootloader set
> the muxes?

It'd rather have the kernel reset the muxes to the proper value to ensure a known state.

regards,

Koen