From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [ANNOUNCE] dspbridge: kill camelcase
Date: Wed, 24 Feb 2010 11:02:04 -0600
Message-ID: <4B855B8C.5060000@ti.com>
References: <4B848B9B.2030002@ti.com> <20100224031325.GM28173@atomide.com> <4B84D759.7000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46963 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757313Ab0BXRCH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 12:02:07 -0500
In-Reply-To: <4B84D759.7000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On 2/24/2010 1:38 AM, Menon, Nishanth wrote:
> Tony Lindgren said the following on 02/24/2010 05:13 AM:
>> * Omar Ramirez Luna<omar.ramirez@ti.com>  [100223 18:11]:
>>> Hi All,
>>>
>>> I'm currently working on removing camel case + hungarian notation
>>> from dspbridge code in the following branch:
>>>
>>> dspbridge-next-camelcase on d.o-z
>>>
>>> I'll appreciate if you can mail any unsent patch otherwise it will
>>> need to wait (and be rebased) after the camelcase changes.
>>>
>>> If nobody disagrees I'll be marking dspbridge 0.2 (as per private
>>> discussion) in the upcoming days.
>>
>> Maybe do a perl or sed script that allows you to convert one
>> string at a time? That way you can regenerate the patches as
>> needed.
>>
>> We used something like that to convert the musb code a few
>> years ago.
>>
>> I recommend converting one variable at a time and then compile
>> and boot test in between. Otherwise you can easily convert
>> substrings accidentally and then things will not compile..
>
> I think we discussed this quiet some time back:
> http://marc.info/?t=125319739500001&r=1&w=2 - yep there is script
> available.
>

Tony,

Yes, it is not a bad idea to generate single patches, probably I can 
create another branch if needed for each change, in my laziness I 
decided to replace safe stuff in one shot.

Nishanth,

I have been playing with the script, which is great to parse the tags 
file and create the new tokens, but not so hot for replacing stuff.

If you have time, you can criticize my rationale ;)

http://dev.omapzoom.org/?p=tidspbridge/kernel-dspbridge.git;a=commit;h=7c0065d4219b7b4ba15709870ef9fb819f7e71c8

All,

As of know, with the safe symbols (this means symbols are not duplicated 
in bridge code), I had to fix:

   dspbridge: conflicting types for 'mem_init'
   dspbridge: variable or field 'nop' declared void
   dspbridge: conflicting types for 'clk_init'
   dspbridge: conflicting types for 'io_schedule'
   dspbridge: conflicting types for 'find_symbol'

These are duplicated on kernel sources so renamed:
mem_init ==> services_mem_init
clk_init ==> services_clk_init
io_schedule ==> iosm_schedule
find_symbol ==> dbll_find_symbol

Right now count stands:
151 files changed, 12579 insertions(+), 12579 deletions(-)

I'll now proceed to rename the symbols classified as "dangerous", 
because might get duplicated with new replacements.

Thanks,

- omar
