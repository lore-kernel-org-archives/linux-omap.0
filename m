Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D33ACEE1
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174572; cv=none; b=EQ05cU0DFm77om+nk9+rqN+ddHOgImtZ9xkizCFPQ+t7Ch+835VwQ0x5YyLwoGO7o2pxqVNl7JUrl50vQBt8d9R6OBEDyRU2Lxd//IgIHcL2by08lT7EQ74cnLJQcNm6C4guHd8x2izZlYEKXDfQdQ011NEioIOH7M3Fpp8Jp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174572; c=relaxed/simple;
	bh=SzUr6zig9u+8VJEkLvWpenZdKF09X36HV3SolVfmfk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOWOJefDfkT2GKT+t9f6z62DHCCSp0KYVLe1A917Wvx5GvIhtK7ijG0kzlu/vUrbH0B5wzLBTX+nHqFMqGIHSJxfdlSdCdDNHn1yLbtqFYK7gYE+2XwWPDiaZruTKkaziuPElQbem3klm0/HuGx89G6USXzgPhHyUVr8tC73PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvuNhPZT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHBonBcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvuNhPZT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHBonBcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
	b=FvuNhPZTAZ2PK28rYi8GxEQfyEKF0XI1qEUvdUQXbGT4vGPnWyxOxCJTq3st7qU6ez8wBL
	Hnln3RsYuhExec2GI9L8GVKKpx/JWuZrcHYgDyjH0HTTNnq5FIUM9RTti6SkZZ798JqbnQ
	m1QZhgcU/W9olbrWcXVkV4pZhLgHlug=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-gtc6Q-ZWMBuNasFsapnWTw-1; Wed, 19 Aug 2026 17:22:45 -0400
X-MC-Unique: gtc6Q-ZWMBuNasFsapnWTw-1
X-Mimecast-MFC-AGG-ID: gtc6Q-ZWMBuNasFsapnWTw_1787174564
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907ca5abf1bso11604166d6.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174564; x=1787779364; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
        b=UHBonBcNHqyKboom6YYt+t+ZK9mcVmi9cN0KODqFWGxuCu8/KOdMY7Ohc22sQO7iuO
         M4nJ2EDKe2ByFEhvifdxSk1qngxDudfryBdKJtudp1SyQV0/R4cHe/AvPqEdaWI6VIL6
         lgiF5sMDvLol52vny0cHgEwYNS2V2vB5S8Qkz6+ndaPUnxl/T3ncyKDFoszphPM5Ooud
         TGhQ2cLKd5ebRQ4gygtai7utvrZIHjVn2fczOjPvwY9xXqBigxAiHKzuOYYguQ0vrxEm
         OGUP5x6BkHENkSk8KHmla3HLPCF6dfoTBL8GnWF9ZS/plqAZMyjywbxEtn90ScpWc/3D
         9bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174564; x=1787779364;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
        b=OVP1IMlaesiNh2welvZkomqsYB+zGDRaotcOjsfXlOv2LE3k0bpWb+n5cB53CWiTlr
         fy1fKr1UCC65aroFrFokqhYygXOW+bLYtVeaqIcqg+nkGoP0ZPL+Sbi4/uZBJVGLBmRy
         XgL0eR9BnxMjW9p/fPVQoeRJuDes75MxWJLNlel85J7SL1WP7JeWlXzQORp1b8Kc1liR
         zzWi4vjPCnefpPZ0HV9BO2xQQm8grmC3o6n///Xa8gy5m+DWwrsvOTzwv8Ag4M43Yrvt
         XMehFEQ33tmZlqI9Jkq0ACozm2BQIIXQT1uopr1gmdsQsZjqTssL31ADH3FT3i/fvcFE
         uzIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYdjVeKS/brf0EtzOcRN8uXE9dch3eEhSNULMPN9TZQ/xVQPHrHWRaWfCvvsM4j8fNk4MsI5rAZPj4@vger.kernel.org
X-Gm-Message-State: AFuF++kPJPuu5lt9KyT4apqbeL5/+QBXVdts5iB00WNuCYCSFm0NZSlf
	Ub0R74RQLKYU9BmchldBxhldND6aB5G2mCSPYco7oJLlHGAGSZ7U7/C/Z/6mdKSUt/gCJ5WKuyu
	2zr0ExQoPVkbc+A43dda2qAwFIe40/f14hkfnUGyjwvh4Uas6Hd3PzBLRRTKlzCU=
X-Gm-Gg: AR+sD12BAX7GiOmTeLydCspe1vU+Lb7MSqWLbHvCsVaQPFLnZfBKecWGHv9NzDy2LgR
	tXPxiyXW7HE8cSmuGsNL4E2rJtwzXU8K+yA+9YJZHHDuYA2x1TBseDl+5j4B88qZ9+VdkSUq7eW
	c+ZDGjhnuuMri9cbUg5hme++6q27MdFrpmg1SpK5HKcPFuoFX6bRpivo53hq0kVTCyO/+g+kwhc
	uZHTgVeezl7ROxZwdSXYNasBtEMnPfLSnIyRsZgBKX1NqmwpTa8JQuNO3/nsggDJk3ZyojpjSwE
	Fj7lJXeJRp6O2ZtSG6D18X4BP92SW7IPhQrbStQa38FTvxykei+j6vsc1iPsHrIyyElK2PR5sLz
	Csz7GAQRHBy+Llv5Vf3w5RiEmoN3JpuFB5Mg=
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79736666d6.23.1787174564262;
        Wed, 19 Aug 2026 14:22:44 -0700 (PDT)
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79735276d6.23.1787174563736;
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee16e0sm23636866d6.17.2026.08.19.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:22:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 4/5] iio: frequency: adf4377: Make sure
 clk_init_data is fully initialized
Message-ID: <aoYeoSnvf5-l69lE@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:18PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

