Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE43EB0E1
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510495; cv=none; b=G00mciJB8JJrhJSV1COc9xCaF+Il2a/9q70MF6OBZRV/rWxStlzRozOJeE4h9mbACcaOvQruCxuDkG8Z5XbBp7rNwldDM4yQD/Dx8JXhlk4bztJZeRSd7mrgf6yN4fDNvuc7NBHoUVGZSV4XTvS2kTUflEqJw+MNao7xFNgesS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510495; c=relaxed/simple;
	bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iZGRngcAm2eqw2JHqpnPerc5FrYZfDdxJ3a8wnJBFiEv8dMapci9uWtLg0keiHmMkOtLJun3U+RNWo163hPLeEF/OcCJ/PLXdkQxvcQhd/DYBscjPytrhbXkeDjkSTeXleZGtuaDhO7Sjtd4IlwFfSQ9yOrG/ydPenJXOJRQ4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RiaQwOXB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RiaQwOXB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4956869750eso5641345e9.2
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2026 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788510486; x=1789115286; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
        b=RiaQwOXBOn0YzZFijm1RpCHRJ6mSahw/bPpElMP5GJkOHm8JqWCflj9TE/WMO28aZi
         eIlnm2nMZ7As9Wb0rrvdYwAGVWKQuBq2K5u89uD0JAuqEFQJJUHFofCeKLkYUiRIeKcI
         05vwddqEQUKkS8KNpu8ZrtLK4fSvbO51CBuMSRnrdWPaCrDq6LD+UHpi6Z8UAQ8YwK8H
         Z62V1ZojujRMo1Zg8V9NCVmjRMIk3jOW9HM9uDauoxXTBeIlbYsww4z2q15ahlxqt9oi
         tUBvWRQu9kOhGLecsOqFRlDq5kn4tWxpJmCYTUtITkz1aIRyf/B9o/9qJl9W8lC+bgfT
         7cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510486; x=1789115286;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vAduMceZ5WykF9AxLntA2mjBC+eC1Z+b3m9MMdygFJA=;
        b=QVfA7ZAbL6ZNe/XJtdvm+K4R4TejbQDLFO21M8B8MGBW1uYDHynbQX5XZQ6WKUC3t7
         O35haIBBhbrnwLJcKKUrat99ccs8f0AafZDkQs+b+b0ZVNwbH/DpjdvHvnRGN4HzVodu
         sJ4eDbjK9N96nZaYo6vfH/7C5x6Jz6vsu2vJzuEiS75Fv1FrC4vMK7VfU/Xz5FnhgrKT
         aVIoVh+Nc6blqf89bQL95JnjBBlHSRdG82Cf75ryl6hP5TXOK/Co8XiwoFEu7O2DZX1G
         7WmVJPJcSl/vPTC68S8XeUb0doILn1Qnu8P3yLztO7MHwRDawILCRpLGl7bNFKsQOZqi
         UeEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOroE603Rj+t2I8VIf/otD4FE66KuOcSHfcQZblgHuAsQyWyvKtSRrSabDfT/S2lqUQqmlUt8e5ST7@vger.kernel.org
X-Gm-Message-State: AFuF++mo1pRoYpWMsnh5LrlUUrKN6R+LqJr6znETSgz9aKKz+hdrN2XV
	LW2gFyfgJmi6zLtF7z3p3qh3G37zfFWNLnsuZsynDE63P3PR6LI9OPljkJKrSNAI+j8=
X-Gm-Gg: AYBFou3ZZXzKAzShAL7twl5jA+sy4yiqBJQ32PyE/TUlYshdWUUMdoKEHBSi4JTWCYx
	IaCAS9zcrFeywMN2RgF6RmyDBwwXQ5KnW23yEx9j/qR3Mgw4HGU/CaoMtu+4slc5RUQ7yeLV53a
	SKK+ejcOlY8gmD26PU8VZ5v/vqO5ZjmTuQerYNXVRdB1a9x/2HDxoEsB9VFNwiZcL7o8wXKk1Bf
	hdTgFE8pvM6oke3dh6j+sJwea5mgry9x/GoNRLRGOm6fJOXsnntkqsFRm57Br8og7FqWhlBM91b
	UM9NvV2uQ03JHQDxrvEZsByNgQneKH6JFa7MLxe7hxKlGmJPN24sQ7t6NdVAbLnFxv5mChSj6Qu
	wzXirMcod7CwDcmQQ/LuIY13B/3C33YnTQBWBkAuRBvmVY/LWtPn+CFtfrkGEnUTKoB4TjcdX/T
	wRl6fYIjub+bd71zevex9JNxQ89HjpMpAJQblTEXzEZku80n6f6AbrYmwT
X-Received: by 2002:a05:600c:3511:b0:49c:fa20:cc01 with SMTP id 5b1f17b1804b1-49cfa20ccddmr25588125e9.24.1788510485753;
        Fri, 04 Sep 2026 01:28:05 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf5135353sm68845625e9.2.2026.09.04.01.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 04 Sep 2026 10:27:58 +0200
Message-Id: <DL6E1V8AMI2X.EQQ009BX5AZ6@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 05/33] can: m_can: Remove comma after
 sentinel-entry in match-table
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>,
 <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>, <msp@baylibre.com>, <florian.fainelli@broadcom.com>,
 <jonas.gorski@gmail.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <kurt@linutronix.de>, <hauke@hauke-m.de>,
 <chester.a.unal@arinc9.com>, <daniel@makrotopia.org>,
 <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
 <ansuelsmth@gmail.com>, <linusw@kernel.org>, <luizluca@gmail.com>,
 <alvin.sipraga@analog.com>, <clement.leger@bootlin.com>,
 <justin.chen@broadcom.com>, <dlan@kernel.org>, <rogerq@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <rjui@broadcom.com>,
 <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <opendmb@gmail.com>, <andrei.botila@oss.nxp.com>,
 <wangruikang@iscas.ac.cn>, <amadeus@jmu.edu.cn>, <kees@kernel.org>,
 <tmshlvck@gmail.com>, <c-vankar@ti.com>, <horms@kernel.org>,
 <vadim.fedorenko@linux.dev>, <daniel.zahka@gmail.com>,
 <nora.schiffer@ew.tq-group.com>, <v-singh1@ti.com>, <oss@vassilevski.com>,
 <haokexin@gmail.com>, <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
 <lgs201920130244@gmail.com>, "Kendall Willis" <k-willis@ti.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
 <20260904043724.2955444-6-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-6-s-vadapalli@ti.com>

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 4, 2026 at 6:36 AM CEST, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

+Kendall

Note that this and another series by Kendall will probably have a
conflict as both change the compatibles:
https://lore.kernel.org/all/20260902-temp-v4-0-3896f7d16ce8@ti.com/

Best
Markus

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapqBDhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNU
DgD+NDmEsw57cLpzBEOHVv/Nk1EkJHkfkEl6somoL6FeZhQA/igsPy7rmcarz6Ym
lEV7ixhaA3JU6LQo0KOc3yMdNwIE
=DaCZ
-----END PGP SIGNATURE-----

--aceffad199f989fc0e7a2bade7854fe91c95aab0591a0938aa91a92fdd3c--
