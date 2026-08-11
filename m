Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936E3AE187;
	Tue, 11 Aug 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469875; cv=none; b=l/YmGtXc2rk9n830zpc0FTx7exAwQ6cvi7JW2Zv0V/kRmZTiULw3QlbwwV8f1dMYgjbVDctAumLrKOUNZqp78U0ShVHhrLONC16+2TRg6cKQJnDfSciYs1AND98dizUI2C5WEUZDk1Qt8WIyGl/ngD0RsJ7icFBV4LjE6w2o2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469875; c=relaxed/simple;
	bh=jXvs7WF53qP0RSx1ed/7TEKhqKS99BtgQV1dPKSxTrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg/B/KEJ3OXxXW9LUJXef631aJzcOfEkslK1Qa0CMpvMvCMeChy7d6ouymApKtcyZGVWFX2bpGkry/Mdp33e4i5Va2W+p9rVXcnDb3YfeUnRb5XzDWXc6xywkVH3UI5Ek+QUX/YL1CllUYoELB5lPV4zB3rJHyBl1Kn9/yOAwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHl8gYib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHl8gYib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CA1F000E9;
	Tue, 11 Aug 2026 17:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786469873;
	bh=qm5Us2aLjYbusWVKB7AGj67HVUJF6lt+CgUM+64+1vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dHl8gYibG1EFM7pdFQeD5axxwaiHLcEbOjt20ayFs7ThDjM+y02BNBut+NicTxSfb
	 3RshYHkhIrxBlGcOZYKjBsZZZPfFB+Simg1VRyQ5/ylTAcNoey29+VbQCYoAbiL8AB
	 LSpER66PGsfd48w94ql7NwNpxrNJBUQrhazFG/E4nFsAtwiaVp9kcQxlYUt0jJYaAA
	 xSu92B8DEaQR792LcLUMefaSmMV48YGm5EqDr6VxT77NPJM11ldWnGESzWcJ3ErPU2
	 RFSrqhzqQTFsZmq5b7revM1sPr2PfC2aDggt+I78O6ICW+d1r2rWFHUh8Y40EIATYA
	 d/j7wwz4U063A==
Date: Tue, 11 Aug 2026 12:37:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, m-chawdhry@ti.com, simona.toaca@nxp.com,
	goledhruva@gmail.com, Roger Quadros <rogerq@kernel.org>,
	daniel.baluta@gmail.com, devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Tony Lindgren <tony@atomide.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, Afzal Mohammed <afzal@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: rtc: ti,omap-rtc: Convert to DT
 schema
Message-ID: <178646986882.2676673.17373114650727574893.robh@kernel.org>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
 <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-ti-omap-rtc-v3-4-ba3bbd8af570@gmail.com>


On Tue, 04 Aug 2026 22:35:08 +0530, Bhargav Joshi wrote:
> Convert the Texas Instruments OMAP Real Time Clock (RTC) binding from
> the legacy text format to the DT schema. Mark 'ti,hwmods' as deprecated
> as it is no longer used, it is kept to support legacy boards.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  53 --------
>  .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 140 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 53 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

