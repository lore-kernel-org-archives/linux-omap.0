Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EC3D9055
	for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519121; cv=none; b=Y+bXuxVijreBxNlwHZDP8u7+Gc6ALSWVJrx/5VSPOb6uRnXnUzQTZORuFrEBR2YhZN010yBbz8TTZ80Pq25+gtEG6l5c21oit+oJ2jLbFO9tM9CdtLZzPNwoWemgZcfpCthe/fSKbsG7V5r5A57zvs32zztSuIlgonAaEAPq0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519121; c=relaxed/simple;
	bh=mz+6nG47ilX3A59NTc4OGIJD2EZY+ExfhHZBUxFJ8hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDRt9Je/z0tFqoOQVvUCiq2syTlU/AReZSSai3uuhZK+txsXSl5mLk2h6PMKSf9A/dBj9uX6aoQkK5HYvtozrA9REaQB0Oc6iAwmd2QH73WNpnLHvfmt+/VCj0axVGbOmXwBsjxPxOq2haTlHuLQzVx66NC7uai3ngusbHAwSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WugABhll; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WugABhll"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b9144790dso402898f8f.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Mar 2026 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774519115; x=1775123915; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mz+6nG47ilX3A59NTc4OGIJD2EZY+ExfhHZBUxFJ8hI=;
        b=WugABhllTBAsetpNlmsp/KAyIG+NmD1ax0+UHzjCfUNK1l3o5Oaw8bcHdDDngqbpJa
         xEEoocVDgC3OFLo2ui65anQwE3ETbSRpuM16xCNuoJxDmX405wNT9N45iZrJvkOclWle
         AaUPouRtBpb2IRVPRiZ/no8iVrTYSQJ7MBcmuu8HBb+JCwxfaLfK721+M09ZvFTdFZrR
         O8XKyJdIpaghtZoW+LgykRfYzW6Ni5D5wfZ6z+YX9BcPprDZ9E9VLXcxuyIpfpD/2AWR
         uO1ZqNJ5fOV7ew7D29lvYjqo2nFz3sIf/Wzq8erS4p1NDitMbuHNY+NRZer8UYvYnp3M
         J1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519115; x=1775123915;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mz+6nG47ilX3A59NTc4OGIJD2EZY+ExfhHZBUxFJ8hI=;
        b=ep7C4oKKXciA1Fv2Ze6bdW5I129ZhH/BsWa9pYVKUoSHSRQzJKpBHH2YCK8+sQhJLq
         RmFcq8/PRr4QM0p8uJu83XpGHKoU0yy1+DLWc4gzd48b193hhlxTLmF0ejfG7Hns854v
         GR4Ha9VMq5lCzSrmt4UulTGY/QIWpf/Gl8Uya7nfi9LWCt45SkC+hpPUWQP8OE5MdqVa
         BzDoph/G62ohp2O/qZWpBrkDX1a1WI98uPWSNQURBLnA8gOQaG12hOQvrxKB7gYkZYVr
         ktMc5QptoOhOna6h8mFzBkpFRnLnvBefM0L66y8aU1N7uHRLQmvYObLizHrVVW0XG90c
         k1WA==
X-Forwarded-Encrypted: i=1; AJvYcCXCfDHOg2Xt59lqw7uBSViEh6qfgI4R4ovAXQXdMOeNMpTYLOuF7o7WVe8kIsPYE5Cd3DlKx9FWDLJv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xpJorzI9mRhyWRgBf04BbpWGHWJNGjEuKioLMjv3unlqG4s1
	j+75DWsEVyBmayFf8i7erx3MbX2V19xUTf3p8Uj6MV+JLHbgMj1yKsfD
X-Gm-Gg: ATEYQzwHhtTBThM1FDIU2yTia7+H+7YdROI6vnA+ifWY7nyMGeIlhYiOI3yCilzgZBh
	yafDKwKWKJelO1gwGosNnbqHBxzsnvFd9X2IcvNtQHnZNaAyG3xD0TiJRqgh7hTHVUpaOw/KWCX
	vnbFMjCwfkFanL9fEZc9TiyjupEMrwvdd4nkibzFfgM3kEQrqyNqmXQw48oVA2oIL7kvNKoepEb
	Gn8DlzxJeSc/wnwqolCT/OGWngSbnQ+2J9EYM2hMzHKnoOcH2w1DA94nqvXLaketO83S2ifRoKf
	8ywwJf3IGu/qQrAaCa5L5EaT7uugzEjRzThFmww8wDLbE5mg9HAKdA8Sw1cVPq/QAO1bjxKBr8R
	eTmluEl6PX5I6n5dBZf4Y7pk759jrO/VAd3IvsCglJo3v2UNDcAqeZV89zPir2Ru0+pc3RlgOWR
	mHczXj4AUWkXCA0T8NURjOFXev1lCg5iHCygaDGq/Sy8lbEcpVtDDtPXHsHNUoPAGu7PW9Xi/2G
	1+RqOK6cngBCePg4A==
