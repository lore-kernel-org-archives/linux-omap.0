From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
	by uBoot)?
Date: Tue, 17 Jan 2012 20:48:10 +0000
Message-ID: <20120117204810.GJ16726@n2100.arm.linux.org.uk>
References: <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com> <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com> <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com> <20120117133918.GE11475@arm.com> <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com> <20120117162720.GG11475@arm.com> <20120117194724.GI16726@n2100.arm.linux.org.uk> <CAMQu2gyjGYooWih=cK72VYEe8X_bKyOi3_eHec7cWi37CHBoJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40353 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab2AQUsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jan 2012 15:48:31 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gyjGYooWih=cK72VYEe8X_bKyOi3_eHec7cWi37CHBoJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>

On Tue, Jan 17, 2012 at 09:11:37PM +0100, Shilimkar, Santosh wrote:
> On Tue, Jan 17, 2012 at 8:47 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jan 17, 2012 at 04:27:21PM +0000, Catalin Marinas wrote:
> >> Anyway, the first step is this API provided by the secure firmware=
=2E
> >> Since such API may need to be called before the MMU is initialised=
,
> >> Linux would need to have knowledge of the platform type early on. =
Having
> >> some platform hook (asm macro) to call early on wouldn't work with=
 the
> >> single zImage configuration. Stack space is not an issue as we alr=
eady
> >> have one for ARMv7 for D-cache flushing (XIP kernels would work bu=
t they
> >> aren't that many).
> >
> > It _is_ a problem. =A0How much stack space would these undefined pl=
atform
> > specific functions require? =A016 words? =A032 words? =A0A page? =A0=
Where does
> > this memory come from? =A0The .data section, or are we going to stu=
ff it
> > into what is supposed to be the read-only text section?
>=20
> Stack requirement is limited to saving and restoring the processor
> registers. There is no additional need. If this is an issue, we can
> also use SRAM as a stack for this operation.

How do you know that's all that would be required?

Let's look at another secure monitor API implementation in the kernel.
MSM has one - arch/arm/mach-msm/scm.c.  This requires parameters passed
through memory - a command buffer consisting of at least four words in
memory, followed by a response buffer of at least three words.

So where would this be placed if not on the stack?  Pick some random
address and hope that there's some memory there?

This is what I'm saying: while we may know what the requirement is for
OMAP, that's not what it is for other SoCs.  Every SoC has different
requirements for this, and so we have _no_ idea what so ever how much
stack space would actually be required.  And if we don't know that, we
have a real chance of having some implementation overflow the stack,
thereby overwriting something (eg, maybe your DT data, maybe your
initramfs image) which would be extremely detrimental.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
