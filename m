Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2748FF95
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988822; cv=none; b=PvnhtxD5046DBGTjXc+R89cdLpgbFh9THZvDIOtRPMR88CN29Df8rGf7EDG5OK11SYVf+g5KJ17KpchlthNWUwMb5LGoau/vg/WBeqKE8o1Gb+RC6jQ/K6tz4uPz1Znx415G6fKZwKMAa6R1G78ax4nVw75r9EWdLrsKl6SJflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988822; c=relaxed/simple;
	bh=UUOINDD93jJS+LUcebWPI3js4hVCQibaR3IC0U7k49c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KklYodxE/sO25WClb0oSGUJjGds4iTz0WiyX+wQNo/e6tPGRxckcp8wSTV3VdRB1yQ6efsjattVJzgfYPuVINLeCptVFovzLh/E4RP0yMhsoY4Xg/5Dd2vpxc9ktSYj6Op4G1zNijnUF0UKN08VBcJ3cQ9TNuG5fYWY4eiS1wVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmd4dzw7; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmd4dzw7"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f38so28464185ad.2
        for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2026 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789988815; x=1790593615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycnprV0l+QiM05HZAYzXXqeG9wnBaUsBNe37TTIlwsM=;
        b=kmd4dzw7YZwUGOpAohpIZBA84zGfg7XBW2MOXiu/6PtAIAey7CGoejz0Zx3N/LAUQY
         hFXz0jGOkd74aCYP98iga4k3O8w5+pl6eeik3e6AgCWKaNYVNkL0KJ49+QuGXt2TOM/s
         /JHmiVKtrRmdFk10TkJzqzwvM4DA3c65JItDPe7ALCMyGcfHUZ7IKfuvW9BuYSq5v4YU
         5wep9KIJutpDUF7a8BqfsG3nRWCmXCfuNK+qLGffBqgpR6zEmK4431v0FSYTS42e2/CL
         USWzYRVdteKi6yadRWl0nFHsuyfd4szDleMnlgzO+1zis8tdTbWLsol2SHHHcRvzcnT8
         GC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988815; x=1790593615;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycnprV0l+QiM05HZAYzXXqeG9wnBaUsBNe37TTIlwsM=;
        b=BBOI/JIzeJazsUuqH34wNv/vC3hM8lYJf6hVblvS+1xa3teLg07kEP9pSmEt9bp1bw
         e+IhwuvDC5h3aI6DvYgA8EDZaCq09TS21+JCxpwuvzQZvNqao89nM1K9pDIhdKaKfdxH
         T6mJO4g/BLdUrwcV86xFUsvs4KCN7qV4sDRzpLGgF+U8C5I4H+OTV0W5MjV2jbyt2s3D
         Mzq4P3FWp2VtKHD2CA6dxBuUEa8ZV80iVSFWYu1/EJ7LBXVmKXPf+WYaYyjm+xuNxTTz
         91WOj7gTUDSyBvTHIcGv67HG0q1viEbCkY7WHfJDQSm/1OZpKUe7G36bCcank4DZ/4W3
         eLLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOHSrQLq9PaqKiijBOa3LRzTOvhh9tNl3LtmLLyNJb4bGvOYS6v+ZGBzMV75CyquQm0On4aWmcnBsy@vger.kernel.org
X-Gm-Message-State: AFuF++kEBmzu+HhaEfSOffIxLEwoywnaPqBoYvFpXIzotcrZBSvXFrbi
	HMbcC1TUnkEGDBMbmJfogZ14iOUVTIWx4d9Sdu0o0ME4z/8b4bahmH0O
