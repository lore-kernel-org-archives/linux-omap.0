From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: n900: Include adp1653 device
Date: Wed, 27 Jan 2016 11:02:37 +0100
Message-ID: <20160127100237.GH25796@pali>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd>
 <20160121163857.GH19432@atomide.com>
 <20160121165408.GJ5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121165408.GJ5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 21 January 2016 16:54:08 Russell King - ARM Linux wrote:
> On Thu, Jan 21, 2016 at 08:38:57AM -0800, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [160121 02:19]:
> > > On Thu 2016-01-21 09:29:10, Russell King - ARM Linux wrote:
> > > > The merge window is open, which is when development code that w=
as merged
> > > > in good time prior to the merge window is sent upstream to Linu=
s.  Linux
> > > > maintainers may choose not to merge new code into their tree to=
 avoid
> > > > disrupting the utility of linux-next until the merge window has
> > > > closed.
> > >=20
> > > Support for new hardware is normally allowed after -rc1.
> >=20
> > Yeah most maintainers avoid looking at new code until -rc1. Or unti=
l
> > regresssions are out of the way. So patience please. Fixes are
> > welcome any time though.
>=20
> Indeed.  However, unlike Pavel's comment, many maintainers choose not
> to merge code for new hardware until the merge window - it's very rar=
e
> that support for new hardware is merged during the -rc phase.
>=20
> If it were otherwise, I would've been able to get the Hummingboard 2
> DTS patches in, or the etnaviv team would've been able to get the
> Etnaviv GPU DRM driver in during the 4.4-rc cycle, or the Dove PMU
> driver, or... etc.
>=20
> Practically, new code waits for merge windows, because no one wants
> to de-stabilise the progression of the -rc series with new code, and
> Linus wants to see -rc merges fairly quiet and be mostly bug fixes
> so he can feel good about a final release around -rc6 to -rc7 time.
>=20

In my opinion this patch is not support for new hardware. It just add
missing DT definition for one specific board for HW which was added to
linux kernel in v4.2-rc1 version. For me it looks like that needed DT
definition was forgotten...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
