Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DA3AFD00;
	Mon, 20 Jul 2026 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530151; cv=none; b=UOmt/SM1NSGVfhiNsP/5swhZAtkEsg9qyf8GvoG3oTQSVsbdJXMmiDS8qhHKUQF2XLxcQ2jXkLAEuTfOjwc7Qtjs5dABaP4KGq+elqsbU32Z4xUQoV5tKmHJ8YAbl9oSGCWJ7zmeJA5gfSxbgXSXYhOsRgbTBfdHQNFt6Pjga/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530151; c=relaxed/simple;
	bh=Ry9+H351PRVIvu5vCfIer432Q6M8xqRP0Sn/miUHYkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQUJXkVD12BsD4rChqCa5h4blWi7Yo8Y1YNjtcFlmQHf410KAl+LcHAArYXJqO7yrzGxU2JanXGWJs5nyf6PczVBrFAqCwo9amYD/0wHWsSy4Jersn3JJF1LvyqcILkzhK1Kp7MWsdPoWjlIDC9HkE0I56t2tGFTOExlpl6BwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nde6GuEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nde6GuEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EF1F000E9;
	Mon, 20 Jul 2026 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784530149;
	bh=Ry9+H351PRVIvu5vCfIer432Q6M8xqRP0Sn/miUHYkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nde6GuEr7OlZiPypguZ1cJnwb3Qwsv0SJG6vGPlgn/HdybXuagqtMMNzQPpy03iYj
	 pOYLpshQ9s8ytGcVd3hVXJgvar756OtCIteylABt4yOEwBw+z25FxD7f2tGndKR1KA
	 84SHixNIGqUbo6cmf1+3Zzrl8bdKYXV5CKMbk9hX7fk6TZgjigadigeyKq/qhQmf2T
	 +BBw0z7rpupjz5WKoTulj5uPlBpGZPWzJbsQy2IUMgW46P21XGvW1NM00Fey8yb4Oe
	 jiN/46wfxPy2DWT4a/T1ZdMjMby6lTkefLa4+sGeNanxwXIAHDhKmRzcIBr8quHM+V
	 y0H/88c/+k2tQ==
Date: Mon, 20 Jul 2026 08:49:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
Message-ID: <20260720-debonair-calculating-muskox-830657@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-2-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-2-egbostina@gmail.com>

On Sat, Jul 18, 2026 at 09:56:30PM +0000, Eduard Bostina wrote:
> The 'isink-en' property is not read by any driver, so remove it from the

"...is not documented and not read by any driver..."

> TPS65217 backlight node.

With this change:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

