Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D273D9555
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908527; cv=none; b=NNUzLiAf6i7fDEDc/KvyIImJjukeiQSH7BenBnsBkQZ4+hWI46UDzgn3UV75qMg+L1WmuWh904DK5yrU6VGhYhvuhFl+tT/ZscT4oRPQSRIvENcKjZfhdVzNkF6n+eWtMq0JhVuAQTsC6F41ZJiuTQjIdUJlZoIUTIhtHHqAVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908527; c=relaxed/simple;
	bh=JhbTbs0FOdbvKTC2L6+5hjqopjEb9VhxHqIQKPO/IAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1UruB++ukc2TQEIUr+EW7k/+EsfX8rKB4L+1v5LF9ng0FiZrawQ6fez4yKZskvQVy36ohHSx/N22YWjvEr1BoIpVArDQ1kDo4ir7mbJ63JK43QdvFGoXigFViaSvjgy9WMK5wW4Kqn3HBrmnFdRYxmTurOeZs6Ymwo90+Awi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihWzgHWd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtcYu0q3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihWzgHWd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtcYu0q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784908524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWD66a2ehIm/e4HyZcO15kOI/PXJYRp804FM2jJzuJM=;
	b=ihWzgHWdFN+9vm500uwFu6ShvceQ3TcZQtzIYaejY1QkCWhStdbPdVqlYGtGhE3YzrhB+A
	JxXyoApO8Ig8DfRR51UUfDAdynZ0q2wMe960wwlWaU9Pc6Fers9dgC+UTO70EObssxmave
	2fnfr5uzEK+kZ4gSgt3MaX8NuAYr5+c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-G2rlhsPRNp6QxzxcswG7zA-1; Fri, 24 Jul 2026 11:55:22 -0400
X-MC-Unique: G2rlhsPRNp6QxzxcswG7zA-1
X-Mimecast-MFC-AGG-ID: G2rlhsPRNp6QxzxcswG7zA_1784908522
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso6426121cf.3
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784908522; x=1785513322; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aWD66a2ehIm/e4HyZcO15kOI/PXJYRp804FM2jJzuJM=;
        b=NtcYu0q3gtPFzO0aIqg8kMrC3Oly67xUPxCdDkpiALicGk8Go2Y9yVgH6v7/9l1yvc
         riOU8BW0vjJ9M1hRhfm3qurzHvh21/oaA9pRvi26ckBRxhvxBg7TyE9whbsh9w1/U/XI
         Dgz5XrKpZSni+c0RyLrKcnz7yx4XImCv5unEIE6q3hgwLffbLFXLZE5VOYZTD+V0KSfD
         MGM2iQui2rSIL7+uRDOEZaq57Ug5eE6xxth3fRHb/ASQf6/d6yVOKsi9qQg5QJJW+7e4
         7JTMJuPgXqoeE/M3rF+YPT8JZSgkRpEfHDZJxI4Vd5wsQIzD6wJeS1gokbL4xkdeIw/4
         5EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908522; x=1785513322;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWD66a2ehIm/e4HyZcO15kOI/PXJYRp804FM2jJzuJM=;
        b=gjLr8O7/JjXEYrs6bTDAqjKi72OKjGVoe84l+sixMYAyrrF1N2HZxpTRPP7Dcqrpb5
         L0V2gLj2Ucb1TTuM/cx1T8+AOXGttwUmwdTehXEq/W68FxQM6dA0eWwi8zCBY6EcBwEW
         Cp0VGw5u5XRHpqiLAkFyPV8kyTR/4TwNQ1fw3mazeTNNddR+BXRu4vt/A0pignGdr48S
         PoSBtytvsW7AI5EgxbOLm1nRWia4SqhDVPqDu3nrE5opCu0I2j1G6Jug9MZOE98vvN8Y
         MSwI+ZdEOs/XnyRThudAp33zS/DF6oqjur7VgPjvQy5mjezmVBA5qKnDNBTfS7nvOFOh
         3VYw==
