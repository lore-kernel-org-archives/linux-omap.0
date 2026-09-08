Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504B59C97F;
	Tue,  8 Sep 2026 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898196; cv=none; b=iYdVN4MgYV/SxQcoxYE1OUIJM8m0tJtsqQXck7OlQeLY790O67cmolDyWjGYa3+8thUX1wiwW0IZ334vGmR8Ft94E8uECGx2/vwwoKI8Uz9Ka8L1x+UfldZ4YJeQZ8ZmKYdrl5byHKBK0Azjzry4UzxE6BS29vObX1zADzKFHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898196; c=relaxed/simple;
	bh=NjpevSsqsdVcBoNaqYNd964U1pKMHVgRtoQ8Fgxmacw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OauWcWgc1YjbSeB5/4IjX+6wb1jBNI61jl83ZWMCsRkx2LLrX7poH5+Qp9MOz0U0DMaPeILeD7UYRd08Gh312YcT1C3o6E2SyX/J0UPYKrdQ6AlHQ35C4SPBiHX4CRyAOOtARnmlCtrgZuTnGR43vMdu8qE0vGKwYoac37B49Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ku2CBzv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ujMQYS0s; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ku2CBzv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ujMQYS0s"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 29C0A1300C52;
	Tue,  8 Sep 2026 16:09:49 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 16:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788898188;
	 x=1788905388; bh=XGzc/5Eb+lr6gHxtsWUeqlpbhH2hHOwRDxbQuElICwQ=; b=
	Ku2CBzv1lbwKt7FkbK1hK9z6lUhC4lyMvWVuJCDperQCrGR4/rovcYZT14+F2GRU
	Rav/lw7wDP1LZUNHanxxKPv9TiMXrWJeF4XcFPkUtSvKXHgFfqD1zYYomxsGk/6w
	D0ugcsY4ct992ReVcs1IUi3KQk3MwK2m0/nVfeh2El0YDoKepsDCsUsJEw2Xopqf
	vUaW1KTQtRtXeElKC9QKtKuQIKUo2YJjj/bJt4iyEuMRznXurrxMtEOYF0Vypnae
	hzllfDFfMF4MLpuFLIHlHRQICSgPksOWfpJUZziA6rKH7zrejjbOHOF06vLIb/zc
	w5HH3y04fc96xLHdT/IkTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788898188; x=
	1788905388; bh=XGzc/5Eb+lr6gHxtsWUeqlpbhH2hHOwRDxbQuElICwQ=; b=u
	jMQYS0sL+Aowo4kNVDUIZ6sxKERcte19OIubGhUn842ROtFnMhzcn9nOmWNq8m7C
	FHmwKHYgoJ/jG2pkJGkAUm7NezuYNDuHEtea2iCCY1h68vHHRw1tbwvNgBC7NsFY
	rbLssRXRc0/8Z7/FVbSv77yvARhK4G2eGFJ9PzzEfE+9jQ1o9Hc+VoCcqrJKguIG
	cVWq5h0ss748M5e43R0TGSageD0VACosHeHSAOqC2oKrcgC+Dywg34eoHUA61vUD
	Om+SXPAR6IF9uWHBupFJaffqsw5yQdw56xQkgFp2LSYGh5EmlOC0wvW/IaDQZnCb
	LMTZ1CVIosTouKpnUkAaA==
X-ME-Sender: <xms:fmuganAtXtSwL-JpSs__4SRF0rTRt5GmxPf831izoU_erzPTWgAXSQ>
    <xme:fmugaoXMuufuq90WbEJq3jH2RboT9th930_-cNxUKLtsWrbB1oneFf9Xz6yLhoedT
    YqurXU9BXFFOxISdk694hhj0cpVnKQYoXn04NuD4ysdyrWwPbUYtRY>
X-ME-Proxy-Cause: dmFkZTEOp8fHm5Y3J5V2OI0TYboevCVDMAAGYDcPknsZa+0X0RAcfHjfIunQUCrjwll0ea
    rAQKkk63eMYO5/YsUuJodvREtVTrCuYoOIZ9cdLF4PumfhTpYgh50Lfo6o9D8QrGucOErt
    1sYxt2QrPbopoRmAf/GENKdf06cSRGVrvjFFQcAbo5nmTHwS3A0bt3HwuabeSgvhnsObAg
    dbPo0mT2Qbsifo2veGFIaoL0lJSdd83VAXqWQzrdwJ/OSfRVxeUmrfI9jQpSwWye6jKqFi
    NOft3xXk0NdTzkITEAa33TJA6ix1zF0AwdpfuVEyfJmRNLBy11archzASh1BSGprZa93Ds
    C+Sv9U/weUns6mx2nwFA2lCN3zLi/Rk8p/J83yqZM7VlcK675+DuzSxAZqfRkMJBci1i1e
    eqsl5xkRkXCorwVc/2lQanGN1S0IbMaPI/UhcGXT2qI1gtN8VcS4pCweSc1uJ3MgWVP5Fr
    fd6wuggi9qR2Is2m5jQDxFEcLJqjzcHUFW7JybEqzCT2wTsaTx7pu+YFjg6kopHPn0PbED
    uooY3D/duB0e3xj8T9BQsm45luJjYM2Rz0k3B09xmHAt8V34sz5JvPIlWK2+nJkOpdV5Fl
    Crqztnvqs4a/7+lCs3/5TbA3fZD27fPI9F+o3hImahc2L0qBOLFE1RAotMHQ
