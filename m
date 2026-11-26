Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702938;
	b=xY2sPdIGpwMXN2Kyz5/GavuaoMqOYL0CWB4tBOxjCoNvq2EyYuoeu0riSWM5FCPaaGvR
	 L8jsJ1A2Q5yWf6AXi7/dPUouXK65P4KzC6ACqQ2F6OTt91gEGDMrGOezaqfwf1Uk40iQD
	 CLYB2DHIM+cRETe7qA24QkwJObTYsBfjTwmLBwlj3kQDexzBxbmlve3SXenlj/z/VQh8I
	 7Yin3S7HkcxjBYqxNKTt+DzgnP/aienMSnUe2+S249cmlWHTGzLxH6Ftom9HNNK8uNgLp
	 ESqgMkoh5ddmhthBoo0XcfpIOBNwftQExz/KFub4PZM23IFk+ysEezFv/7XfduX7epg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702938;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=rc/TYdeU5IR4Vo0cju9KmA15ddxtIBbmbow4xSEBeJ4=;
	b=VOx1HI5YaJtQG8UOwmTd0gYlxvlboeSyFx3aSCdj4lqLnZGaICMChbBtkXuQUVmy/gZL
	 mAHSqfG83l12SXnSqNr/HXNqQ5KvSitXhgZtjVF7IiRQs+ktZAEd8Udh+f3cjT+DmwnPz
	 iP6GFyiWDdD+XYwzcKMQDUCtMCqVXBtlQss7qzZkQcVq0BJud/PIw/+6LZkVDf8ROG5Bz
	 Wt/MAHXG90TcpsAkM1xgK0lcZJ+uV19xN9WGErHNsMzr2qwrW0TnN6FL+Pi9jrpPoSntH
	 fld4gWqpzvvamJwALRxub1a3dU2gi37my0gUGUx8/NTuqJTU4MzTZa+rJHZpOycpE1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="o9P+JSh/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4949606A31C
	for <linux-omap@vger.kernel.org>; Thu, 26 Nov 2026 14:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4949606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=o9P+JSh/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A2361A1819;
	Thu, 26 Nov 2026 14:22:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45F39604ED;
	Thu, 26 Nov 2026 14:22:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F75D11E683F6;
	Thu, 26 Nov 2026 15:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795702930; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rc/TYdeU5IR4Vo0cju9KmA15ddxtIBbmbow4xSEBeJ4=;
	b=o9P+JSh/UvepDTqv6kgAO7l6pgXEpuPjJhyDSWMt9sWFwFK3b+xbDLjQCy8nbs6UpMlVff
	YqkeHLM5REUJBR/UCQWcSBz44N1IiSVStgm0BdtzDDQBRvkXFXyCKq4FfmR6neY8OIUsSL
	/BshhrGGWRjCAI1T79w+cwaLK4Ap8otPFPjNd/h/CEu4ATau3a5RsO2umMqv24IjxTY/5V
	CrwHkGDmnhAxcDFu/t6I3cin7rRyYFYoO72XrGTYIjLFB4RC3aE+ENiNQsZT+rHoYFKrHf
	wd76miVsKZpG9V+MPZ3SUVXsBf9yFBL5vXWtH+ANMWsOdAuYDfbSfYGvNcjlwQ==
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 15:22:05 +0100
Message-Id: <DN57K7KTZK8P.1M20MF8V8E3U7@bootlin.com>
Cc: "Bo Mellberg" <bo.mellberg@se.com>, "Ravi Gunasekaran"
 <r-gunasekaran@ti.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>, "Pascal Eberhard"
 <pascal.eberhard@se.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: enable MDIO
 manual mode for AM62PX
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Paul Louvel (Schneider Electric)" <paul.louvel@bootlin.com>, "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
In-Reply-To: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Adding Pascal in the thread.

On Wed Nov 25, 2026 at 4:08 PM CET, Paul Louvel (Schneider Electric) wrote:
> The problem described in Errata i2329 also affect the TI AM62PX SoC,
> despite not being listed in the following document:
>
> https://www.ti.com/lit/er/sprz574b/sprz574b.pdf
>
> Add it to the structure that enables MDIO manual mode.
>
> Link: https://e2e.ti.com/support/processors-group/processors/f/processors=
-forum/1647576/am62p-external-switch-connectivity-problems
> Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
> ---
>  drivers/net/ethernet/ti/davinci_mdio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/etherne=
t/ti/davinci_mdio.c
> index c413887657e9..9b58ba7acc4f 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -505,6 +505,7 @@ static const struct k3_mdio_soc_data am65_mdio_soc_da=
ta =3D {
> =20
>  static const struct soc_device_attribute k3_mdio_socinfo[] =3D {
>  	{ .family =3D "AM62X", .data =3D &am65_mdio_soc_data },
> +	{ .family =3D "AM62PX", .data =3D &am65_mdio_soc_data },
>  	{ .family =3D "AM64X", .data =3D &am65_mdio_soc_data },
>  	{ .family =3D "AM65X", .data =3D &am65_mdio_soc_data },
>  	{ .family =3D "J7200", .data =3D &am65_mdio_soc_data },
>
> ---
> base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
> change-id: 20261125-am62p-mdio-bitbang-1092530ef9a0
>
> Best regards,
> -- =20
> Paul Louvel, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

