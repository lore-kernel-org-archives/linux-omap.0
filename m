Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C13644CA;
	Mon, 10 Aug 2026 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395504; cv=pass; b=ZLUuMggZoXVqnhCxz6F2lP91Elm0VAVL9BqAU69QrFtcdHHv2ejDJ48aZhdXnMuo0U3ZuPgQdZPK3vITJvD06XVWj69WKewKsz/h9aXBo6TzHjF3haES2aFS0JtnSnOzxuOmc+vO9pv7wlpFxyGiUda1EnUzA3ixSDdzT0AA+rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395504; c=relaxed/simple;
	bh=M2b0s5sV+UlmrYlU5mF5+QdMgIVz6hWvd8/C7SfZBcE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MF89f/CQqsJCvL4xNkEZydCPdRRH/eD5nEee10JVBOIVpprFCO6vd3m4FuLWSO5g5vRzFfDzAfXCf2bTQaGCuV50j4af02G458V++Hzcsj39zsJKsoYsdKXlcF9FXm4w187gGR4ZAgnlxRPrMLkm0bvr0TYQccvO4qnKPl7An4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=PsP/bxV0; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=ol9sAKua; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="PsP/bxV0";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ol9sAKua"
ARC-Seal: i=1; a=rsa-sha256; t=1786395414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=t2BQl9Z8KeurTNXDux1Cx0A8Bjn5K0igXQw7bigsJM3q6Fu18PGX6fQ8shpduQ2qp9
    kojVa+x45LQPfZEA7f21vmALVD24IAPFWurY/6pZjrRMtWvkYIWYRxp6gKPf+fLOGsSl
    kVsyrHPDywUYKyqNnyR9GXUPh19Yz1q6Gqukf+lmS9AnuahB/U1XVVZKSS0hLRmaqCkE
    0N9c9YRybc2rxxFMk31QEfKmbi869/LgVytFIpDjRQnEkDQaa6uBwwiQom/I2JaRLoEo
    HKsxaYV0a401CR32Zo4qSYOLi1oTrRJyJBpWn4BiGW6G0SOuZGtogL9eW4MayGFUM5NT
    LR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786395414;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M2b0s5sV+UlmrYlU5mF5+QdMgIVz6hWvd8/C7SfZBcE=;
    b=Dwyj4QBN67/T9pzAOzwI1/AJhjzygobZHUmTcKODeVjNNEWKSV73ese/v4lua+h54C
    IoGUXYfXo1dcUm6YCznSLE5tI2CwV5ca4KM+zS4VK4uVDykY+/5TW/lSMxDCkmTFd329
    aHnbS5D6ENGua0gnvcq6s96Tp3XMeRV4H2ichflsdisgRE01IPVSdqL79XlpTDEAXg12
    efmtlwOw9200KHv86Zp3TLhuxI8zUdS8mnTPzmwM1Sec0g8zCfBsTIZ3vG7RmmcHcxvK
    tPTphRF5vVjbqPstelrDB1lv/Csoj//SX/yYxh/qQf23AX4v4YY7pFx7k5BuQfC3DPzy
    7OXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786395414;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M2b0s5sV+UlmrYlU5mF5+QdMgIVz6hWvd8/C7SfZBcE=;
    b=PsP/bxV0DkARdQeMAEKbfJPJg42HksHI8mlHtlKGDLalnkZ7cIXtbWwJ8LdE7DB99M
    IIfb2bPHCNo1n8eCFg3PDJO55f0wEdVCy4Hlj8e9VrqLUhmh+LPpel1ZHgOBjIfR2WXF
    5DV01vxRyuEGon6/1hhSINkJRmXOOTeKgrhyjj5VVzKXcz4fRAUawT+xQLdsxJxX+1K9
    qHY3mrD4msgpzTNz6d8JL36TJcOrnyYROQ2y6rtb6lYNmnmlSe7AtpWh31Og8Do3WDBX
    pMTRi48cpor8XLotO1HUL59BLznYwONrDYakOLuV9NNlZRVJDj1yyMUzFkSLgHvFK6G0
    OJIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786395414;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=M2b0s5sV+UlmrYlU5mF5+QdMgIVz6hWvd8/C7SfZBcE=;
    b=ol9sAKuaZNHWsPcZa7fLcth6fUGMED5C+eqhENktvwwMT/CtFPT0K86CugHMLpZSaJ
    zfejHdUcnNxS2MSRKNAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrTipoGmsiNZ9v/oGyp26o/Wi+pVFrZX1Db5b3z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id Q58eac27AKuqiaO
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 10 Aug 2026 22:56:52 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [Letux-kernel] [PATCH 15/16] backlight: remove pandora_bl
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260810223413.01af9a6d@kemnade.info>
Date: Mon, 10 Aug 2026 22:56:41 +0200
Cc: linux-fbdev@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 dri-devel@lists.freedesktop.org,
 Niranjan H Y <niranjan.hy@ti.com>,
 Sen Wang <sen@ti.com>,
 Rob Herring <robh@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Helge Deller <deller@gmx.de>,
 Lee Jones <lee@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 linux-omap@vger.kernel.org,
 Daniel Thompson <danielt@kernel.org>,
 Grazvydas Ignotas <notasas@gmail.com>,
 devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 mfd@lists.linux.dev,
 linux-sound@vger.kernel.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 linux-arm-kernel@lists.infradead.org,
 Roger Quadros <rogerq@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 kernel@pyra-handheld.com,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38ED9D73-7BF3-4005-8E1C-4F7125906A20@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <f897f695c0e1e128d7ebb41be8dfdce4d634f552.1783749722.git.hns@goldelico.com>
 <anmpiADsvzW39DNx@aspen.lan>
 <DA9588C6-0238-4713-B1A1-CB2123F02028@goldelico.com>
 <20260810143914.64d29a5c@kemnade.info>
 <2C9844A3-3C4C-48E6-863D-BF8328CEE540@goldelico.com>
 <92FE1162-8C61-4186-B073-6AB4B2BDA640@goldelico.com>
 <20260810223413.01af9a6d@kemnade.info>
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)



