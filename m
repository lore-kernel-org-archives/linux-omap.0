Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774A3D34B2
	for <linux-omap@vger.kernel.org>; Mon,  9 Mar 2026 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068116; cv=none; b=b94S3zfKbg9tTxMKudRhG4krLHd8koF9qUBmFSI1iplML9ya1VmUvNOVshc6Tbie3xdw7xBFn9YcnabKWdFw04W68qRXhu7EmD/AKwjEosKZ5//kLpt+Yl/LbBMSCHSmi6hIOVBz/lF2NxYjqCtZf9LqKGPmMOfphqRyYJAHTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068116; c=relaxed/simple;
	bh=x4QP15R/9B+N5FOjDqYYIRxEF2hUc6vGxoVhCVIDDdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=futYXxwmMBuCEXoqgXorZYsGDINmdM+KTe/1iRkPuI55+HdFKncJp/SMb88/W5FISpPz2HJfj42suUZBiAdNR3Ck5YVzgGGCNZ1DnJzyr3EFKRNwWAhvQR7goSMR65PgY256WJqMZ3+8kvh+q4d3GOc5ZBt5CzMpZxJxV2W3mm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk0RlBnn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk0RlBnn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso36996335ad.3
        for <linux-omap@vger.kernel.org>; Mon, 09 Mar 2026 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773068113; x=1773672913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1i5e7Q8gFbJD5fnK2/pRPBASYfAfCYgjknfSgkScnQ=;
        b=Pk0RlBnnPF98zh7/LFFhSz4hbxnXrJtj4cnO6/csqEK9o8OVfxPoaDww6Z+cl7rM8/
         GtPGhjMw3fBYynpFpPfJO0VoEg8tOuBxTpoujIbIxxJEqiJ/Oc344zO8EcwDf/8G1go/
         PbV0Tn1uc8/KDw12BqLxWkHJqqZ7lJwQQQ22lATOGPYOcALvk2VlzIccWcG/oV/xCMEv
         YCipeo0pB6K2tbNvz1xxOvdaSMyxrt/rUtDClunqxDeo2LPgxFXDJKl+Djvlw0WJkjiG
         L/aBOOrjHi9r87LaTSOYWJSzAoflr/+JAppvtKdIGCZFeQdxkQBOym2ZS4Nc7EiMsC4p
         OIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068113; x=1773672913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1i5e7Q8gFbJD5fnK2/pRPBASYfAfCYgjknfSgkScnQ=;
        b=V0mEiWBbMVHAsO4YzslMR9rkeNLLSAGLjSNY0hUHwrMSuA5yKnzK9sL3HVyVsbQUGm
         pQCbxySJE0+0bELU69F5tj+64lsGGblYmS9WtBYhpMo7xLZzM1/emPlCH0iSpd2jKC8v
         JnbF21NKdt2+KUSKUSDI2N8vi9NSaRl90Nzeyqbd7Ue9O1b06y/VAnRA3d0BhOsbvohZ
         brAtiY60/dMH50MMmhtPz6fQTj656jAiBnNW7XGp1cPa981R+3TNGNWhaSqZkt1Ik75d
         gfztUbULryrOlolD8lzA+NdF040QV3IgaXdZn6pZj0jMIKIpNOivTlQcScM478Jid260
         kj/w==
X-Forwarded-Encrypted: i=1; AJvYcCURbXy222bvKUzgILcn7PqdN0987c843CEKAbXYyi+yM7DNXk07zg1z+4J8sXMVlmz0HHu8iSZaSrLm@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOM/vZq8XCjEzJfX0H2tXUtWgGTbRz/NB8Z0rFM9vlgpZGosf
	9Ar1vD8aw2MnKDOyKW53RqevhjQWE1aQ+JkuzmajQggl4MP4G1ve3Hnn
