Return-Path: <SRS0=sQ2K=AK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D021C433DF
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C64B20842
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 19:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgF2ToS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbgF2Tmm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2020 15:42:42 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Jun 2020 06:45:27 PDT
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [IPv6:2a00:da80:fff0:2::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9AC02A579;
        Mon, 29 Jun 2020 06:45:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E0DD1C0C23; Mon, 29 Jun 2020 15:36:45 +0200 (CEST)
Date:   Mon, 29 Jun 2020 15:36:44 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Merlijn Wajer <merlijn@wizzup.org>, jikos@suse.cz, vojtech@suse.cz
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Beno??t Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mark Gross <mgross@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "open list:OMAP DEVICE TREE SUPPORT" <linux-omap@vger.kernel.org>,
        "open list:OMAP DEVICE TREE SUPPORT" <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>
Subject: input maintainer -- are you there? was Re: [PATCH 1/2] Input: add
 `SW_MACHINE_COVER`
Message-ID: <20200629133644.GA22227@amd>
References: <20200612125402.18393-1-merlijn@wizzup.org>
 <20200612125402.18393-2-merlijn@wizzup.org>
 <20200616105045.GB1718@bug>
 <fef69c79-9943-7bd1-5c51-101f551cf2c8@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <fef69c79-9943-7bd1-5c51-101f551cf2c8@wizzup.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Looks like we're blocking on this input patch.
>=20
> On 16/06/2020 12:50, Pavel Machek wrote:
> > On Fri 2020-06-12 14:53:58, Merlijn Wajer wrote:
> >> This event code represents the state of a removable cover of a device.
> >> Value 0 means that the cover is open or removed, value 1 means that the
> >> cover is closed.
> >>
> >> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com> Acked=
-by: Tony Lindgren=20
> >> <tony@atomide.com> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org> -=
--
> >=20
> > Dmitry, can we get some kind of comment here, or better yet can we get =
you to apply this?
>=20
> This is part of a patch series to resolve problems with the Nokia N900
> not booting when the cover is removed (making the cover be the card
> detect was also just weird IMHO). Just removing the card-detect from the
> DTS is fine, but it was suggested that we expose the data instead as
> input event. And that's gotten no response for about four months.
>=20
> Should we just drop the feature and only remove the cd-gpios line from
> the DTS, assuming upstream doesn't want this SW_MACHINE_COVER code?

I believe series is good, lets keep it. Changing now will only delay
it a bit more. Let me try to get Dmitry's attention...

If that does not work, we can get Linus' attention :-).

If that does not work, umm, there are some other options.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl757mwACgkQMOfwapXb+vJWKwCeKCWtJeiWc/FxANNI2HrHGQQ7
Fx4An1mjqwvcVp1xJprABVuC4z8nryZ1
=Fk60
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
