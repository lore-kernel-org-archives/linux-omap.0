Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795718296;
	b=SsUo5oIBjFsWRpHLb/JtlqAHahsJBwDoSZIQ0Q9gAahQNbVN1hMyt2aW0JulU7eftWKC
	 F0bJh4Jg91BSDhzhbWEk2vgpAyDiDWDdEO4H92WxK2VIdPQT0S8xPQXTJ8lklJ77fnIdQ
	 cSY76FFX1CNhDfNDGf/qcWh0dKDd5BkUIPQ+AsKnP1rBY5uSqTbN/rEo3pCotXHfdeEq7
	 v7GEme6IdV4mxuI3ldmZ2wnQrJBSiJfJMbd7asfhzqeTcur+URgWkoRa4q/T5DyG5mnfj
	 mHCH59qUxUETE/uI62gA8fO3zCvPQI9C3UCBsRI+rzy1gVPesEWoa/ZSETT869jWazw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795718296;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=NYe3fpJiKO8+IsXNE3ip4kByrEDJ+wWHRmGWym8cbdo=;
	b=lMLCaOkoTzzBAqRhcNwyM6YNILQVgpOJd09I34fyFptVCAqNdxe34IfuuzDv0I42wU+i
	 JRt+yYVXRO7OY17gPYshjwH0TGOpcpaXluaycFGvC6X2rUo4CeLVfG6ObR9j09zqwdjss
	 VWuuw/eHMnRg5tZgP3wiNPAW1jYYeG5RiQEivUVt2lPK6K1BqkckE25RqbbuTakaIbOsY
	 ZhRpyK8NiSeX4RtoBgz0KI5NSBYsaN0NCoACDnrs731ny9EZar49X4Om4y4IX8Z6T/hKf
	 5cCNApPo98nrm9EQV1t1liccJpx7npH4CdObJ3BEDDbh+YnVHuTVbPJK0wfak50JLww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=M5X5HITu;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VsiAfvSh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83C606A327;
	Thu, 26 Nov 2026 18:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA83C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=M5X5HITu;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VsiAfvSh
ARC-Seal: i=1; a=rsa-sha256; t=1795718191; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J991VfTQxDV9HXTqDDuT+ttE7+L8zYNJmnh2n0bg29QdlQHeh7ymOY3PRDHsj4eMwk
    2V54jEX5K5A0iGS/d3TLeY/9m5usQ+f6QTIw7JA2V2LKTr6LHhybM84kCHrNq/+bbQzC
    vr/+6TlCxGEOZUTZqbPZ7N5TT/g+fErVdMg2wtjN1aa01pb2QcICY8M4zoeVStyGpli+
    mLTMh3kUaY+P8AjwE9Lbr4aG0HLqtk4fQeg0X+hhQ/i8eylRqlm7LIbxg8gG2bBn8NxY
    80B91p8OMusb2May46qmf/XwiDl0Y0+tJKbGb01AAOkfRxQGbQ7ckvKNZgyzwLxSGjrb
    e6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795718191;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NYe3fpJiKO8+IsXNE3ip4kByrEDJ+wWHRmGWym8cbdo=;
    b=g+IoJTz89+C1jquOfbCbjYnlDDOlOBjCOpL2E2hiZHiLieighaXdcSq5J53Grkq0Qa
    wmH+MPtZ29jJSK/Pv7DhYKxuoWTheGFVqY+EUh06hU6/LO2fCKMhdw80zR8RJwMRtgHx
    pMSPwBL7/gQ+MKvrkUEafypzmB0iBK4bFezt0pCROLZSxOx6kBK4rUyf6TPk25hdmuh3
    xAJX1+Hdx0QKEkpfssen7eNs1GXxdz6921aMzeofB8OmMsRcMMyhxxNr9+X59EWvDnKA
    h9il8RiIeFS2zd7kfTupI34TwBOC9sQOYdSwKTnUo8PJCDkn2+MOZq4rxlLyvqSayVUx
    iFvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795718191;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NYe3fpJiKO8+IsXNE3ip4kByrEDJ+wWHRmGWym8cbdo=;
    b=M5X5HITulfuTW6C706dwdeNdHxjT3tUE4Za+jZj/L94gV6qsfBCQ/I+1r7SCTdt1IJ
    5gxBwbYOxs1izTnJDyDVMwqKj8yP3qC8YTmc0U7fK72fILK8VGehvONy9BDQM5PbkQdx
    +KvsG1JYWm/hpJdX8EJ7NQPZmdj6j3sFIxXyPabDazYzV1zfq7PIePaX5vtna2+MMwph
    b3eCH9Tf4C0aW+olQTzEL6ypSXtMpM8MdR/brA1dDlmI+Jcb3HCfTjN+wnkeTyPnXiTX
    mv/TPdZuCoNDMuiY12JhjyojQ9Pkgcnw08nPzJiZzU5tlk9zcSuxYhqNZs6MaLqxtNsj
    Yc3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795718191;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NYe3fpJiKO8+IsXNE3ip4kByrEDJ+wWHRmGWym8cbdo=;
    b=VsiAfvShX038YzxMDGCBnWBKQXU15hM3/nec/5OEW9bdKrQ9KHQd68FEBeQVGf7Ad/
    cj633Nrf/Dh7UfLW9KAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrSippbmsiNApeHDyjDkvgGuStcrkeTGFmktdrc"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AQIaTEph
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 19:36:29 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.11\))
Subject: Re: [PATCH v2 06/20] dt-bindings: sound: Document OpenPandora sound
 card
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261126192036.6646c688@kemnade.info>
Date: Thu, 26 Nov 2026 19:35:58 +0100
Cc: linux-fbdev@vger.kernel.org,
 Lee Jones <lee@kernel.org>,
 linux-pwm@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 David Airlie <airlied@gmail.com>,
 linux-leds@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Helge Deller <deller@gmx.de>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Daniel Thompson <danielt@kernel.org>,
 devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Roger Quadros <rogerq@kernel.org>,
 linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 kernel@pyra-handheld.com,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0CDC9F92-70F4-43CF-BBAD-255D98465F64@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <5c6f7deca16f70f1f19cb40c57d70e30068d6000.1795505160.git.hns@goldelico.com>
 <20261124224300.519d8686@kemnade.info> <20261126192036.6646c688@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81.1.11)

Hi Andreas,

> Am 26.11.2026 um 19:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Tue, 24 Nov 2026 22:43:00 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
>> On Tue, 24 Nov 2026 08:25:46 +0100
>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>=20
>>> The OpenPandora audio subsystem describes the routing links between =
the
>>> OMAP3 McBSP interface, the external PCM1773 DAC, and the TWL4030 =
audio
>>> codec, alongside amplifiers and power supplies.
>>>=20
>> I think at least in some commit message should be commented why such
>> an interface is needed and the generic sound cards are not =
sufficient,

I think there was a specific reason as I would be happy to remove the =
board
specific driver as well. But I have to check.

>> also as a starting point to recheck that later if these reasons are =
still
>> valid.

Agreed, that at least a comment would be necessary.

>>=20
> To clarify a bit what I am talking about:
> there is e.g.
>=20
> =
https://lore.kernel.org/linux-omap/20261123-omap-mcbsp-tdm-slot-v2-0-3e3aa=
e215952@telaak.dev/
>=20
> which might be one piece of the puzzle.

Yes, it looks like it may be a piece of solution.

This should at least also be mentioned and checked if if it is applied =
upstream to rely on.

BR and thanks,
Nikolaus


