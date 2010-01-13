From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different OPP types
Date: Wed, 13 Jan 2010 06:43:48 -0800
Message-ID: <87skaa3w0r.fsf@deeprootsystems.com>
References: <1263299979.1536.7.camel@boson>
	<7A436F7769CA33409C6B44B358BFFF0C012E309BE6@dlee02.ent.ti.com>
	<4B4DA36C.7040206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60114 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0AMOnw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 09:43:52 -0500
Received: by pwj9 with SMTP id 9so2877786pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 06:43:52 -0800 (PST)
In-Reply-To: <4B4DA36C.7040206@ti.com> (Romit Dasgupta's message of "Wed\, 13 Jan 2010 16\:11\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit Dasgupta <romit@ti.com> writes:

> Menon, Nishanth wrote:
>> 
[...]

>>> -static int __deprecated freq_to_opp(u8 *opp_id, struct omap_opp *opps,
>>> +static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_t,
>> Re: enum type and variable have the same name :( mebbe a rename of variable is
>> appropriate
>>>                 unsigned long freq)
>>>  {
>>>         struct omap_opp *opp;
>>>
>>> -       BUG_ON(!opp_id || !opps);
>>> -       opp = opp_find_freq_ceil(opps, &freq);
>>> +       BUG_ON(opp_t == OPP_NONE || opp_t > OPP_TYPES);
>>> +       opp = opp_find_freq_ceil(opp_t, &freq);
>>>         if (IS_ERR(opp))
>>>                 return -EINVAL;
>>>         *opp_id = opp_get_opp_id(opp);
>>> @@ -218,9 +218,6 @@ void init_opp(struct shared_resource *resp)
>>>         u8 opp_id;
>>>         resp->no_of_users = 0;
>>>
>>> -       if (!mpu_opps || !dsp_opps || !l3_opps)
>>> -               return;
>>> -
>> the original intent of this check is lost here - if the initializations did not
>> take place, we will not proceed. An equivalent check might be good to maintain
>> at this point.
>
> You are partially correct. I took off the checks because we have a BUG_ON() call
> in the beginning of the boot code right after we initialize the OPP tables. So
> we should not hit this check.

Please do not code things based on the the existence of BUG_ON().

All of these BUG* points need to be removed as we none of these are fatal.  We need
better error recovery, most likely using WARN* and returning error codes.

Kevin

