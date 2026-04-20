Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B42E3B15;
	Mon, 20 Apr 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713535; cv=pass; b=oqzBvYzbkPS0f+f69FvfCic/FJGysShlfWgEbtMSn5VhObkZRAGo9DcClhWaI7JJyllIybEmNn65aufo6kq7wRlyEfnQ8IFTxIb0OlC94OMzpX1la15w+dmtxTJ4doOlvnJyVTiNqV6ntWJElBJanJisZDPTCcLEgc9fZ17O3pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713535; c=relaxed/simple;
	bh=MnjgDgm43KQZ2fMMPFZVWkYkAZQlDlm19bghmyolsKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcz7JorPDMxyU4AIT2G3tQ0aJLjT32geRJAI+fZ0huiMcXvtr3XqiPsuQYctI5iS+QJOSnLTPdp2mmHElqb1TidmzTWe0DS1P5lnuKq9eVz+6zryB83oxOrowVmnX61wExru7clqy8ZTbj+p8PyCp2ZISxpe3CZOqhpfNJprm6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ukG37M+X; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ukG37M+X"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzwbp6gfLz49PtL;
	Mon, 20 Apr 2026 22:32:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776713527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qxViCgW6EC8n2IF2MWZbBd3t3RwgF7Ubx8QXH+7lRc=;
	b=ukG37M+XatFsnxm9gU5ZNXIygD0o16uXUHcSw677csPPsQbW20k1PzrsWYosrp17ktYOXX
	QbWsqGecvBY82M5QVGZuJXuLj5eceOBWRESbxR9n7gvSK000cWB5h+7ywH5J3G1B8Payio
	HR0x66QzjYvKpPlVn7T74VRqoxigMyidQtK1R+JDwy/XX1uBAwAdQNaIHeu8sta8gJWpc4
	LO5Pk9LsfLYqEC3GXYdectkvyYL17TeLG+0P7+CPSL+E2UQUT91kedIs2XUixceEygw02X
	BcdhJQZYIP+SeMP7jFjDbg+Poa7TMeEb86d8yYlyaL3m6qqkx9e3x93JB0DjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776713527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qxViCgW6EC8n2IF2MWZbBd3t3RwgF7Ubx8QXH+7lRc=;
	b=azDM6yqK+EV2EmHdu1jfjA5cOhVrSzBrR/HgqvQw0XTLLFdmeLXMolAYQyRX4jeGZFzO6e
	Tcpud8QZhLAZYTWB9b/LdiYrC0r8Py5breR8kd3f7VQR2VwHd9pWCXQoJ7pQNCpmVMJBCz
	ucm3Mop9Xz1LqKj6DpRw/6lLh354RKqRylaorP3BqKAMnvLAXa+v2HiLM9OjP67dJTL23u
	J6SqYtzRC5VR1fjl0/n1JULtMlVyHq20SiJi/BQshI3VBUOy9VDqCDL4WvVCYCYQFOMImL
	KMahVddGP51yyVicnI9uK6uZZNLh2znft4rVeGrmbuO208QNgt9hWPA9zddCEQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776713527;
	b=JAv0zZ7FBakVrPut9I8lBCR/KRYwoX4vJr/jHUknOIAxbDUq8X2fstMoq79ICvNuOFhIYC
	APCOKpkK00hB3ipZzzkDalbIMhDzuwY4pcfBRd8bWuSvYqbAKRFO+fPRhEZD+5hlM/JbQD
	HPu0mGFvWsjk8w35ofD3aHBshqSzVPzhpvamVRVmTQrujCKL7iDRR8GewTXpOsecoxgUPd
	aDeDfSlHJf1nRO3t5KupwUsgTkI7Y6zfXzbXD8+Y2WxFX3GdUl4GAPwo6MuhlyOi/R9bPO
	JsUjIoLNkLj2GpwwfCblU4U9FIlaPtDwIAJ81FGK+xl2Fkz3bVla2sHE6OtJ0g==
Date: Mon, 20 Apr 2026 22:32:03 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Message-ID: <aeZ_M7jjisCExva8@darkstar.musicnaut.iki.fi>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-2-aaro.koskinen@iki.fi>
 <aeVu2-zlzl-fn1dN@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeVu2-zlzl-fn1dN@google.com>

Hi,

On Sun, Apr 19, 2026 at 05:13:56PM -0700, Dmitry Torokhov wrote:
> > +static void ads7846_halfd_read_state(struct ads7846 *ts)
> > +{
> > +	struct ads7846_packet *packet = ts->packet;
> > +	int msg_idx = 0;
> > +
> > +	packet->ignore = false;
> > +
> > +	while (msg_idx < ts->msg_count) {
> > +		int error;
> > +
> > +		ads7846_wait_for_hsync(ts);
> > +
> > +		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
> > +		if (error) {
> > +			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
> > +					    error);
> > +			packet->ignore = true;
> > +			return;
> 
> Sashiko recommends trying to power down ADC on errors, what do you
> think?

If we want to re-work error handling, then I guess it should be done the
same way for both full and half-duplex modes, and belongs to a separate
change set. This code has been in use quite a while, maybe 20 years,
and I haven't seen those errors in real use anyway, and AFAIK there
hasn't been any bug/problem reports by others either.

Maybe it wasn't so clearly stated in the commit message, but the patch
just restores the old code verbatim that was working fine for half-duplex
mode.

(Thanks for introducing Sashiko, I wasn't aware.)

A.
