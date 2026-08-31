Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F249EC6C;
	Mon, 31 Aug 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183658; cv=none; b=SCpJNnyvL9R3XpIUEl+M6TkEBTxPuwR9FT4F7Ezp7QrFcjChSXrIQ8c2TgLsag8AgoINJBlnu9Iqr/5U9NqQUv5kiUEje8m9k8nUJZfetOC9j/HMf9Q+c9jD45zGB/jWAfrmT4Cmkpg0MR10jDMfuuJCeOe/UpGIbu4pXiTHW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183658; c=relaxed/simple;
	bh=JEYEe013MeWw5vJDMvnCki2TlSdVjHke2uUGW4Tm1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXR5tvCAjLPcpeStTKdpvQ0gQOac9q3WtA32bJZF52dWd/JoSofD8fjISdBv9Ch8rq7fFnjiPeP+PuBw9hNJZ7yh0A9gmm3YIAWUDiLWZcH2AwfhfL3x+g6nB5ZgwsP/s34iurrjDUDKKRoxim8GME+2G32ClFq9O9mMhN640KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLYn4Xoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLYn4Xoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966541F00ACA;
	Mon, 31 Aug 2026 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183656;
	bh=a3xAqzva9iX6AIHQHMEXxnpG84kympdAWLmYKSlr+xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nLYn4XocDGJ1j1+1kyeg9YASiCwGxZO0YIHtAhQpl8Q1TAnHBXKZcqb9T2vPRWpOi
	 FY/S1Jv0qCGT85GrAWDdU7Z2ma++tztcHNa89yrkLxxHZtSBrJGkhv20kDuQNhv/ji
	 kmZX6OUEn4+55sql03lwPaZIyjGDTp+awBrgDcCCFlNOQAG7nN9ksDHAoUjI3wk5Xr
	 SKE+moxbut4b6SSFtGTjvAAT2LSJY6odKWuYqs05LmgRwq0JmtGW++tBXMknBQBJoj
	 5fmdjWVKmw4KMVYeiD4MUZKzkMIErWm0/DlbUxq96V+gDGYoDjbpwepfuNfNrJb+qE
	 hLpD68SyOvJTQ==
Date: Mon, 31 Aug 2026 08:40:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com,
	m-chawdhry@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	Andrzej Siewior <bigeasy@linutronix.de>,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kumar Gupta <ajay.gupta@ti.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>, goledhruva@gmail.com,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	devicetree@vger.kernel.org, simona.toaca@nxp.com,
	Ravi B <ravibabu@ti.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: dma: ti,cppi41: Convert to DT schema
Message-ID: <178818365533.732788.12823920440612665617.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-1-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-1-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:43 +0530, Bhargav Joshi wrote:
> Convert TI CPPI 4.1 DMA controller text bindings to DT schema. Add
> ti,am3359-cppi41 and ti,da830-cppi41 into single schema since they share
> the same hardware IP block and driver. Add undocumented #dma-requests
> and power-domains properties to match existing DTS usage.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/dma/ti/ti,cppi41.yaml      | 109 +++++++++++++++++++++
>  .../devicetree/bindings/usb/am33xx-usb.txt         |  14 ---
>  .../devicetree/bindings/usb/da8xx-usb.txt          |  12 ---
>  3 files changed, 109 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

