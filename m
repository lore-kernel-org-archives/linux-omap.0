From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Wed, 25 Nov 2009 18:37:52 +0300
Message-ID: <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <873a43wzfm.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:45805 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758074AbZKYPhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 10:37:48 -0500
Received: by ewy19 with SMTP id 19so508908ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 07:37:53 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Nov 24, 2009 at 11:21 PM, Premi, Sanjeev <premi@ti.com> wrote:
> From: Kevin Hilman [khilman@deeprootsystems.com]
> Sent: Tuesday, November 24, 2009 11:57 PM
> To: Sergey Lapin; Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP3: enabling CPU idle leads to panic
>
> Sergey Lapin <slapinid@gmail.com> writes:
>
>> I use PM branch merged with linux-omap branch.
>
> Not sure what this means.  PM branch is already based at linux-omap
> master branch.  You'll need to be more specific, ideally with commit
> IDs.

I do git branch tmp origin/master
git checkout -f tmp
git merge origin/pm
git merge origin/mybranch

git log origin/pm^..origin/pm
commit 596f2d2c8153fe24de5c3b6ad78658ce9fff7f28
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Jun 17 14:42:22 2009 -0700

    OMAP3: PM: default defconfig for PM kernel testing

    Supports 3430SDP, OMAP3EVM and 3630SDP by default.

    Also supports, Beagle, Overo, Zoom[23] and RX51 simply by changing

     System Type-->TI OMAP implementations-->Low-level debug console UART

    from UART1 to UART3.

    Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>


>
> [sp] I will also need the last commit from pm branch - if not the id; the
> commit header to start.
See above

>
> [snip]--[snip]
>
>>
>> addr2line -e vmlinux c003b5c0
>> /home/slapin/linux-omap-my-2.6.git/arch/arm/mach-omap2/powerdomain.c:452
>> It is in function
>> int pwrdm_for_each_clkdm(), where pwrdm is NULL.
>> farther investigations found that "core_pwrdm" is defined only for 24xx,
>> but I use 3525, and it is being searched.
>
> [sp] I am a little confused here. core_pwrdm is defined for 34xx as well.
> Other than sgx, there isn't any difference between 3530 and 3525.
Yes, I see that in source, but that function returns NULL for unknown reason.
How could I debug it farther?


> See the definition at:
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/powerdomains34xx.h;hb=867d320b6c30d2478358eafeca0e1a6c60cf06c3#l203
>
Yes, there is.

>>
>> This is where variable allocated. If I add BUG_ON(!core_pd), it crashes here.
>> arch/arm/mach-omap2/cpuidle34xx.c:348:        core_pd = pwrdm_lookup("core_pwrdm");
>> Otherwise it crashes the above way. Any ideas on how to fix this?
>
> [sp] Have you hand-picked the commits from pm branch and applied against
>  master?
See above. I use git merge on fresh branch based on linux-omap master.

Thanks a lot,
S.
