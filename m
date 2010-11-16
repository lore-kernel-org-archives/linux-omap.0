From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using Dual-mode Timers
Date: Tue, 16 Nov 2010 11:52:32 -0800
Message-ID: <87hbfhcagv.fsf@deeprootsystems.com>
References: <C9081DFE.1FEE7%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58458 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393Ab0KPTwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 14:52:37 -0500
Received: by ywg8 with SMTP id 8so630692ywg.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Nov 2010 11:52:36 -0800 (PST)
In-Reply-To: <C9081DFE.1FEE7%marathon96@gmail.com> (Grant Erickson's message
	of "Tue, 16 Nov 2010 11:39:42 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Grant Erickson <marathon96@gmail.com> writes:

[...]

>> Before something like this can merge, I would rather see
>> 
>> 1) generic PWM framework pushed along and merged
>> 2) the dmtimer hwmod conversion finished
>> 
>> Yes, I know it's a lot more work to fix the core/framework code before
>> having a feature included, but having something more generic that can
>> actually support multiple PWM sources is clearly needed.
>
> No disagreement on the long-term architectural and design goals. All good
> stuff.
>
> However, patches have to be submitted against the repository and branch we
> have today, not those we might have tomorrow.

This comment is where we diverge. 

An alternative to waiting for the generic framework cleanup/refactor
work is to contribute to it and help it along.

Kevin
