From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 0/10] OPP layer and additional cleanups.
Date: Fri, 08 Jan 2010 12:40:55 +0530
Message-ID: <4B46DA7F.8080808@ti.com>
References: <1262266140.20175.176.camel@boson> <4B42609B.7050403@ti.com> <4B459A23.9030709@ti.com> <4B4603A3.4030608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52288 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab0AHHLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jan 2010 02:11:08 -0500
In-Reply-To: <4B4603A3.4030608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>>
>> Only point I see that may disfavor list based implementation is the fact that we
>> do not expect high number of OPPs.
> yes + overhead of CPU cycles walking thru the list Vs indexing off an array.
True there is overhead but the downside of an array is reallocing (as is the
case in the previous patch).
> 
>> Having said this, I have tried to encapsulate the implementation within the OPP
>> layer. So moving to array/list/any other fancy data structure should be hidden
>> within OPP.  So the patchset is not only about moving to a list based
>> implementation. It also to change the semantics of the OPP layer APIs with a
>> deliberate intent to hide/encapsulate the implementation details.
> opp.h:
> +struct omap_opp {
> +       struct list_head opp_node;
> +       unsigned int enabled:1;
> +       unsigned long rate;
> +       unsigned long uvolt;
> +};
> this is exactly what we have been trying to avoid in the first place 
> (see numerous discussions in the last few months in l-o ML). This allows 
> for users of opp.h to write their own direct handling mechanisms and we 
> want to prevent it by forcing callers to use only accessor apis. opp.h 
> is meant as in include file for all users of opp layer and it's inner 
> workings/ inner structures should be isolated to opp.c OR a private 
> header file alone.

I am not sure what you say is correct. If you see the opp.h file in my patches
you will find that it has accessor APIs. One does not have to do any
dereferencing to access any of the struct omap_opp members.
On the other hand if you look into opp.c you will find a struct opp_list. This
is the internal details that users do not want to care about and thus I have put
it in opp.c. OTOH when you define the opp lists (e.g. for 3630, 3430) we do it
in an array of struct omap_opp. Hence we need to define this in opp.h So I think
your concern is taken care of.
> 
>>>> * The OPP layer APIs have been changed. The search APIs have been
>>>> reduced to one instead of opp_find_{exact|floor|ceil}.
>>> Could you let us know the benefit of merging this? the split is aligned 
>>> in the community as such after the very first implementation which had 
>>> all three merged as a single function, but was split after multiple 
>>> review comments on readability aspects.
>> Actually I wanted to minimize the number of interfaces to OPP Layer. What was
>> shouting at me was the fact that OPP layer at the heart of it is a in memory
>> data list. So all we need to poke about OPP is to add/delete/enable/disable/search.
>> for search I thought only a single interface like
>> 'find_opp_by_freq' is enough. The flags passed to this function should dictate
>> the mode of the search.
> 
> yes, I am aware of this(my first series was motivated by the same 
> though), but the alignment with the community is for:
> split search into search_exact, search_ceil, search_floor for 
> readability purposes. I dont deny that this is a data list and the basic 
> APIs u mentioned are what is enough, but functionally, search is split 
> as the above instead of taking params to denote the variations in search 
> techniques - hence the community consensus.
> 

I wanted to reduce the interfaces. Imagine designing a car with two steerings
(one for going for driving back and the other for going forward). Instead it is
better to have one steering with a control to decide if you want to go forward
or backward.

> I really dont care if struct omap_opp * or enum is used (they are both 
> 32bit and have to be dereferenced at the end of the day) to refer to a 
> voltage domain. In fact using enum might allow us to do cross opp 
> dependency queries too if such an infrastructure is being introduced, 
> but that can be done also with struct omap_opp albiet in an obtuse way.

Slight difference than what you say. When you maintain a pointer to the head of
your data structure (be it an array or a list) and expect the APIs to pass it
around, it is different from passing an enum to identify which list you want to
search. You do not need to store a handle to the initiliazed list anymore.
