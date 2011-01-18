From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Tue, 18 Jan 2011 15:01:02 +0000
Message-ID: <20110118150102.GF10997@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <20110118143041.GA13576@shutemov.name> <20110118144014.GE10997@n2100.arm.linux.org.uk> <20110118144452.GB13576@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47165 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1ARPDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:03:18 -0500
Content-Disposition: inline
In-Reply-To: <20110118144452.GB13576@shutemov.name>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 04:44:52PM +0200, Kirill A. Shutemov wrote:
> On Tue, Jan 18, 2011 at 02:40:14PM +0000, Russell King - ARM Linux wr=
ote:
> > On Tue, Jan 18, 2011 at 04:30:41PM +0200, Kirill A. Shutemov wrote:
> > > On Mon, Jan 17, 2011 at 07:20:50PM +0000, Russell King - ARM Linu=
x wrote:
> > > > This patch series reworks the ARMv6/ARMv6K support options, cod=
e
> > > > selection, and bit operations such that it's possible to safely
> > > > build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SM=
P
> > > > in one image.
> > >=20
> > > Is it posible to implement CPU_ARCH_ARMv6K as well for runtime ch=
ecks?
> >=20
> > Err what?  There's no CPU_ARCH_ARMv6K.
>=20
> I some cases we need runtime check for K extention (see exceptions_in=
it())
> Is there any facility for it?

=46rom what I can tell there's no hard and fast way to say at runtime
"this CPU has K extensions" as it appears possible from the ARM ARM to
have a CPU which is ARMv6K (eg, the CPU in Dove) which does not support
SMP.  Whether that identifies itself as ARMv6 in the architecture field
of the main ID register, or uses the new CPUID scheme is not clear.
If it identifies itself as ARMv6, then there's no CPUID registers to
detect what it supports.

If it's the new CPUID scheme, while we can tell that a CPU has CLREX
support, that doesn't necessary mean that it has the access fault stuff=
=2E
That just means that a greater range of exclusive operations are
supported.

Also:

| An implementation that provides hardware management of the access fla=
g:
| =E2=80=A2 does not generate Access Flag faults when the access flag i=
s enabled
| ...

So, if we don't enable the access flag support, then we shouldn't see
them (we don't enable them.)

What's more:

| Memory Model Feature Register 2 (ID_MMFR2)
| HW access flag, bits [31:28]
| Indicates support for a Hardware access flag, as part of the VMSAv7 i=
mplementation.
| Permitted values are:
| 0b0000 Not supported.
| 0b0001 Support for VMSAv7 access flag, updated in hardware.

That doesn't suggest that it's valid to assume that this will be '1' on
ARMv6K - and istr there's some subtle differences between the various
CPUID registers for different architectures as well - to make the CPUID
scheme just that little more complicated to use, so these bits may not
even be defined that way for ARMv6K.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
