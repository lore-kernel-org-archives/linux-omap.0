From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] PM: Fixed clockdomain state control for OMAP3
Date: Tue, 23 Sep 2008 16:16:27 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE3943089069D@vaebe110.NOE.Nokia.com>
References: <> <1221582816-21372-1-git-send-email-tero.kristo@nokia.com> <alpine.DEB.2.00.0809230654480.27938@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44909 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbYIWNRB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 09:17:01 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.0809230654480.27938@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

Hi Paul, reply below. 

>-----Original Message-----
>From: ext Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: 23 September, 2008 16:02
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] PM: Fixed clockdomain state control for OMAP3
>
>Hello Tero,
>
>a few comments.
>
>On Tue, 16 Sep 2008, Tero Kristo wrote:
>

<clip>
 
>> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_deny_idle);
>> -
>> +	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
>> +		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
>
>In general, shouldn't this happen for each clkdm in the pwrdm? 
> i.e., you should probably create some _clkdm_wakeup() (similar to
>_clkdm_allow_idle() ) and call that via pwrdm_for_each_clkdm().
>
>This may not have any functional effect at present with OMAP3, 
>but avoids the assumption that each powerdomain will have only 
>one software-controllable clockdomain (and that it will always 
>appear at the 0 element in the array).

The access of element 0 only is not because we have only 1 clockdomain
for each powerdomain, but because we only want to wake up some
clockdomain
to make the powerdomain come up. It does not matter which clockdomain is
awakened, as long as one is, and I don't think it makes sense to wake
all
of them up because this would cause additional overhead.

>
>> +		sleep_switch = 1;
>> +		pwrdm_wait_transition(pwrdm);
>> +	}
>> +
>>  	ret = pwrdm_set_next_pwrst(pwrdm, state);
>>  	if (ret) {
>>  		printk(KERN_ERR "Unable to set state of 
>powerdomain: %s\n", @@ 
>> -268,7 +257,10 @@ static int set_pwrdm_state(struct 
>powerdomain *pwrdm, u32 state)
>>  		goto err;
>>  	}
>>  
>> -	pwrdm_for_each_clkdm(pwrdm, _clkdm_allow_idle);
>> +	if (sleep_switch) {
>> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>
>Same comment as previous - shouldn't _clkdm_allow_idle() be 
>kept, and called for each clkdm in the pwrdm, instead?

Same comment.

-Tero
