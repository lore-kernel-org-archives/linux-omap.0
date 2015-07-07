From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Tue, 7 Jul 2015 12:32:13 +0100
Message-ID: <20150707113213.GC7576@n2100.arm.linux.org.uk>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436214373-12969-6-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 06, 2015 at 10:26:13PM +0200, Pali Roh=E1r wrote:
> Legacy bootloaders can pass additional information for kernel or lega=
cy
> userspace applications. When booting DT kernel then ATAGs structure i=
s not
> more visible after running kernel uncompress code. This patch stores =
full
> ATAGs structure into DT "/chosen/linux,atags" entry, so kernel can la=
ter
> reuse it and export via /proc/atags to userspace.

I think you need to go through your commit messages and improve them,
especially the ones with "TODO" in them.  As long as there's still thin=
gs
to be done, they're obviously not ready for merging.

Moreover, exporting the ATAGS is questionable, even _if_ there are non-
kexec programs making use of this.  The ATAGs have _never_ been exporte=
d
to userspace when kexec disabled is the kernel - it was introduced for
kexec, and has always had this:

config ATAGS_PROC
        bool "Export atags in procfs"
        depends on ATAGS && KEXEC
        default y

Now, the fact that someone decided to start using it is pretty sad,
because it means that if you disable KEXEC, userspace breaks.  That's
not a kernel regression in any shape or form, because /proc/atags has
never been there without KEXEC enabled.  That's a userspace bug, plain
and simple.

Given that, I'm in two minds about whether to accept the last two
patches which make this more than just "for KEXEC use to enable a KEXEC
kernel to be booted."

Had it been provided without the KEXEC conditional, then I don't have
a problem with these two patches.

It also sets a precedent: by adding this into DT, it is creating a new
DT ABI as well, and we'll end up seeing dts files with an ATAG block
patched into them.

Are the ATAGs at a fixed address on the N900?  Can that be handled in
some kind of legacy file for the N900 which calls save_atags() on it, s=
o
we don't end up introducing yet more stuff that we have to maintain int=
o
the distant future?  If not, what about copying a known working atag
structure into a legacy file for the N900?

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
