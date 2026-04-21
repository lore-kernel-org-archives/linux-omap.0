Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499F37AA82
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766240; cv=none; b=Bqh5cVeJ0MbJHiikMNZV2GUyLbVbqNDr6TOqV8l/ob5vpDV8zRc4gi+XAwW+AMgHV6FCOrYkQM/mGEDkzJxz/S5uxhST219v20PLO9NHTJL836+PLMSpSwcrPmrh1xPZqWRjpu9aNSYuPkPbRNhkyWBSLaeAYAbXf1QXGTz01gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766240; c=relaxed/simple;
	bh=f40Z2T6UXslhgeqPT0SLEpc3IntV+bpVpgRMsiLEyn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/d4O2ModUnPd+mZKZbLMNyddSLLTaCzZrh7lsYyqYjJUDSDUCGSZpPSYtwv1bGWzLXQdLJR2SjQPOOcX5OSekI5Rd0eg+jsDzddw8M/3/oYDp47Ck+dfQCjK5coLzc1P6MsZBSlS4rtP5MjecK+IbmX0zPxI7pKNcT7l8zgBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4IdtJpx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4IdtJpx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso18664845e9.2
        for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2026 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766237; x=1777371037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8i26WnvEzqtjggoSSbd+ZCeLOG6Y3DS7nQqRJJ4EJQ=;
        b=P4IdtJpxh3J4Ba/yQW9bqWB6yY/2B7O+vqosljSHnOLXbAb1Z6ePuWTerhDGAVQha8
         87wk0IfuqqED3PtVpLhUAMn6lkY6mQfVe6SQsODNrGxsTjO1bevJj2Ke5qxdSdPmk+X7
         VVqn/vlr9QvXVlGwEGhzu3qmIdjl/06h2NqByf+rWnoJ5kNpDXsLVlPHUla/5H+IOlCJ
         RMGmk/1yhgbJUtEZTbWEt0Qw/7fPsa1VTzEBOfL5rwL4i/Kc7VySzQYuv6lKdHi70QWs
         37KiNSuyvz7TLUjeC9pAl9koDNGrIo5Eb/kNTzjI56T6etFr2mqGpC6+qIm4s4rgilUL
         NXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766237; x=1777371037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8i26WnvEzqtjggoSSbd+ZCeLOG6Y3DS7nQqRJJ4EJQ=;
        b=tVvLYNJmU///OWwBl8qVrl+0xNz2I1Ojnn90dxfRvFKSc3qglz6IMgwkXu5D2V5/6j
         dM/QGi/ymoKZHeoB9FdWGJiRWmAfgTn/LKWplWa+qmQWzmbCvWFMYHP+BwOBP11fyHxD
         qGvldBG4HRMZGvP+5v/WFVzXAhGwu8nwDbkpy9ZxnTSR5ZAc55+Jv/jRAylvPwMOUAU7
         o1PWpQt/vSBlVHK+fFHoq1fP560kl635j9crnxLq06O7K32aDgMRAjE+91emqp2r5hhS
         AZQPRHu6bsgWhmcGK/11rJDbAt1edDEF5D0jkLaautv8V1I5zJe6q+8l9/RDogFxVBnx
         N7Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+asp/lLGAPnLx49TdHv7cLG7U0NhtFQdM826Q41IkjoqW6mPSi2nRcajqFNxQ7ADr4bWmBfpoNolPY@vger.kernel.org
X-Gm-Message-State: AOJu0Yydhv1xsDnCATB4fGLj2lK7Mm7Flti4pO80qrBmCzGWUnK2kEWW
	h8at8yM7msSFevPdlBOL1NhgeMOpwYh7PU3FiADIstdI8ikPHestOq1I
