Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37803CF677;
	Mon, 20 Apr 2026 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716857; cv=pass; b=lsAGVj/cIKNsjJEnJYrPRGPZM1TaVbPQ2hrwfZUeCT8CzDHFSl51N4oTAZI/GN0om8K+nfJqCEGyhh/Hl2IFEb0wUKhkh6fy4uQ13p3q/4JhxJKpDinCn+uIhFXxs3gMJ1Fh7Yq7Ahi3ZeQvW2UTcgmmp3vOpAd8NHrK36ujbg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716857; c=relaxed/simple;
	bh=cj3oEJkumEVGjJPTfTJgi0TjxRJ6ug+ReRvXRBKNddM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itl90VAhYisBcvyfPGYhCHqQwd6EFX7EcmyvzQIkiArBj8fu+eVwlhAZ5gWIz+tY950cGI0EuzaDOX+/Te7/LDqXBe6eNbFXZymjjLX6J6toaYD+YB1uyLr4QhTZaIx0qADaSs0G9YUfFC7+znSsPWVK4O0rKDgYmikj/zliqak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iMJAkfjN; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iMJAkfjN"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzxqh24dhz49PsK;
	Mon, 20 Apr 2026 23:27:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776716849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqGedFnT3teWh1lHSoLCTJEgghEUYXuwf2j/pOcO/3c=;
	b=iMJAkfjNWMJ/t4l0tl7Skz/7+NxghitzKZ73RRZGdOdocvREghbnFpwaz/dOmd4DFMLRGP
	GekgwjWoxTR+cIuD62MoZL96Fykm4DO5UUCjPwo2hO6TGpz/XN2fyRXjl1qf6iaCcPXJ7r
	5yu/oJf2kXJVvVmpNzNv19eNXT7z0gGDTd2O6Uijc6nF65z+Nn7t1H9ErwAtiX/3srx7Rc
	JHgJV2UX645Q2lcKPvIFUsf0OO9XwAA9gqHBWbe8BwKFx78VfBUUYbnQRoJcV2YFqudRYm
	2bN7kJaeUsG50Txo8SYj8WB/zh63tg7O5DsEVnZgML/B+KdJ9i0JWkTLBJbcOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776716849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqGedFnT3teWh1lHSoLCTJEgghEUYXuwf2j/pOcO/3c=;
	b=ikKwXmpmObdgy/1/HFNmvxtjM8TbTeDriMJxEe01qtWMvEgLZgXKxbF0Zxcitcc+Aiylla
	LQY9DZCdCB2u9TkglHyohmaQu0r7UZXJrGDXzEwBNGEB6wMMkykVPIcBG5zAgxK9eYysSz
	A0BGTA0Z+uuIbrw5Hwagno5u/AWc7ebqCrEBARxb0NJx+sc2nQpwx9pAu8mvXUepUkjLQ6
	uFJgOvdqYRhaGUeMjCCDrZLIP1Qmj3meQ8fG+r7xeCGudI29e7jEAJMF1iol454PmJe4tB
	wnn08QCfAdX8asgB+W+xDpATpwhlZyiqV1w+pLWgmhR86wDJaFuZvzXluYPB6Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776716849;
	b=ZEMTNW0vb+/jCFIKwzM0bjWOt3tzAgJ7lN5hMe4l/Uhn4zKWRV/miVLv8RrEjKp+4fuuRD
	iVPQVawli0L16/OHiIzRZS7JVbo82k6kTWZ+0OqQO0gMW94ktTIfeiyRYHGnS3GBXogvE3
	wmLYpiDXvaGNEBhlrw1laoRgqE0FFWYS8I/S1DGvhk33kEnyaWbJ6K+X4cIdfyEgRBYxIz
	yhsgiPU+Tqy5VjhswqIHf2UvcgaxegnOmvkQr2zILFbfsKunJGBzOamM48GyeygANPhVjz
	zuRw4qA+6G2H63dDPN+bNjIy6+bYnVEKWJLHUCxSu3Sr/Yk6m/J0vQ2lJnDVxw==
Date: Mon, 20 Apr 2026 23:27:25 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: Move Peter De Schrijver to CREDITS
Message-ID: <aeaMLfrDCoyTrWet@darkstar.musicnaut.iki.fi>
References: <20260417131549.3154534-1-thierry.reding@kernel.org>
 <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWeXS3ytgozp-mSrW4jcMRCW7_tbDTbMoEdXdbVj0dqJA@mail.gmail.com>

Hi,

On Mon, Apr 20, 2026 at 08:50:06AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
> 
> On Fri, 17 Apr 2026 at 15:15, Thierry Reding <thierry.reding@kernel.org> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Peter sadly passed away a while back. Paul did a much better job at
> > finding the right words to mourn this loss than I ever could, so I will
> > leave this link here:
> >
> >   https://lore.kernel.org/lkml/alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com/T/#u
> >
> > Co-developed-by: Paul Walmsley <pjw@kernel.org>
> > Co-developed-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Co-developed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>    "every Co-developed-by: must be immediately
>     followed by a Signed-off-by: of the associated co-author."
> 
> https://elixir.bootlin.com/linux/v7.0/source/Documentation/process/submitting-patches.rst#L506
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

You can also change my Reviewed-by: to

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

if needed.

A.

> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - add more missing entries
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
