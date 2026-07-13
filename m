Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6C3AD52B;
	Mon, 13 Jul 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931285; cv=pass; b=CjMjIR6VLct7jM1qnEEYiCrxhogBfKZqiAjc7s5IPFZOVa05YATsK+ACkJA+3mriTLqDKQbOCnNZrBrIA6jadHEAMY/xOH586EYIn3/dMNkGc4ft0QKqV74ty5jsRhTSf+2uGmlKqnx4fMXu/cTG8B+THjOqm9tcLdhCDzJQKvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931285; c=relaxed/simple;
	bh=TmBCGJ40zcqiObxb5WI0YMQUk3XkQJfcOkD4AdtSdTw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eME8g0jXQX5Le1wNsHjKAd2QchRvl/T+MKK2EjDqJV3nhgeMR3knbqa7A6JxUuHbE4vhrVxAmoTLhcz1UmWlRoDykub1D8iOuKoEMIXMwDei788+CBRkQtEkicvcq3r8cBWtgYZAE2vhA7yXhS1ApdSzATOw/+AUYxffqCGRYIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=cNlzCSfH; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=aEHftVVv; arc=pass smtp.client-ip=85.215.255.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="cNlzCSfH";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="aEHftVVv"
ARC-Seal: i=1; a=rsa-sha256; t=1783931244; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wv45c5Xu0HYQjDS/lmDFwfn2fEfWOvgX4BPfwjcUKhsruzOtt0odkWxXhGCgnxZxlc
    uXfafRFGCj3vcFTjiZ6T1z/dGvU5B6+gC6RFXfS17KIN4mzxwvFXyns0F9+8RLwTj8xI
    BMNrR2LJebjh7lD8lvZGQQ0oPEGhE/RsPZmLamVpuxmBpyC5qpqAlSO/qlVGGjLVYt/H
    3K9JaNNbaLZLg10nr/BxZy8XEyPeS56/NEGUTp6mxtIYY9qyb8nhCZ9fwubYBZWGLkuh
    5Ds5CwR4VD3JCEEyBNlIw/9QEG2RUnneaxHwZgnwTSgW8gnC5hX/iK/ZMf1SPVcDV5oU
    2saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783931244;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TmBCGJ40zcqiObxb5WI0YMQUk3XkQJfcOkD4AdtSdTw=;
    b=jH+QUmeOlR+Mx9H+3gfmgwtrQYJhI1wYw+IVVAmWm2VTLL5dEnyflCQ8/T9BiyShIQ
    +ccKvt7xofP0znuilBHpfAhg1pwwJvt4xuap6ZrJ4nrftMyLFmrHMqMpPViyj4KJ/zGj
    Jx21fwlqxJlRbMNAT3r1F7RJHUfJfaQtb0EJb+tnG/3JT7Vs8IOOHUaGKEsYsk5Dq7Cb
    57gGiWNnOUjE81seZKIGiUugMvrJtyFqNLKRPAvAK9XYWgoXqvciio9izoy6KQHZKWkr
    ISPnmmTlBoTJz60v4vsTRG0y2uH+f2xf/vxYW9AhvAhRF8Hg2F5Mb3Ga8cv4chHhLbYF
    LeKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783931244;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TmBCGJ40zcqiObxb5WI0YMQUk3XkQJfcOkD4AdtSdTw=;
    b=cNlzCSfH/qGgSOVYmvr4SlrYtitUckKYoycdOVJ45Z2cdoggvfTW75ItQpML3uBmj+
    FgGLYHB+d6WmwPQpbHktKOWatlcEDECp9Vu5G6dZ+xfw5uyffES0Z7hYy9ptz/JS5t5e
    1M6O7kReFaS5PZgRJwmun7lStZl2pGkVubgUYxKw1yC1hT/KNO/riSkRQ8kF2s4pXrXj
    tWU4t/Vf38RKciodN1NfbdKfK9CRxfy1Neo2AR2TkK/x+s5TKd9NRDhC8GcfHiU3ffAH
    rb9qjC3i5BLndXd1rL5HuwCWprS8ewL/cw9mWrP4yfurCvogLcm7nWF1bs+0QXt1/dH/
    IhAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783931244;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TmBCGJ40zcqiObxb5WI0YMQUk3XkQJfcOkD4AdtSdTw=;
    b=aEHftVVvhVUeYGE73TJxXZmN8r3wQfDudi6nEy0VUJj9TMQ5kjkML/3V51KhioACDx
    mUrJEl7Ek3h+k7oqjrCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQi5pZlciNgDl2kEp5oHJ2/c57N2Mc49IfXTKd"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426D8RNMvV
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 10:27:23 +0200 (CEST)
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
In-Reply-To: <20260713-infallible-capable-dormouse-aaaebe@quoll>
Date: Mon, 13 Jul 2026 10:27:12 +0200
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
Message-Id: <BF2B6C4A-A4CC-48D7-9854-DC014950184B@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <7989e699de400c0fe3f0cb7af77a54077784df78.1783749722.git.hns@goldelico.com>
 <20260713-infallible-capable-dormouse-aaaebe@quoll>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Krzysztof,

Thank you for the feedback.

> Am 13.07.2026 um 09:37 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On Sat, Jul 11, 2026 at 08:01:56AM +0200, H. Nikolaus Schaller wrote:
>> The OpenPandora audio subsystem describes the routing links between =
the
>> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 =
audio
>> codec, alongside amplifiers and power supplies.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../sound/openpandora,omap3pandora-sound.yaml | 94 =
+++++++++++++++++++
>> 1 file changed, 94 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yam=
l
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.y=
aml =
b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.y=
aml
>> new file mode 100644
>> index 0000000000000..d3c747e5c58d6
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.y=
aml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org
>> +$schema: http://devicetree.org
>=20
> This wasn't ever tested. Why?

It does not emit any C compiler issues or runtime problems so it =
remained unnoticed.

It was notified by the sahiko-bot and will be fixed in v2.

Thanks and BR,
Nikolaus=
