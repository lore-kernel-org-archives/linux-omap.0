Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB541B8F6
	for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247887; cv=none; b=UuvzGCrpmBGrzDLGgKwio+hVeiLJv4HkXw1Wefb+v0GyAneP5mAEwDLoVS0lm+LwotyjpusGAcPZAGGfqe+FvBYiTs/IlaqToPrVRQeCWIJfiERKLUzsULVXjq/ItygMBlVBnVyrTr3v2KGzCh11JpAUxW4E/niV/dC0ti3T7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247887; c=relaxed/simple;
	bh=0fz0IdD0HThpC7IO3Z9qzbU0xi6FpEUe0g7j3i48V78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8fCE0oBrI39dIjCze/76CS2pHMOoAe/n3wrEaoqi/2F1q3Hw12g/8XKhDEshrQ5lQwrOo92aopvPetLFWVAfxz5IbrFsgsk8CX0jOUjRIxpIPQzQq1b9Uf+EYwuCvjYVadAcLl4to+I6LKj/Wg/Mu3RZAmoOgjx6pPMGP5LSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSA2p/IW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRtk5zBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSA2p/IW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRtk5zBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TF93kallz27XSXLRWu1t46UFHr/jncGwJpnhKwCAGTY=;
	b=RSA2p/IWa4otxDg68n6Jj2QaP6dkR8CgE0WAi9yr9eLl7czwTwfFC5AnJiBL+WQNInirGx
	49Dex+HQDKOZE0Q0OXCEH4TtzshNwbulSM5iRk2/lszQ7zvjWC9q4HQLu9CcV5Ds/h3Oa8
	aFwJheJuIdsBSXKnTxMZJp4JioAzf4M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_ub4xIACPhWJ7_1ksL5Kug-1; Tue, 28 Jul 2026 10:11:23 -0400
X-MC-Unique: _ub4xIACPhWJ7_1ksL5Kug-1
X-Mimecast-MFC-AGG-ID: _ub4xIACPhWJ7_1ksL5Kug_1785247883
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so473295285a.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Jul 2026 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785247883; x=1785852683; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TF93kallz27XSXLRWu1t46UFHr/jncGwJpnhKwCAGTY=;
        b=RRtk5zBn5E8H0vOiwut9KirX4iIPRltVQZxOENU+1UZWXWHUfOfsTQbvfT2AXXiLsM
         TI/2/w0rXVKtrtzHiGQVUmraen+cgIOFTSSfKCdtN/rOVqg44reRrs5MtTB3x9DmEb95
         cMZpfyB8UErPI530lg2zZWBIrsXvJt3/uTYvpWCwpzy05zvkWjnyDpWmZ7uZQYWdhYYi
         sK0cegntb62iNXkEFL1rZDthnLWZuV8ZOaLAPsrO4G/z42HcAV9ATIxp/HbS0imA/cuE
         tF2WRxayn8KbjTnVvoyVCFMFlJ+gp5hRITMD5zFvbiqb7nXVowgkSa7JJo+lAEMxjgqc
         g8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247883; x=1785852683;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TF93kallz27XSXLRWu1t46UFHr/jncGwJpnhKwCAGTY=;
        b=J8e9NJi1GKIWdhTXEKlgV9Ywb5a500G+Rm5Q5CbnPQ9dL8+p3j1luFIxTmZ21JlP53
         0ZDsl2z26pOEWKldhoo5KPZSTqLOi2VzSn5mVXXXKCpxWdv2ph/tqvTIbubW2yMj6iib
         kdZ3g1UK69PXpsglKMklenT6r16A8glDd5KnBzop5++Iu+7vTQKYh6CMrb9n4FxnovVG
         Yk5bRpxX/wPrBb/01h0JZNPS06XegWt31jTx3nGHc5dnX7V0VLU4U5OBOld1ZtdN1/iM
         iWLUhPofj0eqsm0b2eUIYjFbXm3+pCfJHDW5HU09jUbDMotOEkWh0cbHX9tTw8EynZHg
         NSsw==
X-Forwarded-Encrypted: i=1; AHgh+RoBJIoaleyyBISESLa7HfwpvLu+jIRWu4+wEDGq0wpPHwm5cHFcM5dt9rRIpzAyiOWUmk1/eghSHwlv@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFgbBFvscabUrZLgkGlgbGdDMos1RwaouXMoFewtLpQlMTg7c
	UPxjn2NW1kQH6XR07xsPrGKa5tQb5dWh4oq8ap3TEoerRZCnf4kyyC1ZVcvL2Rj6ied9hzAo1Wu
	TTFP08Pc0Jz1N0XXnpNzj7z7PFjZbtjEb97Upkj6D8TKzFShutilTiy8QA1mjAqw=
X-Gm-Gg: AR+sD12Ls2oQ64TAN2J4X2ovwhqj6Gx3rP2/irw9djAukmUrfNb1KTK9ACNRZr9SGgW
	FxyoHnA66wb9OBh7k8LnIqlxXLUBjUI4Mj4dw3u/om2Tzx9p8258ZHRLrakYGE7OFRjGCZ+wqSo
	60USmI1SXeFadpYJKL3WPkLuSRapUiBOQLSqUCBRiyAB8ecmId0meVTt20XIANAXEGEsoRXl1d7
	AwH0a+JYCt6SVpRWf8uh26S4cLWf2mRs3yH+sGprp97SDePyz9khuHgPf+FTaxmnFsySBNrRxHA
	cO+qRm9z4VsrBG+8i9RW+m0TcV8CqnNUzEc8ZrASKO4dZGCnOgC24bSTuFHYLRrbc5Rd3MuKa8s
	2iRsjkcRN16AbT0sFJ1rbzQ6pHC5LDHGabHs=
X-Received: by 2002:a05:620a:270a:b0:930:a12d:b158 with SMTP id af79cd13be357-933026c7e40mr229017885a.21.1785247882363;
        Tue, 28 Jul 2026 07:11:22 -0700 (PDT)
X-Received: by 2002:a05:620a:270a:b0:930:a12d:b158 with SMTP id af79cd13be357-933026c7e40mr229012885a.21.1785247881818;
        Tue, 28 Jul 2026 07:11:21 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de657299sm839772085a.35.2026.07.28.07.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:11:21 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:11:19 -0400
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
Subject: Re: [PATCH v2 2/2] clk: ti: composite: resolve parent clocks by DT
 index, not by name
Message-ID: <ami4hzvy4PQ8cuTE@redhat.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-2-c048a6394436@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-mathieu-wdt-clock-theo-v2-2-c048a6394436@bootlin.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Mon, Jul 27, 2026 at 09:41:41AM +0200, Mathieu Dubois-Briand wrote:
> Resolve parent clocks by their index into the device tree "clocks"
> property rather than matching names as strings. This makes it consistent
> with other parts of the same driver.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

