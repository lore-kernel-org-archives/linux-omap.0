Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330138CFE9
	for <linux-omap@vger.kernel.org>; Mon,  2 Mar 2026 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445035; cv=none; b=YNL6xgT4y6/nAVIbsMQVG3rLHdsA87HsnFMt+yXJHzJ46kEUQ8BT18BOl6ZIQgqJeelgudAjsWPifn3/osfLDY5Idf2ipREvuJIEMD+OcBMymSmqhXTKZ74UFnDdJE+7G6sEEYF42IjrczJvbt8BT9qTHhs0TSYexUI4jJsz5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445035; c=relaxed/simple;
	bh=NyMfMtRhobnbhhTa8wxHG744/QHuGG5OUzKRNx7qLZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4J0ELGRr1LkIZKBR5JG3NqwU8bIHzWVO5WdnpTySBqonMqCxsFX/o37Rz5IeYYfUuPzGH1l+E/5S6VNcPw28soDLEcAzDuDcV1pebdECrF+ioNesoes5d2HYvJ5SB8HLQ9KnCDys9bF3mR0vCWrJnkXmbHd6J8lxyu0PIXUnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yy9nuxvi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yy9nuxvi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 43B26C40F86;
	Mon,  2 Mar 2026 09:50:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFC905FE89;
	Mon,  2 Mar 2026 09:50:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF7B10369541;
	Mon,  2 Mar 2026 10:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772445030; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NyMfMtRhobnbhhTa8wxHG744/QHuGG5OUzKRNx7qLZs=;
	b=yy9nuxvixIDkfdT6D+bnnZJLkfisrqHiiN9ObFZNYi8zyLqZIbNFiGVAYCX1Ut/dpDCuk7
	sUfHqMKMg8/sstMsgtB4MeOVqPWHw9nAF57/niUYYK9qmQDrr9fEPUfTrvDy0YyVGdXINX
	iPqeHF7ANoUv0COIn4C6sDSuadT5NOMVjyo4Q7F1l2V+t6NhxUI+aJAUuw6Ug5isqa8+UQ
	QRgfwtQ57T33DhKSnhkTZ/Ei82FoU4v3wxCBBHWOcM0QrzoAGI9LMMje78O+iitxOOcvSR
	NQZze6x4HJIYYvfj/oIBCVBs9tsS7wPCMSV99WQZ5u4vAEnGaDNtFxVrQUKrhw==
Date: Mon, 2 Mar 2026 10:50:21 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 0/3] Add support for Seeed Studio BeagleBone HDMI
 cape overlay
Message-ID: <20260302105021.400b9621@kmaincent-XPS-13-7390>
In-Reply-To: <20260216-feature_bbge-v2-0-22805cfdbf62@bootlin.com>
References: <20260216-feature_bbge-v2-0-22805cfdbf62@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Mon, 16 Feb 2026 17:55:51 +0100
"Kory Maincent (TI)" <kory.maincent@bootlin.com> wrote:

> Add devicetree overlay for the Seeed Studio BeagleBone HDMI cape, which
> provides HDMI output via an ITE IT66121 HDMI bridge and audio support
> through McASP.
>=20
> https://www.seeedstudio.com/Seeed-Studio-BeagleBoner-Green-HDMI-Cape.html
>=20
> This overlay requires the recent tilcdc cleanup patch series that was mer=
ged
> to drm-misc-next to function properly:
> https://lore.kernel.org/lkml/20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bo=
otlin.com/
>=20
> With this DRM tree dependency I don't know if this series should land in
> DRM tree or in OMAP tree.

Any new on this patch series? After a few internal discussions I think it s=
hould
land in OMAP tree.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
