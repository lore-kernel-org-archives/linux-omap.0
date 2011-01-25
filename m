From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
Date: Tue, 25 Jan 2011 17:46:36 +0000
Message-ID: <20110125174636.GE17286@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58873 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab1AYRqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 12:46:50 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 05:33:14PM +0000, Dave Martin wrote:
> On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
> >> A couple of questions on this:
> >>
> >> 1) I notice these spinlock functions are generally marked inline.
> >>
> >> Is that likely to happen in modules? =A0If so, there would be a ne=
ed to
> >> do SMP_ON_UP fixups at module load time -- I don't think that's
> >> currently implemented.
> >
> > No one should be using the arch_* spinlocks directly. =A0The spinlo=
cks
> > are implemented in out of line code in kernel/spinlock.c
>=20
> OK--- do think this is something we need a sanity-check for, or does
> this fall into to a category of bad driver implementation which will
> get thrown out during peer review?

Hmm, actually it looks like you can end up with configurations where th=
e
spinlocks are inlined.

That means we'll have to get rid of the link-time discarding of the
=2Eexit sections, and discard them along with the .init sections.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
