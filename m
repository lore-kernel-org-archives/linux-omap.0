From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Tue, 23 Oct 2012 21:13:56 +0530
Message-ID: <CAM=Q2cvLc63tGMG1t1wguiMHqNxcrZ60GF+fHjxc6_8c7rBykw@mail.gmail.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
	<87zk3edvti.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37355 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938Ab2JWPn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 11:43:56 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5477330iea.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 08:43:56 -0700 (PDT)
In-Reply-To: <87zk3edvti.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

On Tue, Oct 23, 2012 at 3:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> When waking up from off-mode, some IP blocks are reset automatically by
>> hardware. For this reason, software must wait until the reset has
>> completed before attempting to access the IP block.
>>
>> This patch fixes for example the bug introduced by commit
>> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
>> to SYSCONFIG register"), in which the MMC IP block is reset during
>> off-mode entry, but the code expects the module to be already available
>> during the execution of context restore.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Venkatraman S <svenkatr@ti.com>
>
> I can confirm that this patch the regression in my OMAP3 PM tests where
> suspend test (to retention or off) failed if ran after the off-idle
> test.
>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> on 3530/Overo, 3730/OveroSTORM, 3730/Beagle-xM

on 3630/Beagle works.
However on 3430 on idle path didnot work.
let me know if i am missing some thing.

>
> Thanks Tero for the fix,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
