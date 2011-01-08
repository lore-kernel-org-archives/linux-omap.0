From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] omap3: Enable SmartReflex calculations for 720MHz
Date: Sat, 08 Jan 2011 08:55:49 -0600
Message-ID: <4D287AF5.3070300@ti.com>
References: <1294421217-18730-1-git-send-email-premi@ti.com> <4D276F99.1080007@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024829AF66@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:32935 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161Ab1AHO4F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jan 2011 09:56:05 -0500
Received: by gwj23 with SMTP id 23so8897890gwj.4
        for <linux-omap@vger.kernel.org>; Sat, 08 Jan 2011 06:56:03 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024829AF66@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev wrote, on 01/08/2011 06:29 AM:
[..]
>>>    [1] SPRUFF1D-June 2009 section 1.5.2.1.1
>> Where is this doc?
[..]
> [sp] Thanks for pointing out. It is not accessible for some reasons.
>       It can be...  and is being looked into as i write this message.
>
thanks.
> [snip]...[snip]
>
>>> +#define SWCALC_OPP6_DELTA_NNT	379
>>> +#define SWCALC_OPP6_DELTA_PNT	227
>>> +#define GAIN_MAXLIMIT		16
>>
>> Magic numbers - do they scale from 3430 to 3630?
>
> [sp] The patch is meant for 720MHz - which is applicable for 3430 only.
>       So, these values are meant for 3430.
Right - and since sr_device is common for omap3, omap4 etc.. does'nt it 
make sense to isolate code properly out?

>
> [snip]...[snip]
>
>>
>>> +
>>> +static u32 swcalc_opp6_nvalue(u32 opp5_nvalue)
>> so what does this actually do?
>
> [sp] Returns a nvalue which corresponds to opp6 based on input which
>       is nvalue of opp5. Elementary?
yes Sherlock :). I apologize that I was'nt clear. But I was wondering 
about the following:
what does the algo actually do - does it add a specific voltage delta or 
some %v to previous nTarget?

It takes an input and does some magic - what does that magic algo do to 
produce output?

it is possible that it is self evident to you, but it is not to me - 
probably because I dont have the mentioned doc to refer to.

what is the overall objective of this code?
we have start nTarget from OPP5 and we are trying to put in a new one 
for OPP6 out of the previous one.

things that pop in my mind are:
a) if this was the case, I just need OPP1 value, I could generate values 
for all other OPPs.
b) if the algo itself was generic enough, we could use it in OMAP3430, 
3630, OMAP4 etc.. - as far as I have confirmed from h/w team in the last 
couple of years multiple times, ntarget generation algo for OMAP34,36,4x 
series is not algo based, but production floor operation based (making 
it unique and not really an algo based mechanism of nTarget programming).

>
>>> +{
>
> [snip]...[snip]
>
>>> +       opp6_nvalue = (opp6_senPgain<<  0x14) |
>> (opp6_senNgain<  0x10) |
>>> +                       (opp6_senPRN<<  0x8) | opp6_senNRN;
>>> +
>>> +       return opp6_nvalue;
>
> [sp] Elementary, if you preferred to read the code. Rather that glossing
>       over in hurry to respond compulsively.
I had hoped you could help my time a little (I do other things other 
than review as well ;)) by documenting the algo in the function header?

>
>>> +}
>
> [snip]...[snip]
>
>> Sorry, Dumb question:
>> a) You are using OPP5's nTarget to use in OPP6's nTarget?
>> is'nt it fused
>> in for OPP6 offset?
>
> [sp] Again, in hurry to respond, you missed the description for the patch
>       [quote]
>       The eFuse registers do not contain the nValue to be used
>       with 720MHz (OPP6). This patch implements procedure to
>       calculate the nValue(OPP6) based on the nValue(OPP5).
>       [/quote]

Right - how does it calculate the value for OPP6 from OPP5?

>
>> b) you are using OMAP343X_CONTROL_FUSE_OPP5_VDD1 itself
>
> [sp] Quoting the description:
>       [quote]
>       The eFuse registers do not contain the nValue to be used
>       with 720MHz (OPP6). This patch implements procedure to
>       calculate the nValue(OPP6) based on the nValue(OPP5).
>       [/quote]
>
>       Repeating again, just in case you missed: nvalues for OPP6 are
>       calculated based on the nvalues for OPP5. So, i need to use
>       OMAP343X_CONTROL_FUSE_OPP5_VDD1.
why not define CONTROL_FUSE_OPP6_VDD1 with the same offset?

>
>> c) these should be __init functions.
>
> [sp] They will be when i post formal patch.
>
>> d) how would you allow this code to work with 3440?
>
> [sp] Does 3440 have same behavior? If so, it is quite easy by
>       updating this check.
>       [quote]
>       +	if (cpu_is_omap34xx()&&  omap3_has_720mhz()) {
>       +		nvalue_table[count-1].nvalue = swcalc_opp6_nvalue(
>       +					nvalue_table[count-2].nvalue);
>       +	}
>       [/quote]
>
>       However, i am not conversant with 3440. This will have to be
>       covered by a separate patch.
Right - could you help start a TI internal conversation and alignment to 
ensure 3440 is not broken by this change?

>
>> e) next time could you please try STOP using CaMELCASInG in your
>> variables and functions?
>
> [sp] Did you ever notice any camelcase in any of my formal patch
>       submissions earlier. 10 brownie points for catching it here!
why do you waste reviewer time by posting CamelCasing anyways? your 
responses make me wonder why did I even care to spend time to review 
your code? could have waited for your formal patch and NAKed it :). ok.. 
no more discussions from me anymore untill your formal patch arrives

-- 
Regards,
Nishanth Menon
