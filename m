Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05047ECF9;
	Mon, 31 Aug 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184745; cv=none; b=Yw3ike4bc7Oxj+swwwgKhdirte8wsXfABA5EB0B9dhd3wp3d3pD6r1Pc9FG1Cx2X7iRrFxr3Hf51kqMLu0g/Eur7aUyyYdE0QyMlaEAT+Rr++dFGcB8VIFUIBpf4H8lRKX+ry8mP3xAhGvSV3Dp9GmWtu9dmKhk/V482+wr/jt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184745; c=relaxed/simple;
	bh=titzif/xhH9o5b/pQv5GU3skmZ71uiz8DXmDWz6FJPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8J7hiC8pFi6gYF9H9fUwvtZwijyzQ1kpE8VbZ6VOyzjYebqTEYpJ6NP5m7h0AihMm7rd0Gw9w0tgOvT8CX5uSwBM57ceBwyIkFplVD/G/JSnx11GiD3ThK6vW6CTwK6PWPdb0D9/PmswQCqAecMsKNuSbQJLW09ExxO91tM7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjCH8PVp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjCH8PVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE71F00A3D;
	Mon, 31 Aug 2026 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184742;
	bh=7+CvhtcqpL9LlO3vZRZJVBm4ZHg/NPx+bJ7qZ6gUihg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gjCH8PVpjTBsD1ePcxwIoDX6HHOneozCA3ON2UCBVWEb9PqTdRgB7u3B0naRADa8y
	 3UYdXFjwVShwDE0nFrR7S+M4LTm6g+NjeIi905m06z8WQSE7xDBlNln816peOK5MKO
	 fPeohNoYbQI0SqnObkfW+qQ1V1bU25KaEjQUKqyCo0lcIv/VXBOom8Q6jTK/hdlTav
	 lqjTVt1B/HNkR46lwZod20e93j5lVZk1Bxoog4EpqZ9/idcNUTtNZ6uHYzrRFyafG0
	 0WjtqYcykn4iPDxwbOO8uQareLy/NLQ6T4tAmagdW0QKi9AJNI2xcEC7aGT63LnZRD
	 Yw8cvs0eYkVrQ==
Date: Mon, 31 Aug 2026 08:59:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: dmaengine@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
	Ravi B <ravibabu@ti.com>, Kumar Gupta <ajay.gupta@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>, m-chawdhry@ti.com,
	Neil Armstrong <neil.armstrong@linaro.org>, simona.toaca@nxp.com,
	Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Lindgren <tony@atomide.com>, goledhruva@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com, Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: usb: ti,am33xx-usb: Convert to DT
 schema
Message-ID: <178818474136.784979.12649803457088631518.robh@kernel.org>
References: <20260818-ti-am33-usb-v2-0-66fd44d66824@gmail.com>
 <20260818-ti-am33-usb-v2-6-66fd44d66824@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-ti-am33-usb-v2-6-66fd44d66824@gmail.com>


On Tue, 18 Aug 2026 19:58:48 +0530, Bhargav Joshi wrote:
> Convert the TI AM33xx USB Wrapper text binding to DT schema.
> Changes during conversion:
> - Drop the USB control module from child nodes, as it physically resides
>   within the System Control Module address space, not the USB wrapper.
> - Allow standard phy@[0-9a-f]+$ child node names alongside the legacy
>   usb-phy@[0-9a-f]+$.
> - Mark the legacy ti,hwmods property as deprecated.
> - Document required #address-cells, #size-cells, and ranges property
>   missing from text binding.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/usb/am33xx-usb.txt         | 143 ---------------------
>  .../devicetree/bindings/usb/ti,am33xx-usb.yaml     | 103 +++++++++++++++
>  2 files changed, 103 insertions(+), 143 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

