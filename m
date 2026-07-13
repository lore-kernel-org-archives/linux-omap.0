Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3407F324B22;
	Mon, 13 Jul 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935582; cv=pass; b=dqVsOKSSdu8l3BcD5b2HFJm0U6VmwdgQwca9zWqqXLYhNVkBXqvZ/fHUHIdX71EULbFKiLsz83Eq6eFGDRELuqRlB9h87lGQMoESd2AwIMLkBRtTyKp0Cp8TQuLmnqPL7bZwgzdu9Oun555N26MfIZTKNZDAZyLrO6yZBiaJIME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935582; c=relaxed/simple;
	bh=hnhHYznYw4U+dJX7Gr1QJFYbWAhkfB84VU99JrG/Yvg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C+JfKRKGzThj/wTpIButSAxLK86pPwPyELhvSqvEHS0fEycSIf33/YHEHezD1J6uzicnoF0ZEVJmfzHTdfOeQ7u/Ex5xH6Oh56wdkp+PyAagpIdmzzjst+jGuyDbN+2ka7egqO+8TANVvfqePs+UPc1zoTlRDU1DJMWpKY4F6Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=GR+pzhec; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=dC8bNf8x; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GR+pzhec";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dC8bNf8x"
ARC-Seal: i=1; a=rsa-sha256; t=1783935395; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dP7OcmRnbwhCBH1RoJu0txmmrfPY1oppMgEqp052JfsHPADq+XQmroimpG/Bcd1tQ2
    XkUF8sIltV3UbQKKEVvwnPLPY1isrhIkqM8+BH0cNyuMJZ647KC/9j9akGQwGMCBMDGY
    2CHTazeGLdAOb7z1EvGSIL7q01ddxCVu4eWk3cW7Sic7J68wL72vEu8Eeg9L22dsd7kr
    etviG/LUL9RVSvHOKzFhBrGA4lnscNb9P6f71d62ArlACy+3r7ukkTQT4eoJpUrSDNgw
    BtVpqhFeiFQAt2Pf1ney1jGlCAQrTdHz+3k59/QNUxwbzbZCjP8wW0ukq9DpUu2zp/4X
    z5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783935395;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=hnhHYznYw4U+dJX7Gr1QJFYbWAhkfB84VU99JrG/Yvg=;
    b=i4ylZOSETHOTtxTdM6FHIyJqoa1k5j8HFL1QUpsJGOci28Q7PDUR47wd+g173HWoYh
    VvbTln2Babj6qzPodSTUnafD3yN6AJhAx4KjjalBC8DHfJTIAcRWPe+wh1jjsU1E6goG
    izTHi4psfYWBT47tHAfOn3ELPpq8/C+DQJDkOidIP7nEKDyzdb6wowVAmh1Bka5LPI0/
    O8ncVDwXSEGbj2Zv74GkKZOnwq3A7KKo8SVfpUFMbg+oJUjkbxpuCnoTxSk2QqfAY0zD
    JtjXfC3phLcUTla7szaN/zyMiNf/uReytyKl8PVt0JS/1yuJ0uOvLvZjVK527lvGHzbp
    dq3w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783935395;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=hnhHYznYw4U+dJX7Gr1QJFYbWAhkfB84VU99JrG/Yvg=;
    b=GR+pzhecddLYFJZMc2TkGjkjxgc7DC0nZFR03CQdi+czSfM6pxlv/3KTMXQCGBNz9z
    BcJuwmMD+eyqm9Gq96U9Fgny+Gkd9td1wnpUYRaXIzGjKFDXgR5JWNkkx97bxd9NdKmR
    Ot6Nnogfl9XsMNwLcZPqnbQVo/77HbxfxrQMnIKbOhLUaM6FOKFU4PK0y0GH6QK9j1bQ
    UGAG2tZ+xAvYFn3dJmvoVnJElakBDEcUMsjRQbukdeJIJKoDJ7yy7O/+QHBTfCO6Sz7d
    wdafVe+iE9kJ4weOtCaj5gKcOGg1HmTshPDlA0BsSTq0U6xEQ4jqfgwRlttZHIn658vQ
    O3ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783935395;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=hnhHYznYw4U+dJX7Gr1QJFYbWAhkfB84VU99JrG/Yvg=;
    b=dC8bNf8xW+rX8n44wt9DVlrzvORrz9yJLqjhY6lCP6awzocEeb+ilJ8db4Rk1zkHNL
    Mg/Z3iyLc5JCNkCNZiDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQi5pZlciNgDl2kEp5oHJ2/c57N2Mc49IfXTKd"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q4b76426D9aXNNi
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 13 Jul 2026 11:36:33 +0200 (CEST)
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
In-Reply-To: <17497012-97d8-4c52-89b8-f433179f1eda@kernel.org>
Date: Mon, 13 Jul 2026 11:36:23 +0200
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
Message-Id: <CA2C7052-43D0-411C-8556-26228EB6FEC2@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <00718b18253a764c2a7c9a2b95c3b8c411796583.1783749722.git.hns@goldelico.com>
 <20260713-aquatic-memorable-griffin-cf9e46@quoll>
 <3D58F644-3EAA-4BE7-88FB-1DCEAE7D5768@goldelico.com>
 <17497012-97d8-4c52-89b8-f433179f1eda@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)



> Am 13.07.2026 um 11:19 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On 13/07/2026 10:26, H. Nikolaus Schaller wrote:
>> Hi Krzysztof,
>>=20
>> Thank you for the feedback.
>>=20
>>> Am 13.07.2026 um 09:39 schrieb Krzysztof Kozlowski =
<krzk@kernel.org>:
>>>=20
>>> On Sat, Jul 11, 2026 at 08:01:48AM +0200, H. Nikolaus Schaller =
wrote:
>>>> From: Grond <grond66@riseup.net>
>>>>=20
>>>=20
>>>>=20
>>>> Signed-off-by: Grond <grond66@riseup.net>
>>>=20
>>> As explicitly written in submitting patches: we do not take =
anonymous
>>> contributions.
>>=20
>> Thanks for pointing this out. In more than 10 years of contributing, =
I actually have never run into this specific issue before.
>>=20
>> To give some context: this is a contribution we received on our =
mailing list about 5 years ago. We do not know the author personally, =
but the code looks good and has been thoroughly tested by us. I kept =
their Signed-off-by because I didn't want to falsely claim authorship.
>=20
> Take the authorship. You are allowed to do that by both DCO and common
> sense (you are not doing something immoral, unless author shows
> interest/hints to fix it by themself).

Ok, let's give him some days to respond. Thanks for the procedure
to resolve a potential deadlock.

>=20
> Commit msg also needs fixing/rewriting.
>=20
> Beside, one more nit since there will be a new version:
>=20
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.

Ok.

> Best regards,
> Krzysztof