X-Gm-Gg: ATEYQzwOLGPWfbs8OUA6BhQfkPPCjVAzs02z+i4KkR9MFE97TqiA5FSv4ITh5jAwrRK
	Z8mhGIlVt9df1nWgesJ3EhjgveAE7onIoYdGuML3xwkr82wibr6+vYePogQpJDlMaQvj8uZMjMA
	X6TYxJX6Z+MOCs81/nkdtYEGco0Yur8EOrdeLD9ZuzszlYMgfRMeF/Uo/nRjeO8OcP5FcuC1R8i
	KIGtt8g7QY5FUkYKJVk9y5WYF45/rwPKdLUEqYvsCexsd20nKxRIEFgaJvKd05j8ehpG2iN4PFf
	BkFX736B0swlt5nYTCoJS+nMAOBgH8vv+LvcM05c3msLpwQzCojZ2fdvdzfqx4G2m+dkR+EF8gz
	Y5izB8bNbbU2Se5asciyoK+R1C0cllHQiOyIbfDBRHmLB6/NOlEVFYpWQbssb2aazYBVvc9Ba+e
	oOxSKZjvj+UUs2tA+9fUmlGe30HHGEXaGM12DM3yG9elUB5450CzrKGxk=
X-Received: by 2002:a17:902:ce83:b0:2ae:45bd:9b39 with SMTP id d9443c01a7336-2ae82416b18mr115119055ad.12.1773068113255;
        Mon, 09 Mar 2026 07:55:13 -0700 (PDT)
Received: from [192.168.1.6] ([27.7.215.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e584aesm115567155ad.3.2026.03.09.07.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:55:12 -0700 (PDT)
Message-ID: <afd2974b-fd6a-4d2c-831f-ec2e6e656a98@gmail.com>
Date: Mon, 9 Mar 2026 20:25:06 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm: dts: ti: omap: align node patterns with
 established convention
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Roger Quadros <rogerq@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260123-ti-phy-v4-0-b557e2c46e6f@gmail.com>
 <20260123-ti-phy-v4-1-b557e2c46e6f@gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20260123-ti-phy-v4-1-b557e2c46e6f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, 
This patch from this series is still not yet picked to apply.
The dtb_check will throw errors to the YAMLs in this series if this clean up patch is not applied.

On 23-01-2026 21:09, Charan Pedumuru wrote:
> Update OMAP DTS node patterns to match established conventions.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  arch/arm/boot/dts/ti/omap/dra7-l4.dtsi  | 4 ++--
>  arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 4 ++--
>  arch/arm/boot/dts/ti/omap/omap5-l4.dtsi | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
> index c9282f57ffa5..ed206eb84d02 100644
> --- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
> @@ -328,7 +328,7 @@ ocp2scp@0 {
>  				ranges = <0 0 0x8000>;
>  				reg = <0x0 0x20>;
>  
> -				pcie1_phy: pciephy@4000 {
> +				pcie1_phy: pcie-phy@4000 {
>  					compatible = "ti,phy-pipe3-pcie";
>  					reg = <0x4000 0x80>, /* phy_rx */
>  					      <0x4400 0x64>; /* phy_tx */
> @@ -348,7 +348,7 @@ pcie1_phy: pciephy@4000 {
>  					#phy-cells = <0>;
>  				};
>  
> -				pcie2_phy: pciephy@5000 {
> +				pcie2_phy: pcie-phy@5000 {
>  					compatible = "ti,phy-pipe3-pcie";
>  					reg = <0x5000 0x80>, /* phy_rx */
>  					      <0x5400 0x64>; /* phy_tx */
> diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
> index 4ee53dfb71b4..d8b16cbe6c35 100644
> --- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
> @@ -72,13 +72,13 @@ scm_conf: scm_conf@0 {
>  					#size-cells = <1>;
>  				};
>  
> -				omap_control_usb2phy: control-phy@300 {
> +				omap_control_usb2phy: phy@300 {
>  					compatible = "ti,control-phy-usb2";
>  					reg = <0x300 0x4>;
>  					reg-names = "power";
>  				};
>  
> -				omap_control_usbotg: control-phy@33c {
> +				omap_control_usbotg: phy@33c {
>  					compatible = "ti,control-phy-otghs";
>  					reg = <0x33c 0x4>;
>  					reg-names = "otghs_control";
> diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
> index 9f6100c7c34d..5c94db589dd1 100644
> --- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
> @@ -472,7 +472,7 @@ usb2_phy: usb2phy@4000 {
>  				#phy-cells = <0>;
>  			};
>  
> -			usb3_phy: usb3phy@4400 {
> +			usb3_phy: usb3-phy@4400 {
>  				compatible = "ti,omap-usb3";
>  				reg = <0x4400 0x80>,
>  				<0x4800 0x64>,
> 

-- 
Best Regards,
Charan.

