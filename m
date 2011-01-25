From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
 asm/spinlock.h
Date: Tue, 25 Jan 2011 16:21:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk> <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com> <20110125165919.GD17286@n2100.arm.linux.org.uk> <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
 <20110125174636.GE17286@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1734949911-1295990470=:8580"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37762 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab1AYVVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 16:21:12 -0500
Received: by vws16 with SMTP id 16so150117vws.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 13:21:11 -0800 (PST)
In-Reply-To: <20110125174636.GE17286@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1734949911-1295990470=:8580
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 25 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 25, 2011 at 05:33:14PM +0000, Dave Martin wrote:
> > On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
> > >> A couple of questions on this:
> > >>
> > >> 1) I notice these spinlock functions are generally marked inline.
> > >>
> > >> Is that likely to happen in modules?  If so, there would be a need to
> > >> do SMP_ON_UP fixups at module load time -- I don't think that's
> > >> currently implemented.
> > >
> > > No one should be using the arch_* spinlocks directly.  The spinlocks
> > > are implemented in out of line code in kernel/spinlock.c
> > 
> > OK--- do think this is something we need a sanity-check for, or does
> > this fall into to a category of bad driver implementation which will
> > get thrown out during peer review?
> 
> Hmm, actually it looks like you can end up with configurations where the
> spinlocks are inlined.
> 
> That means we'll have to get rid of the link-time discarding of the
> .exit sections, and discard them along with the .init sections.

... but only when CONFIG_SMP_ON_UP=y.


Nicolas
--8323328-1734949911-1295990470=:8580--
