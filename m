Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468D30DD2C;
	Wed, 18 Feb 2026 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399723; cv=pass; b=K3Y0Og/rZxzXBHZkMWfEJ85qVMJ44YR0GUmu+p61RTzIuuwnX0qh1wwWfnBgNzchnu6KInR6o53CeGpUkhcd7YIiv2tC79+BZ+ET+MWzHITeQNpME8pWOiqPQrWkSluFcWfjfZF6E9BTaQ1vTw4qAmzFco7Q3vdA7katm2cY65Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399723; c=relaxed/simple;
	bh=szPjih8StXjtpoWpw5AU4Nh/8ZKCaGLIvtLe3Q7WVpM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oUGBYLYhQUuGluN4NucTSKw8c2NeNKvEU74YU+IO9WPc0VW5TyfBlluQjBsNBRl+QFzdFVGu1mQmHYeNy8kdwsERz0AuLgAs/+VmhoTGAGeztS90tsxn1SCLhvGhpP1kUewxjaAxekcH1FUWu72/8KJ8kfQeLKIjvsDqwjJlPnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=dPiOy1kD; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=8Y33m6qL; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dPiOy1kD";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="8Y33m6qL"
ARC-Seal: i=1; a=rsa-sha256; t=1771399700; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qlQTB35yqRaleZiARsUXNGgfLr7+6uDXK627aisjzVBk65OfF/HxSYKGa/Wd/7PJwT
    ib0nsaIeENa4U+SGqw249cJXec8IWHzPSSThrcdJfmJfXRs6Q+lGkxpM/Cytx4h2Mkcn
    BW2jWSHvq55tupo2t6dis8xVONLXQ9D3xidvoUebDImyN3S+6pw/pvztK9eI1URCAFIk
    73XMbpZHXYGAU4oL9eAYe8ynvRkfM2KXDWdlGpKFsGJoSSKczKLdejP1sd05kwi5zQn2
    BVNv0jGcKg4h8ksN+CityhpEwCDMkiPW1XG7ux8xJW9h8OZl/7eLhqqMkCKBbvQuc8qH
    XErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1771399700;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u86cw3tjl8hdVmS71Xuy45XeU5ZCNXcT6zOzax89Suw=;
    b=DCZKBR2FOOyS0qYuvpebUxS35GpI1uXZ8fAsmCY6FKUIltMb1YKwH3RwnNa0vh/egA
    oZmZJ8XIRXOVsZh9PrDR1mZHUscb1Jtshe4Up7jDYGyRLTVLGt/0ySv5FtpNGUX3k/Lb
    W75PWf7qHlkX7LDw+wefO1GDyNxXI/0XO22Gv4yUVlB7DtaUxD0s9LbbqYtG5er+6n17
    6vt+m7LsvK5iKblK7G1hHOGwV6P6pl/rPNMjeRHTBOxAfs8g2HDkDAcNThnT7RyO/2WF
    EUKP4vRz3C0JIm+Nkc3ojZ4yTnQpMO173sdX3wY7IblVyUrijE2R+Bs6VsPkMF1ntp0E
    QZ7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1771399700;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u86cw3tjl8hdVmS71Xuy45XeU5ZCNXcT6zOzax89Suw=;
    b=dPiOy1kD3OJQLdZeDi/510rxp3uOjpwjlhbgAP4+BRwPGHumfotxrJ8P2W5AdNUgJd
    9Xua+Loxfvp7/XbVPMF3DzbR0iNRT7y+RQ+q22kD5FLLzr1AuW++UPQSYuVv2nMbeMwX
    tijWmkFKDlswd0ABYEfuN4W9uzgtapfCyJcP77pBVovvUhgSFhzmaXpJPu2vPJWRISSX
    TLn0vmlxGPXtJgRDlhOl/g3Kj7sv/P4eJs6fJj4/6NeTXu+xJ6tf/T7kSR4sGus99J5J
    WoJQRYXKRmudbzlmursTwTCsEe5Ek2aEWLFxJznDpTX9VyNI/w8czSqTuKqmvRRSf0LI
    ZjRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1771399700;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=u86cw3tjl8hdVmS71Xuy45XeU5ZCNXcT6zOzax89Suw=;
    b=8Y33m6qLBiNtqtrUtnJK+4LKyYvRmzP/2O5N0XA5jzP5BRRcwbAvs0E220qraSoWH9
    398tRVTxaXqSWk4DQSBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeDAZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Q3a36b21I7SHJkR
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 18 Feb 2026 08:28:17 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH 1/5] ARM: dts: ti: Enable overlays for all DTB files
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260217103638.30149f16@kmaincent-XPS-13-7390>
Date: Wed, 18 Feb 2026 08:28:06 +0100
Cc: Robert Nelson <robertcnelson@gmail.com>,
 Andreas Kemnade <andreas@kemnade.info>,
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
Message-Id: <FDFC6C9E-710B-4723-A453-5CAE25CBBC1B@goldelico.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
 <20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
 <B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
 <20260212174718.7daccb70@kemnade.info>
 <719BF710-26DF-49AB-A016-D2306F0389E2@goldelico.com>
 <20260212231907.6120a2e2@kemnade.info>
 <CAOCHtYicmeSzH5Q2_qTwAZw3s+__JRwUrXvz01+KCsJJHAznUw@mail.gmail.com>
 <20260216161155.09fae580@kmaincent-XPS-13-7390>
 <0EE0658D-56A7-480C-BF71-6B2EB81DC41C@goldelico.com>
 <20260217103638.30149f16@kmaincent-XPS-13-7390>
