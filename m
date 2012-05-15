From: "Buckley, Bryan" <bryan.buckley@ti.com>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM address space.
Date: Tue, 15 May 2012 13:55:44 -0500
Message-ID: <CAG_NtY_KH5s-dQx_CY5unn74WUUjbBKyghp-grM-NHFbTAOn-A@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
	<20120508124116.GE17798@arm.com>
	<CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
	<20120508215554.GA18980@n2100.arm.linux.org.uk>
	<CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
	<20120509122348.GA30632@n2100.arm.linux.org.uk>
	<CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
	<20120509154849.GA10375@n2100.arm.linux.org.uk>
	<CAG_NtY_qv-cv=Yd8CBcP4TrNCXJbTgz5WXvAsmCdQFWEotVhrg@mail.gmail.com>
	<20120509214040.GB10375@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:34151 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966209Ab2EOSzp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 14:55:45 -0400
Received: by vbbfs19 with SMTP id fs19so7141974vbb.15
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 11:55:44 -0700 (PDT)
In-Reply-To: <20120509214040.GB10375@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Wed, May 9, 2012 at 4:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Wed, May 09, 2012 at 03:44:08PM -0500, Buckley, Bryan wrote:
> > On Wed, May 9, 2012 at 10:48 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >
> > > On Wed, May 09, 2012 at 06:00:10PM +0530, Shilimkar, Santosh wrot=
e:
> > > > On Wed, May 9, 2012 at 5:53 PM, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > > On Wed, May 09, 2012 at 02:20:28PM +0530, Shilimkar, Santosh =
wrote:
> > > > >> The only change done common code is =A0clearing 'XN' bit for=
 DRAM
> > > > >> region in page table entries. The other change of setting th=
e DACR
> > > > >> register is done in ARMv7 specific code.
> > > > >
> > > > > Yes, XN is an ARMv6+ thing. =A0Before ARMv5, it was implement=
ation defined.
> > > > >
> > > > > Some implementations used the bit to mean "allow writes to up=
date the
> > > > > cache". =A0Other implementations labelled this bit as "should=
 be zero"
> > > > > while others labelled it as "should be one".
> > > > >
> > > > Good to know.
> > > >
> > > > > The upshot of this is, we know that having this bit as '1' me=
ans that
> > > > > all the CPUs we support today work. =A0I would be _very_ conc=
erned to
> > > > > change this bit to zero as we _really_ don't know how the pre=
-ARMv6
> > > > > CPUs would react.
> > > > >
> > > > I agree.
> > > >
> > > > > The solution to this is pretty simple - if ARMv6+ needs a dif=
ferent
> > > > > base section mapping value, then we need to extract that from=
 the code
> > > > > and pass in the base section mapping value.
> > > > >
> > > > > I'll sort out a patch later today for this.
> > > > Great.
> > >
> > > This works for my 4430SDP board. =A0I haven't booted it on anythi=
ng else yet.
> > > Please can you check that this solves the issue for you? =A0Thank=
s.
> > >
> >
> > Solves the issue for OMAP5. Thanks Russel and company.
>
> Can I add this attributation for this patch:
>
> Tested-by: Bryan Buckley <bryan.buckley@ti.com>
>
> ?

If still applicable, yes that is fine.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
