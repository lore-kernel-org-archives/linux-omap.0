Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A933DEE6
	for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2026 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961759; cv=none; b=UueaTBxt1ChbLcSj6mHckAPfVNPWimJp1u63HNjfao9iXGS30rSrUp3lcPv4Qqa8sjqmZlq/Ircza14ivj3BhqctLj8QHhxxClfVYX7BSoky7/rz8slGY8fnPWbf4RvRNxUTLtx5nVzhVlPciIYLsv6GU1oPhCK3iiPU/Uo8sbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961759; c=relaxed/simple;
	bh=EiqxYFAKuDv/UY1/7/yWHVKgFO6ivnoIo7jCuJsb0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUcqDdCwwAwC22vRtxBtNzv0n8QlDxTTShjDci3sLNxSvPKE1/bzGXS0buUPQtVO2hI0mwSYRe+mxTZoqpGqM0hjnCbAxKVIuz3k2CN6XojK3xpeGZb2ppfGRMhFRoq7pX1O8oZnZAv0MnuBL8g5AU2SMK1SdzQ5kQ+zmX2GjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKqBI4gY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKqBI4gY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c6113524690so341654a12.1
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2026 18:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768961757; x=1769566557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBYj61sXNcZXb9zsbWXDZntUfG6O/Hy5NDGW/6P4u40=;
        b=LKqBI4gYZViIp/AyrM/140Th6+RN6hISQ8PzsDdgBrterxVfq56W8oF9/LtQUqFJuQ
         WZhxXH5R2suiUnje41NmrkWKEe6YXFlp4YImOX8RE4FzKvi/zG/WZO0e4Le7dmigIRWI
         L+qTlieQQDp1UiI1e0ZImAkuJxUtexuMx323k1rUlQ3byBX5J81H+u9JAIVD/hioVcuz
         xeNchi/9jnGUh0D3JzWUfkYbIA3DqNPgS9TV+L3Ek6rOmCdGFhdp5h6myoPqM/W3B0cu
         h6A/xMwHOv+gB783ua0A9m6dxoAQ70vhxaaTtzgr1e4ZqCSzNrBzI9T5Y59IotPZF7Ge
         yabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768961757; x=1769566557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBYj61sXNcZXb9zsbWXDZntUfG6O/Hy5NDGW/6P4u40=;
        b=PJXZPD6dMkyM3LZ/3TXnMesUH0OPNC8ep/cjiX351X8UdCVje+Kt3JQKJFLTie/78j
         x6w9Qg8E1tyObiFlSk5u6qQds/McS40zInOzX18Wp6ciq92OzLWhpnZ4EWPk1FawtbP2
         wYB1Lx/Xy7L+xcMn3j9hyE1DdoV5TVcEbs8G6BZraXikZpfwk5/PbcnTpeTNFwrsA2bN
         JYUbPVYSWPdPV1MnQPgSjQHJAO7PQBWAFKNAxwtE9XhJnC8F2s5PmoAcbH7gXImblm9m
         et3x/cPIqW0FWz+gCiCocAss/ZVKKELBwiqvGTwAu7M5m0rHtUakzNDE7AMzcLtAkjIb
         D4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUwuBlozrQQL4++GHwwSWtJpn6KzTTlbBF75Yc4IWwO8/GY8YpQQT6XGsX52omZLstR1BaJbQBRSF9J@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/maY/1qQ8tl3OkiAFXYaE7ZXRtHq67PXDepOxGKhqrOav0nP
	k/JeRkX83Dw8lq9LY959WO3fPX1KMbrNwfUryJ6SGDlhKv3nySKk7yQ4
X-Gm-Gg: AZuq6aKY2BS4EYnrAziovxHPuvUZl2POaYzSSTt2yOCvH7vFtK8ThVajKHqiA5l56za
	q7Lnjttvn67VTJzfcc3e2ouE9kd+/wYTSamGPlf3kWVWVXylHGsTijwJSodTgVKUZk9oeKDEXyp
	uytovVqSd/yuWrGKgL9SvOG46auO+4pD9LC56KOf3hjHE/zpxS4B59uv5Q4cSBxG2JPmw3AO6pR
	Bq4FOK3Vy+wfVgE4PH3nZt4Gp7cyVfWtgYna25ues5XDDV9V/iZUuZYQrWxPVel09otCLkW07EI
	1DgeaJtT8y4e2FJJ6U04vvYE6KqihbFOX9naHKQXcJhxJe9e6xpLozG3f7lcNSvHOFM8IJlsmMf
	rW6wSpzreRLbXFDJRRaykkE5AnxYZuahABBKT1V6KhluxUOVtlfyh6gbR9Dwb66bk9ULwlVaAAe
	dqgUOqEUBA6UI7G2VuLRYI6rin4klVp5BHWDlhLp8d9moAG+WGCOnvFkU/KsbCCyS8y5REG+c=
X-Received: by 2002:a17:902:d48c:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a7177da66dmr148370945ad.50.1768961757159;
        Tue, 20 Jan 2026 18:15:57 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:cb0f:63ad:26a0:511b? ([2601:1c0:5780:9200:cb0f:63ad:26a0:511b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce4dfsm134107205ad.29.2026.01.20.18.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 18:15:56 -0800 (PST)
Message-ID: <aefd4942-41de-4e27-9777-aafff7b01aab@gmail.com>
Date: Tue, 20 Jan 2026 18:15:55 -0800
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] staging: fbtft: Make framebuffer registration
 message debug-only
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org,
 deller@gmx.de, gregkh@linuxfoundation.org
References: <20260117042931.6088-1-chintanlike@gmail.com>
 <20260117042931.6088-2-chintanlike@gmail.com>
 <aW3gCgB1YAsjuOZ7@smile.fi.intel.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <aW3gCgB1YAsjuOZ7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/26 23:40, Andy Shevchenko wrote:
> On Fri, Jan 16, 2026 at 08:29:31PM -0800, Chintan Patel wrote:
>> The framebuffer registration message is informational only and not
>> useful during normal operation. Convert it to debug-level logging to
>> keep the driver quiet when working correctly.
> 
> Suggested-by: Greg ...?

Ahh.. thanks for pointing it out! Will send v8.

> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

