Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64A389E18;
	Thu, 14 May 2026 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778608; cv=pass; b=nBrTP6IHfCd1C6MkYLyYkkmb2u56RjvaGALF+8Upg2Uwua7qkTLNs/c1Lweq79fEOPLGDxFrk/TjO1eO/n7W6jNktrmWN1mYRNhdQN2GjA2rb4O8oUNaMhMMPJ0PK3Sae8AQ6mCuedcWnE4psfyhrk9GYoSfyrSIXbP+QnL1ghk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778608; c=relaxed/simple;
	bh=quVLhMAGCotpq7Q3ZXdmJatR0Zaz1mKaf2HjspYcorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFRmb/UeAvfL+V6vVh7HlK6uT+63MlpIezjCYKCaRQ1w8nPRnjNGOk4eh6PZRVHaUyDlZKEj6YYcKy+4eBHTOfd2W69Dp3WPuOLparO6khUTM6uvqgMsuAzGYwoMxp8gQ5WfQsH5tpPCSEqmv8LE5hg3l9FqxC2OVBIcLGZquZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NBmeMdjE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NBmeMdjE"
Received: from darkstar.musicnaut.iki.fi (85-76-71-86-nat.elisa-mobile.fi [85.76.71.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gGcJf05VvzyNR;
	Thu, 14 May 2026 20:09:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778778597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ranXWKRhhfeffYG39L6YAknxenMYzYXGHr09Vb/2vp0=;
	b=NBmeMdjENBZTv7/Amm+WcH+TaIAVge9MiDpPc7lqohkAw3Yxll7B2Fq4P31BjFEqxZAZXr
	pvhjydh1WCfWORgWOg7eggMsIXKqgoM9EW/k/DMxGVsEfVZYkSFKhzJIuv21phLMxkSVBR
	TGl6dqLpHkSmVHQ46MIhlLNzay74470=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778778597;
	b=QPYw6Vu51ExZfbQa3Xj3m/1pL5ULQl202XrGAgHYwZCmkap4askr0+RYiySHKCPNWTm/uV
	wQHfc5vQ0ZKht7lm/yg+tcPi/ZITb+Ip0VPf12Lu8fZoL3twhhNblYyVrQCsyuKT4sm0/4
	DGI5syvOFtPw+Kh1soGrk9DAPhpIuJU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778778597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ranXWKRhhfeffYG39L6YAknxenMYzYXGHr09Vb/2vp0=;
	b=lUtqBFVa0qm8A+UC5ouzsPiunNWCpn+iSiB1yuaIBBvGrtv+En5LaVobuqeSEBiTKnfC2y
	a8m08Fn+kifwUh+pl19P1UNOM3zGNxSn88WFI69Vd74FwsWDtnuaJ4T/0xx9pB7lI4RZl5
	WkgloBlnkeewHzjEJTAEv2NZbGWeEmE=
Date: Thu, 14 May 2026 20:09:51 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/3] ARM: omap1: use real firmware node lookup for
 GPIOs on Nokia 770
Message-ID: <agYB3-T9yz9-hdr4@darkstar.musicnaut.iki.fi>
References: <20260430-nokia770-gpio-swnodes-v7-0-c88f74c90dd6@oss.qualcomm.com>
 <CAMRc=MdN9EpQVW=1Sb-9hRdt56Y5NNbskujjq2RiXhu90t0QyA@mail.gmail.com>
 <20260513145926.2dc4d037@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513145926.2dc4d037@kemnade.info>

Hi,

On Wed, May 13, 2026 at 02:59:26PM +0200, Andreas Kemnade wrote:
> On Mon, 11 May 2026 15:34:39 +0200
> Bartosz Golaszewski <brgl@kernel.org> wrote:
> > > This converts Nokia 770 to using real firmware node lookup for GPIOs by
> > > attaching the software nodes describing GPIO controllers to their target
> > > devices.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > 
> > Hi!
> > 
> > Gentle ping, can this be queued now for v7.2?
> > 
> So any objections from your side, Aaro?

It's fine.

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
