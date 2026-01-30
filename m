Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD988183CC3
	for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2026 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740297; cv=none; b=l4T8kNNGlDAi6Oo3U9Cpyrr/8LAW/sSarX72+5pj4BDKOs1OuwSDy4kjuKf+5vwE/MzAaorZIcGau7vAAjAaIn38+c8+koV38ha2REkYn0siyXqMFgQyCUm5oatpIX8pw7KRSstFOPX0rof8n0cMZXvj9MJzStdi4hYnrEgmZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740297; c=relaxed/simple;
	bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhq5cPuD7StAdjxaz1tNOzwUZPV2TraoKNT2g4Fi3ze4nQmSnSEhG2GDVQL2qbnxj4omEluZbZAUT8j/oYkIkQRTKrryYixZkPN28XoE1F6wpkxf9RBomOhlwh7r1H8CsPQfrRjIw+lHJfTKdDXJjMl7WUAly322iAhiJQ+NL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5dOwUDK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5dOwUDK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8946f12b1cfso19101736d6.0
        for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740295; x=1770345095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
        b=G5dOwUDKhE9mlBiUamQY3E4J5sp7x93ctIUFyTNf3+Kx6+hcg4VPVrC1BHB2XA80i/
         eTpwjXorA3cPU4bZSEHcQDyjrkhnP8EUe5kTyULTreUIj7JaKVatcj6cjoQJNPdK5JaE
         pZfmTlXb6Phe1LHKASCUkQfX73ZO89TRrgizyMYGHiujKEjtTautGa9SgrO4webjIozQ
         jHRxMe0EM7lPD1ivQ0V7lkeDOvY+W3zGAuvxx8eEmYLfuncbNc9Pu12aQc6r0EvXt2NV
         3AY2a2sZ8kfm1qnXF5+19IaBH2GJeughcfBA+JooCpvZFHqz9Av5CiC+m2UH1AiSxV8B
         ESVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740295; x=1770345095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5n7c+mYs2Jmw3DmLv+whK9T9EUa0DU9JyUfUNg/Y0o=;
        b=Sv7AEvRyrrKCxbTWC641KMk3hI9sSSlyc2LPOq2mPZulDQRNf2XWQSOEEyvstth/b/
         vMgoIHgwlqk/FgCj3zTDAZPOW20AmP8QS2TA9CtPNPnDQliX8qMY9LwxovQ4qk2jmORR
         jEgkHXMmFaoq6zra2/StX0c4PXdpxj6fIXgp+bEXz1cTCaqqcQuV/L90kCaKHOK2KESn
         KYt+Sqs2pjcOz/tzJ2KjLTNtCSojJNgfQvGFQ0N1cJPJKEkeNLt9HAtd9I9GkCt3o6vw
         BMY1eAtcmNDaEwgUbTDcvPgGhaKInWhLpEvUMnN/rX322D154LsTY1sYtjWxK+RuyY4T
         TU9w==
X-Forwarded-Encrypted: i=1; AJvYcCVoStMyO5YxBF5AFGPrmF3Hqtqnjh9mwwFunZiBKv1HDhGItzwxydJHzs3xLtNu3WzMGCIhJOhFW8kE@vger.kernel.org
X-Gm-Message-State: AOJu0YzuoEs6fYE70jQV4Htd4/DIUOYSub7DS3v8M1MzkcXxI3WFApwO
	TpFICo0WZv2bjxAt85oASZwrRdT02qdBIqpk1okEiZ77Rcbd/U+EMy20
