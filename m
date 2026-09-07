Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DC3A5459;
	Mon,  7 Sep 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788802644; cv=none; b=La2kEXukmOqG58r0yxSuskxdWc7Dph0Z2xPx9w2gS57/uHgDO42TfL9AYzTg7TwD2WAKoWCVSBLnlDhvLBbWR1Eczqks7KyDJOA3RzvBAB4Vm9iSP39f/lp/31bYGfSV1gAPjxQLK9O20pYsGpQeS9zffmJle9WaBhMiF+Z6afE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788802644; c=relaxed/simple;
	bh=cKGfZi/d/BvYweEPxQ98m1jdb4NZizKQN3d0517GUvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPXR0cDeGrc9ltDzMfyNmEamoOP0zM6ot4sokr1o+LsXZb0tvi2pmEBauQWE/gmBC+Wet+G0hUugCKSBbZd8a+glMYuN4VbG65AD9+zCIYM8R+egsNBZUGhYLbbFpEOY9rtiUUv5lyOempUG6M7V8LKpaGQhDtMFpOGItxCuAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ziBVjdDG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ziBVjdDG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ACGhNatmfvP3k7lNT7yDJdLpYx1Fv4gEWAi6RsdoK9w=; b=ziBVjdDGuaRXNMCiP0JWDieadF
	RdcDhnP6Emiy0n9Wz+YMUAYiP5LKkWoLuu3dvZeOcAKYVkaH2S/GFBA04+suXu11v6EL5L6JuC6H/
	+y/nE/Fo3cRzkuNDBrybChEE8iiiEALVdefXTa66BZb32BfAGQBnfwZqly8zktipXSEJ/pXDotSw9
	C6uAmY0hS02ekZRXP1IkX1SvewPgvNorHXn84GEpxgrVb3MVA6okYznp1Tp0iI/nlq0yKqrmhuzxZ
	ZmgFLOCD5KdQpfZYwjnPXd6g2ELgcoLukqyMXdubCIvRbi6E165m2FaBvn1qo8DLXJDbb/W/ru/1m
	xhra7iUQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3dHT-00000007VVA-0es4;
	Mon, 07 Sep 2026 17:37:19 +0000
Message-ID: <b5f26c3d-daeb-4a71-bd88-85a75f5ac8f1@infradead.org>
Date: Mon, 7 Sep 2026 10:37:18 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tools/thermal: fix typo "binded" in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Eduardo Valentin <edubezval@gmail.com>,
 Keerthy <j-keerthy@ti.com>, Christian Loehle <christian.loehle@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20260907064725.10686-1-hemanth.selam@gmail.com>
 <20260907064725.10686-4-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064725.10686-4-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/26 11:47 PM, Hemanth Selam wrote:
> diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
> index 44d16d778f04..f347efb47c96 100644
> --- a/tools/thermal/tmon/tmon.h
> +++ b/tools/thermal/tmon/tmon.h
> @@ -77,7 +77,7 @@ struct tz_info {
>  	char type[256]; /* e.g. acpitz */
>  	int instance;
>  	int passive; /* active zone has passive node to force passive mode */
> -	int nr_cdev; /* number of cooling device binded */
> +	int nr_cdev; /* number of cooling device bound */

	                                  devices

>  	int nr_trip_pts;
>  	struct trip_point tp[MAX_NR_TRIP];
>  	unsigned long cdev_binding; /* bitmap for attached cdevs */

-- 
~Randy

