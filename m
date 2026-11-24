Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795530924;
	b=mKTvs/fwjc6FTAQVZhYl5hYwojj5jTvfpd947M/mxG89pN082+VMPgUk2kriLtM3pQYF
	 S8wh+V5BlMrjTanLleJvTLArkhTSFQcnoH3CkhaG+t84Gy3EOVRL/jhTNqptXKJw/YzUT
	 xBy9iyMO/xE8ESw4cND/XaLNgs0IuXZ5y1Sz2qwlVFTxAGoTkFbwY/M0xemZa3Vn9MQyN
	 kxJ+2REMV64ZV4Mlpwlq1OdhKLhXE+2onhJrtfwkTXbNeFdtE9YRHjW8nhgrrlLYLaWSp
	 HG4rzrdpTDhsJuES1B/0T5oJw7CHDsOSmerqFrMoQZKXikafwHc/6vqjmdpfCBpTntw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530924;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=pPC4o0FashGrZ7q1ba6XFZ2dyTINKWWF8cNcwGutazw=;
	b=Tp217BjOo29vQEj1/vRzVOooYuysvg9UdU1MOUWTXtvpcbYNkGU0UKfg+91Ff+GAfCRw
	 yXa2TrkYAf22AI9XVOBElEUWDkrrLqhzNQ/Z4oV5eXfZTg1mAfQoBfAaCEm3RF3lKX2IF
	 BjYHrze14I3j7kQe0duisrIeVfzbzPdBa++/jz4llwyPbEBdmTL1ewF389X+ZKqb6UC2j
	 rB6Z/0LBugX690EqTdDLBUWJnvsDj16hLwQ24CtpPgOLP6tENCKOcg0GhsBs8n+LqrQe8
	 qzW6zuilf3oV5PZIaCUGPE4JV2WQvCp9pR0Pk3bXTpCdJvaMg20Ww98SGJUFOZXb9wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TBq3Zp9F;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9K1WvYtz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F23606A31E;
	Tue, 24 Nov 2026 14:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F23606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TBq3Zp9F;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=9K1WvYtz
ARC-Seal: i=1; a=rsa-sha256; t=1795530855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VQiaI5Hy157VlrRqaOCj1N9vjjVa8Ra0JmiNp7xaIASjJ9jINXJ0n3OKdnYSQRp4JZ
    +EShQjRUhHzrJZJ7sL5P8n0r04fvc5f1n+yoXkQddn7xVATA1/TZ9th/4PZ+vlVxqbIl
    jpmPK15kaGe7+/0/dlIzlo2RhAcQfaFGmdEojwWa9EcecaXzd8JzT45K+ugKPNxYCY2I
    rnOPo4AX4UK8cKxWYfqEhoTC2FIWfD1ka/Ateg8XoQTc7pADiw/BrgJD9c3LYwJSkNjX
    3JocLaQ7E0IzmGCQsTZqvzi1MU/Oy7HoHzw5ysEoEsjpY5pMiLsP9n43mrM2dq7EfYiQ
    PoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795530855;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=pPC4o0FashGrZ7q1ba6XFZ2dyTINKWWF8cNcwGutazw=;
    b=H1naZhooZrS8f4XAxSxLXUg4qjedYo56i3dz4xniKf7PkDMMjT/O1xgSSh9pfgr4pS
    RFaYBeA2pNvx6TjrzltkUhOW7nU34meCf3mdle70hKq/e+sMBfvnJL5nfk+s5JF0bOna
    F5tgYYVwgBLjH8a/kqlIKwsIqVii7+hqZwRjgzP11d1zIiOv/wtvdZez3yuLiTf3YWAg
    7uXrxSe9FyH9wM6WMDcMENrz8D1ktfCFFP4qkCT+/lgv+mO27fL3zIMZxH+PgOZcHrWy
    TV+UI924lerakwwjDWZ5PhvjFulKtvt3MAylYXdCPVn9WjoDEy7M99Y5Vll7+TYdrztB
    ElIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795530855;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=pPC4o0FashGrZ7q1ba6XFZ2dyTINKWWF8cNcwGutazw=;
    b=TBq3Zp9FVBdC07XCYxWQJdKxG6KJ26CqiOTO1TaNSfuZPKB7l6tlkfjJCkcYX/bzxN
    NzC6pX1L6sq8PzgPHNP+VfBSLIv+4n8QXwCH5OmFQY7o6YOKs6xKFKPkDhMka5utJ6Tg
    lrAAIHPZmZmnqAMFPo19GWniCdao68N1O6rerqOFE6VjphVxTNb+MiMGp8ZZK0J6BvUB
    nUYNTZrX7gzhEqMlVtFWrjqRQR2iqJWiQr29ymQeF4e2rXp+rZD0vaRApCBvz3aso0gh
    Rhf3vkl868bsKQJ9S6UY5Tr7hLY9BJp5YU9ukW02eQnC6EiisrjxWy8CIIXFRWY0OxAh
    B9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795530855;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=pPC4o0FashGrZ7q1ba6XFZ2dyTINKWWF8cNcwGutazw=;
    b=9K1WvYtzJzNNHClBs+8Vddpi1CzZaNt4JUc5jRlbRw8+zB//G65L//AA5d5KzafPpj
    z8iD9e13OeegkV32RYAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOEYD3aL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 15:34:13 +0100 (CET)
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
Subject: Re: [Letux-kernel] [PATCH v2 04/20] dt-bindings: sound: pcm1754:
 Describe PCM1773
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <608d13a4-6634-406e-aba8-b48114895cc0@sirena.org.uk>
Date: Tue, 24 Nov 2026 15:33:42 +0100
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
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5A40DA10-E001-49C5-9432-F1494F6CDD49@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
 <608d13a4-6634-406e-aba8-b48114895cc0@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)

Hi Mark,

> Am 24.11.2026 um 13:05 schrieb Mark Brown <broonie@kernel.org>:
> 
> On Tue, Nov 24, 2026 at 08:25:44AM +0100, H. Nikolaus Schaller wrote:
>> Extend the PCM1754 device tree binding to describe the related
>> PCM1773 stereo DAC.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Agreed. Should become

	ASoC: dt-bindings: ti,pcm1754: 

Unfortunately there is no tool to find this (neither checkpatch, Sashiko-Bot,
nor ChatGPT did report it before submission and I didn't think of checking
again).

BR and thanks,
Nikolaus

