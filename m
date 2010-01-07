From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 0/10] OPP layer and additional cleanups.
Date: Thu, 07 Jan 2010 13:54:03 +0530
Message-ID: <4B459A23.9030709@ti.com>
References: <1262266140.20175.176.camel@boson> <4B42609B.7050403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47123 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562Ab0AGIYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 03:24:12 -0500
In-Reply-To: <4B42609B.7050403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>> * OPP layer internals have moved to list based implementation.
> 
> Is there a benefit of list based implementation?

Actually, this is a question I have asked myself several times. The motivation
behind list based implementation is to accommodate introduction and revocation
of OPPs.(Not just enabling and disabling). Today's CPUFREQ layer and OPP layer
are disjoint (meaning we prepare the OPPs at boot time and then cpufreq copies
them to its own internal arrays). I want this to be united.

Only point I see that may disfavor list based implementation is the fact that we
do not expect high number of OPPs.

Having said this, I have tried to encapsulate the implementation within the OPP
layer. So moving to array/list/any other fancy data structure should be hidden
within OPP.  So the patchset is not only about moving to a list based
implementation. It also to change the semantics of the OPP layer APIs with a
deliberate intent to hide/encapsulate the implementation details.

> 
>> * The OPP layer APIs have been changed. The search APIs have been
>> reduced to one instead of opp_find_{exact|floor|ceil}.
> 
> Could you let us know the benefit of merging this? the split is aligned 
> in the community as such after the very first implementation which had 
> all three merged as a single function, but was split after multiple 
> review comments on readability aspects.

Actually I wanted to minimize the number of interfaces to OPP Layer. What was
shouting at me was the fact that OPP layer at the heart of it is a in memory
data list. So all we need to poke about OPP is to add/delete/enable/disable/search.
for search I thought only a single interface like
'find_opp_by_freq' is enough. The flags passed to this function should dictate
the mode of the search.
> 
>> * OPP book-keeping is now done inside OPP layer. We do not have to
>> maintain pointers to {mpu|dsp|l3}_opp, outside this layer.
> nice idea, BUT, you need some sort of domain reference mechanism, 
> introducing a enum (as done in enum volt_rail - patch 6/10) is the same 
> as providing named struct pointers, they perform the same function = 
> identifying the voltage domain for the operation. what is the benefit of 
> using enum?

The introduction of enum volt_rail is a totally different thing. It is to make
the voltage scaling function generic. On the other hand identifying the OPP list
is also enum based (like MPU_OPP, DSP_OPP, L3_OPP). This is to identify the opp
list I am interested in. Note that doing this enables me to get away from
maintaining struct omap_opp *.
> 
>> * removed omap_opp_def as this is very similar to omap_opp.
> yes, but the original intent was that registration mechanism will use a 
> structure that is visible to the caller, this allows for isolated 
> modification of structure and handling mechanism keeping the overall 
> system impact minimal.

Moving to struct omap_opp reduces one more data structure. I am sorry, I did not
follow the later part of your above comment.
>> Verified this on zoom2 with and without lock debugging. 
> zoom3/sdp3630?
Not yet verified. Any help on this from anyone in the list is appreciated.
>>
>>
> minor comment:
> Might be good if your patches 1/10 to 9/10 had different subjects.
Yes, Santosh pointed the same to me few days back. I agree this can be done.

