Return-Path: <SRS0=+U9p=4C=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F563C2BA83
	for <linux-omap@archiver.kernel.org>; Fri, 14 Feb 2020 12:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FA622314
	for <linux-omap@archiver.kernel.org>; Fri, 14 Feb 2020 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581684564;
	bh=I2z+me8ZlJdPuu+TxgkV8Mr9SKlKNdQE81Zf4qtmN5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z8Dc3pE7/b6JKVLf30/+5QSXgT0hkbkkM1s/37ql5aithKqZuLmfSHn7BJnjdG4Jk
	 seT1Vxk51fEC8a2MmAg4sv+3PxybEVcVxhSkgFtRw5FxbZ8nuUXFdR3YfRRVBatCG7
	 i3KGTvvf9u9tbRI1BHhNxAALmYbuZDIRXb8CU65c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgBNMtX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 14 Feb 2020 07:49:23 -0500
Received: from foss.arm.com ([217.140.110.172]:60950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgBNMtX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 14 Feb 2020 07:49:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF1E1FB;
        Fri, 14 Feb 2020 04:49:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E29E3F68F;
        Fri, 14 Feb 2020 04:49:21 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:49:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
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
Message-ID: <20200214124920.GH4827@sirena.org.uk>
References: <20200211171645.41990-1-tony@atomide.com>
 <cd46c6ec-80e3-332f-4922-e58a3acbfc61@ti.com>
 <20200212143543.GI64767@atomide.com>
 <346dfd2b-23f8-87e0-6f45-27a5099b1066@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline
In-Reply-To: <346dfd2b-23f8-87e0-6f45-27a5099b1066@ti.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 02:41:30PM +0200, Peter Ujfalusi wrote:
> On 12/02/2020 16.35, Tony Lindgren wrote:

> > Oops, that's not good. So should we just keep the old naming if there's
> > only one endpoint?

> That's an option, yes, if we really need extra dummy McBSP DAIs at all,
> again, let's hear from Morimoto-san or Mark.

We really shouldn't need dummy DAIs at all I think, if we do it feels
like there's a problem.  It's quite possible that there is actually a
problem here though...

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Gl08ACgkQJNaLcl1U
h9AGSgf/WC1rD+oEYoImv2NX+F1kZLeDZ1n+50cMMhVxzUM8Wc/oD6BZAF7BSo5I
Pd0iBQQd9PStwHOvnWEdTzohUmiK/7iRVPKYYYpv47/9g4v4tT7BDe7tNRNolBGR
xYV/sJiD+U0DlpSUOYuwd4xxQVLAcEXUp7SSjvHAoYEiJlZ055K1opwl3avKwYR0
7d2vQr0nQrc9wD49QxxD9fGMhv/o+sVx6rpkayuiOpcE3QRxSJIgxnVdPwlKSjxU
YIe91JG0GI4BGwWy3fi21D4tiMNLIPrwubI91PuPhBFaUkJVSW+8njfpLK+SrHrJ
uaRh/PD/nMhNE7bNAr7JbguqB70QRA==
=s0ru
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
