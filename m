Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9754A21;
	Thu, 12 Feb 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911583; cv=pass; b=XIzk6x67ckj4i2hOCHRyzG5TCnzsImVPGd69H4UfP0HHm+nALb/Vpxa/kaxtq5keOJwqccguiaKrGbdrruI3QPhI7lifpc2wCPFBBjbcEWL4934H8PYhQuLzkZh6i3pjRrPxEFJL0MhATjAbiTsNeGaPrqCe6NmxOvrMpsyAuC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911583; c=relaxed/simple;
	bh=MJCNIdsXgOqoDULdSr1unLlWeh32HgM31dUI13xFAEA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wv+npVpj4bxu/87aSacrB7PnlJSZRk0XZ+o6Zq1ynT3wRP4cALmTyNGLZ1Zxn/Q6uu8SnwjjxzSO3lXR3V396zV0UX8CQ3+HNfuVoVmyL9UP1Xfh6U4h06QEhBzQ6uQ4plH38HrjeLpypVAUe33DQMmHxJ8QdiCl6V3j/ZcO3RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=kql0YCEN; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=vmZv9KJC; arc=pass smtp.client-ip=85.215.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="kql0YCEN";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="vmZv9KJC"
ARC-Seal: i=1; a=rsa-sha256; t=1770911396; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MJuNzbw+KGVIkKLyIu7zA0IPd2dbYRhZA/u4N8qRGspt7RLRcvxbP2CIMOfhw7FUkc
    kpSno87c4Uqs5XJs9JcsjGsXgC/aP67dLD1bGE1sbdy9iNpcxsCYN1teSrpPxEz/s06p
    7ksPQlGN9KaNU/OQIQ7JQMRqMxblUu5tdaqjIsWVkU53QSPgHoucolGrhHSxyM8gGB6S
    4jD8P1aLex4jMmKwMtPr4RN1Hw1Y9jS8yry8mlaUXLSX+WOSD11kVw7rnE2MSJbCyQWq
    cUhSPMAvZNI/gqNoe3IepyDTI1YPFiTDyQzCrBdVOsQqKmDLrfsHqRxYFz6DgEpBHVpd
    AyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770911396;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MJCNIdsXgOqoDULdSr1unLlWeh32HgM31dUI13xFAEA=;
    b=NpCZvS5RjsPvlUIgBVzpNMK8eXMDy26FJaCgZvk+gVW9ppc0XvizdzT5hmf50bDe0u
    gBcRT8H7peb76eg5l2yKcI11kfhbLGOA+AKzwZZ9RzQZk+32Kj+vdxAeaty+O6RL8evs
    YxF6+3ms/VCKaf/sJxroe9wZhprJJ58gBWOFrP+RGGThin3YXyDlWIB5zEx18lPHHLDX
    Dt0HBbF1jY3vshFzY3UBP6hqeSRknxAZj758OYb5ghk0In1gVZM3af4jZsLcbAd63dkK
    khtd79xIaXm+v2hjBx76jh5uNJlcZQ8uPQdk+zgVfF7es0u6PLnD6bwjSoi+zDmmfnz7
    5fGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1770911396;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MJCNIdsXgOqoDULdSr1unLlWeh32HgM31dUI13xFAEA=;
    b=kql0YCEN2/Lix3x+4eNp7G3f0ERH3oxYKxK1s2gy4XVcmORuS93yFNxe8QppBI0dJi
    Korkh7NOilUYSJDLpcQ7+hmm3miGIqWQFoFzVFwSe3GT5rEHgBO44rCiO+xkqCGDXjnZ
    uYbxaS9ml/fmLRdN9KpCy2cLIfj9RBHG1UdColLG/gdGku2MixAHtj3tVKskN9pvvph1
    rZSXppRH36g/Fg/3ho/Z5NRApMGvJxTzwty0FSMxd6jsusETX3h0LBGfHmMOrl9bZ/9y
    K+7IjWGe6yTszGQ6VqCuvj0agDlNBTztYvi2dHUEMFK+2jruecEkH2UW06d3pEGPd+LE
    wAzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1770911396;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=MJCNIdsXgOqoDULdSr1unLlWeh32HgM31dUI13xFAEA=;
    b=vmZv9KJC5D/I/e97tUyq+SF7Oz3aJFr0vo5Fy1RA0UAURJXUr9YBtlmtTb2GWcjsiz
    EeJVRmMJUewIU4/NrODg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yfzkZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Q3a36b21CFnsQZJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 12 Feb 2026 16:49:54 +0100 (CET)
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
In-Reply-To: <20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
Date: Thu, 12 Feb 2026 16:49:43 +0100
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
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
Message-Id: <B3366A17-641F-4E02-A5D4-978F525E0A96@goldelico.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
 <20260212-feature_bbge-v1-1-29014a212f35@bootlin.com>
To: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> Am 12.02.2026 um 16:26 schrieb Kory Maincent (TI) =
<kory.maincent@bootlin.com>:
>=20
> Allow overlays to be applied to any DTB. This adds around ~40% to the
> total size of the DTB files on average.

Is this unconditionally enabled or can it be turned off by some CONFIG? =
We have
our own defconfig so I would not worry if if is enabled in =
omap2plus_defconfig
and disabled in ours.

We have several devices where the boot loader can't handle overlays =
(never touch
a working boot-loader :) So this seems to only contribute to build and =
load time
without benefit.

BR,
Nikolaus=