To: Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi Kory,

> Am 17.02.2026 um 10:36 schrieb Kory Maincent =
<kory.maincent@bootlin.com>:
>=20
> On Tue, 17 Feb 2026 09:58:04 +0100
> H. Nikolaus Schaller <hns@goldelico.com> wrote:
>=20
>> Hi Kory,
>>=20
>>> Am 16.02.2026 um 16:11 schrieb Kory Maincent =
<kory.maincent@bootlin.com>:
>>>=20
>>>>>>>=20
>>>>>>>>> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI)
>>>>>>>>> <kory.maincent@bootlin.com>:
>>>>>>>>>=20
>>>>>>>>> Allow overlays to be applied to any DTB. This adds around ~40% =
to the
>>>>>>>>> total size of the DTB files on average.   =20
>>>=20
>>> Yes, I will move on to this solution for now to avoid too many =
complaints
>>> about the devicetree size increases. =20
>>=20
>> I have done some experimentation with this patch (on top of v6.19 and =
our
>> private defconfig) but could not find any DTB size increase.
>>=20
>> Does it require another patch or CONFIG change?
>=20
> No, but maybe you had already the "DTC_FLAGS=3D-@" option enabled =
while building
> you image.
> This options add the "__symbols__" node listing the symbols to the =
built
> devicetree:
> $ fdtdump arch/arm/boot/dts/ti/omap/am335x-bonegreen-eco.dtb =
2>/dev/null | grep symbols

Yes, indeed there is a __symbols__ node in all .dtb I have checked.

With make V=3D1 (on v6.19.0 + some local extensions) I see

./scripts/dtc/dtc -o arch/arm/boot/dts/ti/omap/am335x-bonegreen.dtb -b 0 =
-iarch/arm/boot/dts/ti/omap/ -i./scripts/dtc/include-prefixes =
-Wno-interrupt_provider --symbol -Wno-unique_unit_address =
-Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size =
-Wno-alias_paths -Wno-graph_child_address -Wno-simple_bus_reg   =
-Wno-unique_unit_address -Wno-unit_address_vs_reg =
-Wno-avoid_unnecessary_addr_size -Wno-alias_paths =
-Wno-graph_child_address -Wno-interrupt_map -Wno-simple_bus_reg   -d =
arch/arm/boot/dts/ti/omap/.am335x-bonegreen.dtb.d.dtc.tmp =
arch/arm/boot/dts/ti/omap/.am335x-bonegreen.dtb.dts.tmp

So --symbol is already included, even without your patch.

With your patch I see:

./scripts/dtc/dtc -o arch/arm/boot/dts/ti/omap/am335x-bonegreen.dtb -b 0 =
-iarch/arm/boot/dts/ti/omap/ -i./scripts/dtc/include-prefixes -@ =
-Wno-interrupt_provider --symbol -Wno-unique_unit_address =
-Wno-unit_address_vs_reg -Wno-avoid_unnecessary_addr_size =
-Wno-alias_paths -Wno-graph_child_address -Wno-simple_bus_reg   =
-Wno-unique_unit_address -Wno-unit_address_vs_reg =
-Wno-avoid_unnecessary_addr_size -Wno-alias_paths =
-Wno-graph_child_address -Wno-interrupt_map -Wno-simple_bus_reg   -d =
arch/arm/boot/dts/ti/omap/.am335x-bonegreen.dtb.d.dtc.tmp =
arch/arm/boot/dts/ti/omap/.am335x-bonegreen.dtb.dts.tmp

Here we have -@ and --symbol (synonyms for dtc).

Well, I finally could trace it down to a malicious infection of our =
LetuxOS tree
by some ODROID kernel patch to scripts/Makefile.lib (0ac84640f12c). That =
patch
globally modifies the DTC_FLAGS mechanism and permanently adds --symbol =
instead of adding
-@ in the arch/board specific Makefile like you propose here.

So now I know why I didn't see any increase in size (because it was =
never reduced).

With removing this I now get 67179 bytes as default for =
am335x-bonegreen.dtb.
And with your patch I get (back) to 94260 bytes so I can confirm a 40.3% =
increase.

Please proceed as planned (I don't think it necessarily has to be =
limited to
motherboards with an expansion card system, although that would be a =
good
indication of its usefulness), and thank you for bringing our local =
issue
to my attention.

BR and thanks,
Nikolaus


