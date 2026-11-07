Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064043;
	b=RBpXgaacRzU0XWU2hFjcofk6DWq7IrYWtyuOQdz3uHdIh7HW9wespNpzrvOgFy4hTp74
	 fNP8vIiBCsbzt2hMgDK6iax/kn9cMQ8ExNZ3pZOVcKhHgg74V5p7W8IDV66mftBOkf41X
	 3yzIWr9Rf/3tKFXck8WQJOG5E0FKpW7JLJBJcHo+HAnFSophzlUmf5TLKDg3qGbNnVuWL
	 dZ9ttx1YvDfc7ozrRmR1xwbR2JWpF8hB3cSHYw4QCISLhJpijqlBqJFNX/Cxg3vKPjLrl
	 nj7EK83gFEbxyXvQkp5iogzmSV/eSvkcWIvuWen81u1JwnoIHna74Gje8y24CAc8fYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064043;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=zl6yrg2KvfxVkFW62qjYrFIMancSN6hwHg9jAABc4+I=;
	b=uw98cOZZbl7gbZhjJ6+9+joArM5EZw5KVTSDQ/pM9I/ATnPJ8SGMOo6OU/LRJcCNAOgC
	 Ufvk8zRvMG/DtDXCChiMRg3n+BuWBBouWTxdg+xwg9OndalQo2fw62NFAgOW4zMrHW+Tm
	 wjj3zoEuBiRNdK7XSgr2djj1tjAnRAc/O3zJ5jGRAsc30vrb6LT7TcfmAyJRoUzauXxb/
	 cYaJjYuIplH7h66ntDB8J2zhR/Z83kA37KgiQmmpzHFbLPq819QLCUel70DNPu8b0AJ2U
	 eJCBmw7NCXCfjG2Y7UZi5cmR4/G4+l3CpYsNAgyHLdbApqvOH4H88kGSgpZhNww22fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XVqToAL4;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C5606A9D6
	for <linux-omap@vger.kernel.org>; Sat,  7 Nov 2026 15:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174C5606A9D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=XVqToAL4
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id PNuzxMvlvJFmFPi0oxsGZf; Sat, 07 Nov 2026 15:07:22 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Pi0nxtgoEGh2BPi0nxsyqa; Sat, 07 Nov 2026 15:07:21 +0000
X-Authority-Analysis: v=2.4 cv=Aszu3P9P c=1 sm=1 tr=0 ts=6aef3ea9
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=snJ_kNOXu2uBm3iOx8gA:9 a=QEXdDO2ut3YA:10 a=frdN7do_6UMNKhLXsD4Y:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=zl6yrg2KvfxVkFW62qjYrFIMancSN6hwHg9jAABc4+I=; b=XVqToAL4SUYJ
	lVI7cJCYjVWyg+A6p/vJa82EGbrXlP+atqiEnd6ih+rmKKbQSvWYNsm1mr+FWC6J4qw7O3FfLb8fk
	x18LAstJxR0B9WVPTgOvONqcm0vu5wUQP4YARXe7XM3jNbA7FT++AXuNoJgKVUGXneHSk1Q0RpEhH
	QDfsr1cEcqe8/E5Z/XOQCdybmwsrUF95FXkE9wbnQH5EOONNRbQ+PGb7yunXnlphJdvhgdPgmSwhh
	JKWwWdEeqmT+QU9Zh9z0qK6HLOFtQnUFrtt3T1oKS013WrwTHqwIjC6AY2yy3/l6fp+2cEeaVXdov
	kfABux7+N8t3nYaesRQrqw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40520)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xPi0n-00000003hln-0wqa;
	Sat, 07 Nov 2026 20:37:21 +0530
