From: Tyler Baker <tyler.baker@linaro.org>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm: get
 rid of the bounce page"
Date: Thu, 26 Mar 2015 08:29:21 -0700
Message-ID: <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
References: <20150324004537.GA24816@verge.net.au>
	<CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
	<20150324161358.GA694@kahuna>
	<20150326003939.GA25368@verge.net.au>
	<20150326133631.GB2805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36107 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbCZP3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2015 11:29:22 -0400
Received: by wibg7 with SMTP id g7so152890764wib.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2015 08:29:21 -0700 (PDT)
In-Reply-To: <20150326133631.GB2805@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Simon Horman <horms@verge.net.au>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 26 March 2015 at 06:36, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 26, 2015 at 12:39:39AM +0000, Simon Horman wrote:
>> On Tue, Mar 24, 2015 at 11:13:58AM -0500, Nishanth Menon wrote:
>> > I think we now have a new error: (seen with omap2plus_defconfig)
>> > on next-20150324 :
>> > ./arch/arm/kernel/vmlinux.lds:677: undefined symbol `__hyp_idmap_size'
>> > referenced in expression
>> > make: *** [vmlinux] Error 1
>>
>> Thanks, I am seeing that too.
>>
>> My armchair suggestion is that the following should be reverted.
>>
>> e60a1fec44a2f ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
>> 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page")
>
> Can you try again with the latest -next please? We've merged an additional
> patch aimed at sorting this out. Reverting isn't really an option, as
> there's an awful lot of code that depends on the bounce page removal.

Here are the kernelci.org -next results[1], if you click the build
status you can dig down into the build failures. next-20150326 has now
hit a compiler bug, Arnd mentioned he was looking into this issue.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



[1] http://kernelci.org/job/next/

Tyler
