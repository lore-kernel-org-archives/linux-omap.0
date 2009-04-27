From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: OMAP35x GP TIMER as a wakeup trigger
Date: Mon, 27 Apr 2009 12:41:36 -0400
Message-ID: <1f11a5490904270941xa00d495k191dc72bca42d301@mail.gmail.com>
References: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301D73E11C9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:29696 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbZD0Qlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 12:41:37 -0400
Received: by an-out-0708.google.com with SMTP id d40so13533and.1
        for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 09:41:36 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D73E11C9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Mon, Apr 27, 2009 at 12:08 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ashwin Bihari
>> Sent: Monday, April 27, 2009 9:20 PM
>> To: linux-omap@vger.kernel.org Mailing List
>> Subject: OMAP35x GP TIMER as a wakeup trigger
>>
>> Greetings,
>>
>> I need to implement a timer as a wake up trigger while my custom board
>> is in the suspended state. I read in the TRM that all of the GPTIMERs
>> have the capability of generating a wake up interrupt. I'm using the
>> 2.6.28-rc8 PM Kernel which contains the patch to enable all the
>> GPTIMERS as wake up sources.
>
> Are you refering to the "suspend" state coming from:
> echo mem > /sys/power/state
> OR
> One of the idle states C0-C6?
>
> To understand the wakeup sequence from suspend; take a look at:
> arch/arm/mach-omap2/serial.c
> ...esp the IOPAD configuration.
>
> You will have to do something similar.
>
> ~sanjeev
>
Sanjeev,

I was talking about the former (echo mem > /sys/power/state) and I
will take a look at the serial.c file and might return with more
questions. :)

Regards
-- Ashwin
