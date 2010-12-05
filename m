From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: implement support for read-mostly sections
Date: Sun, 5 Dec 2010 23:04:34 +0000
Message-ID: <20101205230434.GI9138@n2100.arm.linux.org.uk>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk> <E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk> <AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51207 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab0LEXEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 18:04:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin5HiPRd=SF_kdvEnZjV7C3J+6MXKQL02zKKtp=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, Dec 05, 2010 at 10:18:27PM +0000, Catalin Marinas wrote:
> On 5 December 2010 11:43, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinu=
x.lds.S
> > index cead889..1581f6d 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -167,6 +167,7 @@ SECTIONS
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NOSAVE_DATA
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CACHELINE_ALIGNED_DATA(32)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 READ_MOSTLY_DATA(32)
>=20
> Should we change the alignments to 64?

When we have some way to tell vmlinux.lds.S what the cache line size is=
=2E
It should be a separate patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
