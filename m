Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4C3C2787;
	Thu,  2 Apr 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146763; cv=none; b=rQUs1WG/H1XnN2ihZKkG+VM5SX+GyNuA7Ja1Ly7MIkFAuccyCfP42i/arZjaRBqCkixIZUTQ+1pRKkL3kHKBInqKtUpktM6AVWu7Q1zXMnmn470irS5MYHjwhaMF9UJlNSuUb7Wu40vtBFG96DHcmmbyT9myOwCcViPBpNsdW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146763; c=relaxed/simple;
	bh=pMXoH8+Kug+/vbCPmyo9oaefuNRMEW94bMJANJcG2vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUv94hClzDm2MsraS6/UtFT905YO6Hktkz8Ghh/VrT0ddyONx4wY/6yc8z9N0SEn7+0CoU/a2Ui4cE2EhvFpuinqfWsjcXIIALub1xkM5vnYKKsaKaCKtHrkicdqEnVq4j/WMtPk4BkJTXK2GS6c6cL6kykNCLD9RlcT/CoSuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RG1+MiNf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RG1+MiNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146763; x=1806682763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMXoH8+Kug+/vbCPmyo9oaefuNRMEW94bMJANJcG2vk=;
  b=RG1+MiNffFphJJjzhNserokVCqE+JtYkroNhN+EeKLnxgbCGxsu/eapH
   l50xdEU4aZaf+3N+cKrIJpMUHOkgGEi8IBUO6TbstWV8Hb/lKbXo/tBq7
   LNyDHF5u/7lncIOkeEyjL69+ou67s1S6gmsQqV0HiUpWvwn04Qlb/HXg8
   OlhUanQMswSrL7MYWAUVE3y4d16FNzAl7N2Tx0RQmgbF55r5qioGIAppq
   0VQ0zouVcAtfS4z9SnEwExgSzf3bsKSL0DB+fk07FyJNqsZQE+Q3YOQna
   2QMwaL2dYo5biIuNEDdV9VuVO1r9wYAJyaDYAaeXw0oP+JaoJRZTdz17T
   g==;
X-CSE-ConnectionGUID: Of3pNj4wSAqC0e5MU1yEbQ==
X-CSE-MsgGUID: Ni4rGuxvT2mNThVa1PSnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="87664174"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="87664174"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:19:22 -0700
X-CSE-ConnectionGUID: 2wUYM1L9QBefu6w5SVTnpQ==
X-CSE-MsgGUID: zCxDvFP/R+qWsY+u2IcbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="220369184"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:19:17 -0700
Date: Thu, 2 Apr 2026 19:19:15 +0300
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
Subject: Re: [PATCH v5 2/4] software node: remove software_node_exit()
Message-ID: <ac6XAyjxTct_WCEI@ashevche-desk.local>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-2-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-2-d730db3dd299@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 04:15:03PM +0200, Bartosz Golaszewski wrote:
> software_node_exit() is an __exitcall() in a built-in compilation unit
> so effectively dead code. Remove it.

a dead code

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


