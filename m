From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
Date: Mon, 17 Jan 2011 12:27:22 +0000
Message-ID: <20110117122722.GA21542@n2100.arm.linux.org.uk>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk> <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com> <20110117103739.GA18626@n2100.arm.linux.org.uk> <20110117105332.GC18626@n2100.arm.linux.org.uk> <AANLkTikrgOLJ0bj_V23i-RM_wYa_4dDTXb_RaPY8Cr8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59451 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab1AQM1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:27:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikrgOLJ0bj_V23i-RM_wYa_4dDTXb_RaPY8Cr8v@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 17, 2011 at 12:12:55PM +0000, Catalin Marinas wrote:
> On 17 January 2011 10:53, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Jan 17, 2011 at 10:37:39AM +0000, Russell King - ARM Linux =
wrote:
> >> 3. Do we always need a dsb prior to a sev? =A0Maybe the SPEAR patc=
hes need
> >> another review to determine how they're using sev()?
> >
> > FYI, this is how the SPEAR patches use sev():
> >
> > | +static void __init wakeup_secondary(void)
> > | +{
> > | + =A0 =A0 /* nobody is to be released from the pen yet */
> > | + =A0 =A0 pen_release =3D -1;
> > | +
> > | + =A0 =A0 /*
> > | + =A0 =A0 =A0* Write the address of secondary startup into the sy=
stem-wide
> > | + =A0 =A0 =A0* location (presently it is in SRAM). The BootMonito=
r waits
> > | + =A0 =A0 =A0* for this register to become non-zero.
> > | + =A0 =A0 =A0* We must also send an sev to wake it up
> > | + =A0 =A0 =A0*/
> > | + =A0 =A0 __raw_writel(BSYM(virt_to_phys(spear13xx_secondary_star=
tup)),
> > | + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __io_address(SPEAR13XX_=
SYS_LOCATION));
> > | +
> > | + =A0 =A0 mb();
> > | +
> > | + =A0 =A0 /*
> > | + =A0 =A0 =A0* Send a 'sev' to wake the secondary core from WFE.
> > | + =A0 =A0 =A0*/
> > | + =A0 =A0 sev();
> > | +}
> >
> > so the dsb() is inside mb(), before the outer sync call.
>=20
> BTW, don't we need some cache flushing for the pen_release?

Which is why I referred to "updated patch" - that's something which
all implementations suffered from until recently.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
