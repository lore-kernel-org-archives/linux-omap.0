Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8372BE7DD
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867858; cv=none; b=Sj6cGqu9+di0FntL9hlt9VdFocseUxN06Hr1d6zFYcVtbx38RyaVDJafir/KipTvburhM8XsqLgfmo2Z4WCY09A50sOnRk2SHoA/RclndlNKoxGcylcJHiKapGWdweJqKivfnODa8vgFw9jgxQMhSIsEynI1vua7pFa+5nwIHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867858; c=relaxed/simple;
	bh=Qzxxfb7kEku2747lmzT1fwRiAYJSGvUIx6A0aGIdbAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuxJxCc4LGXjUQpN/hNvdYk/zBIPuVncxHtl4RPfdZeUpHhPqGwlj4g0vchMqKwccrfDlpiEPT0LTI0U0yaM4YXJqYxIWTmTKPXO+AEIY06Ql54XiNn31CdmXy6uqWKD7q3pT9W8pvprT/1vsDG43FzMU8hhvxburbT/qPehV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YYjvRE4H; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YYjvRE4H"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-40ee196dd78so2705865fac.1
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867856; x=1772472656;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8V8psmXfo8hyIGZcjW58KCT42psor/P8r1YSImT3V8=;
        b=c87UT9EVcidRi8hGVEDn6Kl1UjmKHaa6MMF3MptCmIHKGlfNCJgzjbFL3Jlm1K8Lji
         QfZtUOvr+24J5ewcDmVeAjS6EM/S3ywgkXEECB9W5kWCqDsxCWVD2mb5o5042cAJsZJM
         kZKlKV0OMV1cQ9KGK9IAA2toGkpEIcmq40oY0LipW45ak8N2YsQ8NaaAsd5oZ9eGJEX4
         McLpBTuHoEacspUWDpqQjAyBJOfTg5IQyHcDEIHgRcUlaC4aXNBqbMjJ2i9qAGdGkOOD
         Al1XUetgVbRplqGmcWxu8/AgmKnJQF6DhEqKs9Z5C0KarLXUNFT5VmE0bLtIugSyW/cO
         s20g==
X-Forwarded-Encrypted: i=1; AJvYcCVMt+YiXZ04nYfZJIXd6FWyc0P1kVrUpYto4QPbvaZ4HsTcrlQ8Q8dCdZwmFwbL1qcNzcOTfT/zhlbQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjRtjlPskOdviwfB9hGcVpxmqFFjRLVcND4bVeXSVsLAEitzS
	9yFxpAexIZYXrj84sKUfP4KZ7yjbroSPS/bY8reWVDKEVzPR3PuFTRFB07EmdJ9/10PGC8d22vP
	cEqaw4oPoiMrLbDCS9b1qEbvB+1jVbPxmd0ME9NudEFVUeHCp+tbg0CfxygkO3lyaNgs2+qug4W
	ILeuqB4BPiRvSdcN+m6jSTZnme/J2539hWNBcJbMsyKMOinCG5e2UYarPFiYBeKjUKxcATFjG9L
	tH2/0dbxyLi/uYbfjJJ/A==
X-Gm-Gg: ATEYQzwBqh4Lduf0m3djCPltXpfBPRrsZS6x8FP4XXVELaaF2wdzFeb8fYQiBpLut0R
	Aw3GT8nI8/Vu6dGlEtWoDU7IElf/GQdzE+cScVKGauwpQCqnyP+fVC5d9FYxIe4kSqEEMR1VaBq
	/Sshk61N3XUdSkF+QsFrcKsg914Qj1TeKnzo3NNW2B0hyvororcvMTPX8/A9RzzBhVJZQkh2ot4
	XuvOM/EIbLKWYPb+rNE/ZHowmGHcllCqVuHWZUvR49PbCmq2kTSQ8pjpoj6E/2TK1BiXq/xPmno
	iYVKjZ6k/2wFIItIUjRA1XQykwNYF3lG9VmalSQ9nrs/5xnh4algSlSSAUdwFeKqyFFMSGrkwfH
	/oTZV7XFeDPLOKgeFbsl5EvDGvogQXv8v9aCHE2H4OosxpQJJPjAwFGnuk8Q0o23LfTSrqdeFpr
	AkDdfUFK+L92IdDPjhd209A577AAo16YiyNmmCvgmpQWOry1IyF6LJSI+8BIsqG6MN
X-Received: by 2002:a05:6870:b0d4:b0:409:5e6d:2716 with SMTP id 586e51a60fabf-4157a8688d1mr5138018fac.5.1771867856030;
        Mon, 23 Feb 2026 09:30:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4157d2c8b35sm1073036fac.11.2026.02.23.09.30.55
        for <linux-omap@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:30:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12734af2ca4so3938410c88.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771867854; x=1772472654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8V8psmXfo8hyIGZcjW58KCT42psor/P8r1YSImT3V8=;
        b=YYjvRE4HruAu5OzT7QZgqGW7g70xXAhKcDsBNonHu2yW0hARBd8aBGgcAEuairOtRX
         NRSCf9n0jFz6aPCuDkXlrWTLY8R6a7zt5D/OueQbP5AFFsbUTm/Gxl6l1ZMFhr42tiVE
         8kXPbEOKedaAjG4vVc3XX+RafSvKOijAw4ssM=
X-Forwarded-Encrypted: i=1; AJvYcCWF6Rm0Pb3DRXEwMFRrMNJwta3t5m/S45NjwCoMzjIVlJLOUQcAJ8YRGMuQTGUyPcK1kXBSEhZEmsl0@vger.kernel.org
X-Received: by 2002:a05:7022:6b98:b0:122:154:7826 with SMTP id a92af1059eb24-1276ab5845dmr3541898c88.3.1771867853497;
        Mon, 23 Feb 2026 09:30:53 -0800 (PST)
X-Received: by 2002:a05:7022:6b98:b0:122:154:7826 with SMTP id a92af1059eb24-1276ab5845dmr3541858c88.3.1771867852486;
        Mon, 23 Feb 2026 09:30:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm5627944eec.24.2026.02.23.09.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:30:51 -0800 (PST)
Message-ID: <73a783ed-ac77-4d4e-b1f8-6114c33ac33e@broadcom.com>
Date: Mon, 23 Feb 2026 09:30:48 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] i2c: bcm-kona: set device parent and of_node
 through the adapter struct
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vignesh R <vigneshr@ti.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
 <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20260223-i2c-adap-dev-config-v2-3-d78db0a6fcf7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 2/23/26 01:05, Bartosz Golaszewski wrote:
> Configure the parent device and the OF-node using dedicated fields in
> struct i2c_adapter and avoid dereferencing the internal struct device.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
