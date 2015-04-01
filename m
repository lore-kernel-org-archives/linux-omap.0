From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm: get rid of the bounce page"
Date: Wed, 01 Apr 2015 11:12:10 -0700
Message-ID: <7hmw2r67lx.fsf@deeprootsystems.com>
References: <20150324004537.GA24816@verge.net.au>
	<CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
	<20150324161358.GA694@kahuna> <20150326003939.GA25368@verge.net.au>
	<20150326133631.GB2805@arm.com>
	<CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
	<20150327002554.GA5527@verge.net.au> <20150327100612.GB1562@arm.com>
	<7hbnj99epe.fsf@deeprootsystems.com> <20150401085832.GA1552@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33834 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbbDASMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 14:12:14 -0400
Received: by pactp5 with SMTP id tp5so59085860pac.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Apr 2015 11:12:13 -0700 (PDT)
In-Reply-To: <20150401085832.GA1552@arm.com> (Will Deacon's message of "Wed, 1
	Apr 2015 09:58:32 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Simon Horman <horms@verge.net.au>, Tyler Baker <tyler.baker@linaro.org>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will,

Will Deacon <will.deacon@arm.com> writes:

[...]

>> >
>> > Thanks for testing this and sorry for the continued breakage. Which
>> > toolchain did you say you were using? Ard has some more patches trying to
>> > fix this, but none of our toolchains seem to tickle the issue.
>> 
>> I've also tested on the default ARM toolchains available with ubuntu[1]
>> 
>> Are there any updates on this issue?
>
> It's been fixed since the end of last week!
>
> (see ARM: kvm: round HYP section to page size instead of log2 upper bound)
>
> This was confirmed by both my testing and also Simon Horman, who reported
> the initial breakage.
>
>> It ha broken most of the ARM defconfigs in linux-next[2], and since it's
>> been broken for a week now, it is masking other types of issues that we
>> can normally find via automated boot testing.
>
> If you're referring to failures such as:
>
>   http://storage.kernelci.org/next/next-20150331/arm-axm55xx_defconfig/build.log

Yes, that's the one I'm trying to track down.

> Then that's not coming from the arm64 tree, and is a completely separate
> issue from the one originally reported in this thread.

Ugh, womehow I got wires crossed and thought they were related problems.
Looks like Geert now has a proposed fix for the issue I'm tracking.

Sorry for the noise,

Kevin




