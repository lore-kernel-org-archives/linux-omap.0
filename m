From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
Date: Tue, 18 Jan 2011 15:44:43 -0800
Message-ID: <20110118234443.GV4957@atomide.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
 <20110114155806.GA22505@n2100.arm.linux.org.uk>
 <AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
 <20110114173400.GB22505@n2100.arm.linux.org.uk>
 <AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
 <AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
 <AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
 <20110118234215.GB17398@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36065 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1ARXpD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 18:45:03 -0500
Content-Disposition: inline
In-Reply-To: <20110118234215.GB17398@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 15:41]:
> On Tue, Jan 18, 2011 at 01:05:49PM +0100, Jean Pihet wrote:
> > Dave, Russell,
> >=20
> > On Mon, Jan 17, 2011 at 4:46 PM, Dave Martin <dave.martin@linaro.or=
g> wrote:
> > > One way to work around this is would be to make omap_sram_push() =
a macro:
> > >
> > > #define omap_sram_push(funcp, size) \
> > > =C2=A0 =C2=A0(typeof(funcp))_do_omap_sram_push((void *)(funcp), s=
ize)
> > >
> > > ... where the definition of _do_omap_sram_push() is the same is t=
he
> > > existing definition of omap_sram_push(). =C2=A0Providing
> > > _do_omap_sram_push() is not called directly, this should now be
> > > type-safe.
> > >
> > Ok I reworked the patch from your suggestions. Indeed a few functio=
ns
> > types mismatch have been spotted and corrected using the fncpy API.
> >=20
> > New patch sent as '[PATCH v2] OMAP: use fncpy to copy the PM code
> > functions to SRAM'.
>=20
> Looks good, thanks.  Next problem to sort out is who's taking the
> patches...

You can take them but we should have at least Kevin test and ack them.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
