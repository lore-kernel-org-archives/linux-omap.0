Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568665;
	b=UwCD0I8URTEfsycY4vxU1Jh2V4M/py534pGdj4LidZpXT+fE3TysqCA0jL1byzaTUkcC
	 9Il09ff1o2pLRIMlwSGzf7vrD+FRKtv11gPxidAM9ZfD2wzjzYV92dlC3zl6EmKY8UjlB
	 XnCgrignLE8yXy7sAubShM7nwJefoaGneWnTIvHYrkoBENsl1crR0nScT3l4YkUv+US6I
	 1pDFWISBSlK35+REFgsFQMlk7vBbepCBkmJCeVY5m2c9FLGlK8Pv0rWe/Vnd47o+u6oyX
	 2bJBAweTyxirbEXIAblI9S4v9VpGEfl3Xz14F7DVRHcRMKBWh3XAGcfOg488ddKaXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568665;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ev4Pxa4GSZfTGiitPcTMLqPoai9j4iSbJvD57fBcqKs=;
	b=OpXxq33DTGZfovRE6PqGP5EcO5tNFaXlO1/M3tBAuRlKY/KfdJYipkx6oj9VBvcg1kIA
	 IrCYelOLQCbr2q01fKeU8BRzaIfHC9e9WBVh/lQsoYcMBoQyKrHSTzvelVIGC3IOEEzGP
	 mVPUiwRkHPyQQiuTYu22noHjKOVLAHfCEIA3etFRPyFU93LOHqTGyiAzvFu5h5c38UYLr
	 yf/eenLg1uM2i82N4g2B35MLvwuNkD9sJfn6UbXmj0PN3Cq6qlLjOBe+KTHBlJ1IjUmml
	 XEJLDwpWPCtXNiE4vTKB7jiR2f7J2aOQ46pwrKC/I+1KYC2K+jm+mDFsOmcgiPBHGEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=6cay0KLm;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3A606A324;
	Sun,  1 Nov 2026 21:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF3A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=6cay0KLm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=ev4Pxa4GSZfTGiitPcTMLqPoai9j4iSbJvD57fBcqKs=; t=1793568664; x=1794778264; 
	b=6cay0KLmAfpCqyqJaYLyGkeohUHbrtWZHZr+V3bgpGl2vnY3aRecnJYlHs76QVJdqdQFCVDBHD8
	HOPN/H7kN+m2z/p94DtsWBGq19/cxh522Y7xiDcT/NNQsaadlp99VHhnQtvUshYNGOw33Tv9cJ3kS
	i5ZENweeFOiGaXZIlNDkT80xLOXccq2xnkjEaMYjX8HPTijhCxJA/BGTQEvy8YFdW3kPNjjxiTOk5
	M/AcfUGTi527e8QQSyBH2EM6bTyVloJC1lhiXzSHXM7/Z8WZbtj/J+tuoJM10NDI50h+6VHeNPXxt
	WZbYxe0WGV/gkv8kCiyr8AUpSB3iXGztjzCQ==;
Date: Sun, 1 Nov 2026 22:29:42 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Christopher
 Obbard <chris.obbard@oss.qualcomm.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Paul Walmsley <paul@pwsan.com>, Russell King
 <linux@armlinux.org.uk>, Rouven Czerwinski <rouven.czerwinski@linaro.org>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/9] ARM: dts: omap: dm816x: Correct speed for
 sysclk5
Message-ID: <20261101222942.1a78c6fb@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-5-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-5-4544429251e2@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 17:06:06 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> The default code for setting up the clocks results in sysclk5 running at
> 1.6GHz whereas it is expected to run at half that ie 813MHz. Force the
> divider to be /2 to achieve the 813MHz speed.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
> index 76ebc6c3c3e5..cb990773b098 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
> @@ -144,7 +144,7 @@ sysclk5_ck: sysclk5_ck@310 {
>  		#clock-cells = <0>;
>  		compatible = "ti,divider-clock";
>  		clocks = <&sysclk4_ck>;
> -		ti,max-div = <1>;
> +		ti,dividers = <2>;

so this changes register value  0 is intepreted as divider 1
to divider 2. Sounds strange. It just changes the interpretation of the
register values, not the setting. Maybe checkout the register value from
user space with tools like devmem. The original interpretation was right.
So this change does not make any sense. I think sysclk5 still runs at
1.6Ghz, but it is displayed as 813Mhz.

I would expect some assigned-clocks / assigned-clock-rates pair somewhere
in this patch instead.

Regards,
Andreas
