From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Mon, 11 Jan 2010 15:23:33 +0000
Message-ID: <20100111152333.GB4109@n2100.arm.linux.org.uk>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com> <1263220628.6305.44.camel@pc1117.cambridge.arm.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38196 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab0AKPZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 10:25:14 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> Thanks for cooments !!
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> > Sent: Monday, January 11, 2010 8:07 PM
> > To: Shilimkar, Santosh
> > Cc: linux@arm.linux.org.uk; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> > tony@atomide.com; Woodruff, Richard
> > Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> >
> > Does your secure monitor corrupt r4-r8? Maybe you could add a comment
> > with a few words on this API.
>
> Yes they are corrupted. I will add some comments on the API.
>
> > Do you need to specify "r12" as well? What about "cc", are they
> > preserved by the secure monitor?
>
> r12 and reset of the registers are preserved. Lr needs to be saved but
> because of function call, the compiler saves/restores it.

That's not guaranteed; the compiler can re-use lr for its own purposes
within a function.  You need to add lr to the list of clobbered registers.

> I didn't get your this comment "What about "cc", are they preserved
> by the secure monitor ?  Do you mean rest of the register. If yes then
> the secure monitor don't tamper those registers.

No - Catalin means are the NZCV flags changed by the secure monitor, or
are they preserved?  If they're preserved, you don't need a "cc" clobber.
If they're not preserved, you do.
