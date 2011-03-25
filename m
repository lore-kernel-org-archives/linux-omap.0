From: Andy Green <andy@warmcat.com>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 13:34:04 +0000
Message-ID: <4D8C99CC.5020103@linaro.org>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <201103251249.32578.arnd@arndb.de> <4D8C85DB.6060001@linaro.org> <201103251424.47141.arnd@arndb.de>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39794 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab1CYNeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 09:34:09 -0400
Received: by wya21 with SMTP id 21so1101188wya.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 06:34:08 -0700 (PDT)
In-Reply-To: <201103251424.47141.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On 03/25/2011 01:24 PM, Somebody in the thread at some point said:
> On Friday 25 March 2011, Andy Green wrote:
>> Having a proper MAC from IEEE assigned for each interface is of course
>> ideal.
>>
>> But even if that happened today though, on Panda there is no "board
>> identity storage" to put the reserved MAC addresses in to bind it to the
>> physical board.  If you try to manage them on SD Card, you have the
>> problem of dealing with correct MAC addresses needing putting there
>> again every time it is nuked.  So it doesn't in itself help in the Panda
>> case.
>
> What I meant is computing an official MAC address from the same input
> data as you already do. Unfortunately that would mean having at most 24
> bits available instead of the 44 or so bits you currently use, because
> the upper half of the address then becomes fixed.
>
> Also it would require
> 1. defining an new algorithm that computes the lower 24 bits from the
>     die ID in a way that minimises the chances of collision
> 2. Getting an official identifier for the upper half of the address
>     assigned to the OMAP3/OMAP4 CPUs
> 3. Documenting this method in the OMAP data sheets.

I see.  It would work OK then.  They probably wouldn't want to blow 
their $1750 just on Panda though, so maybe they set 4 bits or whatever 
and let 20 be computed.

However, the only practical advantage is that it would show up as a TI 
MAC in an OUI database.  The "locally administered" address as used at 
the moment is otherwise legal in every respect AFAIK.

-Andy
