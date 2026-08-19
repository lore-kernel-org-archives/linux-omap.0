Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF68391E4C
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174589; cv=none; b=i3WfKi6wDUnGtHau45BxrNA00w2ou2AGERJRR11rED3LWb6nQhO7PHbkmkKwSaw33aSeHCe36+IUJOjY7EoSFQ5SLMGEdnkvCIQIpWptlyMtcuTneC2JKTZ0+YLkAwyJ8I8tab7iLlImZeN2OtXaoC6JPOCc7IIJAngsjPto81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174589; c=relaxed/simple;
	bh=e86+tyxRdQKzE4t52ZefcteM0bRE88sbIL68NZYIiAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsG7see9xh4vFMPOEkpq5f7hAncNTl60tXeJppN0XA04yf+2mOq1gj3cEkzAq/LS9NDZJQijM72biVJ+zvEooIu8zAKkTjoa0BHr0jnvoXn14a3C2i9O7Oxo1cAVNjI/M0+Lmp7mXaXst0r44Wp2UAbEfY5hWBdKAI94ohDUdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNzU2lCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCKAFLrZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNzU2lCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCKAFLrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
	b=UNzU2lCM8vGP/ynJu6UYWXGCk6w7dVDtbXs2Ew1fNbDLkeCPOIhcDCATa02P4Lr/I9uPYs
	JYUM4xPAGMT8/QeMWtuONz+/MZ83Pyg4nQUPdIILyPPeqtCkhUNLjXCpQYeKCRx+4tbu/d
	NxY/KmvxMtzjxg6jPMx4fJpI+bNtpyc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-xSZ4Zf1ePSWhN-f56wi-0A-1; Wed, 19 Aug 2026 17:23:06 -0400
X-MC-Unique: xSZ4Zf1ePSWhN-f56wi-0A-1
X-Mimecast-MFC-AGG-ID: xSZ4Zf1ePSWhN-f56wi-0A_1787174586
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f113592bf3so28382026d6.2
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174586; x=1787779386; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
        b=JCKAFLrZWsJlDyDL0n3WLYXT63egpUnZ+e9sB2o8Cu52PYgoPA+qrgX0HMk/lPmuhg
         kcZ+OnAOPFAPoYKI9SfWNtt/wNFfb/l1B6Qdpjt9TXkwa43DK7+RdPkfUnPYcbSp4trw
         Y17ETv81mfJFnM6opMhSYQfXk50NGBWU+qwk2peJLmDw+Ewga6+okxmFUof/ZIMerVvb
         1M+0Hzo+ltWLG+vER+nwoKKVNLyJN8Nnj9uBk8EtwVn/j5vuBSOg0S9tvxz0J4D9NJmo
         mhM/RptbedIlUzfhAEYhLCvT3YX9QmZVBkAYg7TGMhcQn3/sfMzWQIBbnVAkWKY11f4X
         qF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174586; x=1787779386;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
        b=myKqmkzYEL73XCOraeb0VPGqU9AG1z7QrWiVaOIeXKAIX6XMRuAu3A0jKAnVf9SYuk
         HC6phGkDOh/fzL4Zor3LVcYd7W6Rj7SwCFhAdQuuNnFuv8OsWzg7a1boHMhvr/1rNd0G
         jVh/mwHy3vBDUPrXjmPZvDvpZuP9w9vgiqQu9h9GeWAHdB0mDwcJVEurjPwS5DADgmuu
         SztpdESTUMKm11DXhjzGyR+/Mt9TxoPgOHxh44CtETpTgLz2JmzFUQ1e05Wbu7ZEvHer
         DhnoM7TCFk8B8b7dbarN8IzMYSZONW6Kh/drbSMifDxQrcaHf7cBTKPF2pmE6KgjAJ0k
         WAQw==
X-Forwarded-Encrypted: i=1; AHgh+RqQopZ18PfPHCXSbD7+7KMwzLmHUo96PmkO9qBa9i8J4ck6h6JtcNPArl1y05KpgJyx9s8GY87Q8ll1@vger.kernel.org
X-Gm-Message-State: AFuF++mtis0F/27oZIZHgzz00C7+PNbf67621wNv3wI91xEnBboSSmot
	I3A4Fn2mEIFHG4iFh5JpYNeaDXOzmygUBnI7jTOsLqXA331KC3xPvfTotLPc3wR6YdHzcCvFe6j
	gN1D72XFjQSSj1AvYmxPib1VdRnIQZG4knu8DDfeqcbY9x0RJiCN6weeFsV+eoPM=
X-Gm-Gg: AR+sD12cC0eMBQwhZtxgZw7fG0vS02RrpvR5/5Ip++QCv652+dU082K2HqhqQCsb0l/
	bmv93r2rMtwmuDoYvqNi+CaQ1v+0L01ElofPR+43LcIsa4cBiNfsUa7lKRxC79hew1ys72rNj3N
	TrtSG/hL+6kbGo5nEvpxQywhBPby/R095AGrq0zmt2Gtxp2PFGxM94k7OmLB9RE4zt4KWH+IHbR
	KuYIlTKALUHABNnHpTCQ83xf1UrbkPpz/qlKg6gqotPTOfHm9qHoIR4Ih1spYBHRO4nXEiFvqML
	e5HGnRqWpYOUQeTJi3EaCl7nZsRTLi9d5eb/F1IAYX0Geuru+E7Aq/MzOYJDjQWC6iEtFcWaNnt
	J8ZbMIUtrYCdhrjGpISoDPf5kFXQ73kfZSn0=
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665606d6.32.1787174585746;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665056d6.32.1787174585342;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a1139sm23455876d6.34.2026.08.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:23:04 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:23:02 -0400
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
Subject: Re: [PATCH treewide 5/5] spi: amlogic-spisg: Make sure clk_init_data
 is fully initialized
Message-ID: <aoYetnpb5fu2M9u6@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:19PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> aml_spisg_clk_init() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cef9991e04aed330 ("spi: Add Amlogic SPISG driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

