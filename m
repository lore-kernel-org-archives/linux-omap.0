From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: mux strategy (was RE: [PATCH] [OMAP1] mux: Add MMC mux pins	for
 omap7xx)
Date: Thu, 08 Oct 2009 08:27:40 +0200
Message-ID: <4ACD865C.70106@compulab.co.il>
References: <6cb013310910060653u4825da1cwf738a9acef5835b2@mail.gmail.com> <4ACB7EC0.3010401@ti.com> <6cb013310910061244q40b78c0ubad1932578e75bd3@mail.gmail.com> <87hbucp6ng.fsf@deeprootsystems.com> <7A436F7769CA33409C6B44B358BFFF0C012A67976D@dlee02.ent.ti.com> <878wfop4rc.fsf@deeprootsystems.com> <20091007174750.GG7899@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54226 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbZJHG2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Oct 2009 02:28:19 -0400
In-Reply-To: <20091007174750.GG7899@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Tony Lindgren wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [091006 15:18]:
>> "Menon, Nishanth" <nm@ti.com> writes:
>>
> 
> BTW, I've been thinking about the following sets of patches for the next
> merge window:
> 
> 1. Do the include directories for mach-omap1 and mach-omap2 as suggested
>    by Russell earlier
> 
> 2. Move all mux code to only live under arch/arm/*omap*/ and make sure
>    drivers don't call omap_cfg_reg() any longer

IMHO, we should also change omap_cfg_reg to omap_cfg_mux or something alike.

> 3. Remove the enumeration for the mux and require all the boards to
>    register the pins they'll use

+1

> After these it should be trivial to improve the mux code further. The
> steps 2 & 3 above will be most likely breaking things for some boards,
> so help will be needed with testing.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Sincerely yours,
Mike.

