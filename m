From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Thu, 5 Nov 2015 12:40:41 +0100
Message-ID: <20151105114041.GC27908@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com>
 <20151012201640.GQ23801@atomide.com>
 <201510122225.12786@pali>
 <20151012204509.GT23801@atomide.com>
 <20151013143746.GJ23104@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151013143746.GJ23104@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 October 2015 16:37:46 Pali Roh=C3=A1r wrote:
> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [151012 13:29]:
> > > On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> > > >=20
> > > > Pali, any news on posting an updated series with the comments
> > > > addressed in this thread? It seems that we all pretty much agre=
e
> > > > what needs to be done.
> > >=20
> > > Tony, I'm not really sure what to do. Just wrap 4 and 5 patches i=
nto=20
> > > CONFIG_KEXEC? Or something more?
> >=20
> > Well for most part your patches are fine, I think there were some
> > minor comments on the series.
> >=20
> > For the CONFIG_KEXEC dependency, we should just keep the existing
> > behavior and keep /proc/atags behind CONFIG_KEXEC. That's all
> > I believe :)
> >=20
> > Regards,
> >=20
> > Tony
> >=20
> >=20
>=20
> Ok. I will add CONFIG_KEXEC into atag patches.
>=20
> And there is missing documentation for these two new DT properties
> (marked as TODO in commit messages). Where to put them?
>=20

Tony (or somebody else) ^^^

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
