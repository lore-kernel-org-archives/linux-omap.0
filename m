From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Sun, 22 Nov 2015 07:51:46 +0100
Message-ID: <20151122065146.GD26074@amd>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com>
 <20151012201640.GQ23801@atomide.com>
 <201510122225.12786@pali>
 <20151012204509.GT23801@atomide.com>
 <20151013143746.GJ23104@pali>
 <20151105114041.GC27908@pali>
 <20151105161756.GG3078@atomide.com>
 <5643E716.9080204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5643E716.9080204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed 2015-11-11 17:10:46, Frank Rowand wrote:
> Adding devicetree list.
>=20
> Thread starts at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/35445=
9.html
>=20
> On 11/5/2015 8:17 AM, Tony Lindgren wrote:
> > * Pali Roh=E1r <pali.rohar@gmail.com> [151105 03:41]:
> >> On Tuesday 13 October 2015 16:37:46 Pali Roh=E1r wrote:
> >>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
> >>>> * Pali Roh=E1r <pali.rohar@gmail.com> [151012 13:29]:
> >>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> >>>>>>
> >>>>>> Pali, any news on posting an updated series with the comments
> >>>>>> addressed in this thread? It seems that we all pretty much agr=
ee
> >>>>>> what needs to be done.
>=20
> I'm not real happy with the concept of patches 4 and 5 in this series=
=2E
> My concern is that those two patches are using the FDT as a transport
> mechanism for a binary blob (the atags object).

Umm. Ok. Do you have alternative proposal that works for everyone?

I mean. This discussion was going for quite a long time, and it would
be nice to have some solution... patch proposal... something.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
