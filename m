Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5DC2C21C7;
	Thu,  2 Apr 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146867; cv=none; b=GkGuZfMi1qiyGRYnVOmKDzJGjy9mfpzXJf9wzsAlTZuXEx6goqYuSqsDQFY4jrYo65mI8c4S6VSyoln0895zsrRyA6JIAXDtaqhHVxUMyIOkQNHWvwLgqtNAKRbphaTob2hvrA6SMQCs/Cl2+pQfGZzwNLihzlNa4qnZ+xazO4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146867; c=relaxed/simple;
	bh=GujdQjZozNiu5xy5BhxV8QzkK0PAVPSJEakluqbDb2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnkARLSmV7OXVTm6cUOr3Dm8uKzuirzO5CIKle9ZjXZ6dyfwwMtXma2cJl7rtYoHtCjfb/tiCFwJPV78kzGIt6JoTEv3DUcEE09uFnYSJAr/sJRqV3oSpeFM/V5cvJSp8r3mPSoLNkyTKYhtKvJKp/bzNRcuIZsRQNg8/67ptsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7QE3oHG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7QE3oHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146866; x=1806682866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GujdQjZozNiu5xy5BhxV8QzkK0PAVPSJEakluqbDb2k=;
  b=L7QE3oHGVyzw+TKI5ny160heiuf7DKMF0BQWtFM9IK8AHt3y+v3u02zA
   +MOYRK1idyktZDls9/i9/A2F0RIOY91ociC+yj2wRAoDIrPZSFFELZyTa
   ZRaFRvTBleojs2aGxKFlivFZ+WJ9KrvVsinaokxTu9GcAUZCFYA7SK5kF
   a+XpRWhM2HpPga44G90Xc9Tg2XuR0EO9SyiTzsjyXPGdxWNKIdTmg/TMk
   JPRM8tpW91xJ0cEs93sb3q5V3S4xa2u2UVmCFtO1pqo/MUNQ2Iw3BNld2
   /BoXon+2fhMlJ4NHgt100Pd5QLEDEsRc05EkE12T6rEUZja4adCh0hqoO
   Q==;
X-CSE-ConnectionGUID: Gt8dBRkASVWb7X5qz4h4Ow==
X-CSE-MsgGUID: yyoG9WgyTY6RDZ3EMGbH+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="63760787"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="63760787"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:21:06 -0700
X-CSE-ConnectionGUID: 80euU5L7TgqPnrTtsw4CKQ==
X-CSE-MsgGUID: UBI1ni8OTnaF1n3N+HjjFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226893234"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:21:01 -0700
Date: Thu, 2 Apr 2026 19:20:58 +0300
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
Subject: Re: [PATCH v5 3/4] driver core: make software nodes available earlier
Message-ID: <ac6XasInVzlqtuPu@ashevche-desk.local>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-3-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-3-d730db3dd299@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 04:15:04PM +0200, Bartosz Golaszewski wrote:
> Software nodes are currently initialized in a function registered as
> a postcore_initcall(). However, some devices may want to register
> software nodes earlier than that (or also in a postcore_initcall() where
> they're at the merci of the link order). Move the initialization to
> driver_init() making swnode available much earlier as well as making
> their initialization time deterministic.

Okay, if people want this, why not.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


