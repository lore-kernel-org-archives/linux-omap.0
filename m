From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFCv3 0/7] OMAP SSI driver
Date: Thu, 10 Oct 2013 10:32:11 -0700
Message-ID: <20131010173211.GH29913@atomide.com>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131010172128.GF28657@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, =?utf-8?Q?'Beno=C3=AEt?= Cousson' <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 'Pali =?utf-8?Q?Roh=C3=A1r'?= <pali.rohar@gmail.com>, =?utf-8?B?J9CY0LLQsNC50LvQviDQlNC40LzQuNGC0YDQvtCyJw==?= <free>
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131010 10:30]:
> Hi,
>=20
> On Tue, Oct 08, 2013 at 10:28:15AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131006 13:36]:
> > > Here is the third round of the OMAP SSI driver patches.
> >=20
> > Thanks for updating these, they look good to me now:
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
>=20
> Ok. I guess it's time to check how this gets included in the kernel.
>=20
> The first patch has already been queued and the last patch could
> probably go through Beno=C3=AEt once the DT people have reviewed the
> updated patches. The other ones would normally go through the
> hsi tree, but that one was maintained by Carlos Chinea and is=20
> now more or less orphaned.

Yes, I suggest you post the .dts changes completely seprately
so driver maintainers don't accidentally pick those up.
=20
> My suggestion is:
>=20
> 1. I create another patch, which adds entries for hsi subsystem and
>    ssi driver to MAINTAINERS.
>=20
>    It would be nice to have some co-maintainers for the subsystem.
>    Linus Walleij maybe? I think you created the launchpad blueprint [=
1]?
>    Especially because I have no documentation/specification for HSI, =
which
>    brings me to my next slightly off topic request.
>=20
>    I would like to have access to SSI documentation and HSI specifica=
tion.
>    Can the guys from Texas Instruments please give me some pointers h=
ow I
>    can get access to the NDA'd documentation? I couldn't find any hin=
ts
>    on ti.com.
>=20
> 2. I create a patch adding Carlos Chinea to CREDITS
>=20
> 3. I create a git repository and put all of the patches in there, so
>    that they can be pulled into linux-next.
>=20
> 4. I add a gpg/pgp signed tag with the key used to signed this mail.
>=20
> Any issues with this or any other suggestions how to proceed? And if =
following this
> - should I request an account on kernel.org to host the repository th=
ere,
> or should I just upload it at a random place?

That all sounds good to me. It is a *good thing* to have a maintainer
for a driver subsystem, and if you're willing to pick it up, that's
the way to go.

Regards,

Tony
=20
> [0] https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/=
tree/Next/Trees
> [1] https://blueprints.launchpad.net/linux-linaro/+spec/hsi-subsystem=
-maint
>=20
> -- Sebastian
