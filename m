Return-Path: <SRS0=0+oN=6P=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F198FC35280
	for <linux-omap@archiver.kernel.org>; Fri,  1 May 2020 20:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D532166E
	for <linux-omap@archiver.kernel.org>; Fri,  1 May 2020 20:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgEAUTI (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 1 May 2020 16:19:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55654 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUTI (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2020 16:19:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 17F191C020C; Fri,  1 May 2020 22:19:06 +0200 (CEST)
Date:   Fri, 1 May 2020 22:19:05 +0200
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
Subject: Re: [PATCHv6 0/6] n_gsm serdev support and GNSS driver for droid4
Message-ID: <20200501201905.GA6043@duo.ucw.cz>
References: <20200430174615.41185-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20200430174615.41185-1-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> My guess is that at least with the pending ofono patches, we just
> want to use the raw interface for /dev/gsmtty* interface and stop
> pretending we have a modem that is AT compatible.

Ok, so I got ofono back to work. ... I believe. It was not that
bad. SMS send/receive and outgoing call start/hangup worked at some
point (I did not play with mixers).

To github.com:pavelmachek/ofono.git
   61d3d727..195760e9  mux-v1.29-1 -> mux-v1.29-1

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXqyEOQAKCRAw5/Bqldv6
8nWNAJ0YiT+Sq5AwuqS5PaFbK/cp13xE4QCgjMG4ORPk+/2ETGiFGpu8yuhiF2o=
=r4yx
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