X-Gm-Gg: AZuq6aL7U4XdaAq6gSOQiT3GTUXJxW/7eOGptPSGoBpAVOB6h9e7bDJsbvlezc7ZhYE
	yDCpvjpp954sg+HSaQCIBr8TwU3cLOCCoj7YdnXGgpE9tH0nTaPz3ybjKfqps5Lu1ckJa3Rukwl
	7+1fkZNri+ktUTevCMi2yhEvxDQ/dB5u0JoNVD8FJP7LxzoLV7QgyVxwkQbZSDDTmFm+YwIPRiC
	TjyU+f3/Mbwbf09U9RPLzw0LZMolCM7xfdwFpcEoJv1zYKl3bLNJ6IObcoSiK/IZs5YkPOPxBXh
	LjP7HsVIcbuO8HmYFHCedygpQGZbW1zxxvC52VKOV3ypHvmq8Y32qNJKNYmRgrsjLDtveQtIx59
	Pon/51fg0Yvd5lIbXqLfLQtvRxodCNlrh9IFtrALfSRWeSnTsIsrJywL7wICWoIxbq8Tj5m+lcH
	QMgUvNhNaQmqE4OKwtsg==
X-Received: by 2002:a05:6214:2685:b0:87c:2938:c358 with SMTP id 6a1803df08f44-894ea0b06damr22269726d6.67.1769740294473;
        Thu, 29 Jan 2026 18:31:34 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376ee0csm49294766d6.57.2026.01.29.18.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:31:34 -0800 (PST)
Date: Fri, 30 Jan 2026 10:31:26 +0800
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
Message-ID: <aXwX_rv-3f-VP6_e@pek-khao-d3>
References: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
 <20260127190836.6a420768@kernel.org>
 <aXr_DNapxeHpuWt1@pek-khao-d3>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RwL+6DsukXCr0kwj"
Content-Disposition: inline
In-Reply-To: <aXr_DNapxeHpuWt1@pek-khao-d3>


--RwL+6DsukXCr0kwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 02:32:44PM +0800, Kevin Hao wrote:
> On Tue, Jan 27, 2026 at 07:08:36PM -0800, Jakub Kicinski wrote:
> > On Tue, 27 Jan 2026 16:02:07 +0800 Kevin Hao wrote:
> > > To resolve this issue, we opt to execute the actual processing within
> > > a work queue, following the approach used by the icssg-prueth driver.
> >=20
> > Code looks good now, but why are you creating a workqueue for this one
> > work? Can't you use the system wq and just cancel it sync where you had
> > the wq destroy?
>=20
> This implementation was adapted from the icssg-prueth driver. After revie=
wing
> the git history, I found no explicit rationale for using a dedicated work=
queue.
> In my opinion, if we were to use the system wq and rely on cancel_work_sy=
nc()
> before unregister_netdev(), a race condition could arise between these tw=
o calls.
> Specifically, cpsw_ndo_set_rx_mode_work() might be scheduled during this =
interval
> and run after the net device is unregistered, leading to a use-after-free=
 bug.

We can use disable_work_sync() instead of cancel_work_sync() to avoid poten=
tial
use-after-free issues. I will send a v4 patch to remove this dedicated work=
queue.

Thanks,
Kevin

--RwL+6DsukXCr0kwj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml8F/4ACgkQk1jtMN6u
sXFCeQgAiJrV8DTfvK4MCejRqM3F9oMUJ+HTMV7UVyM7Vgj5KQwgbkWh2Gxvz89z
A5CB7TrArTN275UpCQ/e2sSmoA5vCyTGlbnV946DXt5RFvL99B4fVC4qVXEao3aR
ipfvGy/CYJ7I5EsEaSRBMq358p6bvnlyrhYAwltx1L0DH7Pd4qo03uC98y9WrlCK
SvmC6JQKlU9xx5kG/1/DmwvEcnI2vHY///yxGzEPo4TTq1C6N9jvyjW2aQksgZ8U
TNI5AKaJXpooCZx8sQ3asOwjyZMuCT/300+8s2hhld12RanlEWlfEFZBs2FqXwlt
RdztUPqQyDiCEKNtMhuJAbgcjpjTtw==
=nmyO
-----END PGP SIGNATURE-----

--RwL+6DsukXCr0kwj--
