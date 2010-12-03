From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Date: Fri, 3 Dec 2010 13:07:24 +0000
Message-ID: <20101203130724.GB30957@n2100.arm.linux.org.uk>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk> <20101202215837.GW17222@atomide.com> <20101202221612.GJ10461@n2100.arm.linux.org.uk> <20101202223208.GA17222@atomide.com> <20101203030954.GD3367@linux-sh.org> <20101203084102.GA30957@n2100.arm.linux.org.uk> <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41170 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605Ab0LCNHs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 08:07:48 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 03, 2010 at 02:10:23PM +0200, Felipe Contreras wrote:
> On Fri, Dec 3, 2010 at 10:41 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
> >> This has been fixed since -rc2.
> >
> > So it is. =A0However, the ioremap fix is wrong.
> >
> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0paddr =3D memblock_alloc(size, PAGE_=
SIZE);
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0memblock_free(paddr, size);
> > =A0 =A0 =A0 =A0memblock_remove(paddr, size);
> >
> > Didn't I say that such blocks were supposed to be aligned to a 2MB
> > boundary - and the size also so aligned?
>=20
> I asked you if there was something special and I didn't receive any r=
esponse:
> http://article.gmane.org/gmane.linux.kernel/1048434

So you thought you could ride rough-shod over my statement and ignore i=
t?
Thank you for treating me like shit, I'll remember that for future and
treat you in a similar manner.

> So, why SZ_2M?

=46irstly, that's the granularity which we allocate page tables - one
Linux page table covers 2MB of memory.  We want to avoid creating page
tables for the main memory mapping as that increases TLB pressure throu=
gh
the use of additional TLB entries, and more page table walks.

Plus, we never used to allow the kernel's direct memory mapping to be
mapped at anything less than section size - this restriction has since
been lifted due to OMAP SRAM problems, but I'd rather we stuck with it
to ensure that we have proper behaviour from all parts of the system.

Secondly, we don't want to end up with lots of fragmentation at the end
of the memory mapping as that'll reduce performance, not only by making
the pfn_valid() search more expensive.

Emsuring a minimum allocation size and alignment makes sure that the
regions can be coalesced together into one block, and minimises run-tim=
e
expenses.

So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
definitely not PAGE_SIZE.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
