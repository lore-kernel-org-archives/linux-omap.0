Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAC3A0E8E;
	Mon, 27 Apr 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301049; cv=none; b=s73Miy8YXF2oPooIWkqaHeNOiBs2X63zgzIoX/4euVamygrN67XN219XHtBXtBBQpb4HC/PDZFE894FKbDi9fvBjKiaTweDt+4kn+JVpDbyA/BCRSaHvZJZfGJwgiGrPe14tVJVl78tdqPHzZRKfrmod+md0stxQ5ziI5jjEF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301049; c=relaxed/simple;
	bh=xEZviH1Rx0Trs7TNfbXnsRxSsbOwAKS55WHlb0BfwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3k1nBiZbD5LDoaOG8tGz+yx634EGd5csHVS0XEv+UKrmpOSBA3Oz4EiSW6Qo5MWjCZ2WcV2bnQTYhwcVazPyf+rvT+W1xM3V0aeDS1zyeMAvE2GD3z2faUOD/Ss1nsV7tp99ekaR9AeVKcmSMUqFQewEsa2uO5RZd3dSSkBfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lsk9RasP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lsk9RasP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777301046; x=1808837046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEZviH1Rx0Trs7TNfbXnsRxSsbOwAKS55WHlb0BfwFs=;
  b=Lsk9RasPDytBYGk7N3tSKGqb/7bS5Nydd/cJNorApdrGQbdL/1uki6e9
   Q6iPg3ugvJbWDikfnzNeNj7/Qay2jONSroZQExadYxleyGML8pYKYexNv
   mzzqL4EhWHQDqI2GSTz/WZGRkQNr4B3iJlDQjOboETE+sAF/gR8fZwkSz
   Plb46jaHDUew4zLGugFAbanCrGJnipm0vAL5QvUf9CRGUfrGWifeSYRwE
   1j7u2booYSHgPd4KtyaDtfzgO2n51JRHu/NpfV/U8MyUoI+LepgxAWqsq
   pfm/qyNgVc1c78VvWnBwLaqZMT4by2OzJ7E5mBmVcvFVqKusgwgJhbCD9
   Q==;
X-CSE-ConnectionGUID: BGBZRrA4RQiIuTNW8aKggQ==
X-CSE-MsgGUID: RwTS3mEkQL+YYwlnaZr6lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78248292"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78248292"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:44:05 -0700
X-CSE-ConnectionGUID: HZMRTky5RgWSWwZjmbXWZg==
X-CSE-MsgGUID: Bb9Y1DJDQmu6NQQfLbze+w==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:43:59 -0700
Date: Mon, 27 Apr 2026 17:43:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	brgl@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ARM: omap1: use platform_device_register_full()
 for GPIO devices on OMAP 16xx
Message-ID: <ae92LAOy6nRsFb9w@ashevche-desk.local>
References: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
 <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-nokia770-gpio-swnodes-v6-2-b693296c1985@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:46:33PM +0200, Bartosz Golaszewski wrote:
> Ahead of changes attaching GPIO controller's software nodes referenced
> from the Nokia 770 board files to their target devices, switch the
> method for registering the platform devices to the
> platform_device_register_full() variant. This is done to leverage the
> new swnode field of struct platform_device_info which automate the
> software node's registration and assignment.

...

>  	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> -		pdev = omap16xx_gpio_dev[i];
> +		pdevinfo = omap16xx_gpio_dev[i];
>  
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		res = &pdevinfo->res[0];
>  		if (unlikely(!res)) {
>  			dev_err(&pdev->dev, "Invalid mem resource.\n");
>  			return -ENODEV;

>  		base = ioremap(res->start, resource_size(res));
>  		if (unlikely(!base)) {
> -			dev_err(&pdev->dev, "ioremap failed.\n");
> +			pr_err("ioremap failed.\n");
>  			return -ENOMEM;
>  		}

Isn't this a stray change? Or why then? And why the previous dev_err() is left untouched?

>  		__raw_writel(SYSCONFIG_WORD, base + OMAP1610_GPIO_SYSCONFIG);
>  		iounmap(base);
>  
> -		platform_device_register(omap16xx_gpio_dev[i]);
> +		platform_device_register_full(omap16xx_gpio_dev[i]);
>  	}

-- 
With Best Regards,
Andy Shevchenko


