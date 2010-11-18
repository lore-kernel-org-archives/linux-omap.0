From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 10:55:36 -0600
Message-ID: <4CE55A88.6010300@ti.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>	<1290091906-32539-2-git-send-email-j-pihet@ti.com>	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com> <87tyjey6h3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42267 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755015Ab0KRQzo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 11:55:44 -0500
Received: by gyg8 with SMTP id 8so1998196gyg.39
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 08:55:39 -0800 (PST)
In-Reply-To: <87tyjey6h3.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Jean Pihet-XID <j-pihet@ti.com>

Kevin Hilman had written, on 11/18/2010 09:52 AM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>>> From: Vishwanath BS <vishwanath.bs@ti.com>
>>>
>>> For historical reasons the OMAP3 sleep code is run from SRAM.
>>> This code can run from DDR which provides better performance and
>>> leaves the SRAM available for other uses.
>>>
>>> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
>>> with full RET and OFF modes.
>> Sorry, But I disagree with this patch.
>>
>> There is a silicon errata which cannot be handled with this - RTA disable
>> - errata i608
>>
>> You need to disable RTA while coming out of OFF - we cannot handle
>> this on GP devices if this is not done.
> 
> You need to  provide some more details here as to exactly why this patch
> prevents the ability to do this workaround.
> 
> As Vishwa pointed out, when returning from OFF mode, current code
> already starts in DDR since SRAM is lost.  The current code also already
> can jump back into SRAM for certain errata/fixup (c.f. es3_sdrc_fix in
> current code.)
scratchpad_contents.public_restore_ptr -> this is the restore pointer 
that is invoked when we get out of OFF mode.
	-> on 3430 and 3630, I agree it in SDRAM, for es3_sdrc_fix, it 
relocates the required code to sram as it cannot be run in ddr. - so I 
believe no issues there.

But after wfi in wait_sdrc_ok as part of the code executing in SRAM 
today omap34xx_cpu_suspend -> we are waiting for DPLL3 lock prior to 
accessing DDR -> how do we execute that logic in SDRAM?


-- 
Regards,
Nishanth Menon
