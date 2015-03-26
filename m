From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm:
 get rid of the bounce page"
Date: Thu, 26 Mar 2015 09:39:39 +0900
Message-ID: <20150326003939.GA25368@verge.net.au>
References: <20150324004537.GA24816@verge.net.au>
 <CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
 <20150324161358.GA694@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150324161358.GA694@kahuna>
Sender: linux-sh-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, grygorii.strashko@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On Tue, Mar 24, 2015 at 11:13:58AM -0500, Nishanth Menon wrote:
> On 09:31-20150324, Ard Biesheuvel wrote:
> > On 24 March 2015 at 01:45, Simon Horman <horms@verge.net.au> wrote:
> > > Hi Ard,
> > >
> > > I have observe what appears to be a build regression in next-20150323
> > > caused by 06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page").
> > >
> > > # make
> > > ...
> > > arm-unknown-linux-gnueabi-ld:./arch/arm/kernel/vmlinux.lds:546: syntax error
> > >
> > > I have observed this using the cross-compiler that is available on kernel.org:
> > >
> > > https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/
> > >
> > > # arm-unknown-linux-gnueabi-gcc --version
> > > arm-unknown-linux-gnueabi-gcc (GCC) 4.6.3
> > > Copyright (C) 2011 Free Software Foundation, Inc.
> > > This is free software; see the source for copying conditions.  There is NO
> > > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > >
> > > # arm-unknown-linux-gnueabi-ld --version
> > > GNU ld (GNU Binutils) 2.22
> > > Copyright 2011 Free Software Foundation, Inc.
> > > This program is free software; you may redistribute it under the terms of
> > > the GNU General Public License version 3 or (at your option) a later version.
> > > This program has absolutely no warranty.
> > >
> > 
> > Hi all,
> > 
> > This is fixed now in next-20150324.
> > Sorry for the trouble
> 
> I think we now have a new error: (seen with omap2plus_defconfig)
> on next-20150324 :
> ./arch/arm/kernel/vmlinux.lds:677: undefined symbol `__hyp_idmap_size'
> referenced in expression
> make: *** [vmlinux] Error 1

Thanks, I am seeing that too.

My armchair suggestion is that the following should be reverted.

e60a1fec44a2f ("ARM: kvm: implement replacement for ld's LOG2CEIL()")
06f75a1f62000 ("ARM, arm64: kvm: get rid of the bounce page")

> cross compiler (from ubuntu 12.04):
> $ arm-linux-gnueabi-ld --version
> GNU ld (GNU Binutils for Ubuntu) 2.22
> Copyright 2011 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) a later version.
> This program has absolutely no warranty.
> $ arm-linux-gnueabi-gcc --version
> arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
> Copyright (C) 2011 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> next-20150320 was the last kernel which was successfully built

I have also confirmed that.
