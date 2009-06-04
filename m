From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Thu, 4 Jun 2009 19:18:33 +0100
Message-ID: <20090604181833.GG31770@earth.li>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <20090602220433.GD31770@earth.li> <200906031103.21758.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:53215 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbZFDSSc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2009 14:18:32 -0400
Content-Disposition: inline
In-Reply-To: <200906031103.21758.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jun 03, 2009 at 11:03:20AM +0200, Janusz Krzysztofik wrote:
> Wednesday 03 June 2009 00:04:33 Jonathan McDowell napisa=C5=82(a):
> > I'm obviously too late as I've seen the "Applied" mail,
>=20
> No problem, I'm glad to hear from you.
>=20
> > but some=20
> > comments:
> >
> > * I don't think SW_HEADPHONE_INSERT is appropriate. input guys, is =
it=20
> >   not reasonable to have SW_PHONE_HOOK or similar?
>=20
> I do share you point of view. However, I didn't want to start a discu=
ssion if=20
> there is a need for another symbol or not before the patch got any=20
> acceptance.
>=20
> > * We assume the bootloader does the appropriate GPIO pin setup for =
us,
> >   so I don't think your omap_cfg_reg is required but it doesn't hur=
t in
> >   the unlikely event we ever replace the Amstrad PBL.
>=20
> OK, let it stay there. Do you see a need for replaceing it with a new=
=20
> ams_delta_hook_switch_init() function call that just calls omap_cfg_r=
eg()?

I don't see a need for this; it's always present and not a lot of code
to have in the init function as it stands.

> > * The commented out code to include the GPIO status in sysfs should=
n't
> >   be included.
>=20
> Yes, I put it there to get a feedback.
>=20
> >   Does the input layer not provide a way to obtain the=20
> >   state of the switch?
>=20
> Yes, it does, with EVIOCGSW ioctl()[1]. I personally don't like this =
way of=20
> getting the switch status and would rather see it available over sysf=
s.=20
> However, input guys may have their own preferences and gpio-keys driv=
er=20
> belongs to them.
=20
I think that's a discussion to have with the input guys rather than
putting a hack in the platform file then.

So really the only issue with the patch that remains is if it justifies
adding a new SW_PHONE_HOOK switch type?

J.

--=20
] http://www.earth.li/~noodles/ []  Purranoia: The fear that your cat  =
[
]  PGP/GPG Key @ the.earth.li   []         is up to something.         =
[
] via keyserver, web or email.  []                                     =
[
] RSA: 4096/2DA8B985            []                                     =
[
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
