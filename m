From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
	address space.
Date: Wed, 9 May 2012 22:40:40 +0100
Message-ID: <20120509214040.GB10375@n2100.arm.linux.org.uk>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com> <20120508215554.GA18980@n2100.arm.linux.org.uk> <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com> <20120509122348.GA30632@n2100.arm.linux.org.uk> <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com> <20120509154849.GA10375@n2100.arm.linux.org.uk> <CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35020 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422Ab2EIVlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 17:41:04 -0400
Content-Disposition: inline
In-Reply-To: <CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Buckley, Bryan" <bryan.buckley@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 09, 2012 at 03:44:08PM -0500, Buckley, Bryan wrote:
> On Wed, May 9, 2012 at 10:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrote:
> > > On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > > On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh wr=
ote:
> > > >> The only change done common code is =A0clearing 'XN' bit for D=
RAM
> > > >> region in page table entries. The other change of setting the =
DACR
> > > >> register is done in ARMv7 specific code.
> > > >
> > > > Yes, XN is an ARMv6+ thing. =A0Before ARMv5, it was implementat=
ion defined.
> > > >
> > > > Some implementations used the bit to mean "allow writes to upda=
te the
> > > > cache". =A0Other implementations labelled this bit as "should b=
e zero"
> > > > while others labelled it as "should be one".
> > > >
> > > Good to know.
> > >
> > > > The upshot of this is, we know that having this bit as '1' mean=
s that
> > > > all the CPUs we support today work. =A0I would be _very_ concer=
ned to
> > > > change this bit to zero as we _really_ don't know how the pre-A=
RMv6
> > > > CPUs would react.
> > > >
> > > I agree.
> > >
> > > > The solution to this is pretty simple - if ARMv6+ needs a diffe=
rent
> > > > base section mapping value, then we need to extract that from t=
he code
> > > > and pass in the base section mapping value.
> > > >
> > > > I'll sort out a patch later today for this.
> > > Great.
> >
> > This works for my 4430SDP board. =A0I haven't booted it on anything=
 else yet.
> > Please can you check that this solves the issue for you? =A0Thanks.
> >
>=20
> Solves the issue for OMAP5. Thanks Russel and company.

Can I add this attributation for this patch:

Tested-by: Bryan Buckley <bryan.buckley@ti.com>

?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
