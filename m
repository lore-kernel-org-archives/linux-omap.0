From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Thu, 28 May 2015 09:01:13 -0700
Message-ID: <20150528160113.GH30984@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali>
 <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54377 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbbE1QBQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2015 12:01:16 -0400
Content-Disposition: inline
In-Reply-To: <20150528073740.GD16509@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthijs van Duin <matthijsvanduin@gmail.com>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150528 00:39]:
> On Wednesday 11 February 2015 14:40:33 Nishanth Menon wrote:
> > On Wed, Feb 11, 2015 at 2:28 PM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> > > On Wednesday 11 February 2015 16:22:51 Matthijs van Duin wrote:
> > >> On 11 February 2015 at 13:39, Pali Roh=C3=A1r <pali.rohar@gmail.=
com>
> > > wrote:
> > >> >> Anyhow, since checking the firewalls/APs to see if you have
> > >> >> permission will probably only get you yet another fault if
> > >> >> things are walled off, the robust way of dealing with this
> > >> >> sort of situation is by probing the device with a read
> > >> >> while trapping bus faults. This also handles modules that
> > >> >> are unreachable for other reasons, e.g. being disabled by
> > >> >> eFuse.
> > >> >
> > >> > It is possible to patch kernel code to mask or ignore that
> > >> > fault? Can you help me with something like that?
> > >>
> > >> As I mentioned, I'm still learning my way around the kernel,
> > >> so I don't feel very comfortable suggesting a concrete patch
> > >> just yet. I've been browsing arch/arm/mm/ however and my
> > >> impression is that all that would be required is editing
> > >> fault.c by making a copy of do_bad but containing
> > >>     return user_mode(regs) || !fixup_exception(regs);
> > >> and hook it onto the appropriate fault codes.  However, this
> > >> really needs the opinion of someone more familiar with this
> > >> code.
> > >>
> > >> I do have an observation to make on the issue of fault
> > >> decoding: the list in fsr-2level.c may be "standard ARMv3 and
> > >> ARMv4 aborts" but they are quite wrong for ARMv7 which has:
> > >>
> > >> [ 0] -
> > >> [ 1] alignment fault
> > >> [ 2] debug event
> > >> [ 3] section access flag fault
> > >> [ 4] instruction cache maintainance fault (reported via data
> > >> abort) [ 5] section translation fault
> > >> [ 6] page access flag fault
> > >> [ 7] page translation fault
> > >> [ 8] bus error on access
> > >> [ 9] section domain fault
> > >> [10] -
> > >> [11] page domain fault
> > >> [12] bus error on section table walk
> > >> [13] section permission fault
> > >> [14] bus error on page table walk
> > >> [15] page permission fault
> > >> [16] (TLB conflict abort)
> > >> [17] -
> > >> [18] -
> > >> [19] -
> > >> [20] (lockdown abort)
> > >> [21] -
> > >> [22] async bus error (reported via data abort)
> > >> [23] -
> > >> [24] async parity/ECC error (reported via data abort)
> > >> [25] parity/ECC error on access
> > >> [26] (coprocessor abort)
> > >> [27] -
> > >> [28] parity/ECC error on section table walk
> > >> [29] -
> > >> [30] parity/ECC error on page table walk
> > >> [31] -
> > >>
> > >> Some entries are patched up near the bottom of fault.c but
> > >> many bogus messages remain, for example the "on linefetch" vs
> > >> "on non-linefetch" is misleading since no such thing can be
> > >> inferred from the fault status on v7.  Also, the i-cache
> > >> maintenance fault handling looks wrong to me: it should fetch
> > >> the actual fault status from IFSR (even though the address
> > >> still comes from DFSR) and dispatch based on that.
> > >>
> > >> Async external aborts (async bus error and async parity/ECC
> > >> error) give you basically no info. DFAR will contain garbage
> > >> hence displaying it will confuse rather than enlighten, a
> > >> traceback is pointless since the instruction that caused the
> > >> access is long retired, likewise user_mode() doesn't matter
> > >> since a transition to kernel space may have happened after
> > >> the access that cause the abort. Basically they should be
> > >> treated more as an IRQ than as a fault (note they can also be
> > >> masked just like irqs). In case of a bus error, it may be
> > >> appropriate to just warn about it, or perhaps send a signal
> > >> to the current process, although in the latter case it should
> > >> have some means to distinguish it from a synchronous bus
> > >> error.
> > >>
> > >> At least on the cortex-a8, a parity/ECC error (whether async
> > >> or not) is to be regarded as absolutely fatal.  Quoth the
> > >> TRM: "No recovery is possible. The abort handler must disable
> > >> the caches, communicate the fail directly with the external
> > >> system, request a reboot."
> > >>
> > >> Bit 10 no longer indicates an asynchronous (let alone
> > >> imprecise) fault.  Apart from the debug events and async
> > >> aborts (and possibly some implementation-defined aborts), all
> > >> aborts listed are synchronous, and DFAR/IFAR is valid.
> > >> There's no technical obstruction to make these trappable via
> > >> the kernel exception handling mechanism. (Though at least in
> > >> case of parity/ECC errors one shouldn't.)
> > >
> > > Tony, Nishanth, or somebody else... can you help with memory
> > > management? Or do you know some expert for arch/arm/mm/ code?
> >=20
> > Folks in linux-arm-kernel are probably the right people, I suppose.
> > Looping them in.
> >=20
>=20
> So pinging linux-arm-kernel again. Any idea how to handle that fault?

Here's what might work.. You could patch drivers/bus/omap_l3*.c
code to probe the devices after the omap_l3 driver interrupts
are enabled.

=46or failed device access you get an interrupt so you know to not
create the struct device entry for that device. For the working
devices you can do the struct device entry and let it probe.

So basically we could make the omap_l3* drivers managers for
the omap bus code instead of probing them with "simple-bus"
and omap_device_build_from_dt().

No need to have these device probe early, and they are all
internal devices so as long as we know the type and address
for each soc the omap_l3 drive code could probe them.

It seems that trying to do this early just makes things more
complicated and should be done in the bootloader instead of
kernel if needed early.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
