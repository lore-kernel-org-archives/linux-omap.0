Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705748;
	b=yMcng6hmV21I/zYPljiEmjCLxINH3gwvT1uH55quSZqoI31p8B8OjuRdBO+KnXrEtdDF
	 WCi6KV3AX68f/esmb2si1oDmZpyAZdmZTfeK0mJdaz6J+4Kio6hxjONsYsMY4luTHajvD
	 yy3/lMdK8f1YB1WXPuqoXgq6hM8d2sUXoMNXAnor4aAApGNz4gCM7Hr1RJypmLd2Ti30L
	 JaLrb5OmR3KrjCEuwNj4m9HGzlF4vXsVLREXikvOlGkwkbOPxt/Qllh0pilhBexeiaUPu
	 ZGkW7ClZiEZWzn1Y0spcSTB4Qr3woCXArDz7lOkc0d+qUUgNnb0ZXju8B0duMWgXqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705748;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sXtleGioD9i4yzeP51aOqPnUyfmsKKBbpPqlr4rXmFc=;
	b=k4SbCb4lWEKDNm6XKsrH3DiOfKem8Pd2oHGQD7BOarf5bdhcp7B6W2PlUfuL5oVkDHki
	 Qx8OwlqB4BHSUViJt4uOAUGSyeudkeAUeHbdZZqhUfjlgEGmjLwWJ8bOj9ufKzFeSMrvD
	 37scQGGYnPBieLYYw0gW4Q5HMqtnzkziurZX7H1Q6ngouGE+OYA2mjie1JS79rNKBxarR
	 bxTpyNKHpT4ywoDbVlx3GRaG6877svMHPbE9d+i2Kjf6O8jRwWqA38Zq82GTzPQBCU1e5
	 wY8bMGxWMJ1ZGQK/2CyIsnWPlMWkys2W7+1eNiiN5sz9ZLekWfwpl0ANKBO3ehb22TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdLqbgFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EC606A321;
	Thu, 26 Nov 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdLqbgFi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC51F008B2;
	Thu, 26 Nov 2026 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705747;
	bh=sXtleGioD9i4yzeP51aOqPnUyfmsKKBbpPqlr4rXmFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fdLqbgFi16ERxCKZS3TlJOBEWZDcUg4j2+7RZ7d1nPbvU8cGK/BbRaOswzaM/qMQQ
	 TBF57zpVWs9TWcPE12i6uDPoGaZAx6HlSbOQdiEdDjNViK3531iDxQXEF+TWmBQ4BT
	 FPxdUetemhD325WGK97IZubRgBRxlQqrHIc+M2LEeh7T2t8DJg3CDQzw8luRnchZCI
	 nIONkIUze91X4m5RtyqTt0PqouktGWGmrnmPj2dLnMfkLgdEZiRXCPJYbSHzcVsdiI
	 Bqbkf+VbS9aGX9SV5Lyt3PWKZDHJNtlMusgVfWr2qVAPi+kQp2Dmm6XFuav7bJGO+w
	 F20r4lw1q6ycQ==
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: enable MDIO
 manual mode for AM62PX
From: netdev-bot+sashiko@kernel.org
To: paul.louvel@bootlin.com
Cc: s-vadapalli@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 bo.mellberg@se.com, r-gunasekaran@ti.com, thomas.petazzoni@bootlin.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 26 Nov 2026 15:09:06 +0000
Message-ID: <179570574643.3135.14735411472140750286@kernel.org>
In-Reply-To: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
References: <20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch turns on the i2329 MDIO manual-mode workaround only
  for the "AM62PX" family string.
- [Low] The commit enables an erratum workaround to fix a problem users
  can see on AM62P: MDIO corruption and broken external-switch…

--

net: ethernet: ti: davinci_mdio: enable MDIO manual mode for AM62PX

This commit adds the AM62PX SoC family to the k3_mdio_socinfo table in
drivers/net/ethernet/ti/davinci_mdio.c. That turns on the MDIO manual mode
workaround for Errata i2329 on AM62P. The erratum document does not list
AM62PX, but a TI E2E thread reports the same issue on that SoC.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1647576/am62p-external-switch-connectivity-problems

> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
> index c413887657e92..9b58ba7acc4fa 100644
> --- a/drivers/net/ethernet/ti/davinci_mdio.c
> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
> @@ -505,6 +505,7 @@ static const struct k3_mdio_soc_data am65_mdio_soc_data = {
>  
>  static const struct soc_device_attribute k3_mdio_socinfo[] = {
>  	{ .family = "AM62X", .data = &am65_mdio_soc_data },
> +	{ .family = "AM62PX", .data = &am65_mdio_soc_data },

[Severity: Medium]

Should J722S be added to this table as well?

The cpsw3g_mdio node is in
arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi. Both k3-am62p.dtsi
and k3-j722s.dtsi include that file, so the two SoCs appear to use the same
MDIO instance:

		cpsw3g_mdio: mdio@f00 {
			compatible = "ti,cpsw-mdio","ti,davinci_mdio";

J722S has its own family string in drivers/soc/ti/k3-socinfo.c:

	{ JTAG_ID_PARTNO_J722S, "J722S" },

This means the new "AM62PX" entry does not match J722S. On J722S,
soc_device_match(k3_mdio_socinfo) in davinci_mdio_probe() finds no match and
data->manual_mode stays false. The driver then uses davinci_mdio_read() and
davinci_mdio_write() on the hardware MDIO state machine instead of the
bitbang bus.

The commit message says the erratum document under-reports the affected
SoCs. If that is the case, J722S being absent from the document does not
show that it is unaffected.

Was J722S left out on purpose? If so, could the commit message say why?

AM62AX and J784S4 also have ti,cpsw-mdio nodes and are reported by
k3-socinfo, but neither is in this table. Their link to this change is less
direct, though.

[Severity: Low]

This isn't a bug, but should this have a Fixes: tag and a Cc: stable?

The change fixes an MDIO problem on AM62P that users can see. AM62P
CPSW/MDIO DT support came in with commit b5080c7c1f7e ("arm64: dts: ti:
k3-am62p: Add nodes for more IPs"). That was before commit be5fc78a0084
("net: ethernet: ti: davinci_mdio: Update K3 SoCs list for errata i2329")
reworked the i2329 SoC list, and that rework did not include AM62PX.

Either commit could be the Fixes: target. Without a tag, stable kernels that
support AM62P may not pick up this workaround.

>  	{ .family = "AM64X", .data = &am65_mdio_soc_data },
>  	{ .family = "AM65X", .data = &am65_mdio_soc_data },
>  	{ .family = "J7200", .data = &am65_mdio_soc_data },

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125-am62p-mdio-bitbang-v1-1-aebf1f5fa3fc%40bootlin.com
