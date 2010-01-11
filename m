From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not
	invalidate clean lines
Date: Mon, 11 Jan 2010 20:59:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0509417@dbde02.ent.ti.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
 <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
 <20100111152333.GB4109@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35853 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab0AKPaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 10:30:10 -0500
In-Reply-To: <20100111152333.GB4109@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, January 11, 2010 8:54 PM
> To: Shilimkar, Santosh
> Cc: Catalin Marinas; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> tony@atomide.com; Woodruff, Richard
> Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> 
> On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> > Thanks for cooments !!
> > > -----Original Message-----
> > > From: Catalin Marinas [mailto:catalin.marinas@arm.com]
> > > Sent: Monday, January 11, 2010 8:07 PM
> > > To: Shilimkar, Santosh
> > > Cc: linux@arm.linux.org.uk; linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> > > tony@atomide.com; Woodruff, Richard
> > > Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
> > >
> > > Does your secure monitor corrupt r4-r8? Maybe you could add a comment
> > > with a few words on this API.
> >
> > Yes they are corrupted. I will add some comments on the API.
> >
> > > Do you need to specify "r12" as well? What about "cc", are they
> > > preserved by the secure monitor?
> >
> > r12 and reset of the registers are preserved. Lr needs to be saved but
> > because of function call, the compiler saves/restores it.
> 
> That's not guaranteed; the compiler can re-use lr for its own purposes
> within a function.  You need to add lr to the list of clobbered registers.
Ok will add that.
> > I didn't get your this comment "What about "cc", are they preserved
> > by the secure monitor ?  Do you mean rest of the register. If yes then
> > the secure monitor don't tamper those registers.
> 
> No - Catalin means are the NZCV flags changed by the secure monitor, or
> are they preserved?  If they're preserved, you don't need a "cc" clobber.
> If they're not preserved, you do.
I will double check this but IIRC the flags are preserved.

Regards,
Santosh

