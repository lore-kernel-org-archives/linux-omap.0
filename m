Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8683AFD1D;
	Mon, 13 Jul 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931244; cv=pass; b=FfwDFv3D0FKQmDhs5YstHiMDAgXSYoFS/gxE9oxm387kGhb5l3lQ+WQmM3osqbGl6sRoIUesW5pQoLVRfuVWHxxsT0RPUJOSIAbKP/8Pxcgl7PHTEZg32Kp0fBDFOQjptL4XvUMztVM9yneiUNJcZp/3u5vg15mNhuTo3J+oMXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931244; c=relaxed/simple;
	bh=neYFUrjpt4d+eKiwf3U4FL7aP1Kz/MEYOd8OByQiveY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bxBE5+kOvW4Zy3LN8YM4hrY5ldWvYdyitG312hFlNVYePEqEe+WAkWVW3unlsTJC4imyUgvcye1r5/8nQYUEPVN0ZwRRKibUTb5rKEFJxHfVy9akZtYn0rAfgJt8RnIc7rTWxeYZS6q6OgIqZ3b7Wqoa0ozIKSebjFb6tY6bzoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=p4xjHkYV; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=Ir3lWB6A; arc=pass smtp.client-ip=85.215.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="p4xjHkYV";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Ir3lWB6A"
ARC-Seal: i=1; a=rsa-sha256; t=1783931203; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ApQ3WWCvBciM8URTbhxcxqb4i8zY4Wa35Ijaz69v+oBKLcM1aVNqHoqUTGZeNYRIhc
    p3rOoNfW4pCwUYdeUN1u08wepro6wyrkzbQrOA/4TnWuc6Ziy8dPGCy9yWPrquD/r7Qr
    SNp2p1/Qh0aM9E1g3ecQpwr/TGeuIdYRuGmA8pSa+CphL75R1gH9X8E0C/SslCkARY9F
    j2gmsK/aTPGDAD0p2bVM7U7dFTZ3AyEUVI2xMfqEX0zlCzwgnI3ELjfbglhH9hxqO6av
    TLCIVcLEDd0i0r25PPcLfSk8HyvaUX2HiV+4Xn1lp3Fq2M73Cj7jhuY5GbUAlPLta9Wp
    jtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783931203;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X5eaNUk6cCIj7tkB6iVA5BRLOW7UfZYznohwiY6XKyM=;
    b=jkw1cYEuSot5zixvbO2Br/oB1pen23UVnS3yKFShKiB/eFVK0I/qQruj4Q/u7GbzLD
    708vqr5eEwC5WA/8t83sD6ZnTYL2sWEqWAjo0s0PhEbCgJmOsANB/f+d6AZEWOlfKA3f
    Ve+ECJAWcWgrpjIFkm7vuY45I2Ty9xZtj0tHztVJAVbdJJnbNdpvoBZOnw/VB1BeYolT
    OiuOWVu6aDSbIUEJXeCKCQTyVnBZXSAMAWSukhc73+Oo3MbI/bn799GVDwGy7ABjhDtF
    qi0jVqPdlLr8QUVqX0epVHtutYSYIu7BInotdu4QukP63gdwksRdMuS1Hm+U7+SOWWq3
    CAbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783931203;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X5eaNUk6cCIj7tkB6iVA5BRLOW7UfZYznohwiY6XKyM=;
    b=p4xjHkYVayC9PTvG1lMRwEsAQQ0Ig/+fv7E0yJHN0xgS4xCjV0PSAWHVZuWsOlD5rZ
    00rXBzV20qRSG8VlSv2pIO9dEe1Bfdv1CPXEontcCOiZmFAywiZJtw5w/71tZyNHGtSi
    TrM67CF5eJQHee6YA+wAAMgvWdfHnGX1TfmZNDa278lwYJ6ZtUPToR5SZqhVQzNe2USY
    cPJdob4Lf3v0GSyl+rCW4B+uenQvP4swR6esOmZLXrNb9KKlLfqQp8kITojd0fdsFqXg
    juSj4/qeM7LyBuW356p6XVtq+ksYktxICTTxIYWNfduWx5+KlTzIwKJ7WRBNTDDonBBp
    KL/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783931203;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=X5eaNUk6cCIj7tkB6iVA5BRLOW7UfZYznohwiY6XKyM=;
    b=Ir3lWB6ATJq5Hfy9Uynb83ys1EpQsZ8CxCjBrPT4OB1dURlxyuLB9A2UFe50CGsdn4
    sfRMP8oQAZABq37w88Cg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQi5pZlciNgDl2kEp5oHJ2/c57N2Mc49IfXTKd"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426D8QfMvC
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 10:26:41 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 01/16] dt-bindings: twl-regulator: Add bindings for
 exposing ti,twl4030-regen
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260713-aquatic-memorable-griffin-cf9e46@quoll>
Date: Mon, 13 Jul 2026 10:26:31 +0200
Cc: Stefan Leichter <sle85276@gmx.de>,
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
Message-Id: <3D58F644-3EAA-4BE7-88FB-1DCEAE7D5768@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
 <20260713-aquatic-memorable-griffin-cf9e46@quoll>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Grond <grond66@riseup.net>
X-Mailer: Apple Mail (2.3826.700.81.1.8)

Hi Krzysztof,

Thank you for the feedback.

> Am 13.07.2026 um 09:39 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On Sat, Jul 11, 2026 at 08:01:48AM +0200, H. Nikolaus Schaller wrote:
>> From: Grond <grond66@riseup.net>
>>=20
>> FIXME: not reflected in the bindings
>>=20
>> +Reguired properties:
>> +For twl3040 REGEN signal:
>> + - regulator-min-microvolt:
>> +  - Same meaning as in bindings/regulator/regulator.yaml, but must =
match
>> +    regulator-max-microvolt.
>> + - regulator-max-microvolt:
>> +  - Same meaning as in bindings/regulator/regulator.yaml, but must =
match
>> +    regulator-min-microvolt.
>> + - startup-delay-us:
>> +  - Same meaning as in bindings/regulator/fixed-regulator.yaml.
>=20
> I don't know what that means.
>=20
>>=20
>> Signed-off-by: Grond <grond66@riseup.net>
>=20
> As explicitly written in submitting patches: we do not take anonymous
> contributions.

Thanks for pointing this out. In more than 10 years of contributing, I =
actually have never run into this specific issue before.

To give some context: this is a contribution we received on our mailing =
list about 5 years ago. We do not know the author personally, but the =
code looks good and has been thoroughly tested by us. I kept their =
Signed-off-by because I didn't want to falsely claim authorship.

Unless he answers to this mail, what would be the best way to proceed?

Should I keep him as the Author: in the git metadata but remove the =
pseudo-anonymous Signed-off-by, and instead add my own Signed-off-by =
(and perhaps a Co-developed-by or From: note) to certify the Developer's =
Certificate of Origin (DCO) myself?

Anyways this will likely be reworked based on the sahiko-bot =
recommendations to make regen not a regulator but a gpio that can be =
controlled by a separate regulator-fixed. This will also clarify/remove =
the "same meaning" statements and ambiguities.

Thanks and BR,
Nikolaus=
