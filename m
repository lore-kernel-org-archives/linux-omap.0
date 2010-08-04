From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [RFC 0/7] OMAP: Basic DVFS framework
Date: Wed, 4 Aug 2010 09:24:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E68C84@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <87mxt3mf3g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758155Ab0HDDyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 23:54:44 -0400
In-Reply-To: <87mxt3mf3g.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, August 04, 2010 5:20 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand;
>>Basak, Partha
>>Subject: Re: [RFC 0/7] OMAP: Basic DVFS framework
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch series is RFC for support of Dynamic Voltage and
>>> Frequency Scaling (DVFS) for OMAP devices. DVFS is a technique that
>>> uses the optimal operating frequency and voltage to allow a task to be
>>> performed in the required amount of time.
>>> OMAP processors have voltage domains whose voltage can be scaled to
>>> various levels depending on which the operating frequencies of certain
>>> devices belonging to the domain will also need to be scaled. This voltage
>>> frequency tuple is known as Operating Performance Point (OPP). A device
>>> can have multiple OPP's. Also a voltage domain could be shared between
>>> multiple devices. Also there could be dependencies between various
>>> voltage domains for maintaining system performance like VDD<X>
>>> should be at voltage v1 when VDD<Y> is at voltage v2.
>>>
>>> The design of this framework take into account all the above mentioned points.
>>> To summarize the basic design of DVFS framework:-
>>>
>>> 1. Have device opp tables for each device whose operating frequency can be
>>>    scaled. This is easy now due to the existance of hwmod layer which
>>>    allow storing of device specific info. The device opp tables contain
>>>    the opp pairs (frequency voltage tuples), the voltage domain pointer
>>>    to which the device belongs to, the device specific set_rate and
>>>    get_rate API's which will do the actual scaling of the device frequency
>>>    and retrieve the current device frequency.
>>> 2. Introduce use counting on a per VDD basis. This is to take care multiple
>>>    requests to scale a VDD. The VDD will be scaled to the maximum of the
>>>    voltages requested.
>>> 3. Keep track of all scalable devices belonging to a particular voltage
>>>    domain the voltage layer.
>>> 4. Generic API in the omap device layer which can be called by anybody
>>>    to scale a device opp. This API will take in the device pointer and
>>>    frequency to which the device needs to be scaled to. This API will
>>>    then internally find out the voltage domain to which the device
>>>    belongs to and the voltage to which the voltage domain needs to
>>>    be put to for the device to be scaled to the new frequency from
>>>    the device opp table. Then this API will call into the newly
>>>    introduced API in voltage layer (as mentioned in 2) to see if
>>>    there are other requests for the associated voltage domain to
>>>    be at a voltage higher than the current chosen one. If not this
>>>    API will go ahead and scale the voltage domain to the new voltage,
>>>    run through the list of all scalable devices belonging to this
>>>    voltage domain and scale them to the appropriate frequencies using
>>>    the set_rate pointer in the device opp table.s
>>>
>>> Work pending -
>>> 1. Handle inter VDD dependencies.
>>> 2. Add OMAP4 support.
>>>
>>> Contributors to conceptualization of the design include
>>> Benoit Cousson <b-cousson@ti.com>,
>>> Kevin Hilman <khilman@deeprootsystems.com>,
>>> Paul Wamsley <paul@pwsan.com>,
>>> Vishwanath Sripathy <vishwanath.bs@ti.com>
>>> Parthasarathy Basak <p-basak2@ti.com>
>>> Anand Sawant <sawant@ti.com>
>>>
>>> This patch series is primarily based of pm-sr branch of kevin's PM tree due to
>>> it's dependency on the newly introduced opp and voltage layer. On top of this
>>> branch I had to apply a few patches to test out dvfs using cpufreq framework.
>>> The following are the link to these additional patches.
>>> 	https://patchwork.kernel.org/patch/107876/
>>
>>This patch does not apply directly to the current pm-sr branch, and also
>>had some review comments to be addressed.
>>
>>> 	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=aa14cb9937e67c48f760c99a3c7fb3b2e7f5e623
>>> 	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=8f1298921d10789bb2f0a2d56cd3b92d844a1450
>>> 	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=10474ce3b07949d791b419aad433590e072e7159
>>> 	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=52fd40b873f8cd5aaea2d01d86ef35017c207eba
>>> 	http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=57a2e45ff4a596a175aba27ae55a2b0d99adc3b5
>>
>>This looks like the current pm-cpufreq branch.  Did you just merge
>>pm-cpufreq or manually apply these?

I had to apply the cpufreq patches manually. If I remember correct I posted this series on PM-SR
branch with the above mentioned patches applied manually. After this I migrated to latest
kernel.org kernel where I again applied some hwmod/device API's, opp layer, cpufreq layer
and voltage/sr series patches manually. I will be posting out a new version of voltage/sr layer patches against kernel.org shortly.
>>
>>Can you please make this available using a git tree so we can determine
>>exactly what was used to put this together?

As I said earlier currently I do have a tree against kernel.org where I have manually applied all the
required patches. This has OMAP4 related changes also. Currently I am working on posting out these patches to LO. I can surely try to make this tree available through a public git.

>>
>>Your series doesn't apply directly to pm-sr neither does the above patch
>>from patchwork, so I cannot currently apply this to anything.

Sorry for this. It did apply for me when I posted these patches. It has been a while now.
Maybe things have changed. I will try posting a fresh series pretty soon.

>>
>>> This series has been tested on OMAP3430 SDP for mpu and iva DVFS through
>>> cpu freq framework.
>>
>>Just to clarify, you're testing this without SRF correct?  Based on the
>>above description, I assume you no longer have SRF code included, but I
>>just want to be sure.

Yep this is true. SRF is removed.

Regards
Thara