X-Forwarded-Encrypted: i=1; AHgh+RrWwZ8CerF2BSpiCOCAQFu02TpZ3dojfYQJUK3dsUivOv6nZELX47kl3B+DrFpabUayC7Z7NYN53Wyc@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOUs7Ag7lR7rx3sn8Mi4nQ8txvECSDOKH1Kt0KmnR7xyh1m+H
	eHi2tCBVn3Xk7BNxZ2GseHnucwK70ndfJzPFIJwZOzqK+1nlQmhc1QEowuxFLOEa0E3v5RfAodm
	dArLCPeceDQr5zsMPkB6oTpSyXXUG3eTmJS7h6RC/60pXKY03I+QGfnZ2Ml3bc/k=
X-Gm-Gg: AR+sD10NO4eyU2ZuSMk37jFibHomhESLQOyOW5ZvWAbSWGnuA8EYT443Y3s47PFEuc9
	iF0WRf+y+kRl0MJEoca/Xg3eKiDL6KJDcIq6m/NqIoOmo6pc/6YGFbNjj8FqBZznqlyV/mGEGWu
	CWvUaOIyoLvhBJC7tr6aALOEKCSsOyYuJ1BA2bIaIL0LKdvffSs0Fnl1wJAMQvWMssAesolw5W6
	ZT9LU5ELdQDRvQ7WuW5LSPxtOr0Xpp40MFifSMlYBUOCvoeyHSg1yyAzpSZKECP2sRoLspUs5VW
	8gzl6v6Wg5gTL6WyJ64RZa0tKkirBesJ83rLgrKo0Fp4vWS4QGypK+yI82xaDvZC0fsybaplNBC
	gkf6SgpEfzvCrm5yD6fFUL+Yr73RWWphiM0k=
X-Received: by 2002:a05:622a:164d:b0:51c:25da:903f with SMTP id d75a77b69052e-5283df3a21fmr79139751cf.59.1784908522041;
        Fri, 24 Jul 2026 08:55:22 -0700 (PDT)
X-Received: by 2002:a05:622a:164d:b0:51c:25da:903f with SMTP id d75a77b69052e-5283df3a21fmr79139341cf.59.1784908521604;
        Fri, 24 Jul 2026 08:55:21 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a27f4346sm2307631cf.8.2026.07.24.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:55:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:55:18 -0400
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
Message-ID: <amOK5hytg7ouOhtM@redhat.com>
References: <20260715-mathieu-wdt-clock-theo-v1-1-da65bba1828b@bootlin.com>
 <alkZmw-XmnCOZfOD@redhat.com>
 <DK6W03NSALJN.1SASGAY5HWSPN@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK6W03NSALJN.1SASGAY5HWSPN@bootlin.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Mathieu,

On Fri, Jul 24, 2026 at 04:56:01PM +0200, Mathieu Dubois-Briand wrote:
> On Thu Jul 16, 2026 at 7:49 PM CEST, Brian Masney wrote:
> > On Wed, Jul 15, 2026 at 05:09:56PM +0200, Mathieu Dubois-Briand wrote:
> >> Resolve parent clocks by their index into the device tree "clocks"
> >> property rather than matching names as strings. Name-based matching is
> >> fragile because a clock's "clock-output-names" value in its provider
> >> node can differ from the name used to reference it in a consumer node,
> >> and because names must be globally unique across all clock providers.
> >> 
> >> On AM335x, this caused broken clock trees where some clocks failed to
> >> enable because their parents could not be found.
> >> 
> >> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> >> .index to the array position.
> >> 
> >> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> >> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> >
> > So this only updates of_mux_clk_setup(). of_ti_composite_mux_clk_setup()
> > calls ti_clk_add_component(), which does a name based matching as well.
> > It would be nice to have this consistent within the same driver. I know
> > this is going to require a larger refactor.
> >
> > Otherwise your fix looks correct to me.
> >
> > Brian
> 
> Hi Brian,
> 
> Thanks for your comment.
> 
> Yes, it does make sense to make everything consistent here. I'm not
> really comfortable with this driver, but I can give it a try.
> 
> Just to be sure, are you talking only about drivers/clk/ti/composite.c
> or is it about more files in drivers/clk/ti/? I'm not sure to understand
> the whole interactions between each components here.
> 
> Fixing drivers/clk/ti/composite.c to use clk_parent_data looks easy, I
> can definitely send a patch for that. But you are talking about a larger
> refactor, so I suspect you would like to see more changes.

I think we should just get drivers/clk/ti/composite.c consistent with
itself.

Brian

