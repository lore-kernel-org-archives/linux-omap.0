From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Tue, 7 Jul 2015 13:58:19 +0200
Message-ID: <20150707115819.GF12087@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
 <20150707113213.GC7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707113213.GC7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 07 July 2015 12:32:13 Russell King - ARM Linux wrote:
> On Mon, Jul 06, 2015 at 10:26:13PM +0200, Pali Roh=C3=A1r wrote:
> > Legacy bootloaders can pass additional information for kernel or le=
gacy
> > userspace applications. When booting DT kernel then ATAGs structure=
 is not
> > more visible after running kernel uncompress code. This patch store=
s full
> > ATAGs structure into DT "/chosen/linux,atags" entry, so kernel can =
later
> > reuse it and export via /proc/atags to userspace.
>=20
> I think you need to go through your commit messages and improve them,
> especially the ones with "TODO" in them.  As long as there's still th=
ings
> to be done, they're obviously not ready for merging.
>=20

I know, in cover letter email I wrote that documentation is not ready..=
=2E
I send patches for review and comments (like yours). I think it is stil=
l
better to send something and mark it as incomplete. It could prevent to
work on something which will be again rewritten...

> Moreover, exporting the ATAGS is questionable, even _if_ there are no=
n-
> kexec programs making use of this.  The ATAGs have _never_ been expor=
ted
> to userspace when kexec disabled is the kernel - it was introduced fo=
r
> kexec, and has always had this:
>=20
> config ATAGS_PROC
>         bool "Export atags in procfs"
>         depends on ATAGS && KEXEC
>         default y
>=20
> Now, the fact that someone decided to start using it is pretty sad,
> because it means that if you disable KEXEC, userspace breaks.  That's
> not a kernel regression in any shape or form, because /proc/atags has
> never been there without KEXEC enabled.  That's a userspace bug, plai=
n
> and simple.
>=20
> Given that, I'm in two minds about whether to accept the last two
> patches which make this more than just "for KEXEC use to enable a KEX=
EC
> kernel to be booted."
>=20
> Had it been provided without the KEXEC conditional, then I don't have
> a problem with these two patches.
>=20

I understand it. Nokia originally invented their own entries in /proc/
which export needed ATAGs from kernel in human-readable form, but all
those entries were non-standard and specific for Nokia's kernels.

Do you have some other idea how to provide ATAGs information created
dynamically by legacy closed proprietary bootloader to userspace from D=
T
booted kernel?

Anyway, for supporting kexec (with passing ATAGs) it is needed to have
working /proc/atags file, right?

> It also sets a precedent: by adding this into DT, it is creating a ne=
w
> DT ABI as well, and we'll end up seeing dts files with an ATAG block
> patched into them.
>=20
> Are the ATAGs at a fixed address on the N900?

Yes, in board-rx51.c is:

=2Eatag_offset	=3D 0x100

and Nokia Bootloader (proprietary) store them to that address.

> Can that be handled in
> some kind of legacy file for the N900 which calls save_atags() on it,=
 so
> we don't end up introducing yet more stuff that we have to maintain i=
nto
> the distant future?  If not, what about copying a known working atag
> structure into a legacy file for the N900?
>=20

I already asked question if it is possible to read ATAGs from DT booted
kernel. And somebody (do not remember who) wrote to ML, that it is not
possible and it can be done in that uncompress code.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