X-ME-Proxy: <xmx:hWugatKoHMBMnZtP17UULzQB6EuGdq9y4KPlROoonj4Gm0uf8OUMXA>
    <xmx:hWugaqqpPwtCM1AUnviPCuSqlRr2u6RRud1ajk-GboRnZDzrQIApPA>
    <xmx:hWugauWHWoYrWzb7a2llPhn3uSnztbyj-cPoQd3ZWlwfPBa7MX2nuQ>
    <xmx:hWugagatGK1_RhDhj2yYgoRPdRO8Qbn-tAse6dSoi-K2c4PVP9gsKg>
    <xmx:jGugarmn9UC73Fhha86G49qnTJMPVdxBgve0N-zdSoV85HG7yX3TtBkr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5E56132A0078; Tue,  8 Sep 2026 16:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwGOxrB98c9B
Date: Tue, 08 Sep 2026 22:09:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Linus Walleij" <linusw@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Drew Fustini" <fustini@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>,
 "Vladimir Zapolskiy" <vz@mleia.com>, "Stefan Agner" <stefan@agner.ch>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Andreas Kemnade" <andreas@kemnade.info>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Roger Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew@lunn.ch>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
 "Gregory Clement" <gregory.clement@bootlin.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Kristoffer Ericson" <kristoffer.ericson@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Nicolas Pitre" <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>
Message-Id: <e768247f-3c29-4d36-a40f-05ec81b45db2@app.fastmail.com>
In-Reply-To: <aqBhF5oS1A2W6dAa@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-2-arnd@kernel.org> <aqBhF5oS1A2W6dAa@gmail.com>
Subject: Re: [PATCH 01/13] ARM: remove sa1100 platform
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2026, at 21:39, Karl Mehltretter wrote:
> On Tue, Sep 08, 2026 at 05:27:51PM +0100, Arnd Bergmann wrote:
>>  62 files changed, 19 insertions(+), 10501 deletions(-)
>
> Note that Sashiko skipped reviewing this patch, because it exceeded
> its current 10000 line limit.
>
>> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
>> @@ -275,18 +275,10 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
>> -	if (IS_ENABLED(CONFIG_ARCH_SA1100) ||
>> -	    of_device_is_compatible(pdev->dev.of_node, "mrvl,sa1100-rtc")) {
>> -		info->rcnr = base + 0x04;
>> -		info->rtsr = base + 0x10;
>> -		info->rtar = base + 0x00;
>> -		info->rttr = base + 0x08;
>> -	} else {
>> -		info->rcnr = base + 0x0;
>> -		info->rtsr = base + 0x8;
>> -		info->rtar = base + 0x4;
>> -		info->rttr = base + 0xc;
>> -	}
>> +	info->rcnr = base + 0x0;
>> +	info->rtsr = base + 0x8;
>> +	info->rtar = base + 0x4;
>> +	info->rttr = base + 0xc;
>
> This drops the layout switch but keeps "mrvl,sa1100-rtc" in
> sa1100_rtc_dt_ids[] and in bindings/rtc/sa1100-rtc.yaml, so a DT with
> that compatible would now silently get the MMP register offsets instead
> of the SA1100 ones.

This one is interesting: this was already the behavior before
my patch, as CONFIG_ARCH_SA1100 is mutually exclusive with all
other targets. That obviously wasn't the intention of the code.

I've removed the sa1100_rtc_dt_ids[] entry now.

>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> @@ -614,16 +614,16 @@ config S3C2410_WATCHDOG
>>  	  be called s3c2410_wdt.
>>  
>>  config SA1100_WATCHDOG
>> -	tristate "SA1100/PXA2xx watchdog"
>> -	depends on ARCH_SA1100 || ARCH_PXA || COMPILE_TEST
>> +	tristate "PXA2xx watchdog"
>> +	depends on ARCH_PXA || COMPILE_TEST
>>  	help
>> -	  Watchdog timer embedded into SA11x0 and PXA2xx chips. This will
>> -	  reboot your system when timeout is reached.
>> +	  Watchdog timer embedded PXA2xx chips. This will reboot your
>> +	  system when timeout is reached.
>>  
>
> "embedded into PXA2xx chips" is better.
>
> The RTC_DRV_SA1100 help text a bit earlier in the patch also still says
> "built into your SA11x0 or PXA2xx CPU".

Fixed all these now, thanks for the review!

      Arnd
