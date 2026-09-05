Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14352E7391;
	Sat,  5 Sep 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788631383; cv=none; b=Xv0iS6wNEuspbxH7L+i7s9hDA4KY/pso3MXTebXl6H9zMs67wXS6Y3O6jBm7hM9B1U0Q2TPeAsGIP0//zyWaoNxxM6/YiTRIFwjGq2r+NEFcqqJ9Qg1Z0G+fbqtZM0esABRfyRqZhccfAhBhwpAKlGPFNHDC3s1X4nFomq4CExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788631383; c=relaxed/simple;
	bh=b4i1HvmYC+QCvkWjfP58W8bQ1OnikECCoFtWUyduYoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqEUuNXhbrs9j2uB9TYmNADAr/yPGSUWxZjJgXfsO6kZwvtqwNRus1H+1eYeKV1Vw8DGHCpJyc7n1lQh+Yxlwtv33msYazsOppKAGNJ7VU7tqI5KlRJtN9v8kv21OCgkMmwamYDz8Kk3F5+o0sKjxXP+Qk0q/lEZ53SQzA2B1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNEexEVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNEexEVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF01F00A3A;
	Sat,  5 Sep 2026 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788631382;
	bh=b4i1HvmYC+QCvkWjfP58W8bQ1OnikECCoFtWUyduYoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MNEexEVGh1RTnMaHT4+kKNk2D3jGJ2LiY1adZUzswWAxj/Lu3Dvmsx4rdCHWxTeIb
	 zuj+DcHdYm9lOmbshmvWY8wukdE7NX4amMJKiPnCPU3fu0Xud6rXCByZQ/7P4Jpp1+
	 rpGCbRWRvvkHto/QMITNm7jl9x+SiWoazoyy1xEu3ttOO7CikqsuL7NA/NLR45A5SE
	 qX12DApvPD3hUQSXxojNo12Plf0eARi8xpKq7AVrgWSGV3mfvqT1UuE14VIGsSfE4J
	 +0M+jXixgPCrD+fbzxu7hi2TWdN8kHwVDi1shNJ3bAmyhz5ymAW+2oI6/1JyDByfR6
	 O79OuJAZSsB1Q==
Date: Sat, 5 Sep 2026 11:03:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <dario.binacchi@amarulasolutions.com>, <mkl@pengutronix.de>,
 <mailhol@kernel.org>, <msp@baylibre.com>, <florian.fainelli@broadcom.com>,
 <jonas.gorski@gmail.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <kurt@linutronix.de>, <hauke@hauke-m.de>, <chester.a.unal@arinc9.com>,
 <daniel@makrotopia.org>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <ansuelsmth@gmail.com>,
 <linusw@kernel.org>, <luizluca@gmail.com>, <alvin.sipraga@analog.com>,
 <clement.leger@bootlin.com>, <justin.chen@broadcom.com>, <dlan@kernel.org>,
 <rogerq@kernel.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <rjui@broadcom.com>, <sbranden@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <opendmb@gmail.com>,
 <andrei.botila@oss.nxp.com>, <wangruikang@iscas.ac.cn>,
 <amadeus@jmu.edu.cn>, <kees@kernel.org>, <tmshlvck@gmail.com>,
 <c-vankar@ti.com>, <horms@kernel.org>, <vadim.fedorenko@linux.dev>,
 <daniel.zahka@gmail.com>, <nora.schiffer@ew.tq-group.com>,
 <v-singh1@ti.com>, <oss@vassilevski.com>, <haokexin@gmail.com>,
 <alex@sverdlin.org>, <aleksandr.loktionov@intel.com>,
 <lgs201920130244@gmail.com>, <linux-can@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-omap@vger.kernel.org>
Subject: Re: [PATCH net-next 00/33] Remove comma after sentinel entries in
 match table
Message-ID: <20260905110300.2b4825d5@kernel.org>
In-Reply-To: <cc1f9d12-e853-4000-8236-9e7f5a9ed314@ti.com>
References: <20260904043724.2955444-1-s-vadapalli@ti.com>
	<20260904085811.7e2c2db6@kernel.org>
	<cc1f9d12-e853-4000-8236-9e7f5a9ed314@ti.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Sep 2026 11:09:54 +0530 Siddharth Vadapalli wrote:
> > You failed to specify why this "cleanup" makes a difference.
> > have you ever seen the sentinel not be the last entry? =20
>=20
> The 'cleanup' in a way 'guarantees'/'enforces' sentinel being the last=20
> entry, by catching 'copy-paste' errors at compile-time rather than being=
=20
> a silent bug that shows up at runtime. If a new entry were to be=20
> accidentally added after the sentinel entry in the current drivers, it=20
> will not cause any compile-time error, but will fail silently at=20
> runtime. This series 'cleans up' the drivers by making it a compile-time=
=20
> error going forward (adding a new entry below sentinel will cause a=20
> build error with the comma removed after the sentinel entry). I do not=20
> doubt the review process on the mailing lists where such errors will=20
> certainly be caught, but isn't it better if they are caught at=20
> build-time instead, thereby saving reviewers the trouble of pointing out=
=20
> such trivial mistakes?

Is it polite to answer a question with a question? =F0=9F=A7=90=EF=B8=8F

Please be mindful of maintainer's time going forward.

> Trailing commas are an indication of 'scope-for-extension' in the=20
> future, which holds true for 'enums' or other structures where newer=20
> entires are added towards the end rather than being inserted in the=20
> middle. Since that isn't the case here, this series makes it clear by=20
> removing the trailing comma.

