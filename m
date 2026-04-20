Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CFA3A0E97;
	Mon, 20 Apr 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714196; cv=pass; b=uW3+6dwG4uDhgU1YbcTlVaU4somUtd1pU7opyC8ufaFYEz1fLsJJGZeMAZk9/QnWoupkBAGmObVkmD+aBuAFcD6W1Hc2YDSxC54xa5shaxHXtNUdIMNctp+D2z2L505TjA2nyz7qKIzjNNzDRLWe/MdhujCMHmzhhnJ/4AjPBrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714196; c=relaxed/simple;
	bh=ijNV4rqhkgNGpRO307fnCTfYP7O2pPHUm7UUfifidGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZamWQJpqVASnGmMW8rv9/+iCfR7yraKIlRqAtbu2ymF+e56IFhVYZtme6EkWQ+gpRXMm+gN5uTJv8V+iXyqICOd8byqRiFOdd7A5iasNoefFIwkrU9i46bJIxh9Myiuxp4Aw6NO3t3ZEuIR2HMnycfrYWH+WJ++NKrUAiplORNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=v1kXaJjq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="v1kXaJjq"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fzwrb0xjsz49PwS;
	Mon, 20 Apr 2026 22:43:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776714191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yHOoBZEVrYXg4mmjrkM3nZCLvtILnaIFFMtWwQrCWM=;
	b=v1kXaJjqLtfXHpHue52YpJCMHREyQalnDtFJQX7iNJDSZBGuaLSfH+dOUetfmhyrIbfCgq
	9np2XwUeHRwDXjkjOTlicv+rIlZInejbl4C9UBXbPdsxwIvbpdplTBEJgRjwbKWosFoc5o
	sazTRh4hjE4FCVjjd4L5JzL4Preqf1LVl25eqe6tRSRJj52ssTvjQcZAg/guXI4YxAvzT4
	zNGlqy6Fv+r9HwW2B9uhhwlw7/2eXcWQoPxIzRMtaJo8ANJIDAasjjxHn1A+AVLVbYYyP4
	fQ8R2CAS+ykRs8HV70aloqFFOzmIy7mgJcIUvf506iPdinZ+RP4DiCOCfbxVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776714191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yHOoBZEVrYXg4mmjrkM3nZCLvtILnaIFFMtWwQrCWM=;
	b=GldxU+cvU3Z1t5ER7Luf0xR8v+C6fycxfzZzlkuaMUhYTWaWys01VM5wgzAdjIAnKkhpmP
	RJUN341yqLZ1MNZ43vzXl5SSbl0KIeNprGX6IUQZjqWyyj1MJahViZkuyHf2t5pqnuHj/R
	n9pv+fIYXfAF7QEd4fniBNC87R7R2z/fvVADl69sfiyDVZ/057e8BDRmSIoKhC1rZTkPKI
	KN2iNcr60Km2vJddqeQmNlnzPxfuA9ZVpEI0fbd6RvQ/0mEgRqBHh9RggbeaSEZ/fJCceY
	mXeMZT1enQGtSLAQZRS8TGkIgmkXh9CJuER3iDv1+HP7MSYDr92GQ6+L2aaZsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776714191;
	b=u7X7aMZPsoR5PPPhPqaAVtLDQjBI5Gz2qG8ZNXwHuUFtx5B0ZYl45Pk/ckeaXEZC8XQOMF
	dFIQnLMwH/LaYntSjPTOW2ZNdQtMU7fdlGH2RokNCUj5XQPiP6CaV5uCdo9oSk8pKtvn3k
	TPy7JVJVFajDlXr1hk8Ckp2wn7X4Z0pdgWdjqhW1wb6SikThyAN1al8pKXau6bO1tagJuZ
	ntsZwkkxaA2glDPhMZA4NlLVfJEJSRfOhRsFxse+mKa7VOrdaWqyCTG8YbnM6TvLoLCKCX
	l1Qqxtx5WbjN5QIrVo0tB8/LZUxcJOnHjStMOmKu92ECLsvvIc2qvK6kLxVirw==
Date: Mon, 20 Apr 2026 22:43:08 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: ads7846 - fix up the pendown GPIO setup on
 Nokia 770
Message-ID: <aeaBzPwdkwJzjFD8@darkstar.musicnaut.iki.fi>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-3-aaro.koskinen@iki.fi>
 <aeVs2VUqPL1v0Vka@google.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeVs2VUqPL1v0Vka@google.com>

Hi,

On Sun, Apr 19, 2026 at 05:06:53PM -0700, Dmitry Torokhov wrote:
> > -	d = gpiod_get(NULL, "ads7846_irq", GPIOD_IN);
> > -	if (IS_ERR(d))
> > -		pr_err("Unable to get ADS7846 IRQ GPIO descriptor\n");
> > -	else
> > -		nokia770_spi_board_info[1].irq = gpiod_to_irq(d);
> 
> No, I think what we need here is a simple gpiod_put(). The mapping is
> not going to change unless someone tries to unload gpiochip, but then
> the device is not going to work anyway.

OK, I will do that in v3. I tried unbind/re-bind the gpiochip before
loading the touchscreen module and yes, it seems to fail in consistent
manner without suprises (e.g. no crash, just probe failing).

A.