X-Received: by 2002:a05:6000:2902:b0:439:bc2b:cb57 with SMTP id ffacd0b85a97d-43b8899d2d2mr10957682f8f.6.1774519114620;
        Thu, 26 Mar 2026 02:58:34 -0700 (PDT)
Received: from dell.localnet (2a01-114f-4a05-91c0-0000-0000-0000-0540.ea.ipv6.supernova.orange.pl. [2a01:114f:4a05:91c0::540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943184sm6132528f8f.14.2026.03.26.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:58:34 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Hans de Goede <hansg@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@kernel.org>
Subject:
 Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of GPIOs on
 Nokia 770
Date: Thu, 26 Mar 2026 10:58:32 +0100
Message-ID: <6058205.DvuYhMxLoT@dell>
In-Reply-To:
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
References:
 <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6331700.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6331700.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Thu, 26 Mar 2026 10:58:32 +0100
Message-ID: <6058205.DvuYhMxLoT@dell>
MIME-Version: 1.0

Hi Bart,

On Thursday, 26 March 2026 09:57:31 CET Bartosz Golaszewski wrote:
> On Mon, Mar 16, 2026 at 9:50=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Fri, Mar 6, 2026 at 1:31=E2=80=AFAM Kevin Hilman <khilman@kernel.org=
> wrote:
> > >
> > > Bartosz Golaszewski <brgl@kernel.org> writes:
> > >
> > > > On Thu, Feb 12, 2026 at 12:46=E2=80=AFPM Arnd Bergmann <arnd@kernel=
=2Eorg> wrote:
> > > >>
> > > >> On Thu, Feb 12, 2026, at 12:25, Bartosz Golaszewski wrote:
> > > >> > Currently the board file for Nokia 770 creates dummy software no=
des not
> > > >> > attached in any way to the actual GPIO controller devices and us=
es the
> > > >> > fact that GPIOLIB matching swnode's name to the GPIO chip's labe=
l during
> > > >> > software node lookup. This behavior is wrong and we want to remo=
ve it.
> > > >> > To that end, we need to first convert all existing users to crea=
ting
> > > >> > actual fwnode links.
> > > >> >
> > > >> > Create real software nodes for GPIO controllers on OMAP16xx and
> > > >> > reference them from the software nodes in the nokia board file.
> > > >> >
> > > >> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qual=
comm.com>
> > > >>
> > > >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Aaro, Janusz: Can you please pick it up for v7.1?
> > >
> > > I can take this via the OMAP tree once I have confirmation from
> > > Aaro/Janusz that they've tested.
> > >
> > > Kevin
> >
> > Gentle ping.
> >
> > Bart
>=20
> Hi again! Any chance we could get this queued? Janusz, Aaro: any objectio=
ns?

I'm not able to restore my test environment right now, sorry.
However, the change looks harmless to me.

Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks,
Janusz

>=20
> Bart
>=20


--nextPart6331700.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmnFA0gACgkQ2WqSnlts
jBq7zwf/SlUujvOszUgmmL7ZvRqg7N4thVWbxI4Fs2PxRX4HUkTwGpHaL3K9YOlv
bnhkhThw7SVDAm7RzZtrsQqhrYiH3eeszxX6IcR4U/KOOvSbzJWwiZiuI4XDHe+R
EE9OT+H66KCMg+BNdWDZrf3d3otqCSTtY9Qe+qJjLGqKfb+tCUo2Qs9HVaU9ZACA
f30YOKOXbXi/D9OkdRmvex8EyIOXa2RKm06eUeuDHgEr65jT0yK/k1QprDj3U8fu
XRhL5LIA2OcPsVeGHN+n/2v0cGdZseTMD8ztneitzcGLOIk1ZHDLY3hJMXpxui2M
9dN0uqYVqv4dLykMTv+4a2QSm1aERA==
=XRf9
-----END PGP SIGNATURE-----

--nextPart6331700.lOV4Wx5bFT--



