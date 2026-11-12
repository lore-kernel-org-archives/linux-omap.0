Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524675;
	b=imBiKsigLdfH3qMtHzhik2ZoV0WrtUFbjBUZqp59TJJvbtjTzZWETDzxxUfw2KIM618Y
	 JNn7zQctnemNliyVkaiKwuYBoJpOBX/Zp7+zEeFnMDz52Zi7i2Sdsw2POXe7xDslBnHF+
	 8u0+ar7Wl4WDTjiYPYhct7gI7b35wbyg/po61QsFEkHeLphTF+jpRsnBlEWsm46nzqLmA
	 EBrIWWgEe3mfpe0XDnMXorX2XvmI3/fmnSIiVZppiv7fgAlLRkV2t+mbEwDPvBrVkmb8D
	 znSPIS/ynBsFwa4F13aOwUWC7G7e+NKcEjknyARDQRtiOsfuFAJa7Ewtzyq7OJkxD5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524675;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WiySqy+HzwtvwN8C0PE2DyxhN1KGJ2XBtjlY5ImikYY=;
	b=A+frgFxAduFDHASRKggjC/Qayb3I6jGVfYJmyYatmIZwwebj4G4KNvfdFxV59VIR+3YK
	 rDBZjiK7rM2qSd7EVqIiDY410vntwnDR0lAwfhe/YMjMbILdVyRKe8VkTQaXf6D42ifAG
	 owFSfvWXJTXQTSo01mcXIqAxVShms10BLLYZgh+GNRthUj6RQe37jJl1pf8un/X+b5ew6
	 jFMtsd673NkQEEgM5ZWU2lLXJ6SMVCvWZ/c76hC/LA6EMhZWnffvYWV/Z/NxA8S2H32In
	 MtVhhwXfu7uJgHVd+F9G/1J76l92GQNYLJTUzkM6INkfQPmTauQ7g2VNNeuRpf3YWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StuQZnkp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4022606A31C;
	Thu, 12 Nov 2026 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StuQZnkp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4491C1F000C4;
	Thu, 12 Nov 2026 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794524674;
	bh=WiySqy+HzwtvwN8C0PE2DyxhN1KGJ2XBtjlY5ImikYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=StuQZnkp5AotdCaLUNpd2Uq8IwnT5aqat1BYQqWLzL0PFdZyipRS9IrHjRarf5iyh
	 cnnvLZt7WX93B8ca5bLqNzWSoptVSMyYA5mB11SqVBBGV0bugXGqaFAEk7vuX/yjDj
	 5wMcWaNUzaUxxrHCqT9696nOfyAdhL6FcSzymXWx8q00rt6s43R4g/fqkgBEQzAYr3
	 kO2U0xNNnivgx3Kn8ZtBZvo5qm6QsUoKbtOWwY+JD1KhyNOZJ6TnTOJ+k5m5xgfHjU
	 cgAAynZl1V+H8BmYszKTZVjA4yPnTbzZXioY7w+/moXjEdUfiE1oZPsp00BvadxdMN
	 9FXW/+ZPVYmJw==
Date: Thu, 12 Nov 2026 17:04:32 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	daniel.baluta@gmail.com, Sricharan R <r.sricharan@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>, simona.toaca@nxp.com,
	Kevin Hilman <khilman@baylibre.com>, m-chawdhry@ti.com,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, goledhruva@gmail.com
Subject: Re: [PATCH v4 2/3] dt-bindings: bus: ti,omap3-l3-smx: Convert to DT
 schema
Message-ID: <179452467187.1933535.7588827800062161687.robh@kernel.org>
References: <20261113-ti-l3-noc-v4-0-5084dcf4ffb4@gmail.com>
 <20261113-ti-l3-noc-v4-2-5084dcf4ffb4@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-ti-l3-noc-v4-2-5084dcf4ffb4@gmail.com>


On Fri, 13 Nov 2026 00:24:03 +0530, Bhargav Joshi wrote:
> Convert TI OMAP3 L3 interconnect from text to DT schema. In text binding
> this was grouped with omap4+ L3 noc interconnect but since it uses
> different hardware IP (SMX). Add SMX variant in new schema.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/arm/omap/l3-noc.txt        |  5 +-
>  .../devicetree/bindings/bus/ti,omap3-l3-smx.yaml   | 68 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

