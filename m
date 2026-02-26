Received: from mx-relay97-hz1.antispameurope.com (mx-relay97-hz1.antispameurope.com [94.100.132.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504C3A1E72
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101566; cv=pass; b=ODMrJ2fkavWL+BdCQQIMx+FVo9SpQIALzOpr5NoHRM8xfKbGMzg/T4wccyeRKKoSZGcSRjM3+/LjBKV6GpSDkAdLFpD3zGx95R7FdCJDPYw6OmLyIZOVRhqYrODQqtiCYL7PzBQZhQoDI6j+wWdzdpx7KhZ4UNmTtkbHj8D7D0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101566; c=relaxed/simple;
	bh=moyssVlWpwqjaiSMGtPZUV/767qmOniG50xtLgGUBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8nKinYUXAUpUO/MOPLrejecw4B4xWZAkLeIZavAdIQP3fEpwJmIQZpwSCcUpFRLrYtiguvt/Na/Cc9/4gYdMoiTC0unVfdV88zLZHXa6y8PS+081QcN6wnXxyETyQgIDQoiibS5D7QDacH3qXdsQWd+ajXbIyXnGff4bz5Dn78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s9D6EB+w; arc=pass smtp.client-ip=94.100.132.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s9D6EB+w"
ARC-Authentication-Results: i=1; mx-gate97-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=kUn9csnyj4e4zd3fT0P+1ubmMOmYC1BISsEuxDwjNs4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772101486;
 b=YRCLRdGUFVlysvRDr9c/NTwz3Q/VRNjS+eqwB4TxXoD5FC/Omehq3EiLMatLIsj2dzuj91BF
 x2WS/aOFzntWC+J7XX1knqyoPxgNjF7RMwGEHkTudDKQS4m4wy4y3Eujy5cEol4JwTIN+U2DYXi
 JUs/mAJe+Ieb7epP7eccaSYBNItleDvADK5FMJDJvP7ruh9fpEP2Btf3Ewavlwj4JIJvQ9ox7XF
 JOtNU5yR63oShS8cVYe3/78XFFIxsd9W6WG2etZf7jRnUOWOPFym0QG/fU/8w23hhWpVeifyNNE
 K0MA2+1NYNJCz0Ezjpy8N33x3wWhb2imxmug/faljiYTg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772101486;
 b=dSER9FZi0z4DvlrNXA6iS61d3RLkBRuHakPUy1X+d2YbTY3aZxDFQOsKSfK71WiP4gT0JqDG
 I8Y8tse7P7C2xDhg9bt05OqDGPByZjrsp9SMebYPPusEuQQHFyb0M1ypGp0eNFlgpdAw0oJ/kJj
 GYt7riuh6UvH6qp3eqpjV0FzxBAVNHFsEpqYEs5uP2Hp3IjxVptZ3MAHGEOso0j/QlduXlOyJwm
 RJ83eb5TiH26dA989vNabDKcHvQT2F7GvNPHLQveOhFjLPq+gr/B791tDznnNzhEg2GVdYVwTl3
 nIc/bOdUiXCInIpd3zY/TdnXS2cPnIwSkW1gl+zk+OLUw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay97-hz1.antispameurope.com;
 Thu, 26 Feb 2026 11:24:46 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id E9B992205B2;
	Thu, 26 Feb 2026 11:24:27 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, linux@ew.tq-group.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 markus.niebel@tq-group.com, matthias.schiffer@tq-group.com
Subject: Re: [PATCH] ARM: MAINTAINERS: TQ: Orphan TQ Systems boards
Date: Thu, 26 Feb 2026 11:24:27 +0100
Message-ID: <2403960.ElGaqSPkdT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20260225171135.122955-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260225171135.122955-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-omap@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay97-hz1.antispameurope.com with 4fM6yN64Qkz27lDm
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:5f8ca20172c337f721ff1e894cd67a83
X-cloud-security:scantime:1.864
DKIM-Signature: a=rsa-sha256;
 bh=kUn9csnyj4e4zd3fT0P+1ubmMOmYC1BISsEuxDwjNs4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772101485; v=1;
 b=s9D6EB+wRTlcMQ7FSltDZApbPq45csJKeYVapFtPZMsPhwfvZQxH0Mc3C4GzHLNAJ/bS9ogr
 ZLpptdEMRogvIZHbfrUBR2Hc/By5rQheQmUdC7ix9ertDOAX6YBYcKVEHRk+gQTtjx7t8BSk70V
 /33cBEOALKLgsCAey7+xnVvLFQH6wzUfOGGgyXAngbpvBvx5Rz/WOGH8uhCmdvAknd3h8kZH8k/
 aXbZJVQ9X2CCtCVkItBXNsV7IXFyWI0DJxxqtbs7eSFrQ5JNVe4Sj4hkdSrB9U55NQdQCvOH8XS
 e6LqfGXJt832se3Rcy/0Dj0WwgJfYxvxVF8nqgSq1t8TQ==

Hi Krzysztof,

Am Mittwoch, 25. Februar 2026, 18:11:36 CET schrieb Krzysztof Kozlowski:
> Emails to all TQ maintainers bounce for a month or longer, because their
> systems decided to block smtp.kernel.org.  This is nothing which can be
> fixed by Linux Foundation IT staff, but aggresive and irresponsible
> email provider.
>=20
> There were no answers from linux@ew.tq-group.com or anyone else in TQ
> Systems after my inquiries about this problem, thus assume the mainline
> efforts are abandoned.
>=20
>   <Markus.Niebel@tq-group.com>: host mx01.hornetsecurity.com[94.100.132.8=
] said:
>     554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.
>=20
>   <matthias.schiffer@tq-group.com>: host mx01.hornetsecurity.com[94.100.1=
32.8]
>     said: 554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.
>=20
>   <alexander.stein@ew.tq-group.com>: host mx01.hornetsecurity.com[94.100.=
132.8]
>     said: 554 5.5.4 Your IP address 172.105.4.254 has a bad reputation.
>=20
> Cc: markus.niebel@tq-group.com
> Cc: matthias.schiffer@tq-group.com
> Cc: alexander.stein@ew.tq-group.com
> Cc: linux@ew.tq-group.com
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Thanks for rising this up and sorry for the delay of my response.
We are still in the process of resolving the mail filter issues.

NACK for the patch though. Our mainline efforts are not abandoned and
we still support our hardware.

Best regards,
Alexander

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index faa914a5f34d..f446fb30cf6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26781,7 +26781,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
> =20
>  TQ SYSTEMS BOARD & DRIVER SUPPORT
>  L:	linux@ew.tq-group.com
> -S:	Supported
> +S:	Orphan
>  W:	https://www.tq-group.com/en/products/tq-embedded/
>  F:	arch/arm/boot/dts/nxp/imx/*mba*.dts*
>  F:	arch/arm/boot/dts/nxp/imx/*tqma*.dts*
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


