Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB7433E7C
	for <linux-omap@vger.kernel.org>; Fri,  4 Sep 2026 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511565; cv=none; b=dwQn0ywjCROp0cbFvyngKSKVjCJtwy0aaIDworr8yry0C8KRggIGZvq/TIkYsiv7uN0gTXDaZGfGR4sczxGTLHpgOasux7eS8HExFZPQHuLL1JfvAZYg6BIh7larfHBUj2KyIJx8iNE5JIKCfZK1aae1m7WftPSAFJxB/K5zjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511565; c=relaxed/simple;
	bh=yM+cf4BW7fWvclHo2h7sHjdg3qaKTsvzuIsAI990Mc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bm/CIsKN2vUluo1DhBvUbOK8rzWTcQuDKTcv5ckWv6tjZoJU/liMsHe8gmCcxyNgRp31Fyl9vJFgAk5S2vE3et8x945x+6eLGvCS+JDhYsEJ7ZPK28cCLDKvGSyWmKVX2u2A5I2deCzbuL2eWKD2HX9wT3IbyBKcCi0L4JmTj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org; spf=pass smtp.mailfrom=sverdlin.org; dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b=MvqnKy3Z; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bqXOfUNW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sverdlin.org header.i=@sverdlin.org header.b="MvqnKy3Z";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bqXOfUNW"
DKIM-Signature: a=rsa-sha256; b=MvqnKy3Z3Kqh89EwTzOhsvMP90LxQ/9rT3yrXzezDlWI6MZ4Pse+AkYD8jUdyR0d6CGkfJ/esgKGc7I/C6l97dLn9KThkzjnOun2b1G458hk6F0ymhzRRjHF3z/SDMw8oOSHqSrbobnyRwk9SMzi0QZfjR2IvcB5oVW4a1xEejrmreMO5Xx8Ds3TxDfqZSEfGlnOmkjpHZN5inADlI5u3SaJdjG6XDo63GnK6jiMBVpcgEPeyu9QGCVEJ10rAz2zQ9S8FBT+U27q3MCXcudoRdJ/GzWGupOE6gh/EMQB1+jcxu31I6AInafSC5sg5C2Ac5xvFza+3a8eKpE9ymOtlQ==; s=purelymail3; d=sverdlin.org; v=1; bh=yM+cf4BW7fWvclHo2h7sHjdg3qaKTsvzuIsAI990Mc4=; h=Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=bqXOfUNWfeOLiVF5J9IK3qIOOz8cBeJr6Z7wBkMyoBMBYhY2WSM9HgKYnzhHUExwNgTTjTsR5NnjWf3Xp0zjeF0rHyLwwF60+RioIo6Di6w5c4jFhaqrjlPjbhRnZSiqYKsDaU7NXJ06rSL5vAnWZfUj08AW3mrnVp6ZqJmfJAOqxDOcoYGeM3R4/vxdIOrv9xU0antLqAm0rUmCswWkyg/zipfUa3BmxTsCAWM6PINDwRsfttg1bQS5T4dcLDnEpv3Bh7Cqd5LADDN+Kw9fZ/r4hI/zgyc7ujRhsCsIG7+CEzrOX6tqSnZngEqyrH5g0wHE36sLhPTbGUU8ETlDZA==; s=purelymail3; d=purelymail.com; v=1; bh=yM+cf4BW7fWvclHo2h7sHjdg3qaKTsvzuIsAI990Mc4=; h=Feedback-ID:Received:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-omap@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1456570978;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 08:45:55 +0000 (UTC)
Message-ID: <5913e1de4be69b0b14557e7ccb5577ffbd1a145d.camel@sverdlin.org>
Subject: Re: [PATCH net-next 27/33] net: ethernet: ti: cpsw: Remove comma
 after sentinel-entry in match-table
From: Alexander Sverdlin <alex@sverdlin.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Date: Fri, 04 Sep 2026 10:45:55 +0200
In-Reply-To: <20260904043724.2955444-28-s-vadapalli@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	 <20260904043724.2955444-28-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-04 at 10:06 +0530, Siddharth Vadapalli wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>=20
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0drivers/net/ethernet/ti/cpsw.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cps=
w.c
> index aa3531e844e8..63b64faeaca0 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1529,7 +1529,7 @@ static const struct of_device_id cpsw_of_mtable[] =
=3D {
> =C2=A0	{ .compatible =3D "ti,am335x-cpsw"},
> =C2=A0	{ .compatible =3D "ti,am4372-cpsw"},
> =C2=A0	{ .compatible =3D "ti,dra7-cpsw"},
> -	{ /* sentinel */ },
> +	{ /* sentinel */ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, cpsw_of_mtable);
