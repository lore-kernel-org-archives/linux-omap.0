Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770122;
	b=nSw2/Kq+QnUaSIpBdrMPEdnSQ2Slp2fGpMd0su2j+jOaEACWVKC1Q4xIAP8K9sRzqaNP
	 wqDsp1xASwnOU4Gca4SIRZBXU8uTb0E/Hz3ZN8qy6dhi4GmN7siKKyDeuryXjpo9mNYhX
	 v8lsEMDmS9NQSOTShd0E7wR6QqUrL7uoXaVDp2Bh3XDVF7uFIeYPmKqH7yJrEmLuMSJgH
	 4/WogVVhMBCc7NussGegh4lCzuVc3MvtGI4BUzGUYjN1FnLccySkmp6y+Zv+3jQj02sEz
	 NigrSl/GsoNOfKwpyByKWLrY1GeYfOrKj62L6hcP5lGuQNLmmAawjJfmpFi+5sn1lkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770122;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=6Xzv5Gb830c3oIfFW5MvPdN7mq0P8Lgb/1Vd542dHec=;
	b=BcHuoJCDGTEtqgNJX+XZ/iTJ3T8G6yGuYty0J+ho+3MMiSOHL2p0pj9fq6zpebT7BSU+
	 hSp0chjBwLLBjT1y6irsqCALcf6rHe3zahd2VG2aLGBxQ0EvzEae2HsDzwRC6C5GfpYfw
	 lJhOFbb6Crx7cGBreE2pXZCCmj5i9cl9zmVNL+X3YkQ6As26sQ56GXt3U6EJcyn53Pv6y
	 zZFYW6c4yD+OlwRZ0VoFf+E43IQOVj0UwvfoFgXcqpC5T3ZJfluBBm+KRYqXk0AVP9kgw
	 H1so6rWDxjOtOvPK/tqt3aBU2MtZ41GX1f1amkK3/KJEbM2SavOddYAClWM9bNHvCwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YNLJWNVw;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF3606A31E;
	Fri, 27 Nov 2026 09:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCF3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YNLJWNVw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DBCD21A1827;
	Fri, 27 Nov 2026 09:01:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B04ED6049C;
	Fri, 27 Nov 2026 09:01:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA31911E692B0;
	Fri, 27 Nov 2026 10:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795770117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6Xzv5Gb830c3oIfFW5MvPdN7mq0P8Lgb/1Vd542dHec=;
	b=YNLJWNVwuyzCyS5NR8ex7ZdxT1ZtXW4GNhkXGziXSzXqv2IrUTNoagVW3e8e6h12N4AgAN
	Eo5taiti36Fg23F1msFL0JMSxHVWuMTLvJ9NdvYrN2x/EQAqDCekWRLl2BxZ4/vOHgJaIE
	oxbkiAU/p7kojPniQYwc8B8kNOxvQq41wIXsbyiqw1PPPrMfHtbjqw9Chn9jnwf4AXzVS8
	K3AlJaXynzoX/IFcwoM4bfzvQLKh4YB7FH0cjEWI5hIO9FzjlG/GTo8gaMu2xq1eUi4/uU
	jhMuaQPB6xcUl9GKWdxoOcxatnmBfT+WFsvzWj93AQCrJXg/78LUuf7lPIbzEg==
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
Date: Fri, 27 Nov 2026 10:01:51 +0100
Message-Id: <DN5VDKIB939X.2SRX526HPDGH1@bootlin.com>
Cc: "Roger Quadros" <rogerq@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bo Mellberg" <bo.mellberg@se.com>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-omap@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Pascal Eberhard" <pascal.eberhard@se.com>,
 <srk@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: enable MDIO
 manual mode for AM62PX
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Siddharth Vadapalli" <s-vadapalli@ti.com>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
 <DN57K7KTZK8P.1M20MF8V8E3U7@bootlin.com>
 <8efc9453-bb4f-46f7-94c5-a3215b287f84@ti.com>
In-Reply-To: <8efc9453-bb4f-46f7-94c5-a3215b287f84@ti.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Siddharth,

On Fri Nov 27, 2026 at 2:24 AM CET, Siddharth Vadapalli wrote:
>> On Wed Nov 25, 2026 at 4:08 PM CET, Paul Louvel (Schneider Electric) wro=
te:
>>> The problem described in Errata i2329 also affect the TI AM62PX SoC,
>>> despite not being listed in the following document:
>>>
>>> https://www.ti.com/lit/er/sprz574b/sprz574b.pdf
>>>
>>> Add it to the structure that enables MDIO manual mode.
>
> Internal documentation clarifies that AM62PX SoC is NOT affected by=20
> i2329. Therefore, AM62PX is not listed in the documented on purpose (it=
=20
> is not a documentation gap).
>

Ok.

>
> While switching to manual mode seems to fix the issue as described on=20
> the E2E, the underlying cause is different (possibly a PHY issue that is=
=20
> exposed when using the Hardware-State-Machine, but is masked when using=
=20
> the Manual Mode with Software).
>
> I believe it is incorrect to add AM62PX as an affected platform given=20
> that the Errata doesn't affect AM62PX and also given the Software=20
> overhead with MDIO Manual Mode.
>
> Regards,
> Siddharth.
>

Make sense, thanks for the clarification.

Best regards,
--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

