Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB52BE7DC;
	Mon, 30 Mar 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902294; cv=none; b=NChcmkBppVlVWEjgdTM7ZUvg0s5epL2xg0bjefBBZOKl1iXTbDvEmD/E2PWaCzc+3G8GyWqTUDWhB1B2IhUN8Yflxc+ZoZr9AMxA6DxlmeroBGXmcg6VIhZ1oMwLAVs/EoGIovFtaNf8M6fXnwAV7LcuTIqGJpcqxFt96/pGXmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902294; c=relaxed/simple;
	bh=i6O0R420JsaobqCAMpIhjIoGFKW4TulkjH6tJS6uS2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It1pyDSh0M+SlQnhDoVprlmucNGlHMdZEno/OTCnMHkmzwM45GcS1sZIeS6wYhtwVfWfE7vJs8RQ9yxP9SCT9YgfCyhqEvde68Iqhxiu5TZCqNLbt0OswJXQN20yLoqWjcBDR/N+Zo/aJynj6qN+jwdyEhOtsxv0mCj5UTpbrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4rvMLab; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4rvMLab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774902293; x=1806438293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6O0R420JsaobqCAMpIhjIoGFKW4TulkjH6tJS6uS2s=;
  b=I4rvMLabUxKJl7BY8w/zu8MQnb37J39/ypXTlHwWY71JDqzyVNQgTRg8
   nwb3erMaHxbunEyjsmuwXrmJWgGePxGfrMuOx81z3pV7voRfUSJbxCaNs
   BFEEiSW4cO0/ZmTgk3bylAchgZzBAL8kPluMqxcJ0UHAawivUBAMG03CO
   /pRthJW2yqpSQzXvV/9m/a381Wwn609L446l0NesEE1Lych3eg3T+j+lc
   2ME0JgSv7K/DZ2S4Ad3nUazQ6dSHMjFlOh5hTENAxtLCw7/+mD+Qrq1Q7
   pONEOArmusjY/iO2A1oVJb8YgHIoRONmhDrHvKBd1fKWeCaoENfm9vnIa
   A==;
X-CSE-ConnectionGUID: CFH8+w6sSoClUjwgNb7gHQ==
X-CSE-MsgGUID: 3Z/rjNrASpCa+TAyk3dhug==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86598205"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86598205"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 13:24:52 -0700
X-CSE-ConnectionGUID: TXJZI8ekRJ6g6M9KfTUpgw==
X-CSE-MsgGUID: 7aHZRfASRmelp1lYOfoS4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="223280125"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 13:24:48 -0700
Date: Mon, 30 Mar 2026 23:24:45 +0300
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
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
Message-ID: <acrcDTPpXZ_5A4D8@ashevche-desk.local>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 02:40:47PM +0200, Bartosz Golaszewski wrote:
> Software nodes are currently initialized in a function registered as
> a postcore_initcall(). However, some devices may want to register
> software nodes earlier than that (or also in a postcore_initcall() where
> they're at the merci of the link order). Move the initialization to
> driver_init() making swnode available much earlier as well as making
> their initialization time deterministic.

...

> -static void __exit software_node_exit(void)
> -{
> -	ida_destroy(&swnode_root_ids);
> -	kset_unregister(swnode_kset);
>  }
> -__exitcall(software_node_exit);


Why? What's wrong with the __exitcall?

-- 
With Best Regards,
Andy Shevchenko


