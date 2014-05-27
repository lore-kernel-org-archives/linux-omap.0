From: Archit Taneja <archit@ti.com>
Subject: Re: [RFC 1/2] ARM: OMAP2+: hwmod: Add refcounting for modulemode
 shared by multiple hwmods
Date: Tue, 27 May 2014 16:19:20 +0530
Message-ID: <53846DB0.2010809@ti.com>
References: <alpine.DEB.2.02.1405141939030.21921@utopia.booyaka.com> <1401101095-27181-1-git-send-email-archit@ti.com> <538466F1.3070806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48366 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbaE0Kui (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 May 2014 06:50:38 -0400
In-Reply-To: <538466F1.3070806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

Hi,

On Tuesday 27 May 2014 03:50 PM, Rajendra Nayak wrote:
> On Monday 26 May 2014 04:14 PM, Archit Taneja wrote:
>> Generally, IP blocks/modules within a clock domain each have their own
>> CM_x_CLKCTRL register, each having it's own MODULEMODE field to manage the
>> module.
<snip>

>> @@ -2751,6 +2820,13 @@ static int __init _register(struct omap_hwmod *oh)
>>   	if (_lookup(oh->name))
>>   		return -EEXIST;
>>
>> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED &&
>> +			!oh->prcm.omap4.modulemode_ref) {
>
> You might also want to check for someone populating a modulemode_ref but
> failing to populate the flag?
>
> Alternatively, Since you expect a modulemode_ref to be always available for all modules which
> share modulemode, that in itself can be used to identify such modules without the
> need of an additional flag?

It does seem redundant to have a flag at the moment. But the flag make 
things more visible. 'prcm.omap4.modulemode' seems to work without a 
flag too, so I suppose I'll remove the flag.

>
>> +		pr_err("omap_hwmod: %s shares modulemode, but doesn't hold a ref to it\n",
>> +			oh->name);
>> +		return -EINVAL;
>> +	}
>> +
>>   	list_add_tail(&oh->node, &omap_hwmod_list);
>>
>>   	INIT_LIST_HEAD(&oh->master_ports);
>> @@ -2759,6 +2835,15 @@ static int __init _register(struct omap_hwmod *oh)
>>
>>   	oh->_state = _HWMOD_STATE_REGISTERED;
>>
>> +	if (oh->prcm.omap4.flags & HWMOD_OMAP4_MODULEMODE_SHARED) {
>> +		struct modulemode_shared *mmode = oh->prcm.omap4.modulemode_ref;
>> +
>> +		if (!mmode->registered) {
>> +			spin_lock_init(&mmode->lock);
>> +			mmode->registered = true;
>
> If this is only used to keep track of the spin_lock being initialized, maybe it'll be
> more readable if you just call it mmode->spin_lock_init = true.

Yes, I'll fix this.

Archit

