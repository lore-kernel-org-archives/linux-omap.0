From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 07:52:24 -0800
Message-ID: <87tyjey6h3.fsf@deeprootsystems.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53900 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab0KRPw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 10:52:27 -0500
Received: by pwj1 with SMTP id 1so469707pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 07:52:27 -0800 (PST)
In-Reply-To: <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com> (Nishanth
	Menon's message of "Thu, 18 Nov 2010 08:57:10 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

Nishanth Menon <nm@ti.com> writes:

>> From: Vishwanath BS <vishwanath.bs@ti.com>
>>
>> For historical reasons the OMAP3 sleep code is run from SRAM.
>> This code can run from DDR which provides better performance and
>> leaves the SRAM available for other uses.
>>
>> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
>> with full RET and OFF modes.
>
> Sorry, But I disagree with this patch.
>
> There is a silicon errata which cannot be handled with this - RTA disable
> - errata i608
>
> You need to disable RTA while coming out of OFF - we cannot handle
> this on GP devices if this is not done.

You need to  provide some more details here as to exactly why this patch
prevents the ability to do this workaround.

As Vishwa pointed out, when returning from OFF mode, current code
already starts in DDR since SRAM is lost.  The current code also already
can jump back into SRAM for certain errata/fixup (c.f. es3_sdrc_fix in
current code.)

Kevin
