From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Tue, 23 Oct 2012 09:09:31 -0700
Message-ID: <87k3uhb26c.fsf@deeprootsystems.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	<87zk3edvti.fsf@deeprootsystems.com>
	<CAM=Q2cvLc63tGMG1t1wguiMHqNxcrZ60GF+fHjxc6_8c7rBykw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32870 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab2JWQJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 12:09:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2857946pad.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 09:09:04 -0700 (PDT)
In-Reply-To: <CAM=Q2cvLc63tGMG1t1wguiMHqNxcrZ60GF+fHjxc6_8c7rBykw@mail.gmail.com>
	(Shubhrajyoti Datta's message of "Tue, 23 Oct 2012 21:13:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:

> On Tue, Oct 23, 2012 at 3:16 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> When waking up from off-mode, some IP blocks are reset automatically by
>>> hardware. For this reason, software must wait until the reset has
>>> completed before attempting to access the IP block.
>>>
>>> This patch fixes for example the bug introduced by commit
>>> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
>>> to SYSCONFIG register"), in which the MMC IP block is reset during
>>> off-mode entry, but the code expects the module to be already available
>>> during the execution of context restore.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Venkatraman S <svenkatr@ti.com>
>>
>> I can confirm that this patch the regression in my OMAP3 PM tests where
>> suspend test (to retention or off) failed if ran after the off-idle
>> test.
>>
>> Tested-by: Kevin Hilman <khilman@ti.com>
>>
>> on 3530/Overo, 3730/OveroSTORM, 3730/Beagle-xM
>
> on 3630/Beagle works.
> However on 3430 on idle path didnot work.
> let me know if i am missing some thing.

Could you please explain what worked and didn't work on each platforms?

Also, which 3430 did you test on?  If it's SDP, then it has a UART1
console, correct?

Kevin
