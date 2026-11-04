Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816303;
	b=2YLM33CXnrKhxTlPCSWiUhj+1zijm4skgHag+ykdBDSWkNS3JW3KPWH28s5JzZwXEhVo
	 O2dbotq7OvroNFOa47l/9YsTrbUMl9XqUHBzmczzv0IVxnFUCQfm6VmEzxi/W8JwUM5V/
	 1jG1hxWSwHKMEFfM5XNUG+PcdsEHC15cNN8iYa+pLEK1J/iPykE++sYQyndKnhGEakrYG
	 8kOBH91cOEbnvnwY0xFMyOWYngwlhPry5bFRZtA7hWoAHygI470EBwNPOqa395Fc2E9Fy
	 gWjliDZ19N8RhBw4FTobZEFBFvdlPvOcSGHkcyxZ2DOeYjgYT1poaJPekRwU9AVOlEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816303;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
	b=BaXjkum5V1zz5YWkVXaUodbuh+eXVLA1GzSM83fCtTKV0UqE0WZzotC6V+SDvrybjcQa
	 AMoBJADH2KQ8lSwn5RlWmrK40IazgvOpYSVqAUVqgTPDS03ppnij4+SLX3n6Pzk5X2tvt
	 rponz/xKwMw146g9PTf8eiCkL0RE7g4/JHuUr+k/gbMByBlqKjPBMP4ksYMZD782o1q64
	 mVMdPla5Qpe8CDx2Riqw5gATDIYXxPlomHtg80w7UQQkaA6XFC0x71DsoHcuCONt0Jd6j
	 qLStOfwNSPwtL7wyOp523jL7S9q1Jd0v2LuNQGUZitn2DmcMIjXUUJf+jKjhSLEnasA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RGtOPZQX;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F036606A329
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 18:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F036606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RGtOPZQX
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so684997a12.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 10:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816303; x=1794421103;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
        b=S0pTTFI7uM0pmFeu6GS7jbHPtBsFRc5h8VkR7mCOq7d/NNvTyXAffvUM9rQSStUqy1
         if0aiN5LgzLbrDClMTlNqi9e4MqUB7HAcBN2Yc696t1fV2iE0JIjnHekGz3LPzUrPjN3
         DbvwitQ8kv9d+TKt8vNI6LQnGz3YIBkzUxdhwD3pIMwDzZAYuq7+x8Ve8lgSBvTh0WLT
         b/y9vvxPwvK3iS2kvZtc413gTTbhMEUugkesKfdyfHiURSHoUzRzU5m+X+lZ3i5VJFpA
         9DHhNfDFbkB/2qLkdXSdzilhLyMRnVGlTNYIC5Lzh4kQ7th0lLmmpTpyWynYM2ttH2NE
         Dldw==
X-Forwarded-Encrypted: i=1; AKwUvBzzXr/huTmODhIghFdpfBnj58Q840W75OOZybWQcMD5zoMC1y8SebQnZ4ikKtbZgGhbxn3kSWGCv1Um@vger.kernel.org
X-Gm-Message-State: APuU4Z+MlNkxVf3BPyyy/WbJ3rjzz0/G2ji1vAlVh+sd4Z+N9kzr1tTZ
	4aBJDKb+uIcwWX40ZpuIfSLYmpTwVlhnPVXd1qgkE2ORXR5P19P3tjJfTtI1SetXZFEb6QI36Vi
	X+li17dbAeU1vMvA66JEVwjn2wpM65XhmFG9A8JBrzOSQcNgrNODZgf9QgS62JWYhuf/kMmpnP2
	kUKySC/8ntMxSTn72P9Kbi+WAJP8kD5coQEpilazqnbEQkoXV4USwnHg7JYXo/Py9bDnekpsWHk
	wvrN+uoaEWK4NdyH5lE77CR
