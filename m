From: Will Deacon <will.deacon@arm.com>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm:
 get rid of the bounce page"
Date: Wed, 1 Apr 2015 09:58:32 +0100
Message-ID: <20150401085832.GA1552@arm.com>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna>
 <20150326003939.GA25368@verge.net.au>
 <20150326133631.GB2805@arm.com>
 <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
 <20150327002554.GA5527@verge.net.au>
 <20150327100612.GB1562@arm.com>
 <7hbnj99epe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37287 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbbDAI6k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Apr 2015 04:58:40 -0400
Content-Disposition: inline
In-Reply-To: <7hbnj99epe.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Simon Horman <horms@verge.net.au>, Tyler Baker <tyler.baker@linaro.org>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On Tue, Mar 31, 2015 at 07:58:21PM +0100, Kevin Hilman wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > On Fri, Mar 27, 2015 at 12:25:54AM +0000, Simon Horman wrote:
> >> On Thu, Mar 26, 2015 at 08:29:21AM -0700, Tyler Baker wrote:
> >> > On 26 March 2015 at 06:36, Will Deacon <will.deacon@arm.com> wrote:
> >> > > On Thu, Mar 26, 2015 at 12:39:39AM +0000, Simon Horman wrote:
> >> > >> On Tue, Mar 24, 2015 at 11:13:58AM -0500, Nishanth Menon wrote:
> >> > >> > I think we now have a new error: (seen with omap2plus_defconfig)
> >> > >> > on next-20150324 :
> >> > >> > ./arch/arm/kernel/vmlinux.lds:677: undefined symbol `__hyp_idmap_size'
> >> > >> > referenced in expression
> >> > >> > make: *** [vmlinux] Error 1
> >> > >>
> >> > >> Thanks, I am seeing that too.
> >> > >>
> >> > >> My armchair suggestion is that the following should be reverted.
> >> > >>
> >> > >> e60a1fec44a2f ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
> >> > >> 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page")
> >> > >
> >> > > Can you try again with the latest -next please? We've merged an additional
> >> > > patch aimed at sorting this out. Reverting isn't really an option, as
> >> > > there's an awful lot of code that depends on the bounce page removal.
> >> > 
> >> > Here are the kernelci.org -next results[1], if you click the build
> >> > status you can dig down into the build failures. next-20150326 has now
> >> > hit a compiler bug, Arnd mentioned he was looking into this issue.
> >> 
> >> I have confirmed that next-20150326 does not compile without
> >> the following reverted:
> >> 
> >> 12eb3e833961 ("ARM: kvm: assert on HYP section boundaries not actual code size")
> >> e60a1fec44a2 ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
> >> 06f75a1f6200 ("ARM, arm64: kvm: get rid of the bounce page")
> >
> > Thanks for testing this and sorry for the continued breakage. Which
> > toolchain did you say you were using? Ard has some more patches trying to
> > fix this, but none of our toolchains seem to tickle the issue.
> 
> I've also tested on the default ARM toolchains available with ubuntu[1]
> 
> Are there any updates on this issue?

It's been fixed since the end of last week!

(see ARM: kvm: round HYP section to page size instead of log2 upper bound)

This was confirmed by both my testing and also Simon Horman, who reported
the initial breakage.

> It ha broken most of the ARM defconfigs in linux-next[2], and since it's
> been broken for a week now, it is masking other types of issues that we
> can normally find via automated boot testing.

If you're referring to failures such as:

  http://storage.kernelci.org/next/next-20150331/arm-axm55xx_defconfig/build.log

Then that's not coming from the arm64 tree, and is a completely separate
issue from the one originally reported in this thread.

Will
