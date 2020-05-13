Return-Path: <SRS0=QTYI=63=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6096CC433E1
	for <linux-omap@archiver.kernel.org>; Wed, 13 May 2020 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0DB2065C
	for <linux-omap@archiver.kernel.org>; Wed, 13 May 2020 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbgEMT1S (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 May 2020 15:27:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37904 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390206AbgEMT1S (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2020 15:27:18 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C195A1C026E; Wed, 13 May 2020 21:27:16 +0200 (CEST)
Date:   Wed, 13 May 2020 21:27:16 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.cz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Configure modem for
 serdev-ngsm
Message-ID: <20200513192716.GB20994@duo.ucw.cz>
References: <20200512214713.40501-1-tony@atomide.com>
 <20200512214713.40501-7-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20200512214713.40501-7-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-05-12 14:47:13, Tony Lindgren wrote:
> Let's enable the TS 27.010 /dev/gsmmux* interfaces via Linux n_gsm that
> can be used for voice calls and SMS with commands using a custom Motorola
> format.
>=20
> And let's also enable the kernel GNSS driver via serdev-ngsm that uses a
> dedicated TS 27.010 channel.
>=20
> Note that voice call audio mixer is not supported yet.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

Best regards,
                                                                Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXrxKFAAKCRAw5/Bqldv6
8inPAJ0aV3C5kMif1WPGg8RRI+KpmCL94gCfcrDwy628UP3GlXtFzIE8VBW/xwU=
=ycpJ
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
