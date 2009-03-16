From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Add new lower-latency C1 state take #2
Date: Mon, 16 Mar 2009 11:37:32 -0700
Message-ID: <877i2piaab.fsf@deeprootsystems.com>
References: <1236952954-5769-1-git-send-email-peter.de-schrijver@nokia.com>
	<1236961156-19262-1-git-send-email-peter.de-schrijver@nokia.com>
	<874oxxvzxu.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC281858@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:16967 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbZCPShh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 14:37:37 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2047967wfa.4
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2009 11:37:36 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC281858@dbde02.ent.ti.com> (Sanjeev Premi's message of "Sun\, 15 Mar 2009 22\:10\:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

[...]

>> > > +static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>> > > +				struct clockdomain *clkdm)
>> > > +{
>> > > +	omap2_clkdm_allow_idle(clkdm);
>> > > +}
>> > > +
>> > > +static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>> > > +				struct clockdomain *clkdm)
>> > > +{
>> > > +	omap2_clkdm_deny_idle(clkdm);
>> > > +}
>> > > +
>> 
>> These functions don't return any value. Even the functions
>> omap2_clkdm_allow_idle() and omap2_clkdm_deny_idle() are void.
>> 
>> So, the return type should be changed to void. Else complier 
>> would throw warnings like:
>> 
>> warning: no return statement in function returning non-void
>> 
>> ~sanjeev
>> 
>
> [sp] I commented on the patch without trying myself.
>      The return type "int" is necessary for calls to functions
>      pwrdm_for_each_clkdm().
>
>      So, real solution would be to return with a value.
>
> @@ -70,12 +70,14 @@ static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>                                 struct clockdomain *clkdm) {
>         omap2_clkdm_allow_idle(clkdm);
> +       return 0;
>  }
>
>  static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
>                                 struct clockdomain *clkdm)
>  {
>         omap2_clkdm_deny_idle(clkdm);
> +       return 0;
>  }
>

Thanks, I've merged this change into teh original patch and re-pushed
the PM branch.

Kevin
