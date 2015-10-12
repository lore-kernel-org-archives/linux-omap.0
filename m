From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Mon, 12 Oct 2015 13:16:40 -0700
Message-ID: <20151012201640.GQ23801@atomide.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
 <20150707113213.GC7576@n2100.arm.linux.org.uk>
 <20150707115819.GF12087@pali>
 <20150713131902.GH26485@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713131902.GH26485@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150713 06:21]:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150707 05:00]:
> > On Tuesday 07 July 2015 12:32:13 Russell King - ARM Linux wrote:
> > > On Mon, Jul 06, 2015 at 10:26:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > Legacy bootloaders can pass additional information for kernel o=
r legacy
> > > > userspace applications. When booting DT kernel then ATAGs struc=
ture is not
> > > > more visible after running kernel uncompress code. This patch s=
tores full
> > > > ATAGs structure into DT "/chosen/linux,atags" entry, so kernel =
can later
> > > > reuse it and export via /proc/atags to userspace.
> > >=20
> > > I think you need to go through your commit messages and improve t=
hem,
> > > especially the ones with "TODO" in them.  As long as there's stil=
l things
> > > to be done, they're obviously not ready for merging.
> > >=20
> >=20
> > I know, in cover letter email I wrote that documentation is not rea=
dy...
> > I send patches for review and comments (like yours). I think it is =
still
> > better to send something and mark it as incomplete. It could preven=
t to
> > work on something which will be again rewritten...
> >=20
> > > Moreover, exporting the ATAGS is questionable, even _if_ there ar=
e non-
> > > kexec programs making use of this.  The ATAGs have _never_ been e=
xported
> > > to userspace when kexec disabled is the kernel - it was introduce=
d for
> > > kexec, and has always had this:
> > >=20
> > > config ATAGS_PROC
> > >         bool "Export atags in procfs"
> > >         depends on ATAGS && KEXEC
> > >         default y
> > >=20
> > > Now, the fact that someone decided to start using it is pretty sa=
d,
> > > because it means that if you disable KEXEC, userspace breaks.  Th=
at's
> > > not a kernel regression in any shape or form, because /proc/atags=
 has
> > > never been there without KEXEC enabled.  That's a userspace bug, =
plain
> > > and simple.
> > >=20
> > > Given that, I'm in two minds about whether to accept the last two
> > > patches which make this more than just "for KEXEC use to enable a=
 KEXEC
> > > kernel to be booted."
> > >=20
> > > Had it been provided without the KEXEC conditional, then I don't =
have
> > > a problem with these two patches.
> > >=20
> >=20
> > I understand it. Nokia originally invented their own entries in /pr=
oc/
> > which export needed ATAGs from kernel in human-readable form, but a=
ll
> > those entries were non-standard and specific for Nokia's kernels.
> >=20
> > Do you have some other idea how to provide ATAGs information create=
d
> > dynamically by legacy closed proprietary bootloader to userspace fr=
om DT
> > booted kernel?
> >=20
> > Anyway, for supporting kexec (with passing ATAGs) it is needed to h=
ave
> > working /proc/atags file, right?
>=20
> Yeah I think that since we already have it in /proc, we should just
> support it. And keep it behind CONFIG_KEXEC and CONFIG_ARM_APPENDED_D=
TB
> and hope we don't find other users for it.. Then reconsider the Kconf=
ig
> dependencies if we do find other users.
> =20
> > > It also sets a precedent: by adding this into DT, it is creating =
a new
> > > DT ABI as well, and we'll end up seeing dts files with an ATAG bl=
ock
> > > patched into them.
> > >=20
> > > Are the ATAGs at a fixed address on the N900?
> >=20
> > Yes, in board-rx51.c is:
> >=20
> > .atag_offset	=3D 0x100
> >=20
> > and Nokia Bootloader (proprietary) store them to that address.
> >
> > > Can that be handled in
> > > some kind of legacy file for the N900 which calls save_atags() on=
 it, so
> > > we don't end up introducing yet more stuff that we have to mainta=
in into
> > > the distant future?  If not, what about copying a known working a=
tag
> > > structure into a legacy file for the N900?
> >
> > I already asked question if it is possible to read ATAGs from DT bo=
oted
> > kernel. And somebody (do not remember who) wrote to ML, that it is =
not
> > possible and it can be done in that uncompress code.
>=20
> I guess the other option would be to keep the raw ATAG area reserved,
> and only initialize /proc/atags from a board specific initcall.
> But I think that would complicate the already fragile uncompress
> relocation code even further?

Pali, any news on posting an updated series with the comments addressed
in this thread? It seems that we all pretty much agree what needs to
be done.

Regards,

Tony
