From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: FEATURES prints
Date: Thu, 12 Nov 2009 15:36:08 -0800
Message-ID: <87y6mbs4d3.fsf@deeprootsystems.com>
References: <4ACE39CC.1070906@ti.com> <87ws2zge60.fsf@deeprootsystems.com>
	<20091112210226.GD24837@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:49108 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbZKLXgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 18:36:05 -0500
Received: by mail-px0-f188.google.com with SMTP id 26so2017875pxi.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 15:36:10 -0800 (PST)
In-Reply-To: <20091112210226.GD24837@atomide.com> (Tony Lindgren's message of "Thu\, 12 Nov 2009 13\:02\:26 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [091013 15:01]:
>> Nishanth Menon <nm@ti.com> writes:
>> 
>> > Folks,
>> >
>> > With the addition of FEATURES in l-o, the following prints:
>> >  - l2cache : Y
>> >  - iva : Y
>> >  - sgx : Y
>> >  - neon : Y
>> >  - isp : Y
>> >
>> > comes up on SDP3430 -> now that we will introduce half a dozen
>> > features here and there, we will soon clutter this up. we should
>> > introduce a sysfs entry + remove the above noise..
>> >
>> 
>> Like Nishanth, I don't like the multi-line noise here.  The patch
>> below results in a single line output like this instead
>> 
>> OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp )
>> 
>> Not sure why we need to dump features that are not there, but if that
>> s considered important, maybe prefixing each feature with a '+' or '-'
>> would still allow this to be collapsed into a single line.
>> 
>> Even with this, I think adding the display of these features into an
>> OMAP-specific section of /proc/cpuinfo would be even better.
>> 
>> Comments?
>
> I like. Looks like this patch needs to be refreshed.
>

OK, will send refreshed version.

Kevin
