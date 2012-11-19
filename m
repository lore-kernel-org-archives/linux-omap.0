From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Mon, 19 Nov 2012 16:32:36 +0200
Message-ID: <20121119143236.GA3296@intel.com>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
 <201211151339.08016.arnd@arndb.de>
 <CAF6AEGuJReNtwUZX6HVZCE8GHuyEAyC8bM0GqZuVMV1=DrGJVw@mail.gmail.com>
 <201211151439.41393.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201211151439.41393.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Clark <rob.clark@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jamie Lokier <jamie@shareable.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 15, 2012 at 02:39:41PM +0000, Arnd Bergmann wrote:
> On Thursday 15 November 2012, Rob Clark wrote:
> > > I still haven't heard a conclusive argument why we need to use ge=
t_user()
> > > rather than copy_from_user() in the DRM code. Is this about a fas=
t path
> > > where you want to shave off a few cycles for each call, or does t=
his
> > > simplify the code structure, or something else?
> >=20
> > well, it is mostly because it seemed like a good idea to first try =
to
> > solve the root issue, rather than having to fix things up in each
> > driver when someone from x86-world introduces a 64b get_user()..
>=20
> As pointed out by hpa earlier, x86-32 doesn't have a 64b get_user
> either. I don't think we have a lot of drivers that are used only
> on 64-bit x86 and on 32-bit ARM but not on 32-bit x86.

Ouch. I didn't realize that x86-32 doesn't have it. All the systems
where I've run the new code are 64bit so I never noticed the problem.

I see there was a patch [1] posted a long time ago to implement 64bit
get_user() on x86-32. I wonder what happened to it?

[1] https://lkml.org/lkml/2004/4/20/96

--=20
Ville Syrj=E4l=E4
Intel OTC