X-Gm-Gg: AYBFou39tmlUoZYl+64vzf4zldZ+2a35EGPE/zUiU5BKAHGVTY01cLRWukQrODdPNH3
	z08juxZTYE1FiYTyxYjfPYsLLwW8U03Gly5YBAzSuGfNbkXa6f1W7L1cpnWG8exvvttm2cfWO/b
	CTCpWeHiFzgYkiE9+ZfBoPImNEHV0TSOE8t47KACD6VfGVhm1saR7ScTZnYIprhb/sIioyE8pFH
	f4czJYTvM9Q7HcJ+Hnxxl1CG9KkgBs3HNEeHgluQOpBgpp9vAFTBXqGkmRUo838YO0SugFBnigm
	hVkNU3ui9B3B2qAYLeE5AKesLKCyEIkln7rAXHih034tmJwrL0Ta3haNaOa4x4TkcwOlFWMhspF
	qR+3ZUUSYrv9eCHtHF2v3pt0P6LG35AplUD9CCOCU40MbPjtpTshSm1HvpYkKLStjW3hec5sam4
	2bDDCcrD4zrw7PR8VOnUSSdEjiJbLhrUb4SpbBNp5O578rzpxUKaJZtKoJlrgcn2f7UFGVlszeQ
	7fr7v0dtBXYRDfDT1Uj/1shGcOTwkunmVSnTAOXG2ERLeyaB9M3oPIwn88Kyg==
X-Received: by 2002:a17:903:2447:b0:2d9:43f5:b462 with SMTP id d9443c01a7336-2ddb1b79df8mr144230985ad.5.1789988815140;
        Mon, 21 Sep 2026 04:06:55 -0700 (PDT)
Received: from [192.168.151.214] (222-228-113-186.aichi.fdn.vectant.ne.jp. [222.228.113.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba719sm31428165ad.56.2026.09.21.04.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:06:54 -0700 (PDT)
Message-ID: <17a74e90-27d1-4954-86a8-491267f00cb8@gmail.com>
Date: Mon, 21 Sep 2026 20:06:47 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yoshifumi SHU <envzhu@gmail.com>
Subject: Re: [PATCH v2 00/14] ARM: deprecated platform removal
To: arnd@kernel.org
Cc: Frank.Li@nxp.com, aaro.koskinen@iki.fi, alexander.sverdlin@siemens.com,
 alexandre.belloni@bootlin.com, alexandre.torgue@foss.st.com,
 andreas@kemnade.info, andrew@lunn.ch, arnd@arndb.de,
 claudiu.beznea@tuxon.dev, conor+dt@kernel.org, david@kernel.org,
 devicetree@vger.kernel.org, enelsonmoore@gmail.com, festevam@gmail.com,
 geert@linux-m68k.org, gregory.clement@bootlin.com, imx@lists.linux.dev,
 kernel@pengutronix.de, khilman@baylibre.com, kmehltretter@gmail.com,
 kristoffer.ericson@gmail.com, krzk@kernel.org, linusw@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux@armlinux.org.uk,
 liviu.dudau@arm.com, lpieralisi@kernel.org, mcoquelin.stm32@gmail.com,
 nicolas.ferre@microchip.com, npitre@baylibre.com, robert.jarzmik@free.fr,
 robh@kernel.org, rogerq@kernel.org, s.hauer@pengutronix.de,
 sebastian.hesselbarth@gmail.com, shawnguo@kernel.org, soc@lists.linux.dev,
 stefan@agner.ch, sudeep.holla@kernel.org, tony@atomide.com, vz@mleia.com,
 thehajime@gmail.com
References: <20260914140821.1805449-1-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20260914140821.1805449-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnd and all,

I would like to request that the core Arm Cortex-M support be retained, specifically for v8-M.

I'm heavily using Arm Cortex-M / NOMMU Linux for academic research.
In particular, I frequently run Linux on newer Arm v8-M (Cortex-M33/M55/M85) processors.
However, dropping CONFIG_CPU_V7M also removes support for these newer CPUs.
Because v8-M is highly compatible with the older v7-M (Cortex-M3/M4/M7), the v8-M support is tightly coupled with CONFIG_CPU_V7M, despite the name. 
The major differences are essentially CPU IDs and PMSAv8 MPU support.
So I need the majority of CONFIG_CPU_V7M to support Arm v8-M. 

Regarding platform support, I don't need Linux-side device drivers.
In my current setup, Linux runs in a virtualized environment hosted by an RTOS (like Zephyr) and accesses devices through virtio served by the RTOS.
I also understand that maintaining legacy MCU platform support is a significant burden.
Therefore, I don't object to removing the platform support, though the MPS platform remains convenient for bare-metal testing.

I am willing to help maintain this support, including modernizing the relevant code. I can regularly test kernels on real Armv8-M hardware.
If an active maintainer is required to keep the support, I am willing to take on that responsibility.
Please let me know how I can help keep the support.

Thanks,
Yoshifumi
