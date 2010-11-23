From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v4 2/3] omap4: opp: add OPP table data
Date: Wed, 24 Nov 2010 00:30:06 +0100
Message-ID: <4CEC4E7E.7020503@ti.com>
References: <1289933661-19505-3-git-send-email-nm@ti.com>	<87aal1kktu.fsf@deeprootsystems.com> <4CEAFD00.4090200@ti.com> <87tyj8kii7.fsf@deeprootsystems.com> <4CEBDB7A.8010807@ti.com> <4CEC413C.3070904@ti.com> <4CEC46B6.1020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37467 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab0KWXaH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 18:30:07 -0500
In-Reply-To: <4CEC46B6.1020700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Tony <tony@atomide.com>, Thomas <thomas.petazzoni@free-electrons.com>

On 11/23/2010 11:56 PM, Menon, Nishanth wrote:
> Cousson, Benoit had written, on 11/23/2010 04:33 PM, the following:
>> Hi Nishanth,
>>
>> On 11/23/2010 4:19 PM, Menon, Nishanth wrote:
>>> Kevin Hilman had written, on 11/22/2010 06:09 PM, the following:
>>>> Nishanth Menon<nm@ti.com>   writes:
>>>>
>>>>> Kevin Hilman wrote, on 11/22/2010 05:19 PM:
>>>>>> Nishanth Menon<nm@ti.com>    writes:
>>>>>>
>>>>>>> This patch adds OPP tables for OMAP4. New file has been added to keep
>>>>>>> the OMAP4 opp tables and the registration of these tables with the
>>>>>>> generic opp framework by OMAP SoC OPP interface.
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
>>>>>>> index 66e12be..48a553f 100644
>>>>>>> --- a/arch/arm/mach-omap2/opp.c
>>>>>>> +++ b/arch/arm/mach-omap2/opp.c
>>>>>>> @@ -131,4 +131,5 @@ static int __init omap_init_opp_table(struct
>>>>>>> omap_opp_def *opp_def,
>>>>>>>
>>>>>>>     /* omap3 opps */
>>>>>>>     #include "opp3xxx_data.c"
>>>>>>> -
>>>>>>> +/* omap4 opps */
>>>>>>> +#include "opp4xxx_data.c"
>>>>>> I'm not sure I like the including of C files.  Any reason you prefer
>>>>>> this to just adding them to the Makefile?  e.g. opp24xx_dta.c are
>>>>>> compiled in via Makefile and these two are included.
>>>>> I dont buy it. I am seeing us go around in circles for this:
>>>>> http://marc.info/?l=linux-omap&m=128986880406272&w=2
>>>>> a) we dont want others to use specifics implemented in opp.c in other
>>>>> files (e.g. board files)
>>>>
>>>> not sure how this is prevented.
>>> The approach is as follows:
>>> the #defines and struct definitions are in opp.c
>>> opp{3,4}xxx_data.c use the same - by itself wont build because they need
>>> the defines in opp.c
>>> that way, there is no possibility of clean hacks possible except to
>>> follow the current mechanism for a future omap silicon
>>>
>>> The main objective was to restrict the potential of board developers
>>> from hacking the default OPP table - which would be possible by exposing
>>> the headers for board files - which as Thomas rightly pointed out in the
>>>     thread I pointed out,  opens up a possibility for board files to
>>> include them as well and re-instantiate the table again..
> [...]
>>
>> FYI, Paul changed the clock and hwmod data files from include to C
>> files, because Russell didn't like at all the include of data file.
>>
>> Why cannot we handle the opp data the same way we are managing clock,
>> hwmod or even pad mux data for various Soc?
>
> Objective:
> I do not want folks to start creating their own custom "default" OPP
> tables for silicon and registering with OPP framework. intent is to have
> the default OPP tables in one place - here.
>
> Solution I followed:
> make the following:
> a) struct omap_opp_def
> b) OPP_INITIALIZER
> c) omap_init_opp_table
> not available for anyone other than opp.c - they are defined in opp.c
> and not available externally.
>
> If these were in a header, I am inviting failure of my objective. yes, I
> could review it when posted to l-o and NAK it, but wont prevent private
> trees from basically(IMHO) misusing the framework
>
> Options available:
> a) v1,2,3 of the series basically used a header opp{3,4}xxx_data .h
> in v3, I received a comment (IMHO rightly so) that a header defining a
> static array implies capability for some other file to include the
> header and misuse it (basically headers are meant to share data structs
> between x and y - if you dont intend to do that, then put it in a c file)
> b) in v4, I converted the data header to a .c and included the data.c in
> opp.c.
>
> NOTE:
> a) padconf, hwmod, clock are designed to be reused by rest of
> mach-omap2. opp defines are meant to be isolated. I dont really have a
> preference c or header file for the data, just that I want to, by design
> "make any hacks attempts - *really ugly*"

Mmm, I'm not convince that this will prevent anybody to do dirty stuff 
anyway.
Doing "dirty" stuff to avoid even more dirty stuff is kind of a weird 
approach... for my point of view at least...

And no, this is not that different than the hwmod data or clock data... 
These data are never manipulated directly by anybody but the core code.

> b) Inclusion of c in c files are not uniquely introduced here.
> $ find . -iname "*.c"|xargs grep "#include"| grep -v "\.h"|grep
> ":#include"|wc -l
> 558

That does not mean that we have to keep doing it.
There are probably much more lines of code that does not stick to the 
CodingStyle ;-)

> Hope this clarifies.
Yes, but that still does not justify that for my point of view.

Benoit
