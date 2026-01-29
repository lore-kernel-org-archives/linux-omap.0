Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF332D3220
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668377; cv=none; b=JWBk0b0blP2OWlIKauQa7sduZeVG6nCpzg8s7YTJuVb2TwVTsGn981dOTCvO9P56Dz70/iV1pWWKaz6gG8Eq+taHkeOY7kMWkRxeJ8wxw6xyES8oB8rMRRu3tcFvdVi67ZYCk9S/kgN446I4lW1Ev0A4oP4OnVWIc0/BaDctuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668377; c=relaxed/simple;
	bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyvQgL0FjdPyJIeIZRiE7xh0SLjbyOLZ82JXaZv5c6+zPMlqUboXHZ4sNsYntWKJ+MKn0sxZ95iBZNK8lS3g0Y4s/TptE9vrow+Wr9to977LEB77eAQtNP/qOcQcmcIjLFqR4QOBo8lFy65J5R8LfTSYtSuFOqC94UdMMf/FIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3TyB+L8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3TyB+L8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014f383df6so4693441cf.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769668375; x=1770273175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
        b=a3TyB+L8FFn8Z/vqcnQrlVoFRY60o9KUNvbChUMhrFZONlqNGrLL9Ey/l6b/s/e0KG
         XTG6nZBuDafUnZFaDn9yieLlLDrXDTXXH+XA/LOH+8zJhIadmfvDDJ71Ok07sj2Pf4Nj
         xIFb4Fo1WWN1Yga+IEvJdVJ9bXTtYtq0qGKrjUg1XYRL/8qQCHr0ftPVGgMVJ9tqf6II
         +27zo+O13cLZMZ4c3RDy50hbtoKMRynfP4MNx25zuIDu5hlz9aGWhowqzyU8tw8GJIWV
         hLvmdHi1Q12K01O/O6shMpBPFHdPRga99wX8yt/IqFP9DE0LG/RkGvsYeakkvaC4ybPV
         GlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769668375; x=1770273175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
        b=oxDe2NLe/3ZRH7nLHrySmkxxfWdFHoQtacIRTQe/PcIm0Ki3mCa47OLTttmt5Zt+w3
         m25VcOQIdFZ6iAEx3XdtuRggNbs7bqRvCMZokL+BP8CwE6084j0YKM7PMql6h/Qbq+lG
         0dbk1kn5yeumJtnLE0DS1LaNOgRCJjDzx+he55XsAM96pJ27fdTo4ZDkDxWpWH6uDzpz
         GpPZlIvHrkR9KZgIxSBSgVL+e6CJODct4uo2EuxlNltu57YdbgNB2wwj1BnUwjSxwJcp
         LHFVlWVZClQcFoUEI99hUiNABt0zLbwg2Bq1d7tXeepHqb+ev5Lw/yQWzTgVuj19jLZA
         Njwg==
X-Forwarded-Encrypted: i=1; AJvYcCUtimayjbMsRNZKXvKMK5OOnc7bLjbwptU4/NhgUTnuup1DVUha3Zqf4G7ATwnHduRKRSnUYCbsp7q8@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRnn0h7Iubj+0Ng4TXIZ99Mb2Z3LxgicUcCihZdprq/iQhiGj
	Mpe5/E0uPtf9hn0dJkGif7Q3UZZYWjb+kEUFGBJYQAF/4ylt1OOBAlpu
X-Gm-Gg: AZuq6aIK6Vr3BoNwP94HKruIQAgOYHfDZ8D+nHo6C8Ht75VWWC/KKw2Quf8xEPm1Nli
	f90q/g2q7ERPjiZWKJquD/vUvJHjcuxpxOmhK88KaiERhVukwV7f6a1L8H36OC9LjidkNXTv/bN
	b2QEnfg0sHHan2sRchuD+Kpr5yH/ociLx5iSRZjdaXqIftEyO4p5BURYeH/BUzbiVXu5ARjSvn+
	XF7j8NyQpYasci8/u0haXOb6Ub3oTgaa56EcTugjnZd3r/deAIAKDsRo4s/FeD/33cvgEWKYWIv
	TkAftv8epPHC5xrwnxwwa14i06worE8zt1Iyh/X2iNs2oSQovJDqIwP71DS1moALVD1nKQHW1EO
	pnXOG5/Nbe4tXFEGLZAHCC6VgDH7BO9VOtdeFUU+oQj1G/4ykTS6Ej7yMKmttCz6GMyujLPCm1L
	SImAjLzX2/sIncypnICQ==
X-Received: by 2002:ac8:5e14:0:b0:501:3df2:fd60 with SMTP id d75a77b69052e-5032f7704c8mr95104321cf.12.1769668374785;
        Wed, 28 Jan 2026 22:32:54 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm35829361cf.1.2026.01.28.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:32:54 -0800 (PST)
Date: Thu, 29 Jan 2026 14:32:44 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v3] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aXr_DNapxeHpuWt1@pek-khao-d3>
References: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
 <20260127190836.6a420768@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UH1uIraS6vl8AKuT"
Content-Disposition: inline
In-Reply-To: <20260127190836.6a420768@kernel.org>


--UH1uIraS6vl8AKuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 07:08:36PM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 16:02:07 +0800 Kevin Hao wrote:
> > To resolve this issue, we opt to execute the actual processing within
> > a work queue, following the approach used by the icssg-prueth driver.
>=20
> Code looks good now, but why are you creating a workqueue for this one
> work? Can't you use the system wq and just cancel it sync where you had
> the wq destroy?

This implementation was adapted from the icssg-prueth driver. After reviewi=
ng
the git history, I found no explicit rationale for using a dedicated workqu=
eue.
In my opinion, if we were to use the system wq and rely on cancel_work_sync=
()
before unregister_netdev(), a race condition could arise between these two =
calls.
Specifically, cpsw_ndo_set_rx_mode_work() might be scheduled during this in=
terval
and run after the net device is unregistered, leading to a use-after-free b=
ug.

While reviewing the code, I noticed that in the current implementation, we =
may
need to move the destroy_workqueue() call after unregister_netdev(). Otherw=
ise,
there is a risk of encountering a use-after-free bug related to the dedicat=
ed workqueue.

>=20
> BTW you're fixing drivers/net/ethernet/ti/cpsw_new.c I think
> drivers/net/ethernet/ti/cpsw.c has an identical bug, no?

Yes, as noted in the patch comment area, I plan to address the same issue in
drivers/net/ethernet/ti/cpsw.c once this patch is approved.

Thanks,
Kevin

--UH1uIraS6vl8AKuT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml6/wsACgkQk1jtMN6u
sXGeSwgApr6OFmEUX234PpjrEIQIlnM3m7PzdD7CUzcQ03K8vr+EeScd9bBSUt3W
s/Ap+TOHLKbv9AcOnWn3jZLNWNYb5xJpzM4+iU+Hl2IkVayaOPwYTGCevMiSnlfH
3RKxR9yh2TuFhYlnPZpeD2bdKXX1P1DPZV464MD6etTY6xJxqLpMVLw2CLxHEQFn
L/dKEngjlRvvKtULu0fVUQ5t4+sjne8nthMmuagnzqzzoXq1Vg5v7w8sqG3WXYN/
dwz5qjBJUGgn0+u/vBOZ0/dUFsxci2/sAlUUjsyRfqexotFyXtt3276QkwgpGLJ6
b/CVzZXLQAk9YoAGRyrZsTThYFpELA==
=gJCM
-----END PGP SIGNATURE-----

--UH1uIraS6vl8AKuT--
