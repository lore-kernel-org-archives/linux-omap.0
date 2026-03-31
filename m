Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943639BFF0;
	Tue, 31 Mar 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955377; cv=none; b=Ikfa7sMqLcVsBRLl1V1AgCxCCfm19HEQhkIpUNdcdPg8jn/go0unTP998/zL69TnNz804Pa0H5biQj54K6HpIkJyKNuq+9Z749pSk+CH+kDGpLaWWu29mUqY4t2jke1+n+mwCfFsfZElhWCo3Yg6wzAFB1E1SlxVUTX3otyHirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955377; c=relaxed/simple;
	bh=LpiNwcecD6qE6BaocrRQkrHduswXspS89v1SmDxcGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpfwwJdAmEYK87EmPYXW/2m+zHl7l2owUb1gHvJxJfRraKdKNltsltoPuJwQkPVBDPbyOPro66Db/2qdPam6aHyyzQUkSV75GN9UPlYuxqnpx0ImLA9KjaL0dH+7jFTIv7icXw/iRl/vJwX3wjrkY/X05TBNKvYHqHeK29zg4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwLhrCz7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwLhrCz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774955376; x=1806491376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpiNwcecD6qE6BaocrRQkrHduswXspS89v1SmDxcGYY=;
  b=gwLhrCz7THVDua2Xkomb5/3CwIe64YkS7Oh7kjBTlJcfAAL8BXW2llQH
   ne/WU+SOo3L3bdnyyo4y1Pv9ZBfMB/NMlnRn1bn8Gnu97ctBaN4vF90rz
   giruMMTnQWvDbfIu0+C0KUvUHoe5sFOg1rntKVeCd3mvdfdyqwhaGytsO
   nGS//LY+9N4R7MfekpckbNYnbtpTJtp38Q+wl7tEdRP0AR1k7zzm9KrIW
   WDbM9BZVVXPPPUUx4GGnXvGEP1NHfvdAvRqG04MjmmwnCGsq33eKiwwxS
   tWX17A8efbFq2qnyUjKUeOIJsXy4ofXeJaM6A14C5U0CVYuaEkmBo/YZ/
   w==;
X-CSE-ConnectionGUID: 4+0XplwYS+iFxA6RFQvckQ==
X-CSE-MsgGUID: sDvXecMIQX6wUZFGU3HyJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="79564585"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="79564585"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:09:35 -0700
X-CSE-ConnectionGUID: gzK6vAGlTtOKb5e4wFOCIQ==
X-CSE-MsgGUID: Cb2BImrJSVqLNPi0PBgcbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231267662"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:09:31 -0700
Date: Tue, 31 Mar 2026 14:09:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Kevin Hilman <khilman@baylibre.com>,
	Bartosz Golaszewski <brgl@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
Message-ID: <acuraLhLVgyP-LUK@ashevche-desk.local>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com>
 <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com>
 <acrcDTPpXZ_5A4D8@ashevche-desk.local>
 <acruxMNdnUlyRHiy@google.com>
 <acto3TE1AR8iTzF0@ashevche-desk.local>
 <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
 <acuMD7Oly4XWW4n8@ashevche-desk.local>
 <9359e475-fc8e-4d32-9ab4-383710170553@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9359e475-fc8e-4d32-9ab4-383710170553@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:45:59PM +0200, Arnd Bergmann wrote:
> On Tue, Mar 31, 2026, at 10:55, Andy Shevchenko wrote:
> > On Mon, Mar 30, 2026 at 11:52:34PM -0700, Dmitry Torokhov wrote:
> >> On March 30, 2026 11:25:33 PM PDT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> >On Mon, Mar 30, 2026 at 02:46:45PM -0700, Dmitry Torokhov wrote:
> >> 
> >> The code section will be discarded when the kernel finishes booting so it
> >> only increases image size on disk. 
> >
> > Almost true. Interesting microblaze case, where it's not discarded.
> > But I can't find where it's actually used on any architecture.
> 
> I'm pretty sure that is just mistake
> 
> >> >A bit of archaeology:
> >> >
> >> >The first time it appeared was in the bcc2152647b8 ("Import 2.4.0-test3pre3").
> >> >Then somehow spread a bit (but not much).
> >> 
> >> And it shows how useful it is. Maybe it had some purpose a long time ago, but
> >> at present time this code will never be executed since it cannot be built as
> >> a module.
> >
> > Are you sure about definition of __exitcall? As I read init.h the macro
> > is defined when it's not a MODULE.
> 
> I also tried to trace this back now, and from what I found, both
> the __init_call and __exit_call annotations gained __attribute_used__
> back in lniux-2.6.0 as a way to prevent both gcc-3.3 and gcc-3.4
> from warning about unused functions or discarding initcalls that
> are actually required.
> 
> My best guess is that __exit_call should just use
> __attribute__((unused)) instead of __attribute__((used)) and
> have the compiler drop it from built-in code instead of the linker:

But why do we need that at all? Can we just drop the full section for good.
Or i.o.w. where exactly is it being used in the current kernel?

-- 
With Best Regards,
Andy Shevchenko