> Am 10.08.2026 um 22:34 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Mon, 10 Aug 2026 20:30:13 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>>>=20
>>> Yes that is what I mean. It needs to be ported somewhere. If it can =
be ported to
>>> some compatible =3D "pwm_bl_for_tps61161" or what fits best it will =
be fine. Or it
>>> could be in some compatible =3D "pandora_bl" driver.
>>>=20
>>> Has to be worked out when the development machines are not blocked =
by 3 or 4 other
>>> projects already running in parallel :) =20
>>=20
>> Nevertheless I did a quick look into the pandora_bl driver structure.
>>=20
>> Here are my findings:
>> - the code fragment is part of pandora_backlight_update_status()
>> - priv->old_state remembers if brighness was set to 0 or not
>> - so this code triggers on any change from bright =3D 0 to bright > 0
>> - the pandora_bl driver is the only one to use TWL_MODULE_PWM besides =
twl-pwm
>>=20
>> So the most natural way of transplanting this appears to me:
>> - add this logic to the twl-pwm driver
>=20
> That chip could be connected to any pwm driver, so
> it does not make sense to have that in a pwm driver.

Well, the chip does not need a driver, at all - at least in PWM case.
The missing piece is just about doing proper startup into PWM mode.

> So it belongs into a backlight driver.

Interesting how contrary requirements can be judged :) Especially
for such simple things that apparently even work without any driver.

> And since it shared so much
> code with the pwm_bl, it could be extended.

But how do you give the chip driver access to twl4030 registers?
Or make it universal so that it works on any PWM generator? Any ideas?

> The compatible should have pwm in the name to be able to also add
> a w1 driver later.

Ok, that is an argument to be considered.

But: for multi-protocol chips (think of SPI and I2C) there are
usually two drivers (or glue code for a core driver) for each
protocol. So we can have one driver when connected to PWM and
another being an EasyScale (which is not the standard one-wire
protocol) driver.

BTW: I am still not convinced that the chip needs an EasyScale
client driver at all. The protocol is similar to an UART with
fixed bit format. So this rather needs a generic host driver. Not a
client driver. Something like baclkight levels -> easy-scale.
Then you can connect any compatible chip.

But even in this case the hardware connection requires you to
patch or piggy-back that into the twl4030 pwm driver because that
is the connection given by the Pandora hardware.

So why not generating the simple startup sequence in the PWM driver?
KISS...

BR,
Nikolaus

