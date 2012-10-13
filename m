From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: vfp: fix save and restore when running on
	pre-VFPv3 and CONFIG_VFPv3 set
Date: Sat, 13 Oct 2012 14:36:54 +0100
Message-ID: <20121013133654.GU28061@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1210130441300.5736@utopia.booyaka.com> <20121013090255.GT28061@n2100.arm.linux.org.uk> <yw1xr4p2myre.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51790 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab2JMNhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 09:37:16 -0400
Content-Disposition: inline
In-Reply-To: <yw1xr4p2myre.fsf@unicorn.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans.rullgard@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>

On Sat, Oct 13, 2012 at 11:50:45AM +0100, M=E5ns Rullg=E5rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>=20
> > On Sat, Oct 13, 2012 at 04:46:18AM +0000, Paul Walmsley wrote:
> >>=20
> >> After commit 846a136881b8f73c1f74250bf6acfaa309cab1f2 ("ARM: vfp: =
fix
> >> saving d16-d31 vfp registers on v6+ kernels"), the OMAP 2430SDP bo=
ard
> >> started crashing during boot with omap2plus_defconfig:
> >>=20
> >> [    3.875122] mmcblk0: mmc0:e624 SD04G 3.69 GiB
> >> [    3.915954]  mmcblk0: p1
> >> [    4.086639] Internal error: Oops - undefined instruction: 0 [#1=
] SMP ARM
> >> [    4.093719] Modules linked in:
> >> [    4.096954] CPU: 0    Not tainted  (3.6.0-02232-g759e00b #570)
> >> [    4.103149] PC is at vfp_reload_hw+0x1c/0x44
> >> [    4.107666] LR is at __und_usr_fault_32+0x0/0x8
> >>=20
> >> It turns out that the context save/restore fix unmasked a latent b=
ug in=20
> >> commit 5aaf254409f8d58229107b59507a8235b715a960 ("ARM: 6203/1: Mak=
e VFPv3=20
> >> usable on ARMv6").  When CONFIG_VFPv3 is set, but the kernel is bo=
oted on=20
> >> a pre-VFPv3 core, the code attempts to save and restore the d16-d3=
1 VFP=20
> >> registers.  These are only present on non-D16 VFPv3+, so the kerne=
l dies=20
> >> with an undefined instruction exception.  The kernel didn't crash =
before=20
> >> commit 846a136 because the save and restore code only touched d0-d=
15,=20
> >> present on all VFP.
> >>=20
> >> Fix to save and restore the d16-d31 registers only if they are
> >> present.
> >
> > No.  VFPv3D16 HWCAP means that the VFP supports just 16 double regi=
sters
> > - and it communicates this information to userspace.  If this bit i=
s clear,
> > and the VFP only has 16 double registers, then _that_ is a bug.
>=20
> That bit will be clear on VFPv2 (because it's not v3), and this has o=
nly
> 16 D registers.  The high D registers are present if (vfpv3 && !vfpv3=
d16).
> Pre-calculating this to avoid doing it in the context save/restore co=
de
> is probably a good idea.

No.  What we should do in that case is get away from this mixed logic.
The HWCAP fields should _always_ be telling us what we have, not what
we don't have.  So, this means we should have VFPv3 and VFPv4 bits,
but also VFPD16 to say "yes, we have d16-d31 registers too".

And, these bits should be set as follows:

	VFP architecture	flags
	VFPv2			VFP
	VFPv3d16		VFP|VFPv3|VFPv3D16
	VFPv3			VFP|VFPv3|VFPD16
	VFPv4			VFP|VFPv3|VFPv4|VFPD16

whereas, at the present time we have the silly situation where VFPv3D16
gives us two bits of information.  Note that the above combination sort=
s
this out for ever, and doesn't involve any userspace changes, and makes
this stuff much more sane - and ends up giving everyone exactly what th=
ey
need to make the appropriate decisions.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
