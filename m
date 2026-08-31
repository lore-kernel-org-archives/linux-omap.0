Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA329477E37;
	Mon, 31 Aug 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184416; cv=none; b=kZ4hdO6UaUdFKVVkC+Tus0Uizbcw/hYqy6J4azf2JL5dELsUqlqfXPP92FhCfC0ZlxO2DoBf8ws4tYzNBWX4RNFC1fDKGX+5T52Tyn93FsL1ljIEeoU+DMDaYPnHe0PeMxyFmo1nsiRw8Jo8nX8XymIRHl+L2WJxXG/8jmCGU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184416; c=relaxed/simple;
	bh=/ze++4UVjLwRSg04rjF2z191Su88ZxBe3hBTOi7AaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nreajza/ZTUhvConDN27ufEX1cTPcQp+GKboBIDfEhIoDNWCtLw16u/zNxXRG9IYqD8I0y3ubHicgbWsmUayvM7VgsY8uiudV4l5OovhXZCY0UmC1ZF68ziUcr5a5d2SnTtoVOZ1N/Kv1LnSwExZd7OS9Hd3mbOdxdbDQHNlz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR7iSfKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR7iSfKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C3E1F00A3E;
	Mon, 31 Aug 2026 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184414;
	bh=iNXGzRvdJs6cwNKIKDaDLJFed/7G5LVtpFTWfVFbPF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oR7iSfKulshQvIA849PgOPNhN7+n82kRUZEf528y7ZjaiA0a4zKa6Av8Ero3eRFCi
	 R7moqfT+blmChj/kC7iomoXRzAwHku4fsNow8Qt3iYk6nCr2ZLb8TKOJI70gKZUi2e
	 uxC312woy2QoSl+99YaHlrrOTLT27HwFie7m3MS1WhXrC5cX93jdx+pHeMPD/uxr5c
	 EyKWgQOKfZyWYlzpfAKJtAP8mdC0n9UT+lzMdTeLmfvTQN7Ut8SrBDSWioroMWP+wG
	 pXwuuD3nidjQ6trINVe5qaEnZk4OiNOgetBziLbLzCR17y3fMPiQUnVZHtHrVc5Ffo
	 xn1nGOXdEObmw==
Date: Mon, 31 Aug 2026 08:53:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Ravi B <ravibabu@ti.com>,
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>,
	Kumar Gupta <ajay.gupta@ti.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmaengine@vger.kernel.org, Andrzej Siewior <bigeasy@linutronix.de>,
	goledhruva@gmail.com, linux-usb@vger.kernel.org,
	Frank Li <Frank.Li@kernel.org>, linux-phy@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, simona.toaca@nxp.com,
	daniel.baluta@gmail.com, Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, m-chawdhry@ti.com
Subject: Re: [PATCH v2 5/7] dt-bindings: usb: ti,am335x-usb-ctrl-module:
 Convert to DT schema
Message-ID: <178818441292.768689.17376087226592682444.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-5-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-5-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:47 +0530, Bhargav Joshi wrote:
> Convert the TI AM335x USB Control Module text bindings to DT schema. No
> functional changes.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/usb/am33xx-usb.txt         |  9 -----
>  .../bindings/usb/ti,am335x-usb-ctrl-module.yaml    | 38 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

