From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups
Date: Thu, 10 Feb 2011 19:11:25 +0000
Message-ID: <20110210191125.GA12582@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1101251618230.8580@xanadu.home> <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com> <20110126124452.GB4232@n2100.arm.linux.org.uk> <20110126172535.GA15983@arm.com> <20110209142211.GA11460@n2100.arm.linux.org.uk> <20110210125624.GA3652@n2100.arm.linux.org.uk> <AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com> <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com> <20110210144617.GD3652@n2100.arm.linux.org.uk> <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54128 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1BJTLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 14:11:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 10, 2011 at 06:29:41PM +0000, Dave Martin wrote:
> On Thu, Feb 10, 2011 at 2:46 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Feb 10, 2011 at 02:13:13PM +0000, Dave Martin wrote:
> >> Note that this tree contains some extra patches (though I believe
> >> nothing is there which should cause the problem), and does not con=
tain
> >> everything from rmk/devel -- so it's possible this has been fixed =
in
> >> the meantime or no longer occurs for some other reason...
> >
> > No need - I now have some modules which contain SMP alternatives, s=
o we
> > do need to fix the module loader for this, and keep the SMP alterna=
tives
> > replacement code around. =A0It's not worth eliminating the code as =
if we
> > include an informative printk() to say why we're refusing to load t=
he
> > module, the string would be larger than the code it eliminates. =A0=
So, I
> > think we need to merge the patch below to avoid run-time problems.
>=20
> I thought the problem was not caused by removal of the fixup code, bu=
t
> rather by the removal of code referenced by fixups?

It is.  But:

arm-linux-objdump -h sound/core/snd-timer.ko

sound/core/snd-timer.ko:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00002f34  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .exit.text    00000070  00000000  00000000  00002f68  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 .init.text    000001b4  00000000  00000000  00002fd8  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .rodata       000000bc  00000000  00000000  0000318c  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  4 .rodata.str1.1 00000156  00000000  00000000  00003248  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .alt.smp.init 00000088  00000000  00000000  0000339e  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
=2E..

Here we have a module which contains the spin_unlock assembly, which
contains the SMP alternatives.  If we insert that into a kernel also
built with SMP alternatives support, but which is running on a UP
system, we need to run these fixups as well when the module is loaded.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
