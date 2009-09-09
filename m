From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: several OMAP newbie questions
Date: Wed, 09 Sep 2009 17:51:01 +0300
Message-ID: <4AA7C0D5.2070106@compulab.co.il>
References: <4A9CF8AC.2010408@compulab.co.il> <f96d234e0909041508m73e0f2a1r946f1c446d3880b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:60554 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbZIIOvA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Sep 2009 10:51:00 -0400
In-Reply-To: <f96d234e0909041508m73e0f2a1r946f1c446d3880b6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-omap@vger.kernel.org



Cliff Brake wrote:
> On Tue, Sep 1, 2009 at 6:34 AM, Mike Rapoport<mike@compulab.co.il> wrote:
> 
>> 3) If I'm not much mistaken, board specific pin mux configuration has to deal
>> with arch/arm/plat-omap/include/mach/mux.h and arch/arm/mach-omap2/mux.c. For
>> instance, if my board uses ULPI pins that have not been defined already, I need
>> to patch those file with my pin mux definitions. Am I right here, or have I
>> missed something?
> 
> It seems to me there should be a global mux configuration per CPU, but
> should be configurable per board, group of boards, etc.  What I would
> like is a set of routines can be used to configure the mux that is
> then called by the board files (similar to PXA).

Yeah, I actually was missing pxa_mfp_config()...
The omap34xx_pins seems somewhat sparse...

> 
> Cliff
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Sincerely yours,
Mike.

