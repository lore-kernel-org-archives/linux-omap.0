From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 1/4] PLAT-OMAP: MCBSP: Tranform into platform driver
Date: Thu, 29 May 2008 11:30:04 -0400
Message-ID: <a0580c510805290830p2709014i7b5e47a6365f005e@mail.gmail.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
	 <1210022587-7756-2-git-send-email-edubezval@gmail.com>
	 <20080520234438.GR23002@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:48510 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbYE2PaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 11:30:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2292465ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 08:30:05 -0700 (PDT)
In-Reply-To: <20080520234438.GR23002@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Tony and Trilok,


I was out of office this last week due to some trainings and brazilian holidays,
so that's why this message is delayed.

I'm sending a version of this series including your patch and your comments.
Please review them as usual. I think that Chandra can still put his
work on top of this
as the change is not that big.

On Tue, May 20, 2008 at 7:44 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Some comments below.

<snip>

>
> You need to check for the errors with clk_get here. Also, I needed the
> attached patch to keep asoc working on 24xx.

Ok. Including your patch to the series. Forgot to change this to 24xx clocks.

>
> In general, how about create a custom clock for each mcbsp that handles
> all the other clocks? That way you can have just one struct clk * for
> each mcbsp and you can use standard clk_enable/disable calls instead
> of the hard to read macros.
>
> You can add the custom clocks to clock fwk with clk_register() during
> the omap specific mcbsp init depending on which mcbsp's are in use
> from board-*.c files. Then the custom clock defines it's own
> enable/disable function that just calls the clk_enable/disable on the
> right mcbsp clocks.
>
>

<snip>

> These macros make things hard to read.. It would be best to have
> things set up in a way so you can just call clk_enable/disable in
> mcbsp.c.

I thought to do it as you describe above but I made it different to
avoid duplicated code into
mach-omap1 and mach-omap2. However, as you said the code became too
hard to understand,
I believe it is better to make it simple.

I'm going to send a new version of this series including:
1. your patch to 24xx
2. clock changes for mach-omap1 and mach-omap2
3. module release for mach-omap1 and mach-omap2  as recommended by Trilok

>
> Tony
>
>
>> +int omap_mcbsp_init(void);
>> +void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
>> +                                     int size);
>>  void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
>>  int omap_mcbsp_request(unsigned int id);
>>  void omap_mcbsp_free(unsigned int id);
>> --
>> 1.5.5.1.67.gbdb8.dirty
>>
>



-- 
Eduardo Bezerra Valentin
