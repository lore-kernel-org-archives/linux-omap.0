Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356250;
	b=XO7nuUlSXd9VwEvOc2jlJ9vymn/ZzQfDnurKGuaDcseqeiPo4QaRxTY1XO4vYXnt3qqW
	 /8f8J8Kz+RiNAVSEUw3IaY43o3F3eSi+1PqvhhrE3FBrRHwUJH2/KbvJ0ax1f5vkRoBSx
	 ul1ggWlV9Oykf5SemY2bIcdvrlt+pBImIQArF65R/411GmQ87cRBUdmTw0z0eFL2Rwyvv
	 BfzJW7joYstvaW9oCtwF4Nskf+aGV/nqZivs2fOzNNzS8kSnaowE2vqDQvpgDzmBTeNmb
	 zqFMpRR5eYlyN3U+0kc78B6HBMdMXH75LGrrX6SHgviF/OBBz47FZGdRxzSfYpxFLOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356250;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DMSB0S9yiCeOUcAaz9FS5qB4n2z+ffGpdh/P4EfWTmw=;
	b=wSZQct43XS6MCQ9s5ytgTe+zwfqeLCJ9LJLnA+3RdVwN+JjMunPP/Wsk9NtQ+OljKFiO
	 JTjGIdhZDIlzOzPErkQOvfnFN2NQA1imnma2FbBXAQtA/r3huVDwRVrO9gER0CHtegQ6z
	 QSYTbXsYUIHeDMcmFdc674ihnD9u1oIQI2oFByzj6pZghRpyIVqI8M81WD1fQSIcDBECN
	 tDoQWfwuSXmX+TXZzkDN7nazb+1vVOk7ECoHmNol61AvTuB/CvuoECR6B1E+BsiR0dc/h
	 +xmteLaI7s4wjCtA92H+n4sjFnfP8xKdbqu6vLKLVxUSwqRL4wU+1R9WF4N3eOHKNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ufc40rJ5;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E0606A320;
	Fri, 30 Oct 2026 10:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D84E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ufc40rJ5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=DMSB0S9yiCeOUcAaz9FS5qB4n2z+ffGpdh/P4EfWTmw=; t=1793356249; x=1794565849; 
	b=ufc40rJ59KzrE6MGxdgtIWMQLD0JCNxLpA5hSvpj4AofP/Y9nIHq0f8zeFK6KmFkQVqbZqnT6Pt
	ClxDxikvfkbpYerIL3ii3MPF8gneEDYOuXiEgqmIH7FALWm3ncAM0MFhkLA0B5aUfMtmmybJb29Af
	jC7Nc/WJHBIBmwJTu3YcFK2Z3YtP4gm/nZiiyIPVyUgRfco24988/s3Lcr8liTiOYH/393LZr1mdA
	Kpk45XVA5ja9s1j4nwBOCVNo268SaC9WOR3hfrse5hdxYEGZGdTzEkDFdzVEbhPozfVuOR3Mvp1RM
	8bYGZ/AXNQHnXQug02d33qTZJgmbvczhvdnA==;
Date: Fri, 30 Oct 2026 11:30:32 +0100
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
Subject: Re: [PATCH v2 4/9] ARM: dts: omap: dm816x: refactor and align MMC
 node
Message-ID: <20261030113032.51b92b19@kemnade.info>
In-Reply-To: <20261028-patch-ektor5-dm8168-dts-v2-4-4544429251e2@linaro.org>
References: <20261028-patch-ektor5-dm8168-dts-v2-0-4544429251e2@linaro.org>
	<20261028-patch-ektor5-dm8168-dts-v2-4-4544429251e2@linaro.org>
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

On Wed, 28 Oct 2026 17:06:05 +0100
Ettore Chimenti <ettore.chimenti@linaro.org> wrote:

> From: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> Update the MMC node in the TI Sitara DM816x device tree to align with
> the structure used in other similar SoCs. The changes include
> refactoring the node to better describe the target module and its
> sub-nodes.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
> ---
>  arch/arm/boot/dts/ti/omap/dm816x.dtsi | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> index fc124f9ecfa1..e3d49651b44e 100644
> --- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
> @@ -423,13 +423,34 @@ &edma 20 0 &edma 21 0
>  				    "tx2", "rx2", "tx3", "rx3";
>  		};
>  
> -		mmc1: mmc@48060000 {
> -			compatible = "ti,omap4-hsmmc";
> -			reg = <0x48060000 0x11000>;
> +		mmc1_target: target-module@48060000 {
> +			compatible = "ti,sysc-omap2", "ti,sysc";
>  			ti,hwmods = "mmc1";

do we still need this?

Regards,
Andreas
