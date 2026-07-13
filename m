Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA43E2AA1;
	Mon, 13 Jul 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935542; cv=pass; b=l3Wew1tM864gg24P/DGgj58WMYITa8tfTgQE0H9TH1NlN1IZCAefmVysHQikQnGTPpuceykrhCRUVbXQi1hv2cgxvjWeZaIN/BCVFyMbwodhWdrb4SMKZsZ+8VvqNGVyBTviKOMth76YaxBHRImIgH6ZWTFt2HN0JY/xVs8CacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935542; c=relaxed/simple;
	bh=imolX7qSsiq9DS+KtH4jQru07kjP4EZc5PZkld9Ag7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YT8STn3zikrWCW8HAqYEI+9b4n6fQ/Y7P0vXLtDYmAAxeiWU9IcuR/3QJujnQQpFGXV87/trmSzzWf2esGMRD6EH8nQAM0BfjwLnUSohkaGtJ7PF37f5g7wACf2otLcOgqrGvI1opTsTwQAhOopWqbwPofG455mbBONsP22Y4vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Cv8a4lrq; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=lTqAmbw6; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Cv8a4lrq";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="lTqAmbw6"
ARC-Seal: i=1; a=rsa-sha256; t=1783935504; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A2PpFk0vGEtY2w45rqud1fyX6/O738D6k+R9ydMJO8qRmstNo1iQGxgaeBVdiZAa6x
    +H2Xvm52EZT7p6OIBBTnBZHvSjhr+djdKOWWzkjoIDAb+N8VitYWFVQFi33g1xGltF02
    p5BGSfXs/DZGNauyGU/CS5gk99Rf7NsSq+4rPxYaIRB6VJFBJY4Txx9S3wcD8JCcDIDV
    K+WDvcI16sSth+1S++Iq+MNu0vSbudz0p9hxOHWv0+ELMTkgOT4yGk7mXMyhPTM/HM2O
    xi/2NG2uls2D/23OXQRGlEHMHwvy7auByLc3n9s3hf9dudCO7CN4qRl79NDhnnt1fa+M
    bHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783935504;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=imolX7qSsiq9DS+KtH4jQru07kjP4EZc5PZkld9Ag7k=;
    b=sSD9A1+izIoL5gWAn4bTLYgoCWTPF+FoRHJO0L/2/TTi3KhWbXUZ4dY+5VO9Jl7cuk
    tNHudl8u7i8/wsXnzkNhZQu+tK0HXlYQOs9IVgLuxGdwQB+u4ltTROcI/JFIcEyjhZx9
    s4EEjuypFgvdFky1NX9h6Om8bVKCFXPKJZgq7WbuYplWGopRhA/rFr3x3d3yDQKlcLT6
    MucTNnt5bC2A3fRaGut49Bs2V6UiKO6WVhENy1EVmoGWn6emR+77XqQBsyBZLUd9bqIV
    40LvE9Hz8R9A8u+8dBI2nq1wOYcZn7AbOj98XL8PIX4OLYwi3Omp1/ELiQ57T/MQRmkR
    Lv/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783935504;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=imolX7qSsiq9DS+KtH4jQru07kjP4EZc5PZkld9Ag7k=;
    b=Cv8a4lrq73F2cX7+2YTJ5/fHsdk1X+y+tuAXmr5tNEtytNlRDE5RpaTuGfBtFneHdt
    mHvnYiGaYUg1B7T4K7CeglLgD9Vy/zf+9ArlPaJlCDAmtf52Ax2Ys7J+r2G5YjsJg20M
    k3uUHi3z0Da4FArlVNLkNbyuGYGhltbI8Nydm7f3PdgMgGU1QaNpcesnik2z79DvRf1H
    4I5N3QBWOo2awuQMwqitYo/bqcx3bxVfol/ElWN3kFWOcpqr9fH3El49Gq45BZ13mf+C
    UGN76T33iKjnQCqiaP10+CKSD05FoThCmYD8ef59AN7dKHCen1BDDn0fZ0RNB1D6AyJX
    iA6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783935504;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=imolX7qSsiq9DS+KtH4jQru07kjP4EZc5PZkld9Ag7k=;
    b=lTqAmbw6/daSGIIBIi0MdJ/BPBDk6SFFmSlKiaiBKD75i2vmEE9ZjNyMI7nxbAo+WG
    7EGEWarw+yfjjzznYECw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQi5pZlciNgDl2kEp5oHJ2/c57N2Mc49IfXTKd"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426D9cNNOb
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 11:38:23 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 09/16] ASoC: dt-bindings: add OpenPandora Sound Card
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5667350d-cc3f-421d-899f-f353b05c5ea1@kernel.org>
Date: Mon, 13 Jul 2026 11:38:12 +0200
Cc: Grond <grond66@riseup.net>,
 Stefan Leichter <sle85276@gmx.de>,
 Grazvydas Ignotas <notasas@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>,
 Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>,
 letux-kernel@openphoenux.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com,
 mfd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A0C119B-7885-4538-8D4F-AC60E5C91B7E@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <7989e699de400c0fe3f0cb7af77a54077784df78.1783749722.git.hns@goldelico.com>
 <20260713-infallible-capable-dormouse-aaaebe@quoll>
 <BF2B6C4A-A4CC-48D7-9854-DC014950184B@goldelico.com>
 <5667350d-cc3f-421d-899f-f353b05c5ea1@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)



> Am 13.07.2026 um 11:21 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On 13/07/2026 10:27, H. Nikolaus Schaller wrote:
>> Hi Krzysztof,
>>=20
>> Thank you for the feedback.
>>=20
>>=20
>> It does not emit any C compiler issues or runtime problems so it =
remained unnoticed.
>=20
> I do not believe.
>=20
> There is a clear warning from Rob's bot.
>=20
> You just did not follow the process of building the code (compiler has
> nothing to do here). Read submitting patches in DT dir and then =
writing
> schema for further instructions. This is ABSOLUTE MINIMUM. We are not
> your build test service.
>=20
>>=20
>> It was notified by the sahiko-bot and will be fixed in v2.
>=20
> Sashiko has nothing to do with that.
>=20
> You DID NOT BUILD the code.

Hm. You are confusing me. I did "make" and did not get any errors...
And the resulting code works as intended.

Best regards and thanks,
Nikolaus

