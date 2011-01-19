From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Wed, 19 Jan 2011 11:10:57 -0800
Message-ID: <20110119191057.GC4957@atomide.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
 <20110114155806.GA22505@n2100.arm.linux.org.uk>
 <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
 <20110114173400.GB22505@n2100.arm.linux.org.uk>
 <AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
 <AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
 <AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
 <20110118234215.GB17398@n2100.arm.linux.org.uk>
 <20110118234443.GV4957@atomide.com>
 <AANLkTin=XwKC5LvXimCfkNatLcq=RYqb-32x5HLx0rOa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25039 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab1ASTLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 14:11:18 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin=XwKC5LvXimCfkNatLcq=RYqb-32x5HLx0rOa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

* Jean Pihet <jean.pihet@newoldbits.com> [110119 00:05]:
> On Wed, Jan 19, 2011 at 12:44 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 15:41]:
> >> On Tue, Jan 18, 2011 at 01:05:49PM +0100, Jean Pihet wrote:
> >> > Dave, Russell,
> >> >
> >> > On Mon, Jan 17, 2011 at 4:46 PM, Dave Martin <dave.martin@linaro=
=2Eorg> wrote:
> >> > > One way to work around this is would be to make omap_sram_push=
() a macro:
> >> > >
> >> > > #define omap_sram_push(funcp, size) \
> >> > > =C2=A0 =C2=A0(typeof(funcp))_do_omap_sram_push((void *)(funcp)=
, size)
> >> > >
> >> > > ... where the definition of _do_omap_sram_push() is the same i=
s the
> >> > > existing definition of omap_sram_push(). =C2=A0Providing
> >> > > _do_omap_sram_push() is not called directly, this should now b=
e
> >> > > type-safe.
> >> > >
> >> > Ok I reworked the patch from your suggestions. Indeed a few func=
tions
> >> > types mismatch have been spotted and corrected using the fncpy A=
PI.
> >> >
> >> > New patch sent as '[PATCH v2] OMAP: use fncpy to copy the PM cod=
e
> >> > functions to SRAM'.
> >>
> >> Looks good, thanks. =C2=A0Next problem to sort out is who's taking=
 the
> >> patches...
> >
> > You can take them but we should have at least Kevin test and ack th=
em.
> Sure, this needs some testing on OMAP1 & 2 platforms. It has only bee=
n
> compile tested on those (means: compile OK, functions types mismatche=
s
> fixed).
>=20
> Anyone with OMAP1 & 2 boards willing to test?

Can you please repost the whole set one more time or have them in
some git branch? That way I can pull them into linux-omap master
branch for testing to make sure omap1 and 2 boards don't break.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
