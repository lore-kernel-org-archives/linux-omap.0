From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] dspbridge: Simplify Atoi() method
Date: Wed, 10 Feb 2010 09:55:52 -0600
Message-ID: <4B72D708.309@ti.com>
References: <1265192086-15633-1-git-send-email-andy.shevchenko@gmail.com>	 <4B7213C1.1040300@ti.com> <5ec8ebd51002092359v740d4e6asb0b6bab0d069c687@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48465 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab0BJP4D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Feb 2010 10:56:03 -0500
In-Reply-To: <5ec8ebd51002092359v740d4e6asb0b6bab0d069c687@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On 2/10/2010 1:59 AM, Andy Shevchenko wrote:
> On Wed, Feb 10, 2010 at 4:02 AM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>>> Try to use simple_strtol() kernel native method instead.
>> strtol or strtoul?
> I don't know for sure, see below.

sorry, i meant: here it says simple_strtol but the code says simple_strtoul

>
>>> However, there are opened questions:
>>>   - why type of Atoi() is s32 if the sign is used only to detect base?
> This is the question about l vs ul.

agree, IMO this should be ul, I haven't reviewed all the places where 
Atoi is used but the ones I have seen use it as ul

about the sign: I haven't seen any value with '+' or '-' prefix so with 
this patch the decision to identify as base10 is left to 
simple_guess_base inside strtoul

if value strings had '0x' instead of ending 'H' for hex the whole Atoi 
could be replaced, i guess this would also allow to use strict_strtoul 
and avoid a checkpatch warning :(

- omar

