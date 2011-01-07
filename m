From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
Date: Fri, 07 Jan 2011 13:14:07 -0800
Message-ID: <87r5comn6o.fsf@ti.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
	<e194160102cb8b695465c81eea6582fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56623 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760Ab1AGVOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 16:14:14 -0500
Received: by yxm34 with SMTP id 34so9217167yxm.22
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 13:14:13 -0800 (PST)
In-Reply-To: <e194160102cb8b695465c81eea6582fc@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 7 Jan 2011 16:44:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...] 

>> I think it would be best to use WARN() on these, rather than
>> WARN_ONCE().  That's because these could be called from different
>> parts of the code base, and the stack backtrace will help someone
>> figure out all the code that needs to be fixed.
>>
>> Once you do that, this patch is
>>
>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>

> With WARN() instead of WARN_ONCE() and Paul's ack, here
> is an updated patch.

Thanks, will queue for .38-rc cycle.

I'll again plead for working on your git-send-email setup.  It looks
like your using outlook.  The inline patch is wrapped (as outlook almost
always does.)  The attached version applied fine, but the strong
preference is for a single inline patch.  

Thanks,

Kevin
