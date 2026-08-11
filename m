Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83637F72C;
	Tue, 11 Aug 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473138; cv=pass; b=A19igP8CEkdpvzYFFB1XSthUQBHKPN9AqIxI97sfYCsA7puBp9yvD+wUYY20Iij16uxVJjcFMIWU/o2rfeidKpS8meeJAyy3pTLT6gizBbKNB4nMzRmPjj2g1EA3rVN0dr3QjJhvpndoM0GAF+b7k0Y+sZ6N3ok9arrWSJGHRBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473138; c=relaxed/simple;
	bh=cpT1+uBx9+jz/37A+C3MKefNQGI5C85MIY84wXYyHxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3V6Qs0DUQSSNsW+eu9WYYxGNDywC38qYYksyPgmdHADWJNOT+PouuYlrwQ5Hh588sMd3JOJIfrnupwpTg9DAbweWU41IQBlBD4PRY4EQBzGVoTAwzmOfUT+iHZ760o4PbH/aPYHWjJaBXTnAB0l8EeueaMf/hae2rX2xB/HyS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DGLNkeYg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DGLNkeYg"
Received: from darkstar.musicnaut.iki.fi (85-76-106-235-nat.elisa-mobile.fi [85.76.106.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hKKwT2ZwxzyTn;
	Tue, 11 Aug 2026 21:32:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786473129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6srynJr6F+iL1JFztpVkhMqsuRR0gj7Zdj8R1JOIvQ=;
	b=DGLNkeYgMrfRzRSj/DNK53t1BCBMvrK8t2+4ELCIObHouX2Clvm1+g7uCHMgVL2QIUklw2
	WZ3SJsEd8kAnobBw2X5b1IettcmF11D0zq/gqE51zGACmQrP9EkMe5qOfyKAQHehm08KpH
	HK5iOcYHIno0luWZ+xSJMthmv+6SlCQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786473129;
	b=TxZ6RMHkrorTYhFHgtPNE40tltk/zFqBywRUMTKRbj9VszF2/dLRHJ0br2rxP/7lhXm1d7
	klWp0jf55NGMb9U33qbRxF7h6U8+goOzzSDR36CJStIw7nC/lD8eW8dgL7PgF4qTV7REet
	ZwIWX4X+F70RnmcjHbV3BBiPILYtDME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786473129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6srynJr6F+iL1JFztpVkhMqsuRR0gj7Zdj8R1JOIvQ=;
	b=wOmgv4iRb1BSDgXLn1uFGBNxwQoxs0iIJz+xuaX18jIIou2tZK9BG3W0IX+r5i6rZcFFDM
	x2NA/7/vAIxjbZNO1QBU9qICeA8UCRTR0arx9eE4AjdQHWBMg1RH7zlYBDkoylJglMheV5
	+ylm+pNEbMJQ2KpjwjHZhy+jRBoX90o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Tue, 11 Aug 2026 21:32:08 +0300
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
Subject: Re: [PATCH v3 4/7] ARM: dts: ti: omap3-n9: Replace clock-frequency
 in camera sensor node
Message-ID: <antqqG7acr8EF4ow@darkstar.musicnaut.iki.fi>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
 <20260810180604.3034255-5-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810180604.3034255-5-laurent.pinchart@ideasonboard.com>

Hi,

On Mon, Aug 10, 2026 at 09:06:01PM +0300, Laurent Pinchart wrote:
> The clock-frequency for camera sensors has been deprecated in favour of
> the assigned-clocks and assigned-clock-rates properties. Replace it in
> the device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/boot/dts/ti/omap/omap3-n9.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap3-n9.dts b/arch/arm/boot/dts/ti/omap/omap3-n9.dts
> index a3cf3f443785..2edc1933449b 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-n9.dts
> +++ b/arch/arm/boot/dts/ti/omap/omap3-n9.dts
> @@ -21,8 +21,11 @@ smia_1: camera@10 {
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
