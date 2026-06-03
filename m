Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38E3803E3;
	Wed,  3 Jun 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509838; cv=none; b=C/wmHtkkJtHGpiPhEfXTVqgSHMxFvN9hffpNGJtWAxEbYDc/JMIpEkozwEe8UUuweCyGFHofTneA+h9fI7JjARWsVhC36YS/zuKP9VAiup4Rtf3Fh3tkGBoyiHMgH51xeiNiyTCvevtnt/J1oCpKKDeoLfYEiUlWKdQIp7g2bP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509838; c=relaxed/simple;
	bh=zp4jQJ1wXlYnbYRHYUqGy4dX+NNH3Md2Txg6tvkNPlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+ZLFQio5Odqs9ZLEv8aKFZQH+0bAF0W4lFAzDaJ+xijzihEMX4a5AQP4FJi027vKVZrUy/YoF7MBpAlTWKaKSUhdyjrLBYyrRSMm2PbvhJiBu+sKJM2DQtLNjwV2yJBRk3R8U8RXD90A16ybhOahjMFpVI6TPHGKW8rBISnvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=K2Xr9dXL; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="K2Xr9dXL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GRH6ROiC7swqpaBAILN2NW9pHI2WaansCMXE6BpbWH8=; b=K2Xr9dXLEiQ9frPEFEss0ZTTn3
	STu/GTYJk1yAyc2wNcfaAD0uyxynF6cm9sGgOxH1Ugjb6OyYeS6ZQW2A5tGNmAilOPMjGWZwi3FTJ
	hfwWCpq9qXHEVRMKypZ0ZY/p5038vFTo7dT7y62VgY7EJaTYiBs7SJVfLJxj+wYik1+YO0FEaxp3j
	klF4E1HB+9e8oNHjThF31PooFZlAFr1RKLJUEunSoLWCSgg+hr5/oL1xGa+H5KfT+w67IHMei7W2Q
	ExQhrczwh9h8oLbMWzUhg6CXSw7lI4m6mEKUNkLIoMB+wIxNFN3ty9T1hZmmpoSG14UOkuFn2McDM
	6lr7VQZA==;
Received: from 81-197-170-239.elisa-laajakaista.fi ([81.197.170.239]:36662 helo=[192.168.0.14])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wUpbt-00000001NfV-3POD;
	Wed, 03 Jun 2026 20:42:33 +0300
Message-ID: <81c80265-f04d-485f-97bb-92b38129db20@bitmer.com>
Date: Wed, 3 Jun 2026 20:42:31 +0300
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ASoC: ti: rx51: drop unnecessary machine checks
To: Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20260603-asoc-remove-mach-types-h-v1-0-2b9446dff0c1@pengutronix.de>
 <20260603-asoc-remove-mach-types-h-v1-3-2b9446dff0c1@pengutronix.de>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260603-asoc-remove-mach-types-h-v1-3-2b9446dff0c1@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id: jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi

On 6/3/26 3:09 PM, Sascha Hauer wrote:
> Nokia N900 is device tree only, machine_is_nokia_rx51() always expands
> to 0. Testing for of_machine_is_compatible() is unnecessary as the
> N900 is the only board registering the device node necessary to get to
> this point, so remove that as well. This makes inclusion of mach-types.h
> unnecessary.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   sound/soc/ti/rx51.c | 5 -----
>   1 file changed, 5 deletions(-)
Recent patch removed the machine_is_nokia_rx51(). Could you base your 
of_machine_is_compatible() removal on top of it.

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/sound/soc/ti/rx51.c?id=ee05c329c0487c86d37635a7503ba989c6aa7636 

