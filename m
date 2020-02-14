Return-Path: <SRS0=+U9p=4C=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48996C35242
	for <linux-omap@archiver.kernel.org>; Fri, 14 Feb 2020 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C454206D7
	for <linux-omap@archiver.kernel.org>; Fri, 14 Feb 2020 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710741;
	bh=cBjRp7OLeJPnaHIk5LoNULWJznxozqfcApheJhG/fCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RO2SQIXmQU9q3M3mvISOXAiP28wQgzU5oAB7lx/LOByVshRcYuh0494QsIheRa5Rc
	 af89AaO3w39w2kLVrCcaCE27vSxas/5b0sX7U29ny3HVof6pxFkwMHisNiL+YSdctY
	 nk+cWmlNZNsKuS+kEShlRdGuD+Op/OY06/KdblNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbgBNUFk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:05:40 -0500
Received: from foss.arm.com ([217.140.110.172]:44532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388703AbgBNUFk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 14 Feb 2020 15:05:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7094030E;
        Fri, 14 Feb 2020 12:05:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7C5E3F68F;
        Fri, 14 Feb 2020 12:05:38 -0800 (PST)
Date:   Fri, 14 Feb 2020 20:05:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Arthur D ." <spinal.by@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio
 graph card
Message-ID: <20200214200537.GR4827@sirena.org.uk>
References: <20200211171645.41990-1-tony@atomide.com>
 <cd46c6ec-80e3-332f-4922-e58a3acbfc61@ti.com>
 <20200212143543.GI64767@atomide.com>
 <346dfd2b-23f8-87e0-6f45-27a5099b1066@ti.com>
 <20200214124920.GH4827@sirena.org.uk>
 <20200214170559.GA64767@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTlsQtO0VwrbBARu"
Content-Disposition: inline
In-Reply-To: <20200214170559.GA64767@atomide.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--jTlsQtO0VwrbBARu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 09:05:59AM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [200214 12:50]:

> > We really shouldn't need dummy DAIs at all I think, if we do it feels
> > like there's a problem.  It's quite possible that there is actually a
> > problem here though...

> It's dummy in the droid4 voice call case as mcbsp is not the clock-master
> and there's nothing to configure for mcbsp.

If the McBSP is doing anything at all it should still be properly
represented with the actual device rather than a dummy otherwise we'll
most likely get confused at some point.  If it's not doing anything then
we shouldn't even need the dummy.  But perhaps I'm confused about this
particular system, I remember some of the OMAP designs were a bit fun.

> But I guess in some cases mcbsp could be the clock-master and then the
> secondary DAI would have ops.

It'd be a bit of an unusual clock design for a phone but yeah.

--jTlsQtO0VwrbBARu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5G/ZAACgkQJNaLcl1U
h9CR+Qf9FPZ/Ad8y5xe0+tkWOFeKHsAJS6dhcJcsAkuHoO9VnHgr8uNfN1Pl6LQh
W2bWc/5F07FYANvhVtVGyj23F2CnzPyewfjG6BGlToQRLZT3HGc0CPLNrnI4vDgb
D+dK9EROqaeuDPppBbdxD0UiURFkB+OGKhIaFjQDhVDlLdr7hBvfPgDdzyilifh9
K5wfAWGUPAjkNRW3IPVAfQZWuCoImOdkVmKTo9cUdxBqB052blAH/Dl6dCAIPXFH
04abRiijYC91F2xNX/XU6XlOWgm2fUCrnmI6K44W71aHyGWPunQd3zhnZpyZXf5K
+vKda5XCIvxFmrVHN4BnbN4qz/Xu0Q==
=q3Lt
-----END PGP SIGNATURE-----

--jTlsQtO0VwrbBARu--