X-Gm-Gg: AYBFou0LqcIar+T2I0gBs9nxCgYGwBpLXs1wXHrC4opVcAQSl8FWsZyFXPDKwFRCiF5
	+H8jhoQ1yUQyoEZ+wgyW50pXOmc9ZW0E5uzZGjQo5DJEz7nmjZRmRMETbEl29hCs0rYsPlPlhuC
	WsRwDmyZDBXBB/hj0odJ0HtLrJB1W6DJOo/XN+9qMBqpJcg/Tp91yVc31Z0m5Bo3Qw1t8HAblGh
	s3Z8O5oNklhbzU7eEdadfaoIGLkkDzCfY4Qfp/PoQJPNN54yXvSmhsD6ywRs+g2v8o7ae5op+v3
	5ek0qrQHUNGk5E/jm9xYDBAkPbiu9402VOjYg06xtRSavXy3gGW1dun6OMPbQrJ5k4KTLKKOi8p
	F4af/dgGa1DkNFXB4U5faSnS7OByUVbwdDXdQfeG9U/tzEny57/pt3irHtQoBABUfpuAvn7Q2Hf
	0rwpsm+vhEEPgPDwQPxF1SwpbAwb+FX8+VYCFg9y8l
X-Received: by 2002:a17:90b:4c09:b0:3ac:adce:60af with SMTP id 98e67ed59e1d1-3ae89724b12mr16155080a91.16.1793816302710;
        Wed, 04 Nov 2026 10:18:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b094554e25sm881652a91.0.2026.11.04.10.18.22
        for <linux-omap@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:18:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91785bd637bso27812866d6.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793816301; x=1794421101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sMF+DuUShxHT93jwpB/tWUFXCy+FZ5GF579riWa0i/s=;
        b=RGtOPZQX2Fz9ek0gpNC2zgdSYq0yoKjSv8q/M235QDrvAkXxkbXEdhlbwDUlUp5lun
         FSoUAU25te5vS5o4D349NuR7vfytBFx+k5DOluRTFkT54TjpfElzU2eKd5fMbCHOTvUC
         le9+1vSf+Sr/FhjCDRjA5yTQEiXnEugu5V4BY=
X-Forwarded-Encrypted: i=1; AKwUvBwu2V8g5O0xqm8vzzFFPYE/YGF/i9q4o3/YLGngOC9uu5i8sgHWqIQGZ833MBOrDwkpQaSLhicyLcPE@vger.kernel.org
X-Received: by 2002:a05:6214:5781:b0:91e:8baa:f132 with SMTP id 6a1803df08f44-91e8bab0503mr27359876d6.14.1793816300858;
        Wed, 04 Nov 2026 10:18:20 -0800 (PST)
X-Received: by 2002:a05:6214:5781:b0:91e:8baa:f132 with SMTP id 6a1803df08f44-91e8bab0503mr27359016d6.14.1793816300171;
        Wed, 04 Nov 2026 10:18:20 -0800 (PST)
Received: from [10.14.197.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e8dac2a3esm9677426d6.1.2026.11.04.10.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:18:19 -0800 (PST)
Message-ID: <c5ecea1e-ae30-4df3-8684-39cfb8288127@broadcom.com>
Date: Wed, 4 Nov 2026 10:18:12 -0800
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Aubin Constans <aubin.constans@microchip.com>,
 Ulf Hansson <ulfh@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, John Garry <john.garry@linux.dev>,
 Hemanth Selam <hemanth.selam@gmail.com>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Rosen Penev <rosenp@gmail.com>,
 Fan Wu <fanwu01@zju.edu.cn>, Marco Crivellari <marco.crivellari@suse.com>,
 Pan Chuang <panchuang@vivo.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Rakuram Eswaran <rakuram.e96@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
 <imx@lists.linux.dev>,
 "open list:OMAP MMC SUPPORT" <linux-omap@vger.kernel.org>,
 "moderated list:ARM/ACTIONS SEMI ARCHITECTURE"
 <linux-actions@lists.infradead.org>,
 "open list:TMIO/SDHI MMC DRIVER" <linux-renesas-soc@vger.kernel.org>,
 "open list:ARM/ARTPEC MACHINE SUPPORT" <linux-arm-kernel@axis.com>
Cc: vkoul@kernel.org
References: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2026 9:21 AM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across MMC host drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/mmc/host/atmel-mci.c             | 3 +--
>   drivers/mmc/host/bcm2835.c               | 3 +--

For the above:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

