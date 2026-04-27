Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D623191D0;
	Mon, 27 Apr 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301577; cv=none; b=hMOlhhTb/Q86n4AwoWXi9/StjCTXq77+rSdXLUQUqtOKlr8R6AXpm2vuDM3KPpiljMDcp3SzUXawgz0Ff6ZvCV60UN32Sqo4oDBet/ySGKGaP5s/V/jqjkF4tAEcOGbhP04dbdmBdPtq7mGhF81rjbQFFx3YHpYn8j4DaKA2i3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301577; c=relaxed/simple;
	bh=GgZguPLQYsq+WYYBuzGAW6TXq7+26UZzZDptmmz1/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG2nEnCJzCHrVJ9NfFlwCCkR/ESuR8g7p5yOSPhgiwWdLJSJlpwDZW8SWXo1CrJRW3wZhf8jsNQKNLKyMaDthJpDl655HJnny1LcgXjN7JVm7m8av65p76WpGyTUAed6dmEnqq5dv779ZrA/ygySV2hiIC8ti/sp9svHU8snr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iL1Afo8h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iL1Afo8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777301577; x=1808837577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgZguPLQYsq+WYYBuzGAW6TXq7+26UZzZDptmmz1/20=;
  b=iL1Afo8h8Idlam+bAJe+PaVyPUoltuGD3EIas9vD6NjI6xaB691T5Vc7
   5W0PebHQAKheL9tqac8BXaE91KvkRDaEsvVACN+RPrj8zR1Hc0vCUynDg
   XMydyRHO4T3Yadzzj4SiHWKv7ZC/VzybWc1bmdkKNNrrj+uKoLFxYCq8/
   2eihRc+w3TkeBfyx3Ka01gKZpGFDoBIKuwpNY+8BvH8WX8H8QkhSKAx2a
   J4mDe1iL8mAZOldNDuYdt7+/XmM3KvL7aADFD3UmTmDR4tFEckZzmbyd5
   undzl86OeI0PI0ssi3gUCX6zuwDloHRhv+MN/OmL23R6p5elsIaRNh/yz
   A==;
X-CSE-ConnectionGUID: JhJde1+UQbi0HuK0YCzmbQ==
X-CSE-MsgGUID: gAKypUwcSoOzt+wfvYlkyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77352515"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77352515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:52:56 -0700
X-CSE-ConnectionGUID: Cl91Ct7QQuyDLm50uxEGsg==
X-CSE-MsgGUID: 28KJ4+YZQ+GB0j5SJbz3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233930886"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:52:51 -0700
Date: Mon, 27 Apr 2026 17:52:49 +0300
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
Subject: Re: [PATCH v6 3/3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <ae94QVJCMpsXIPCH@ashevche-desk.local>
References: <20260427-nokia770-gpio-swnodes-v6-0-b693296c1985@oss.qualcomm.com>
 <20260427-nokia770-gpio-swnodes-v6-3-b693296c1985@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-nokia770-gpio-swnodes-v6-3-b693296c1985@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:46:34PM +0200, Bartosz Golaszewski wrote:
> Currently the board file for Nokia 770 creates dummy software nodes not
> attached in any way to the actual GPIO controller devices and uses the
> fact that GPIOLIB matching swnode's name to the GPIO chip's label during
> software node lookup. This behavior is wrong and we want to remove it.
> To that end, we need to first convert all existing users to creating
> actual fwnode links.
> 
> Create real software nodes for GPIO controllers on OMAP16xx and
> reference them from the software nodes in the nokia board file.

...

>  #define ADS7846_PENDOWN_GPIO	15


This is the only definition for a GPIO pin and its purpose obvious from the
GPIO con_id below. So, while at it, perhaps get rid of it as well?..

> -	PROPERTY_ENTRY_GPIO("pendown-gpios", &nokia770_gpiochip1_node,
> +	PROPERTY_ENTRY_GPIO("pendown-gpios", &omap16xx_gpio1_swnode,
>  			    ADS7846_PENDOWN_GPIO, GPIO_ACTIVE_LOW),

...will become

	PROPERTY_ENTRY_GPIO("pendown-gpios", &omap16xx_gpio1_swnode, 15, GPIO_ACTIVE_LOW),

(or wrapped version).

-- 
With Best Regards,
Andy Shevchenko


