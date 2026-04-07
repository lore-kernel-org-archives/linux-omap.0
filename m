Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEF134CF;
	Tue,  7 Apr 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571377; cv=none; b=IXVbbly9/VZIz6vIkqeSDEVSpOXKmK7rEIJ8IBToYnKbV8KGhnCJ3Piwa9C0VrKnWDagqwbSSbd2AoTojQHmwaHqFZK3yNsaR5TqEAxOZhWnO3XnbjdiiheAeUdO/K6jMoe0vMKpbPROVNfGzSuiyop0Sh4+RA9iMEMuIW3g8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571377; c=relaxed/simple;
	bh=phr90QLyaq7RUo/A3Jc8HshSe4PIXcLlnVoGZR6dc3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD3iJA298o4n26Ot5a/baOYi4luG4aMuLNFCyNA9JnWo0ZrxRhntWWUEl4iXb0ePCiYB6VCeePZn9Q1tbgPV6LaSLEnLFUUDHWGLSq1/zie6ELYscu3cg4mDvp5nOpESL612LXYCDMtRk3hXtIVY39bZsaKzTTSOSmUYyIQlBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jp1qobZW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jp1qobZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775571376; x=1807107376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phr90QLyaq7RUo/A3Jc8HshSe4PIXcLlnVoGZR6dc3E=;
  b=jp1qobZW0PnLYMk4t8Wf+kOeA4ohq4QSiF0se7iPZN/hBQYkT9bTFRe9
   0XjnFzB05Qz4mSXaRPls8VspWJHhRicZqNWWL9mOOgyANSs/WVZorKA/1
   wO2yHIrGnHGWfAby54n+JkbONilOWT+iTX7Kdjptx74cBfURWhZN9Y/pe
   KWFx3R3Y5aHc/Ek2VgEeXSkGqYsl+Ny5fJgnqA7lWdU884h31zT2A4sMh
   cNnp0Q6Ojedhhd8vVkLRIeTv/gz91TNuKB/ypbYo1E0hmD8+hFxk9K+pw
   tqrNWn4KAGRkCnVRFGjQeNxruCoe3ojIAyZPVK2Bhi33IbRmVWTBsdkTt
   Q==;
X-CSE-ConnectionGUID: v/qQs9jTTam70g6qab9rsg==
X-CSE-MsgGUID: 80sOYBKxSbqqEAIwQOAy2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76500311"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76500311"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:16:15 -0700
X-CSE-ConnectionGUID: qewB1qKeTX+YTbDaPymkmQ==
X-CSE-MsgGUID: ctXyPk7pT+yPJmsv3N3spw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228440843"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:16:12 -0700
Date: Tue, 7 Apr 2026 17:16:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: (subset) [PATCH v5 0/4] ARM: omap1: use real firmware node
 lookup for GPIOs on Nokia 770
Message-ID: <adURqCMlAIGjB8--@ashevche-desk.local>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <DHKF135KLNW5.3LT0J6T5TE3JD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHKF135KLNW5.3LT0J6T5TE3JD@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 04, 2026 at 03:47:24PM +0200, Danilo Krummrich wrote:
> On Thu Apr 2, 2026 at 4:15 PM CEST, Bartosz Golaszewski wrote:

>     [ Fix typo in the commit message: "s/merci/mercy/". - Danilo ]

Depends if Bart used French to sound that genuine.

-- 
With Best Regards,
Andy Shevchenko


