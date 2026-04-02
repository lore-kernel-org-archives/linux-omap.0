Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C973EF0B7;
	Thu,  2 Apr 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147032; cv=none; b=q8y7By/hlsR1jeHHM5xouPWhOnUQ4OGHx30ZvrIlf2dKLaF6TUSYKmxivBXo44ZlSPs3lHs+fe6OF7FdaX0O8E4DZ+9OoCxbvR+nJCSk1rDjvatM/31rFUCGIpo3DRaEf+tettvCirpb8ntZNlLFDiE8p20K9qa0RqAPMCefVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147032; c=relaxed/simple;
	bh=jubyS2m2QjhM1wFy1HfygIjKkKElTV1Ix6KF2Q4kQlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpDdk3jJRwUDS65z7QR6vrHQ0LbujTKSy+M83lqcnLnhYIALfo2sGsYf8Qm8rh+sWuFaAzqHTJ2F2Ss2wwnwrbn8HxdhsXGemZbrw2XzzBQn5nHF1L5rEwxeouyuIwzXunLVz7KDz7/Bm4PQbv/xnXE6242y0KzzaDC40RRaVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRxht+fe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRxht+fe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775147031; x=1806683031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jubyS2m2QjhM1wFy1HfygIjKkKElTV1Ix6KF2Q4kQlc=;
  b=IRxht+fe6dniiH2vT5iQKBjUyzqrWRvM3TYTOKBb0n8tYyeh5y9/o/XP
   5PkDzPP8woN5aWGglxRyN42DJFlu0ISFLzPzg/vtX+fB0N9eDUfllDADm
   eIZjh6JQ4Vc9gCBAZ74XbfBtU+5w+fx/8XQTwWx+25+/R1bq8ZWO8Etdt
   Gm9A7JhdMj/Mi36cEotiXSyCrrZ9THABwkAPWuM50rglkH8Mbu9GqoxcQ
   CSzMbQ/W57GXIzspxSATfdUd2hMqwZ9KXM5wPQ/51PI+WbaVfXi0s7hCq
   raJRh0yvdcegwjNoAOg9gYlE2Yfo4tShizJDUckPLVvnYywYXQyUkhiC/
   A==;
X-CSE-ConnectionGUID: gckWcosOScCmRPabFQiMdQ==
X-CSE-MsgGUID: ESbjCSVQTzC6VWw/nkyHdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="87283600"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="87283600"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:23:50 -0700
X-CSE-ConnectionGUID: D0KNrGtMRbC6uGrHszmO3A==
X-CSE-MsgGUID: XhnFx+ziTluokXI1j+c2NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="231060363"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:23:46 -0700
Date: Thu, 2 Apr 2026 19:23:43 +0300
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
Subject: Re: [PATCH v5 4/4] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <ac6YD0Zr46YjNdr5@ashevche-desk.local>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 04:15:05PM +0200, Bartosz Golaszewski wrote:
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

> +static const struct software_node omap16xx_gpio2_swnode = { };

No need to have {} for statically defined variables.
OTOH, if you want to have same style over exported and static,
perhaps it's okay.

> +static const struct software_node omap16xx_gpio3_swnode = { };

> +static const struct software_node omap16xx_gpio4_swnode = { };

-- 
With Best Regards,
Andy Shevchenko


