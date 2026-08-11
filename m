Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13137DEAA;
	Tue, 11 Aug 2026 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473112; cv=pass; b=Va7YOXxkA88ELvGhByDTlLii5nDvsHY/4otk6+ErDCmFla7UTBORoxs2dZHOrs6qUsK6AdYPZCnYxIG5ZoVyt7ATfSD3VcbvWCgesGuU/bFYSi+oRcmxDqTGiDR+XXfxPgSavWFVPvHKs6yo3amJtCatUC6zQ40kUKgSMOqw4ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473112; c=relaxed/simple;
	bh=mVtoqeSXP0mXI7aNM6KA5Qzg2WCi6PTEZbiLXWss438=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLPpF1Q9hNmT9rYANr00803uxsNieebr4M2qeUnwKYieiq7m9fAwYy/ekewERYljq6UFDVYWa0dq4AcRcYpiaTFEfIIxsla+CAUzmR9/3BWsD9JfnFZOACN80fMg2IRnF6AeKyXSavbwJU24zxE16pjJ81/pD3tZZgl3ZlO2Xl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VLP3EcAX; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VLP3EcAX"
Received: from darkstar.musicnaut.iki.fi (85-76-106-235-nat.elisa-mobile.fi [85.76.106.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hKKvq3CmTzyYL;
	Tue, 11 Aug 2026 21:31:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786473097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qoaDDpKICqAjBVzX4e4ip/j+XxAMW19YDIjYVhb0xDE=;
	b=VLP3EcAXAYEjvdEQJqe1vsf06Bb4aES591foWz+TJBqb4PnioazWA7Lc6H+xzLcPjIUa5S
	Y8ZOpu4awXoqTyrEhouUxBtzY+hLs8uoByvjO5/8m4fI3Ri0I5bRzghqo3W8OCWVzWd76V
	+bxu+4c7ScaBWk41qcJyfGlJ/iRgwqE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786473097;
	b=HYl0lh6U67DdmLOT6qp+LQUCXOYNJS+Lb84CN8kqcjEQGYyq+7jCBkMO/pMT32+cRtGVxU
	74d9AU3u+1KYasa68ibKX1nXpAuDx1abnRiysjLKB241zcMjLibAoL8tpuh5RHSrpX+yKV
	/WXZ6ITHckXec8mn1c7RPLnq1JgMkUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786473097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qoaDDpKICqAjBVzX4e4ip/j+XxAMW19YDIjYVhb0xDE=;
	b=SiqmU3zBJo6pNRRNoPVeJXOWvNWPaqXZTOPDvNc4T3B0Tuz1L108/mRhJs3u21BKTGJEHK
	lAhaAB2lUEAGNPwClCyLUrqeF20NiSAmNLax/9/sRKa+MZpUDKHZ2u5RMMVNiIC0i0vHXD
	qGv1IaDMJBMw2UWNyslK5C+sRIN8M1w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Tue, 11 Aug 2026 21:31:32 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ARM: dts: ti: omap3-n950: Replace clock-frequency
 in camera sensor node
Message-ID: <antqhI-3175h-pX4@darkstar.musicnaut.iki.fi>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
 <20260810180604.3034255-4-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810180604.3034255-4-laurent.pinchart@ideasonboard.com>

On Mon, Aug 10, 2026 at 09:06:00PM +0300, Laurent Pinchart wrote:
> The clock-frequency for camera sensors has been deprecated in favour of
> the assigned-clocks and assigned-clock-rates properties. Replace it in
> the device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/boot/dts/ti/omap/omap3-n950.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap3-n950.dts b/arch/arm/boot/dts/ti/omap/omap3-n950.dts
> index b99f97880204..2864ed8dd6c3 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-n950.dts
> +++ b/arch/arm/boot/dts/ti/omap/omap3-n950.dts
> @@ -74,8 +74,11 @@ smia_1: camera@10 {
>  		reg = <0x10>;
>  		/* No reset gpio */
>  		vana-supply = <&vaux3>;
> +
>  		clocks = <&isp 0>;
> -		clock-frequency = <9600000>;
> +		assigned-clocks = <&isp 0>;
> +		assigned-clock-rates = <9600000>;
> +
>  		flash-leds = <&as3645a_flash &as3645a_indicator>;
>  		port {
>  			smia_1_1: endpoint {
> -- 
> Regards,
> 
> Laurent Pinchart
> 