Message-ID: <5d335a0c-9113-4771-b1bc-0e3d88718651@roeck-us.net>
Date: Sat, 7 Nov 2026 07:07:20 -0800
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
Subject: Re: [PATCH] watchdog: omap_wdt: use guard(mutex) to simplify locking
To: Akshat Rawat <akshatrawat095@gmail.com>, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261107063151.441-1-akshatrawat095@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261107063151.441-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xPi0n-00000003hln-0wqa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:40520
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB/3qzs4YXWFCWVAN65d0bW8WPGwxyBCIDChY6cUow4izsJZRZ54C3gk72e9KvFuVn5lJNVeHfAl8qoTujA/Jg0uc5A6lwEkw5lsUkGmqEqIe+DNWAwW
 JB+VRKDBcuM66sbxnCogdoj5BrCgQULjhoSn1MzD3rx3h9W+v4lnB0yiaITQoSy7yx3wXP0Qm/43g9BtrR6eQBjaBAAbN/z+Ki3U+A0pWT4656YNTjZmAzSj

On 11/6/26 22:31, Akshat Rawat wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the modern
> guard(mutex) constructor from <linux/cleanup.h>.
> 
> In each function, the mutex is held across the entire function scope.
> Using guard(mutex) eliminates manual unlock boilerplate and guarantees
> that the lock is released upon function exit.
> 
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Please stop sending watchdog subsystem patches unless they make functional
changes or fix real bugs. All this would do is to make back-ports of bug
fixes more complicated.

NACK

Guenter

> ---
>   drivers/watchdog/omap_wdt.c | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 2a6de73e6f0b..956d9513a81c 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -27,6 +27,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <linux/module.h>
> +#include <linux/cleanup.h>
>   #include <linux/types.h>
>   #include <linux/kernel.h>
>   #include <linux/mm.h>
> @@ -133,7 +134,7 @@ static int omap_wdt_start(struct watchdog_device *wdog)
>   	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>   	void __iomem *base = wdev->base;
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   
>   	wdev->omap_wdt_users = true;
>   
> @@ -158,8 +159,6 @@ static int omap_wdt_start(struct watchdog_device *wdog)
>   	omap_wdt_reload(wdev); /* trigger loading of new timeout value */
>   	omap_wdt_enable(wdev);
>   
> -	mutex_unlock(&wdev->lock);
> -
>   	return 0;
>   }
>   
> @@ -167,11 +166,11 @@ static int omap_wdt_stop(struct watchdog_device *wdog)
>   {
>   	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	omap_wdt_disable(wdev);
>   	pm_runtime_put_sync(wdev->dev);
>   	wdev->omap_wdt_users = false;
> -	mutex_unlock(&wdev->lock);
> +
>   	return 0;
>   }
>   
> @@ -179,9 +178,8 @@ static int omap_wdt_ping(struct watchdog_device *wdog)
>   {
>   	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	omap_wdt_reload(wdev);
> -	mutex_unlock(&wdev->lock);
>   
>   	return 0;
>   }
> @@ -191,13 +189,12 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
>   {
>   	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	omap_wdt_disable(wdev);
>   	omap_wdt_set_timer(wdev, timeout);
>   	omap_wdt_enable(wdev);
>   	omap_wdt_reload(wdev);
>   	wdog->timeout = timeout;
> -	mutex_unlock(&wdev->lock);
>   
>   	return 0;
>   }
> @@ -298,12 +295,11 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
>   {
>   	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	if (wdev->omap_wdt_users) {
>   		omap_wdt_disable(wdev);
>   		pm_runtime_put_sync(wdev->dev);
>   	}
> -	mutex_unlock(&wdev->lock);
>   }
>   
>   static void omap_wdt_remove(struct platform_device *pdev)
> @@ -324,12 +320,11 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
>   {
>   	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	if (wdev->omap_wdt_users) {
>   		omap_wdt_disable(wdev);
>   		pm_runtime_put_sync(wdev->dev);
>   	}
> -	mutex_unlock(&wdev->lock);
>   
>   	return 0;
>   }
> @@ -338,13 +333,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
>   {
>   	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
>   
> -	mutex_lock(&wdev->lock);
> +	guard(mutex)(&wdev->lock);
>   	if (wdev->omap_wdt_users) {
>   		pm_runtime_get_sync(wdev->dev);
>   		omap_wdt_enable(wdev);
>   		omap_wdt_reload(wdev);
>   	}
> -	mutex_unlock(&wdev->lock);
>   
>   	return 0;
>   }