X-Gm-Gg: AeBDieuEWc5Dl4Ti75V6IyLyL86/La6zztf/q6PMi49Z6m8yBnc+hY9CnfnbyzUGCu2
	fCA4/wefk7rB0mZ5rC6WIEi6H1AT9v5m10s2ou1jWOoE5pHrN57LDPUIigXZ/oLzKTWm4/hBfc6
	LypciREWprlrRU6DA4nwj3AftwmGdi0opUsXADxiFfTx/7KZXNRfGs5r+V73MSg/tm3FMs1xpxE
	RWvWvLMpALc6Meu85zq0Aj8J5SvSBC5JRTrVxmLhZjyPz9UoNE2sgWVjF3eGhYfmolyUFxEblmC
	Myq7wUJryfD6MH5xLnOchBPBuVr3JLEsW/0LhT67aCpjUOfYuYzvwglKqmR9XF5f/jHdP4xpkzu
	yUDavVsHye2GZgzg+Nr1aazDEZYHL2TRiHVv2E9o7t2UfErTe8PbqJ0XM0KS/aDpSQIz2spQNZ+
	jbyubJget/OKiHI2j4H8tEuS5ORlHJcF4zEh0pc10YLUrVlT3osh2bqB9oOcvsnpdIJgKJFsHbT
	sW2gTDhethR0OL7HGkEEgUc
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-488fb739cd9mr198783905e9.1.1776766237036;
        Tue, 21 Apr 2026 03:10:37 -0700 (PDT)
Received: from orome (p200300e41f131500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f13:1500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cca5743sm149377755e9.9.2026.04.21.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:10:35 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:10:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
Message-ID: <aedM9A5vZSpg2ejS@orome>
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
 <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iljpeusu54227slh"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>


--iljpeusu54227slh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
MIME-Version: 1.0

On Mon, Apr 20, 2026 at 08:50:06AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Fri, 17 Apr 2026 at 15:15, Thierry Reding <thierry.reding@kernel.org> =
wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Peter sadly passed away a while back. Paul did a much better job at
> > finding the right words to mourn this loss than I ever could, so I will
> > leave this link here:
> >
> >   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@=
utopia.booyaka.com/T/#u
> >
> > Co-developed-by: Paul Walmsley <pjw@kernel.org>
> > Co-developed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
>    "every Co-developed-by: must be immediately
>     followed by a Signed-off-by: of the associated co-author."
>=20
> https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/submit=
ting-patches.rst#L506
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Good point. Thanks, I'll add that to the patch.

Thierry

--iljpeusu54227slh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnnTRUACgkQ3SOs138+
s6FtNA/+IOGgvf2lEqydkdm2yLiSq9mf9BZV7RmX1tRK5PKD53tIx45Jr6VhFbsA
lUfLPKoMJaUJvC+a4SglqYSgjVTR/OXgqWIN8PkWlF7DedUL2pFsF68A8RY0Zz9H
INvSyIIKld2hbW6rMvclNX9G3NKbYoGjNdO/+iBZ5Yg1rNN9fG6BP+QUFmA3TrCy
5x45YruOqPkCcE6/9JslSP8F3xibDt30ZrR01QyBL3GawSrlR24+EpN9WxTlOT+M
eo74keyH71q6J3tT2EiBXJXkB28XSh9ZSlEe0nfcERy0xxFFu9BoGrwCQaLIOGQR
QWMu4eX/U58VInPR6ltYCv7prkAZf9bcrVE25ym3A8TtsdmK27KYbwWKND5Sjlhd
R3p5/Hrtkjuyg1c06co4BUc+vu73LJ6hktpY9Iu2KLOIPRCC+Oh9TOcpkhmPrSK2
JUpmvDinXx6XjUNVGrkfzcdbm6JUGMQiX4i0YEtR6uAb7zfi9VS5Ow5cfoQJu5ZP
OvlcJt0vPbSUhNP4Sqg7xdvqU6g2/soQuh9Kf6Wt0MJPQQrtr0C20HhRxfDwNcId
SIuS8X8BqPv63mRwVSAu0ENlqs4X3qD0059UV+cK+JhLf89cz51OgAFwguzBDX5p
KS2X4VY3cTIEvF3AKA5/ZjcCPYtkJOkXqheTUcfvQuhuy9rHR4g=
=YfYq
-----END PGP SIGNATURE-----

--iljpeusu54227slh--
