Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719934BA20
	for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087645; cv=none; b=H6G9k6G7ZZNsvPT4tENPJlvxVMXJpRhwGNTb3IqLirw2AA0XD/v/z6dMh4AVTGqsrRqpUjFy3fq3oRuRFrB0iF9p2cUrz0vfXzPtoARuC6caZbXMW5lXSsMTsT4idcc4lIBbhpU4E0xg3kUKt/oDPCSuLLAJaUtIshi7QcGlBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087645; c=relaxed/simple;
	bh=6ohOiM74UD4xMxkO4OFu7OuzhXuuv8SHaskdv78UhzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgJDFrzVrYuLpFWWMO4006szPFiZpUpzDtUSphVUkx/xs+Magt48QF4K3idZn4lEXwrGF6pmVziU4oCwJmqexAkfjhgxYpyGa5gDgcPQv3IH2wUBXnL51vXAX9G++1vKXZl8RXp7MNm8rpLpOy5eZMfRGM7Od0KjbivBYzS/BYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIRdSTGX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfXKyppD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIRdSTGX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfXKyppD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787087643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0M1lc1PhRG1akNgGaC7ljiaI/Sk2ScYO5cf2onL4Tw=;
	b=ZIRdSTGXzWYE5KonAi/weK1G+mQAXVfSyHQQmTUpVYstQvk2lK7I4vKcFLO2Jv+EERC/1O
	9l0qXcxRFFhEcz/MfulOq4pW6bWnmV7mxuB4WmJIeFdvn9n+Whk8uWYtrXa5qWsXaCgQ/S
	amyoDqdNUJ9XWuS7ffyJ3rc4LPyj1qU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-tkGIDDHuNkSWSEFZTKj1pw-1; Tue, 18 Aug 2026 17:14:01 -0400
X-MC-Unique: tkGIDDHuNkSWSEFZTKj1pw-1
X-Mimecast-MFC-AGG-ID: tkGIDDHuNkSWSEFZTKj1pw_1787087641
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eec6acbe21so6819086d6.3
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2026 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787087641; x=1787692441; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F0M1lc1PhRG1akNgGaC7ljiaI/Sk2ScYO5cf2onL4Tw=;
        b=ZfXKyppDdjSxU/R/AKqn21yaoi52+aVXvoEX3AAnqGZLzy/jq+NEHRGmB+KBzV0yWw
         upARMsBFLkEMckjexi7L5qGra5LeARNc23vzbZUiAZSgQu9/GCSJnDBo2nDEP55qLZDD
         QZRY8gEUqdRblJ4QimfoAFOcop9Qh1iTgCjDXzMcgYIsXOiMOg0yCdfyvef80FugDnfb
         SHgsgIZ8on4zmOjNXTgZ+6lhq5fjFvv1KOWfJxindhFUQYQm8SuIP0E9Yd+qEUgiv/Ds
         ykD725AoWvD3/Ivaibsh60IpQA3647wo3Pa9YwLUZKD2sh2bFg3oNqcx3L+j019pqD6J
         92oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087641; x=1787692441;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0M1lc1PhRG1akNgGaC7ljiaI/Sk2ScYO5cf2onL4Tw=;
        b=qjuRQdTfadC2tlfPGR6xWvXY2afc0UoUagW6frrmklcO81tx3Fn+cgE5cC1jbeK2CO
         bMqsPSsyjcNsaifK0jpafbSuihf61uoUm6YcfhusuyRwCmokMxKImgUXodFbMbUqP6ma
         i1VM20GftJrDa5pAByTH4NAV6tbiC+RFMZqn0S9mxxYBN94HzFyCo/TNosDiz4nd+Fqi
         2fg0ghrNB5ZOOq6baEy43mvHX72QB9aIL9UW98Txd/EnSoGgdYYDJ/W/2DvYmbS2/nnZ
         WHoZqer4t5TLzV7g4wlPYYiMqNb1CCcL+3klbEyr004d/dKqCby7fYMDeCpk1UYqb7un
         1hIg==
