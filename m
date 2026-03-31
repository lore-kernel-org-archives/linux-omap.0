Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4F3815D4;
	Tue, 31 Mar 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947353; cv=none; b=GVO5StHRiXZEUO7Wgh1tUnHWiENQSrflTOn+NJcUGaJ9bmYTbxUnjxywet+t1CmFTV2hR+/jiDRuqZ69HZD7z6HZAY+CWKWx8GtvdqzTDfVW2WuVqsb9CD1hewJlgdLTnHOZS3K52smgVyiPbqVADNLNliPFtbA7YwV3Cb/zQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947353; c=relaxed/simple;
	bh=mjXdhJ0yvbX1f3PTXSl1lMhjR7w4O0ZEOdEGUX/Cgvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F67Zm8Rl8RFZbRv8uHoYTiXE+eKHhWexrwM1Hh8YbBiW/hEiGSk3JmVf2KtmtpYTfohVsumOfs0kBscWOKm/t5V+bSRVOGnwwtoyCxe9SnCGfl8et15px4uriBz457SrfPKuwO/ySRlzata1c7NQu2kpZxWKQorMvnI+r2GoKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlID2WaS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlID2WaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774947352; x=1806483352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjXdhJ0yvbX1f3PTXSl1lMhjR7w4O0ZEOdEGUX/Cgvc=;
  b=GlID2WaSt2gRaE1x41P5YVqhrLjkGcY3n2aUIoTUqCF+K2reEbYaPzln
   I0Ka/aT09nnJG/bNBlz2Agn+yUvHZCZ/AtCbfh3mlv+ZfFqkM556Zrlz7
   nO/mqYX7T5CkH1zLAjAhFm79I7yP+S4oIixfELy1OEVREB/sFr6DqmlnN
   1vRHgX7OD/qgv/ZKSuDPsbT1Q72HF9JTicb7c/10btQYarTH2/XiTjAbL
   2397wslLWcqSx5WBuxaZEmNr6tQjEWGEYZ++KZdcd+YuF7vx7fpzClaAB
   KRMpDpm/UJH/55FSM4apLxKHqmKsRYlfmCoBXft/vCSfLeW2KTLJvE05N
   w==;
X-CSE-ConnectionGUID: BO96Qh/yT/OAWcstxbmLVQ==
X-CSE-MsgGUID: +1G4UWcDSCKsFowcQMlTRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75669464"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75669464"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:55:51 -0700
X-CSE-ConnectionGUID: xJ1h9dFFR2S3YhGdPQQcnw==
X-CSE-MsgGUID: ZNoiYFOwSnK2Fp72Y8dkLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226272857"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:55:46 -0700
Date: Tue, 31 Mar 2026 11:55:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	brgl@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
Message-ID: <acuMD7Oly4XWW4n8@ashevche-desk.local>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
 <acrcDTPpXZ_5A4D8@ashevche-desk.local>
 <acruxMNdnUlyRHiy@google.com>
 <acto3TE1AR8iTzF0@ashevche-desk.local>
 <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 11:52:34PM -0700, Dmitry Torokhov wrote:
> On March 30, 2026 11:25:33 PM PDT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >On Mon, Mar 30, 2026 at 02:46:45PM -0700, Dmitry Torokhov wrote:
> >> On Mon, Mar 30, 2026 at 11:24:45PM +0300, Andy Shevchenko wrote:
> >> > On Mon, Mar 30, 2026 at 02:40:47PM +0200, Bartosz Golaszewski wrote:

...

> >> > > -static void __exit software_node_exit(void)
> >> > > -{
> >> > > -	ida_destroy(&swnode_root_ids);
> >> > > -	kset_unregister(swnode_kset);
> >> > >  }
> >> > > -__exitcall(software_node_exit);
> >> > 
> >> > Why? What's wrong with the __exitcall?
> >> 
> >> It's dead code. Always was, always will be.
> >> 
> >> Maybe split in a separate patch, but I sometimes feel the idea of "one
> >> change" is taken to extreme and adds to both developer's and maintainers
> >> burden by needing to keep track of extra patches.
> >
> >Why does __exitcall() exist then? It's also used in other places.
> >I think it's generally good to have a possibility to clean up
> >after run.
> 
> The code section will be discarded when the kernel finishes booting so it
> only increases image size on disk. 

Almost true. Interesting microblaze case, where it's not discarded.
But I can't find where it's actually used on any architecture.

> >A bit of archaeology:
> >
> >The first time it appeared was in the bcc2152647b8 ("Import 2.4.0-test3pre3").
> >Then somehow spread a bit (but not much).
> 
> And it shows how useful it is. Maybe it had some purpose a long time ago, but
> at present time this code will never be executed since it cannot be built as
> a module.

Are you sure about definition of __exitcall? As I read init.h the macro
is defined when it's not a MODULE.

Anyways, if we going to drop that, it should be in a separate change
explaining all these.

-- 
With Best Regards,
Andy Shevchenko


