Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94024302FA
	for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224164; cv=none; b=HebwfRb4P+IZEzC4Q9kWo8ENabo8YaTgcAhhpXkm6+qVcje0AJ28/wjqDgDBa9rXshPJYruKJuZBiFHWm0fyg1i5XZ8aJM7t2JqhxVkmUAgmVlJkcmjVbL7Gten4zxL536yUYAYqS/4I7BQyKEegVVu9YF+InUsXhjZCjL6y1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224164; c=relaxed/simple;
	bh=bKRolBV3xBMMsK40FcrEsNOw9RXevHwtK+o1ICFtrTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPxHNfrl+dEjOX6JsTD9fIimopSLHqkaMZPKMf6jUEeLMUaRZGHvnGLMhR2YA2XqL1S3cH3TnpmuwUDgKR63zTokAutF2EvgM5dytPv+M95V7krrnHgWUSI2/844aQC8RX5hXTQwAgvcHig1hwDOgRLWK/YE+DIwstrJRrfcZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HY9S8eGn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sh3bCVBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HY9S8eGn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh3bCVBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784224161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ2dOwd34yp2o4e4FFneZgLJ122AV+T21G+gB1LuX2U=;
	b=HY9S8eGnm8bcYaMHurm7+K2aAY1W4c0qK44dSj/cE9nVvT3YEmk6P7Ni8gyH8VeT67Y+Sk
	0jRea0Er4uRl8r3BhJ6mLeP6aGtahgOVKIn0g0t5FZ1I7yVwtBUoxsileP6RoCnCthub2X
	3SDD4mrMPRLu+qif4tcjMd5Atn6FY/I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lc9a3cLcMCqjBYlAEWj-5Q-1; Thu, 16 Jul 2026 13:49:20 -0400
X-MC-Unique: lc9a3cLcMCqjBYlAEWj-5Q-1
X-Mimecast-MFC-AGG-ID: lc9a3cLcMCqjBYlAEWj-5Q_1784224160
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5fc4c7e9so425135385a.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jul 2026 10:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784224160; x=1784828960; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WQ2dOwd34yp2o4e4FFneZgLJ122AV+T21G+gB1LuX2U=;
        b=Sh3bCVBxrq+yvlcUd1lfDMHxTfBAV2DclRnyxoEim3RUjG8ELZ8oFljbvRhSyHGF5m
         rDGI2PuacImVxy2qPjU9qC54ahvEtEJuXSPLdDnUYBXRiWfClBQFi6TNxe/jNmg0DtqV
         6wPgYyAGL5rct2FFcmh8ZtkId2wwyKJcUn4aapdiHdUQ8SCmF9bYxnYZ72Xo+3+6tjJP
         uc/jqrqo7Ef821QP34RZp5t9r9DgQUuFPjEnfjMOCE4be8xKEONojlGaVl4rIHo4Zlav
         XpEZbravEZeFKqC99oATzBDf+efTduMrsmJYb9i0ru4Vm1TW/Xuc3ycqbrUJGZTX+E5u
         zY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784224160; x=1784828960;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WQ2dOwd34yp2o4e4FFneZgLJ122AV+T21G+gB1LuX2U=;
        b=AA/i8S9FA/h1O+EKdo3NaF90Xj3HE9oBnOjdxkMj9yJX6hKX3KKsjk/XVJew45yHRj
         YQs6s64lACoSaqiGp/kyIMYfoj3ge/jblh/V3SH41GTXgNTqNfF0kt5vImInVvKVVTFN
         Kp7uEjBkjcjZEFKwK8HICaqT17NnWAmMYuDp8C4UZNrPXikRO3mN+p5pUM4cmztBA1nw
         Qb+z8TUrrvg2DV8o73m6whk1Kp1wg8YcwbQpog5NWnbgEnDm5+z30tpm07VPpjTtWDXa
         N81V0PbaCT058e3ahUJQ4YUMrJP25xI2dj49CvEJS1aGDLABEnVWEjj72/xupLa3aFeC
         x0Tg==
X-Forwarded-Encrypted: i=1; AHgh+RpAv6P2I2uHb41/feZF5zwcNz2aR49+IjDmNvW/LsrmKFXkMbAjLn/p/eSvRvj4Bp1UvkKO2TWRE3QA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Ve+CI0VUGMekFsFw8nhX900eu3l5NHmjkUI14LnHVZed2iyS
	L6tx1+AkSH+s43TN9RmbnsKHnQ//PeSguOjKiQQVUuNZVIoRcSZrGTbeoAjv6+AX0t0FOqw6+MA
	VHV+KCAnp9WlI54dxxXOsvWWBAcWI5Qm/pAaw63qUDn80LKlNIMYY6BndVPSHIj0=
X-Gm-Gg: AfdE7cnmEXiIzKN1PJhmwjMuzL0RAgdgHniohttr/q0ROmb76/bYOI8s3rfoFZqwp81
	RIeXi9NpnkXzdrTEchn6Tcsk5sAXVEAtObFCfSt/Z7Ucs+teIAYB1AfD27UcNYcE93WEcXtiH2Y
	9aAWGfprl11qHu49kDy7K5WtqCFuW3UQaLU92bBpqiEJEKyi7UBwFkVKsmS6EfNn+WkD8qXyeDa
	Av31Q00L5VZHu6l6Vm6hFGPbYQ1rG8IDLjgVQJDUD+c9PB02gwncXE4HuPUuE/+JuDFQyXrmueR
	oStQyYYt+ljF4YQBt/csy5PdpxdCGBCkgildRjWCeca9k7mxMmDRAoQB8nU8kI/WjmeC5boDDz7
	FWkZ04iIc8sW4lLXiH9mGgCr822luenZ9l9k=
X-Received: by 2002:a05:620a:6cca:b0:92e:764a:a5b0 with SMTP id af79cd13be357-930b0763009mr52092785a.14.1784224160007;
        Thu, 16 Jul 2026 10:49:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6cca:b0:92e:764a:a5b0 with SMTP id af79cd13be357-930b0763009mr52088985a.14.1784224159551;
        Thu, 16 Jul 2026 10:49:19 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf78a5sm2166683485a.31.2026.07.16.10.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:49:18 -0700 (PDT)
Date: Thu, 16 Jul 2026 13:49:15 -0400
From: Brian Masney <bmasney@redhat.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: mux: resolve parent clocks by DT index, not by
 name
Message-ID: <alkZmw-XmnCOZfOD@redhat.com>
References: <20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Mathieu,

On Wed, Jul 15, 2026 at 05:09:56PM +0200, Mathieu Dubois-Briand wrote:
> Resolve parent clocks by their index into the device tree "clocks"
> property rather than matching names as strings. Name-based matching is
> fragile because a clock's "clock-output-names" value in its provider
> node can differ from the name used to reference it in a consumer node,
> and because names must be globally unique across all clock providers.
> 
> On AM335x, this caused broken clock trees where some clocks failed to
> enable because their parents could not be found.
> 
> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> .index to the array position.
> 
> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

So this only updates of_mux_clk_setup(). of_ti_composite_mux_clk_setup()
calls ti_clk_add_component(), which does a name based matching as well.
It would be nice to have this consistent within the same driver. I know
this is going to require a larger refactor.

Otherwise your fix looks correct to me.

Brian

