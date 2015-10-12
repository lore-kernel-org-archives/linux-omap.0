From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry
Date: Mon, 12 Oct 2015 22:25:12 +0200
Message-ID: <201510122225.12786@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com> <20150713131902.GH26485@atomide.com> <20151012201640.GQ23801@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4563893.WveszxXGdR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012201640.GQ23801@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart4563893.WveszxXGdR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150713 06:21]:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150707 05:00]:
> > > On Tuesday 07 July 2015 12:32:13 Russell King - ARM Linux wrote:
> > > > On Mon, Jul 06, 2015 at 10:26:13PM +0200, Pali Roh=C3=A1r wrote:
> > > > > Legacy bootloaders can pass additional information for kernel
> > > > > or legacy userspace applications. When booting DT kernel
> > > > > then ATAGs structure is not more visible after running
> > > > > kernel uncompress code. This patch stores full ATAGs
> > > > > structure into DT "/chosen/linux,atags" entry, so kernel can
> > > > > later reuse it and export via /proc/atags to userspace.
> > > >=20
> > > > I think you need to go through your commit messages and improve
> > > > them, especially the ones with "TODO" in them.  As long as
> > > > there's still things to be done, they're obviously not ready
> > > > for merging.
> > >=20
> > > I know, in cover letter email I wrote that documentation is not
> > > ready... I send patches for review and comments (like yours). I
> > > think it is still better to send something and mark it as
> > > incomplete. It could prevent to work on something which will be
> > > again rewritten...
> > >=20
> > > > Moreover, exporting the ATAGS is questionable, even _if_ there
> > > > are non- kexec programs making use of this.  The ATAGs have
> > > > _never_ been exported to userspace when kexec disabled is the
> > > > kernel - it was introduced for kexec, and has always had this:
> > > >=20
> > > > config ATAGS_PROC
> > > >=20
> > > >         bool "Export atags in procfs"
> > > >         depends on ATAGS && KEXEC
> > > >         default y
> > > >=20
> > > > Now, the fact that someone decided to start using it is pretty
> > > > sad, because it means that if you disable KEXEC, userspace
> > > > breaks.  That's not a kernel regression in any shape or form,
> > > > because /proc/atags has never been there without KEXEC
> > > > enabled.  That's a userspace bug, plain and simple.
> > > >=20
> > > > Given that, I'm in two minds about whether to accept the last
> > > > two patches which make this more than just "for KEXEC use to
> > > > enable a KEXEC kernel to be booted."
> > > >=20
> > > > Had it been provided without the KEXEC conditional, then I
> > > > don't have a problem with these two patches.
> > >=20
> > > I understand it. Nokia originally invented their own entries in
> > > /proc/ which export needed ATAGs from kernel in human-readable
> > > form, but all those entries were non-standard and specific for
> > > Nokia's kernels.
> > >=20
> > > Do you have some other idea how to provide ATAGs information
> > > created dynamically by legacy closed proprietary bootloader to
> > > userspace from DT booted kernel?
> > >=20
> > > Anyway, for supporting kexec (with passing ATAGs) it is needed to
> > > have working /proc/atags file, right?
> >=20
> > Yeah I think that since we already have it in /proc, we should just
> > support it. And keep it behind CONFIG_KEXEC and
> > CONFIG_ARM_APPENDED_DTB and hope we don't find other users for
> > it.. Then reconsider the Kconfig dependencies if we do find other
> > users.
> >=20
> > > > It also sets a precedent: by adding this into DT, it is
> > > > creating a new DT ABI as well, and we'll end up seeing dts
> > > > files with an ATAG block patched into them.
> > > >=20
> > > > Are the ATAGs at a fixed address on the N900?
> > >=20
> > > Yes, in board-rx51.c is:
> > >=20
> > > .atag_offset	=3D 0x100
> > >=20
> > > and Nokia Bootloader (proprietary) store them to that address.
> > >=20
> > > > Can that be handled in
> > > > some kind of legacy file for the N900 which calls save_atags()
> > > > on it, so we don't end up introducing yet more stuff that we
> > > > have to maintain into the distant future?  If not, what about
> > > > copying a known working atag structure into a legacy file for
> > > > the N900?
> > >=20
> > > I already asked question if it is possible to read ATAGs from DT
> > > booted kernel. And somebody (do not remember who) wrote to ML,
> > > that it is not possible and it can be done in that uncompress
> > > code.
> >=20
> > I guess the other option would be to keep the raw ATAG area
> > reserved, and only initialize /proc/atags from a board specific
> > initcall. But I think that would complicate the already fragile
> > uncompress relocation code even further?
>=20
> Pali, any news on posting an updated series with the comments
> addressed in this thread? It seems that we all pretty much agree
> what needs to be done.
>=20
> Regards,
>=20
> Tony

Tony, I'm not really sure what to do. Just wrap 4 and 5 patches into=20
CONFIG_KEXEC? Or something more?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4563893.WveszxXGdR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlYcFygACgkQi/DJPQPkQ1IBIgCeI3HtFHXC8QH+eovWnQ47NotU
AmUAn0th4MSj4NTOa6dlE/VPmq4g+HLB
=rYVJ
-----END PGP SIGNATURE-----

--nextPart4563893.WveszxXGdR--
