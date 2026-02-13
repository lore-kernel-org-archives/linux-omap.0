Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD329CE9;
	Fri, 13 Feb 2026 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960861; cv=pass; b=UM6+0UEXzfpJ0/uY9P1M12rbAbMrWIZ3Nj51C4xmlLvwLD06r9VEpMWBwxfRmKxuWQb1be3tYY+gjkwRy64rHvfpPV4hwfa2gq2ass2Rk8HIUQC+e/wdI8UUMc6baS8DmRJmdbRZghQRN53LK4d4sMs4hjPlARM0hKKnhWmUODM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960861; c=relaxed/simple;
	bh=E0gQnviZKfBZBl+35onLQqA9d99Wl4wFIpJ+xenvVCo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LttGOyEbtlhlginr7MAyc6Zi184UKrQZ8Xy5Gvc+MfS9XlzAEkt586DuB3hsGKaQwD23jBgwm8iv0k+zzi5nim47HKZxJZXcdvM3WrS2ZeogStyVcpZzhkM2VugnUaOgooDN+zxjTossMnjA/v3rCpuhT/D8Zbh1EV6wV7IqHto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=WhJDdEin; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=v/DDwINB; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="WhJDdEin";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="v/DDwINB"
ARC-Seal: i=1; a=rsa-sha256; t=1770960839; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gnGSP7XBqFzhKVj9JBCmaNFbVQyX2TVmgA7490ha+uBZdGHnxu6W7AE8ga+hZQXW7D
    ksc5myr1mGcqCBwEFO1q+SltV7d0Np8XVOcOFiUVYUE6iUqgF3KtCZooB53I5Mp/mMsc
    YKqaSsix6iZZfLKqyVlJ+ijOfi8kzNvXNHIjQwzo7pXJBSJ+BABFqEQjW24UHfoPDh4b
    YE9EJwIxGi53NmHqR+GJImfZJjZMOeQTa+YSBaG1rccWubz+AlsEVz0N7nUjSNhmGNBc
    Kc5mBoz+Mr9TLJzXoWxGwTUqSNbG0MIIcNYoWqWJxzVAVHz+vuArDGSvHBzUJVBX8tc6
    J0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770960839;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=5YEwoFG2OaLSjd8Yl8JyESysYQ2pvDaXqlQbmK9OUVU=;
    b=WIcg/q71lCdX/NOhdCdnb7xUirNTmpH4YaEnMU6gBPy7kIg4O5bnzsdR6v7PlTX2Me
    eskEVgU2s8uOdU7ogFhXdY8d5p/JR1tENy43HGkO7nxf2B7B3IgRC1DjAGkoFbHi5Q4w
    m258fH60teuumO3eOqM4iW7bB8nCovi97Ku8NCO/qr/g6i5MFSH5QpnyD70kyQWktc8I
    MxFSjGVYsIQqwacWev7Yt43NT0LgZSHoFIrt4fen5E8Mfh/mc8L2+Pc1s1LVzKWvqhXm
    bE3IxlBI5TgdS0UVrDyYz3mqM0l/DCA8tluNnkyQDQJrkZmBU/1k2njMQhRgcPS3hV+m
    Omdg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770960839;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=5YEwoFG2OaLSjd8Yl8JyESysYQ2pvDaXqlQbmK9OUVU=;
    b=WhJDdEinlmCOH7tjMzGe3Wf3WYFeEQCybgpE97c1h9MpoK2Ewlp2ZVkkJw/yJuixdm
    A+dSrbaZuCCMj20zqzZmjBWEVxsQdGzCXd2QnCudO1ek7ZWm74jIKKVr3f5arDMxv1RX
    AXK+Obe7WzSAVefE6+aKLNq7ZGUIXC0S/nrcpOXel/O2Z7gqk+mapzCFlYbzBPcm8kq1
    HA155Fi4K3KoPATNGB3CSzEc09HkOWBqIu687ZIheZ3GecVcEU58NWZwnQRo/wgoquUS
    5UN6CI/FDzvPLgmrFPUhStZ7Mrq9Qft7IxZezekb2YILdm/EFSoFBLU0wvGJXbSSEVo6
    AAFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770960839;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=5YEwoFG2OaLSjd8Yl8JyESysYQ2pvDaXqlQbmK9OUVU=;
    b=v/DDwINB+0vQ4LL3/TCJecH2XW+VUC6T7quALpW1StFMJK3HkKmabY8vs5z+mP8PXo
    fowTgXLR0kirz+TtIZBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzsZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Q3a36b21D5XvW2c
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 13 Feb 2026 06:33:57 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260212231907.6120a2e2@kemnade.info>
Date: Fri, 13 Feb 2026 06:33:46 +0100
Cc: "Kory Maincent (TI)" <kory.maincent@bootlin.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D7424B6-2022-4B03-9B8C-455CD3E3FBF1@goldelico.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
 <20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
 <B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
 <20260212174718.7daccb70@kemnade.info>
 <719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
 <20260212231907.6120a2e2@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi,

> Am 12.02.2026 um 23:19 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Thu, 12 Feb 2026 17:55:43 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>>> Am 12.02.2026 um 17:47 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>=20
>>> On Thu, 12 Feb 2026 16:49:43 +0100
>>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>>=20
>>>>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI) =
<kory.maincent@bootlin.com>:
>>>>>=20
>>>>> Allow overlays to be applied to any DTB. This adds around ~40% to =
the
>>>>> total size of the DTB files on average.   =20
>>>>=20
>>>> Is this unconditionally enabled or can it be turned off by some =
CONFIG? We have
>>>> our own defconfig so I would not worry if if is enabled in =
omap2plus_defconfig
>>>> and disabled in ours.
>>>>=20
>>>> We have several devices where the boot loader can't handle overlays =
(never touch
>>>> a working boot-loader :) So this seems to only contribute to build =
and load time
>>>> without benefit.
>>>>=20
>>> As long as you do not add overlays, the bootloader does not care. I =
would
>>> like to simply carry around the 1-bit mmc overlay for one broken =
board.
>>> That would help me. So I think there is a benefit but nobody forces
>>> you to use it. =20
>>=20
>> Well, it does not force to use the really good feature, but it forces =
to add
>> ~40% more file size and some more compile time, if I understand it =
correctly.
>>=20
> Compile time, hardly measurable even if you just do make dtbs.
>=20
> Size on disk:
> a) if it lives around in a /boot partitions with kernels and initrams =
in it,
>   then we are around 1% more space needed.

Ah, I see. I was too focussed on the "adds around ~40% to the total size =
of the DTB files".

For the Letux arm distro all DTBs are around 8.1 MB at the moment so it =
will grow not that much
(there are non-TI devices included).

So you are right, it is ~1% of the total if the kernel image is counted.

Therefore, space should not be something we should be too concerned =
about (although I remember
discussions for driver code where every single byte did count).

On the other hand this increases load time from (sometimes slow) =C2=B5SD =
for a specific DTB by 40%.
That should at least be discussed.

BR,
Nikolaus=
