From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updates: 3430sdp and omap3evm results
Date: Tue, 03 Feb 2009 21:42:00 -0800
Message-ID: <877i46ahcn.fsf@deeprootsystems.com>
References: <87fxj4ty1l.fsf@deeprootsystems.com>
	<3a2dabf50902010605n4f642d21p35d76f1eef8fa908@mail.gmail.com>
	<3a2dabf50902032134tf769d73m5fe7837e6d6c79a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:38588 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZBDFmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 00:42:08 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2395103rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 21:42:06 -0800 (PST)
In-Reply-To: <3a2dabf50902032134tf769d73m5fe7837e6d6c79a2@mail.gmail.com> (Ramesh Gupta Guntha's message of "Wed\, 4 Feb 2009 11\:04\:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta Guntha <grgupta77@gmail.com>
Cc: linux-omap@vger.kernel.org

Ramesh Gupta Guntha <grgupta77@gmail.com> writes:

> Hi,
>
>  I am able to resolve all other issues with this pm branch except one issue,
>
> I am not able to enable the iva2 clock once system is suspended and
> resumed, I am getting below messages.
>>
>> <3>clock: dpll2_ck failed transition to 'locked'
>> clock: dpll2_ck failed transition to 'locked'
>> <3>clock: dpll2_ck failed transition to 'locked'
>> clock: dpll2_ck failed transition to 'locked'
>
> Once after booting ( without adding bridgedriver/ installing bridgedriver)
> CM_CLKEN_PLL_IVA2 value shows as 0x37 indicates IVA2 DPLL in locked mode.
>
> once after system suspend the value is not restored I am seeing that as
>  0x11 indicates IVA2 DPLL is low power stop mode.
>
> Can any one please provide your inputs on the above error? I tried
> reconfiguring the CM_CLKEN_PLL_IVA2 to lock mode but still I am seeing
> the same messages as above while enabling iva2 clock.

Are you suspending into retention or off-mode?

Kevin

