Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138337F8D7;
	Tue, 11 Aug 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473171; cv=pass; b=Gsjf6xdtCF/lLY1kT2XLD9tccXAfy6UtizB+a0jDIumQm1hkeL0dJXeceiOo/QZnfu6iKeak5lzp8RNosw056gU+UKkZqxFJlFH4psEJbxV2fcScDWBrWJQrF1daIfJvRmuoFo7F7JqNEdMCiQel108GdJZ/jVNu+1DMqfwH8NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473171; c=relaxed/simple;
	bh=bIhM9ndig9/C3tRN23CbuAFxqICpJ2n+mv41X80JqBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJko2sR114/cAYZSgOFqTeD/9hAFGcJ6bbjehgO7b7BGcFnvGjfd82ynv7jHc4qfoOa8xo2NFu2zO/71G+saLrCocc8Md+90WdG+L9pG4qi2aj78qRMYkKku0A3OSug4To3qYcKEcUKUXwzV2QaFp4p4481LVH+weLXP9FZY3Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oZLUx+2Z; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oZLUx+2Z"
Received: from darkstar.musicnaut.iki.fi (85-76-106-235-nat.elisa-mobile.fi [85.76.106.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hKKx05RS2z49Px5;
	Tue, 11 Aug 2026 21:32:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1786473157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLMZG3a0XkvDabygdqWI0Ok/u2IdHHNuIIa8OSa4q6U=;
	b=oZLUx+2Z5E8ar3zagCuGrS7esWiLCq1IVCkwn+abDRIuWTNcVtBDNtLs8jtoidaDyGStUY
	Udgi/WtXNC6fpn2lrz41TB7lhc0MXqMRR6FPWaCJI/F2gU7gFoMkZm6lexKpUbNZsBiZdU
	BG3wN7gv2Ytn6V/76wn5COlNRVbQ14R3WzjnEUl+qX54ZXqvy5knqiu6YHyu7gE8b/CuUg
	yNQj7XcJNb6XksKDn32EWA/n4q0oCXbl9OIrEoxmbTrXXdixsJd2BepUdE1kSkihDfefYt
	Bh/7zp72Xkns7jbOYtq6rIJ6RqOP56dOW8Nk0GmGdNQhptSk89zVHNxBlGZjDg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1786473157;
	b=M55dj2UEFMEPOsz/hCG66MsDHuTWD0ardBnQ/+JYw+1BaMykUik0BS/RFXRJrr7Of0QU/8
	+toeyTl4MELrDtT32KeXJBImz3gx5YvCD4k+THbeu7vyMCzBqsjCvluhuxV5LScIlKP1Qq
	2625T3+tcFSTiC9UhW+0nmfyhhko6v82MLm/olcPFgg6Y+Qpt8/+IxilIyVL1LAlNcpnss
	hKQy7tmBbrEmuEGeNXolC5IdrgsmxnrT0kKpMovvo1Q8O42leQj2FoFZhSwTuWw44NbPfh
	EzvBmnDFDrRGnnb2B0MWwPDqKarsKXo8YX4k4nbJ1y0geu+a5IBNqm+wH9zNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1786473157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MLMZG3a0XkvDabygdqWI0Ok/u2IdHHNuIIa8OSa4q6U=;
	b=hvLE60Tpg2ceXVVEblS+fvjWXRFZCfUSWbzRqqvdOGkm5eYMYsJL/vuG3iEST5ao88H/Ns
	IH4i3aILuj8ejWhhT/KmQnoLUwaqZA6/xUtjmB4IDtlpckafQV93XV+pK9yAsd01Ueo9wc
	3L8/33XcgN9rv0LoIkVFN+Rt8bpwzN+pgxBR7W8sbf26p34sq5vP5FHKtseQkAkraDMKdR
	wHUddPbCKY60zfpnXkg2LobfalkXXgfTUXWkp+VqUyXWfoyLn8UrV4F6TEpzcq1mu8PYdW
	/3YrTFOLoD4XOZzV5RW2erUMQg1E4NPewpWCHKgmx3VjWQdeZM1yfXbgxjSFww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Tue, 11 Aug 2026 21:32:35 +0300
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
Subject: Re: [PATCH v3 5/7] ARM: dts: ti: omap3-n900: Replace clock-frequency
 in camera sensor node
Message-ID: <antqw21HgXTAnZmI@darkstar.musicnaut.iki.fi>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
 <20260810180604.3034255-6-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810180604.3034255-6-laurent.pinchart@ideasonboard.com>

Hi,

On Mon, Aug 10, 2026 at 09:06:02PM +0300, Laurent Pinchart wrote:
> The clock-frequency for camera sensors has been deprecated in favour of
> the assigned-clocks and assigned-clock-rates properties. Replace it in
> the device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/boot/dts/ti/omap/omap3-n900.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
> index 7db73d9bed9e..97e9eae2b60e 100644
> --- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
> +++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
> @@ -792,7 +792,8 @@ cam1: camera@3e {
>  
>  		clocks = <&isp 0>;
>  		clock-names = "extclk";
> -		clock-frequency = <9600000>;
> +		assigned-clocks = <&isp 0>;
> +		assigned-clock-rates = <9600000>;
>  
>  		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
>  
> -- 
> Regards,
> 
> Laurent Pinchart
> 
