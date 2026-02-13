Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61444315D3E
	for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000586; cv=none; b=BxsxuUvDKLD2Bf1VzDtl5Tdbo7guhEeiatXXMJRoplQwlHxa8HsEy52Txmcurn+jrLiJ62m+QN+jbtVxMmAXQmxHzZm5y7NPsOyMDXi3V2qO8e4HNl6sFIzQfX5v+c6d5mIAZQEufyg3lUJZf9qzPlxOeiGCri5nsj6LTgrmgE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000586; c=relaxed/simple;
	bh=ytXLg8/CbpRgWrWXCiN2taAFgPcJw1vJq6zqC5DM7rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF+yVlzWmCgmbEN0q/kYfAVa8xML+7028rb0JAFLQQGShEs5Quo/jXXIN5ALlAVZoAWXpAIoW+A0zUlWH+TqXxObwmzxf3Zd5B+MYkd7aTPl28Dylt4UB9RF5wfbnpch3pPVnX8Jne0loK2TXf4vMRz0xUyvdGGsf+yUL5OY0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsNgMbjg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsNgMbjg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7bced39cfso12771655ad.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2026 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000585; x=1771605385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0F5tQcgxERAB02uB01kJMGI3FPIwYeXfyKo+LVQoV10=;
        b=bsNgMbjga9EiJsjxNqa4sUcCxh6T789XD9JwcjLtJFEAh2XwBDY71cBUeHueS+hK6K
         t8VbPI5yy1sdgszjyVP+E4gna9BvegmB+5FUznppqvNR8B2bCni7fb9+Q+Xr+tF2YFbI
         2W8qfoYkuzI99dFNGu4oLaxtYgUechDTMDW5gqtDY4daucd9KNV6XALdd9VKDw4Uxg5e
         U2tK+9k57HLSLMlgQRMXg7tLuPxJ6UEbi5GkZT8hdD0UgQPy+MkYwA8Nf46wPnM6PHQt
         ozhNra4UY3VbCgzmtsaxdgetItya3mgKcoiGuM02oo990bb5fk/SSV47aJ1twMJAFhMr
         DM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000585; x=1771605385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F5tQcgxERAB02uB01kJMGI3FPIwYeXfyKo+LVQoV10=;
        b=PyPpKzKOK9/Vdcem2jVDsaw3U19GyRuEaq7SQiz38aYW+DHV/oz6xmcam7Nz8nIrc/
         zzbfYv9cWL3kOG09U+UF7PevuhyLCloVdaBpzwlWuTZ4Vn6xAKRzOTDXc4TbKw5Uq4Nc
         mIANOCh8ih6RBnqCy/C/7n9KNAb4yMBBwpb5WcguQdRM5D0ApU4jExjOSAAovGoXxP6q
         j9novoRfJPps0oDKZPnEEMoVQbuvWrWg3kvoycudTl2y8oONDm7HMEGKLF/fDGj1W35o
         xaMTu8NU6t42bK8ddXAyvB3MQHiG8AL4kzrOuBVnNdVsDahtB3XKYrjTk1kMytDzNYBW
         X2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXTWJ/l/sF1ri1LtV4SqwMZKLKu+3Db8RY25gYvsQIQTWLcYdr9k9ujvRNmYoKGd47RP7u4DaivT4A9@vger.kernel.org
X-Gm-Message-State: AOJu0YzywrFANOt9kqiJadPubSHbcmaCgoGLF9QOLgFhbT/JB47DmFVT
	PnDAyiv4gL+QPwQ0KLkkIGgsxYjE9CjHXq4ztn780dM60EUdYD/vSlRq
X-Gm-Gg: AZuq6aKFsZ2ifv8KGsec2p8WviwIYyPXMTp6L6vlE6cp499zqLyrUu7LbRJ4hc5n28x
	mNtJiUBVp3LOkLyGz7KV3bSSsrjHz4DMFJLy3ZeIYkLaYplfYrFupKzJYTbl0akzFlqXh1g5zls
	PXR0RrJVl2RhWdSphUbJgBWgnLAO1Yvf9FSVFAvZCZMtuOb1fArN78rho2j3kjF+r8Yv7AFr9FC
	YicIGSRDbUCzGuRufEorjnxS/xJ5QHf+XHj+SO2VoIgp58/vOBnpNcQ26E3Pznj+bNsKJEeDK1U
	6OYmcrz7RSbCYQyY/8+nwp/xWiUt/lRzoaLO7TLfDl3Y8K58lhPKlNREdV/GEk+aZeVTGgyhodZ
	C9uLmzOs1lBsasrJnxHUdKcqT57nfQeT1+WkyGg/7TcE0A+SKzdyFFNA7jHYRCg6xJKWm1krORL
	bOhb48LUnmq48mze4SRvZ/MqWWO69j7WRfdkzE0mDVMoc=
X-Received: by 2002:a17:902:e787:b0:2aa:d11d:5c36 with SMTP id d9443c01a7336-2ab50598a38mr26413315ad.30.1771000584651;
        Fri, 13 Feb 2026 08:36:24 -0800 (PST)
Received: from [192.168.1.8] ([27.7.171.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2988bd4dsm85424595ad.38.2026.02.13.08.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:36:24 -0800 (PST)
Message-ID: <f60156a6-58af-4548-9dc3-71c71b822343@gmail.com>
Date: Fri, 13 Feb 2026 22:06:16 +0530
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/3] dt-bindings: phy: Convert TI OMAP control
 and PIPE3 PHY to DT schema
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
 <177021985530.133434.13436195442562231016.b4-ty@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <177021985530.133434.13436195442562231016.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04-02-2026 21:14, Vinod Koul wrote:
> 
> On Fri, 23 Jan 2026 15:39:01 +0000, Charan Pedumuru wrote:
>> This series converts the old text-based DeviceTree bindings for TI OMAP
>> Control PHY and TI PIPE3 PHY to modern JSON-schema (YAML) format.
>>
>>
> 
> Applied, thanks!
> 
> [2/3] dt-bindings: phy: ti,phy-usb3: convert to DT schema
>       commit: 62c9ff8fc20d23c0dc36be1330734fdafb3e8585
> [3/3] dt-bindings: phy: ti,control-phy-otghs: convert to DT schema
>       commit: 7878306d182a1750583a325a29e5ccab9ce0235b

Hi Vinod,

You missed to apply the first patch which has DT node pattern changes and now this dtb check fails in linux-next as these YAML patches use the updated node pattern. I got a report of errors from kernel test robot.

> 
> Best regards,

-- 
Best Regards,
Charan.

