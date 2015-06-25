From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2] ARM: /proc/atags: Export also for DT
Date: Thu, 25 Jun 2015 11:02:45 +0100
Message-ID: <20150625100244.GA7576@n2100.arm.linux.org.uk>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431719407-18230-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 15, 2015 at 09:50:05PM +0200, Pali Roh=E1r wrote:
> This patch adds support for DT "/atags" and stores ATAG structure to =
DT.
>=20
> It depends on "ARM: /proc/cpuinfo: DT: Add support for Revision" patc=
hes.
>=20
> Pali Roh=E1r (2):
>   arm: devtree: Save atags if are in DT atags field
>   arm: boot: store ATAG structure into DT atag field
>=20
>  arch/arm/boot/compressed/atags_to_fdt.c |    6 +++++-
>  arch/arm/kernel/devtree.c               |    6 ++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

What these patches are missing is a description of _why_ this is requir=
ed
in any of the commit messages.  The commit messages seem to be describi=
ng
_what_ the change is doing, which is something that can be seen by read=
ing
the patches, but it leaves the question of why this change is necessary
entirely open.

Please update the commit messages on the next patch revision.

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