X-Forwarded-Encrypted: i=1; AHgh+RruEapj0NH7F6auIxL5pLS7S2fYtt4k7/HeyuJEFvzuVKpT1vuKN/wn7ZIr2doGQy1piJdm+Y3Du+mM@vger.kernel.org
X-Gm-Message-State: AOJu0YyeK4BplzBDDYocYCm104t8/3BA5MIH+XWgiDLqyp5ukQzzknTx
	R3r3osWkmwUSgnM7ZrLfwsnHU7Bk4TYhIxzO+9JflhCISaJN2/+qHxmtMDlgdpLRk/oR3InkPBM
	AJ3YToDWlyn3tWsf2AghdB0mn8mhWYHX0Lr3lZRpGV3r9Uzg+rd0iJcTqRAxGmBo=
X-Gm-Gg: AR+sD11sKr0zKyOKZqOSluIrlFLeg2u31IgBHi6yx5QqMgXJuEOv22qp9Nh0TqzSFP/
	PUIk9D/mvw+iM9kPG5qo4yNqIjwbbTbSqoMcwc4k8DWVTx/atbvgYA83tvryWMTrXxdu1Wurw+s
	rHXdvhTBK5eKK5mq1PmNydztFHfU45qFz+xoibjtShGBsex/bp66rjq67I9uVDN8URfDeaWqEq9
	uZ4rcLfijEU4FFvKzFB8HeqJzzbYB8oer4etAuiW7LGFviHkujs9WgdBTJYBkidRXAvAQUXFGhZ
	2r0o2U7c3tJyUiUQYtFToEon2gO06oiwo7fFaL2FCnO496ak9HfXa0J3ON0GuZLTKdi5qbp2zlW
	QWh0M5VGmJWF6VvROnEmXDzO3AxupRdksWMs=
X-Received: by 2002:a05:6214:260f:b0:908:a54a:5b29 with SMTP id 6a1803df08f44-90c5c402044mr14834256d6.24.1787087641159;
        Tue, 18 Aug 2026 14:14:01 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:908:a54a:5b29 with SMTP id 6a1803df08f44-90c5c402044mr14833806d6.24.1787087640706;
        Tue, 18 Aug 2026 14:14:00 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580fcc4sm41326186d6.4.2026.08.18.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:14:00 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:13:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
Message-ID: <aoTLFuE0seVTMuMy@redhat.com>
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
 <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Stephen / Geert,

On Tue, Aug 18, 2026 at 06:02:56PM +0200, Geert Uytterhoeven wrote:
> On Mon, 27 Jul 2026 at 09:44, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
> > Resolve parent clocks by their index into the device tree "clocks"
> > property rather than matching names as strings. Name-based matching is
> > fragile because a clock's "clock-output-names" value in its provider
> > node can differ from the name used to reference it in a consumer node,
> > and because names must be globally unique across all clock providers.
> >
> > On AM335x, this caused broken clock trees where some clocks failed to
> > enable because their parents could not be found.
> >
> > Replace of_clk_parent_fill() with a clk_parent_data array that sets
> > .index to the array position.
> >
> > Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> 
> Thanks for your patch, which is now commit 667f420c09f1417c ("clk: ti:
> mux: resolve parent clocks by DT index, not by name") in clk/clk-next.
> 
> This breaks booting BeagleBone Black for me: I don't get any output
> on the serial console, even with "earlycon keep_bootcon".  When the
> watchdog kicks in (or on kernel panic?), the system reboots.
> 
> Reverting this commit fixes the issue.
> After reverting, I added debug code to print all parents, and compared
> them to the DTB, but didn't see any discrepancies.
> 
> Your similar change to drivers/clk/ti/composite.c does not cause any
> issues for me.
> 
> Do you have a clue?

Stephen: I think the safest thing is to just drop / revert the two
patches in this series in the pull to Linus next week. I'd do it now,
however I'm still waiting for my kernel.org account to get created,
and don't have write access to the clk tree yet.

Mathieu: Feel free to post an updated version, and we can get it merged
earlier in the development cycle so it'll get more testing in next.
Hopefully Geert will have time to test an updated version.

Brian

