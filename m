From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different
 OPP types
Date: Fri, 15 Jan 2010 04:56:56 -0600
Message-ID: <4B5049F8.2090708@ti.com>
References: <1263299979.1536.7.camel@boson> <7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com> <4B4DA36C.7040206@ti.com> <4B4DC297.8070703@gmail.com> <4B4DC8FF.8090606@ti.com> <4B5044DB.1010201@ti.com> <4B504678.8030407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59252 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0AOK47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:56:59 -0500
In-Reply-To: <4B504678.8030407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 01/15/2010 04:42 AM, the following:
[..]
> I like this message. I will include it.
:) I am getting this wrong feel that I should start writing novels ;).

[...]
>> now, I was recommending doing a, till a thought a little more on the 
>> implementation(array based) and how long that implementation might 
>> last(we might potentially move opp.c to a list implementation). the 
>> effort would be to complicate the opp_init,add functions for a very 
>> short lifetime. This effort maynot be worth it.
> 
> I understand your concern. I have made some changes in the code. Please look at
> the reposted patch (in few mins from now I shall post them).
Thanks..

>>>>>> Enum type and variable have the same name :( mebbe a rename of variable is
>>>>>> appropriate
>>>>>>     
>>>>> Not sure why you say this. Did you see the compiler throwing up any warning?
>>>>>   
>>>> The usage later in the code is opp_t -> this is a readability issue not 
>>>> a compiler warning.
>>> What is the readability issue? Why cant we declare something like enum opp_t opp_t?
>> Let me try to explain this clearly. assume we have a struct opp_t (not 
>> enum) for the time being.
>> void some_func(struct opp_t *opp_t)
>> {
>>    struct opp_t *opp;
>>
>> ..
>> 200 line of code (>one page full)
>> ....
>> /* point 1 */
>>     BUG_ON(opp_t.xyz)
>> ...
>>   200 lines of more code
>> ..
>> /* point 2 */
>>     BUG_ON(opp.xyz)
>> ...
>>
>> }
>>
>> lets say this is compiled by some non follower of this mail chain,
>> compiler throws an error for point 1: filex:liney
>> so the guy/gal fires up vim and opens the filex, goes to line y
>> he/she cannot see the start of the function, knows that there is a 
>> struct opp_t
> 
> If a function is that big then the fault lies there to start with! What do you say?
> Nevertheless, your suggestion is cosmetic but I think we should not assume that
> developers are so ignorant. For now I will do away with your suggestion. Please
> feel free to change the code if you think what you say is the right thing.
Having spent a few years on properitory s/w and been one of those 
confused blokes(I being a certified nitwit), I will try to see if I can 
provide a patch on top and Kevin/community can choose to add their 
comments/club the patches and make the few folks like me happy.

-- 
Regards,
Nishanth Menon
