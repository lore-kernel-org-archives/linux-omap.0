From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm:
 get rid of the bounce page"
Date: Fri, 27 Mar 2015 09:25:54 +0900
Message-ID: <20150327002554.GA5527@verge.net.au>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna>
 <20150326003939.GA25368@verge.net.au>
 <20150326133631.GB2805@arm.com>
 <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Tyler Baker <tyler.baker@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 26, 2015 at 08:29:21AM -0700, Tyler Baker wrote:
> On 26 March 2015 at 06:36, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Mar 26, 2015 at 12:39:39AM +0000, Simon Horman wrote:
> >> On Tue, Mar 24, 2015 at 11:13:58AM -0500, Nishanth Menon wrote:
> >> > I think we now have a new error: (seen with omap2plus_defconfig)
> >> > on next-20150324 :
> >> > ./arch/arm/kernel/vmlinux.lds:677: undefined symbol `__hyp_idmap_size'
> >> > referenced in expression
> >> > make: *** [vmlinux] Error 1
> >>
> >> Thanks, I am seeing that too.
> >>
> >> My armchair suggestion is that the following should be reverted.
> >>
> >> e60a1fec44a2f ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
> >> 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page")
> >
> > Can you try again with the latest -next please? We've merged an additional
> > patch aimed at sorting this out. Reverting isn't really an option, as
> > there's an awful lot of code that depends on the bounce page removal.
> 
> Here are the kernelci.org -next results[1], if you click the build
> status you can dig down into the build failures. next-20150326 has now
> hit a compiler bug, Arnd mentioned he was looking into this issue.

I have confirmed that next-20150326 does not compile without
the following reverted:

12eb3e833961 ("ARM: kvm: assert on HYP section boundaries not actual code size")
e60a1fec44a2 ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
06f75a1f6200 ("ARM, arm64: kvm: get rid of the bounce page")
