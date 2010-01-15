From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Fri, 15 Jan 2010 16:12:00 +0530
Message-ID: <4B504678.8030407@ti.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com> <4B4DA36C.7040206@ti.com> <4B4DC297.8070703@gmail.com> <4B4DC8FF.8090606@ti.com> <4B5044DB.1010201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab0AOKmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 05:42:10 -0500
In-Reply-To: <4B5044DB.1010201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth,
             I was about to post a re-worked patch. Anyways, please see below:
> Here is a sample commit message I can think of:
> ----
> Using omap_opp * to refer to domain types restricts opp implementation 
> into maintaining pointers outside the opp layer. This causes issues such as:
> a) Describing cross domain dependencies (e.g. dsp vs mpu)
> b) Ease of transitioning/supporting to multiple silicon variants and 
> families
> c) Choice of varied options in implementing opp layer internals.
> 
> Since all we need a identifying a specific domain for query/operational 
> purposes, we introduce enum for identifying OPP types instead of using 
> opp layer's internal data structure pointer.
> 
> Currently, OMAP3 is the only silicon supporting the OPP layer, hence 
> mpu_opps, l3_opps and dsp_opps are deprecated and replaced with OPP_MPU, 
> OPP_L3 and OPP_DSP respectively.

I like this message. I will include it.

>>>>   
>>>>   
>>> definition of enum and the implicit usage  of enums are in two different 
>>> files. there is a distinct possibility of some one modifying the header 
>>> without actually knowing that .c depends on the exact values of the enum 
>>> definition.
>> As I said before one needs to make changes in the kernel by knowing what they
>> are doing.
>>> pm34xx.c has no right to depend on opp.h definition values -> if it does 
>>> it ties it down and a constraint for future flexibility. please change.
>> The right approach should be to take out the loop in pm34xx.c for now and
>> explicitly call the opp_init_list function after passing OPP_MPU, OPP_L3,
>> OPP_DSP in any order. So pm34xx.c needs to change not opp.[ch]. What do you think?
> 
> I did dig into this a few mins ago.. and yes I can see similar example 
> in drivers/mfd/twl4030-core.c
> 
> The intent of my comment is this: when someone else, few months from 
> now, is focusing on adding/changing opp logic, they will focus on opp.c 
> and .h. we have two choices to handle this:
> a) Ensure that users of opp.h do not know how it works internally -> 
> e.g. ordering of opp list for example.
> b) add
> /* WARNING: See file:arch/arm/mach-omap2/pm34xx.c before modifying the 
> sequence of these enums */ to opp.h
> and
> /* WARNING: See file:arch/arm/plat-omap/include/plat/opp.h before 
> modifying this */ in pm34xx.c
> 
> now, I was recommending doing a, till a thought a little more on the 
> implementation(array based) and how long that implementation might 
> last(we might potentially move opp.c to a list implementation). the 
> effort would be to complicate the opp_init,add functions for a very 
> short lifetime. This effort maynot be worth it.

I understand your concern. I have made some changes in the code. Please look at
the reposted patch (in few mins from now I shall post them).
>>>>> Enum type and variable have the same name :( mebbe a rename of variable is
>>>>> appropriate
>>>>>     
>>>> Not sure why you say this. Did you see the compiler throwing up any warning?
>>>>   
>>> The usage later in the code is opp_t -> this is a readability issue not 
>>> a compiler warning.
>> What is the readability issue? Why cant we declare something like enum opp_t opp_t?
> 
> Let me try to explain this clearly. assume we have a struct opp_t (not 
> enum) for the time being.
> void some_func(struct opp_t *opp_t)
> {
>    struct opp_t *opp;
> 
> ..
> 200 line of code (>one page full)
> ....
> /* point 1 */
>     BUG_ON(opp_t.xyz)
> ...
>   200 lines of more code
> ..
> /* point 2 */
>     BUG_ON(opp.xyz)
> ...
> 
> }
> 
> lets say this is compiled by some non follower of this mail chain,
> compiler throws an error for point 1: filex:liney
> so the guy/gal fires up vim and opens the filex, goes to line y
> he/she cannot see the start of the function, knows that there is a 
> struct opp_t

If a function is that big then the fault lies there to start with! What do you say?
Nevertheless, your suggestion is cosmetic but I think we should not assume that
developers are so ignorant. For now I will do away with your suggestion. Please
feel free to change the code if you think what you say is the right thing.


Regards,
-Romit

