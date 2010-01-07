From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/10] OPP layer and additional cleanups.
Date: Thu, 7 Jan 2010 09:54:11 -0600
Message-ID: <4B4603A3.4030608@ti.com>
References: <1262266140.20175.176.camel@boson> <4B42609B.7050403@ti.com> <4B459A23.9030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141Ab0AGPyP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 10:54:15 -0500
In-Reply-To: <4B459A23.9030709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 01/07/2010 02:24 AM, the following:
>>> * OPP layer internals have moved to list based implementation.
>> Is there a benefit of list based implementation?
> 
> Actually, this is a question I have asked myself several times. The motivation
> behind list based implementation is to accommodate introduction and revocation
> of OPPs.(Not just enabling and disabling). Today's CPUFREQ layer and OPP layer
> are disjoint (meaning we prepare the OPPs at boot time and then cpufreq copies
> them to its own internal arrays). I want this to be united.
> 
> Only point I see that may disfavor list based implementation is the fact that we
> do not expect high number of OPPs.
yes + overhead of CPU cycles walking thru the list Vs indexing off an array.

> 
> Having said this, I have tried to encapsulate the implementation within the OPP
> layer. So moving to array/list/any other fancy data structure should be hidden
> within OPP.  So the patchset is not only about moving to a list based
> implementation. It also to change the semantics of the OPP layer APIs with a
> deliberate intent to hide/encapsulate the implementation details.
opp.h:
+struct omap_opp {
+       struct list_head opp_node;
+       unsigned int enabled:1;
+       unsigned long rate;
+       unsigned long uvolt;
+};
this is exactly what we have been trying to avoid in the first place 
(see numerous discussions in the last few months in l-o ML). This allows 
for users of opp.h to write their own direct handling mechanisms and we 
want to prevent it by forcing callers to use only accessor apis. opp.h 
is meant as in include file for all users of opp layer and it's inner 
workings/ inner structures should be isolated to opp.c OR a private 
header file alone.

> 
>>> * The OPP layer APIs have been changed. The search APIs have been
>>> reduced to one instead of opp_find_{exact|floor|ceil}.
>> Could you let us know the benefit of merging this? the split is aligned 
>> in the community as such after the very first implementation which had 
>> all three merged as a single function, but was split after multiple 
>> review comments on readability aspects.
> 
> Actually I wanted to minimize the number of interfaces to OPP Layer. What was
> shouting at me was the fact that OPP layer at the heart of it is a in memory
> data list. So all we need to poke about OPP is to add/delete/enable/disable/search.
> for search I thought only a single interface like
> 'find_opp_by_freq' is enough. The flags passed to this function should dictate
> the mode of the search.

yes, I am aware of this(my first series was motivated by the same 
though), but the alignment with the community is for:
split search into search_exact, search_ceil, search_floor for 
readability purposes. I dont deny that this is a data list and the basic 
APIs u mentioned are what is enough, but functionally, search is split 
as the above instead of taking params to denote the variations in search 
techniques - hence the community consensus.

>>> * OPP book-keeping is now done inside OPP layer. We do not have to
>>> maintain pointers to {mpu|dsp|l3}_opp, outside this layer.
>> nice idea, BUT, you need some sort of domain reference mechanism, 
>> introducing a enum (as done in enum volt_rail - patch 6/10) is the same 
>> as providing named struct pointers, they perform the same function = 
>> identifying the voltage domain for the operation. what is the benefit of 
>> using enum?
> 
> The introduction of enum volt_rail is a totally different thing. It is to make
> the voltage scaling function generic. On the other hand identifying the OPP list
> is also enum based (like MPU_OPP, DSP_OPP, L3_OPP). This is to identify the opp
> list I am interested in. Note that doing this enables me to get away from
> maintaining struct omap_opp *.
Sigh.. more description below.

>>> * removed omap_opp_def as this is very similar to omap_opp.
>> yes, but the original intent was that registration mechanism will use a 
>> structure that is visible to the caller, this allows for isolated 
>> modification of structure and handling mechanism keeping the overall 
>> system impact minimal.
> 
> Moving to struct omap_opp reduces one more data structure. I am sorry, I did not
> follow the later part of your above comment.

I am hoping we are getting the thought across: providing a predefined 
supported OPP information to the OPP layer (a.k.a registration for a 
specific CPU type) should be decoupled with the OPP 
query/operation/search: that is the purpose of introducing APIs in the 
first place.

the initial intent was:
struct omap_opp_def is exposed to the world (a.k.a files which would 
like to register the predefined tables) for registration

struct omap_opp is provided for the files which would like to 
query/operate etc on OPPs.
For this: a) you have introduced enum with an array - which IMHO causes 
CPU specific dependencies - OMAP3 has MPU,DSP,L3 rails, while OMAP4 and 
future OMAP5 generations possibly will have different rails.
b) my approach was a generic struct omap_opp * which is CPU independent.
	NOTE: opp.h
956f872d        (Kevin Hilman   2009-12-16 14:29:39 -0800 
16)extern struct omap_opp *mpu_opps;
this is not intended to be final, but it is ok for the 
timebeing(considering OMAP1,2,3 ONLY). the reason why I would prefer 
[mpu|dsp|l3]_opps NOT to be defined in opp.h is because opp.h is 
supposed to be CPU independent - we should keep it that way. and 
introduce the specific opp list into the cpu specific file.

I really dont care if struct omap_opp * or enum is used (they are both 
32bit and have to be dereferenced at the end of the day) to refer to a 
voltage domain. In fact using enum might allow us to do cross opp 
dependency queries too if such an infrastructure is being introduced, 
but that can be done also with struct omap_opp albiet in an obtuse way.



>>> Verified this on zoom2 with and without lock debugging. 
>> zoom3/sdp3630?
> Not yet verified. Any help on this from anyone in the list is appreciated.
lets have an aligned version before we go ahead with major tests IMHO, 
just was curious in my question. but for the next patch series, please 
flag it so, so that we know if we need to pitch in ;).

>>>
>> minor comment:
>> Might be good if your patches 1/10 to 9/10 had different subjects.
> Yes, Santosh pointed the same to me few days back. I agree this can be done.
> 
thanks.

-- 
Regards,
Nishanth Menon
