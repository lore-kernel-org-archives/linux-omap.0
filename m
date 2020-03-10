Return-Path: <SRS0=sshs=43=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D497C10F27
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 09:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D6724683
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 09:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgCJJve (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:51:34 -0400
Received: from sauhun.de ([88.99.104.3]:46804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJve (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 10 Mar 2020 05:51:34 -0400
Received: from localhost (p54B33196.dip0.t-ipconnect.de [84.179.49.150])
        by pokefinder.org (Postfix) with ESMTPSA id CC7D92C1EC6;
        Tue, 10 Mar 2020 10:51:32 +0100 (CET)
Date:   Tue, 10 Mar 2020 10:51:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qiwuchen55@gmail.com
Cc:     vigneshr@ti.com, tony@atomide.com, aaro.koskinen@iki.fi,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] i2c: omap: use devm_platform_ioremap_resource()
Message-ID: <20200310095132.GI1987@ninjato>
References: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <1581755803-11242-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2020 at 04:36:43PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
>=20
> Use a new API devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Applied to for-next, thanks!


--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5nYyQACgkQFA3kzBSg
KbYvihAAtLbW6OXNBF33jGTbQy7lTAdCOsNGbXEl/nekp82iEdJ7UTsVQ/jLCrgI
Ci5mL2iB//WuRXpjkqaJ5TdnI1YfnMcyIXMu/9kFks8P1geHPIMANHvoKbv2J8VH
iedTgDArfWHa5K85cPd1To7XXwJzdOx7ey6GGwFN/zAXHLUQ+3K1O8niHEsibpHF
HKUbSqWZcy6XhLNESqXrPbh+2psz7b+1HksddkjQmjaKPh7n7OaPqCprz9oYw50u
TEaChDaL/HJCLGAFWCe3AW/ecO2+1x/6NcIR+K2qbv/gAXmzYvZxTUq8NStxQlds
byqlLzq6SEBY4ZMU4WS5R4gw3CroQ+ZeSWrABJW14xoUphGID0Mh23auHIzy7CnY
zXPQE6cB/AjepJcHOKtwcSRSwkJroA8U9hlsgXSdqjU8q2wcfgQKtP9kqNNIScl4
509KVlHdk+LW01MEf3q4IlB/IZJIRe5P3InbuVDhOiaa4fiXFegNAE0BFtKO665N
NoRPNtsa7TA/Nd+FP0BY+WILLA7lR0Js2NGEjG6VM2SMBTFL4Q2QiH3P59Yv654M
UeMCKk591mZQrovt9dojW0fJbMe9OAiB/OEox6Lp8CqVBw2wP4zygwTwlBDCBd23
pvnNAzBFxhDQGKpIXa29o9xc/brsuMbN8PkKpsm3F8a1Neqsiqk=
=M7Xq
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
