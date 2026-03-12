Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5F3EFD3C
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335235; cv=none; b=F7c4QN/NvjFJAe+HEw3a9vwktlwduRKB63WWf+Cw/neM6rBuH4S8WRzojZl89xvB3WZiMq7uOx12+1nVSSS2WCTdxhbsznqOtu1QuGjw2eTlxge7t7ZiO0AiZn/fNA2kDJ/1FsyR4FoIdWXxGEyDN0f8Rd8rH6A+YB+l4v6Xm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335235; c=relaxed/simple;
	bh=4YRmuyiZ3BSKrd+XqEKuYmpqHzSqvCpxgtwy4jvlN5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZAA51WUf5IXBR+gnT0YT/Nst4OzPD3G8/kHCfl4RzjViLi8qlV2qrO4J4yB10TkekfUWg9V9Gel8kfeBxOC8+94Wrm1lhNKw//FYknjVM0XsItgZhnFGawINWDqBSIwuBFs5n4XP6T0BCNbIJE5Xt3W2VPN0q3sy03dreIMeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dbf8uhn1; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dbf8uhn1"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64ca1ba0089so1278071d50.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 10:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335226; x=1773940026;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r5d3U58A7EbRwEFn4KrmQ5cld9P0wudWqSFmPnXCnnU=;
        b=PwkG7xwefXBGOBysWn+wCybci1EtchMDoIWCYxnGQRh9KgCen6/BErIYOsXnJvelVU
         5jrYNwaUyPMpZZt9dpkx9y58whu2hWc3qlvvYrtk08DydHTioDeE3BaDgEQo2iSet4si
         TkqfhR4RNSNehBM0S6GMC/yXolk7843VvJWGjEGmy+wYxO9G2ggYFTgUZuO5zx+/Fa5e
         52bKU6oc+tRhWXvRRXLszqnhFO3+JVf3a314L41QZWrZMmGFT84wnzlu4wj5FnOzYI8A
         C+6/xN/HdAbGCbdCwJobhaMNrmWw+9QOURMOTBYbj9nx/RNkVy8aWJ4teKRHaQGvx2Ut
         Pj5w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6vA5Ilb5erEdvfU+rEtM0w4VdYMRVv4g3klVfLNauuIFQQiL366XOPHT/MjxsuVJQWqD/GrE7Gvw@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmHy6F3ZzQIeA3eF0BRnucwZBR9SjkmJ4+JoF+QbPWBIv1RQB
	iR6Q1pzJWhz5bAINR1ypXqbas1NFE8YErpXK+yz6JxtsLFi3YkANWzUPPYzoM5fgrSchM8c3f47
	ES88gBqTSIm3JWTYjMjYc5mMd+hNQX5jCbvPFuH2l1TEgwAorXwRJx0GUNB8ez7qXvEgBIurHqf
	DGq/DsIKYE1T8Sks6cbjlfAC5h5aRxcOgk219LjIzzTmNoscs8XlR0aAK/l3IVfvBOnZxRGOtGv
	PNE63Vd9vhVoRPQJG2vtw==
X-Gm-Gg: ATEYQzyan9hErtRFgN1lF633BwVx/bfMiOFw7NyVema34ncOWA6sUKTXQ3NnxN/zZV2
	lznaQwFbqoitA7qp2QLSXYV2ynO2jFECO9gE9eI0aedSMFujH8DLFcuW1glC5/NlTW5wAxdWSfN
	BkLlcb19qr1bUzAZryaI1eBP81ELnh71Omz/6tRFPD2TvU0pn/0fRYpuu4VnXSKrN0mYIhnfEXg
	4l0cldHTgNoWq30UBkA3fV3FYRPxR8d0aXz4MGrsw4iHdbMG9XJEvr6zz8UNL3vUaD4gbnwDDZW
	DaRSiUGAxVTd6VKDd066sSkWJlcTZuED/g979SR4YbrOYMapGs7Q5lzYlpUpbAFgZgjdzaHCjGL
	7MmdLXQ67b8A851irxbygiDlECd7g67pGl8eJrqvjzbadFbrY3Yhi9brzaRJQt4IF8/7+Lfjdd2
	JDXByRYa7Kd7Wg7Smvpguk9ath4lSPOwywxjOYKGSSbQDPxZ3hAxEX4KcG9R0Ujl8d
X-Received: by 2002:a05:690c:3612:b0:798:6a34:74c4 with SMTP id 00721157ae682-79a1c093bb4mr3578377b3.8.1773335226309;
        Thu, 12 Mar 2026 10:07:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79917dfd586sm5522367b3.8.2026.03.12.10.07.06
        for <linux-omap@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 10:07:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899f671ceb2so72433556d6.3
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2026 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773335225; x=1773940025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5d3U58A7EbRwEFn4KrmQ5cld9P0wudWqSFmPnXCnnU=;
        b=dbf8uhn1yqQ9cdMkVTOAE5x6DS0V3qVbFtGeBaIFfAF1uxA90q8ppuGQKFwe260pH8
         lO8ZZkIGo+uTqKLHF0+TQj1XuR+cKVhhx5hQnOAU+A6F6rAJX+elQbo4KLScXDIWSAZn
         JYUk61QzieEOC5FKLTFOb9i8P2D4qAg9dhdO8=
X-Forwarded-Encrypted: i=1; AJvYcCWxlvkEv2iYag4exy1jNFURnwG/RJxWwECIcwrDw5zUQBy1B7OAaV/k8EcBq6tDDNqIwREZ9gfvTBHx@vger.kernel.org
X-Received: by 2002:a05:6214:29c8:b0:89a:116b:e674 with SMTP id 6a1803df08f44-89a81d5dfcemr7819746d6.20.1773335225417;
        Thu, 12 Mar 2026 10:07:05 -0700 (PDT)
X-Received: by 2002:a05:6214:29c8:b0:89a:116b:e674 with SMTP id 6a1803df08f44-89a81d5dfcemr7818666d6.20.1773335224670;
        Thu, 12 Mar 2026 10:07:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d17023sm38864336d6.49.2026.03.12.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 10:07:04 -0700 (PDT)
Message-ID: <9040aef7-1981-44c8-a25b-2179b892d37e@broadcom.com>
Date: Thu, 12 Mar 2026 10:06:59 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] PCI: controller: Validate max-link-speed
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org, florian.fainelli@broadcom.com,
 jim2101024@gmail.com
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312163652.113228-1-18255117159@163.com>
 <20260312163652.113228-5-18255117159@163.com>
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
In-Reply-To: <20260312163652.113228-5-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 3/12/26 09:36, Hans Zhang wrote:
> Add validation for the "max-link-speed" DT property in three more
> drivers, using the pcie_get_link_speed() helper.
> 
> - brcmstb: If the value is missing or invalid, fall back to no
>    limitation (pcie->gen = 0).  Fix the previous incorrect logic.
> - mediatek-gen3: If the value is missing or invalid, use the maximum
>    speed supported by the controller.
> - rzg3s-host: If the value is missing or invalid, fall back to Gen2.
> 
> This ensures that all users of of_pci_get_max_link_speed() are ready
> for the removal of the central range check.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c       | 5 +++--

For pcie-brcmstb.c:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

