Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AA72631
	for <linux-omap@vger.kernel.org>; Mon, 20 Apr 2026 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644042; cv=none; b=UGKYRrlPD1ixPamLOaOJvoes+TUwoYDPHDu6iK+CGZqVEmrCcW1OZVv00ODghL07ndnAeO8W/eDUTrO/meRUAUNa9XozyAXGJ7ncAT/zj71qW/Sr50709fH5FMVqFVk3xVRxgf641IKDtJqAfzDErB/JQshj2KE9bPBs5T9Gx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644042; c=relaxed/simple;
	bh=8e6o2e3S2kEpCh7AnUm8Lw8k4A5RfrAJ6mTx35sXCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH7qMLfpm/CBqGXxjj+tY7hZY7oIYJl5xe4DCEfhtaFrkTo/QJ/9IMB/PzWZhLnqRsgcFrIlQQIl4+dL//XzeWzPE6fg0bDspfYJIXBTqYTLRyWi1P0CnoIx+JArP3eSuz1SEi7Fc6qsyX0JzO+XXEtx0pbzHOi+1VkdPN2cyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6zSy1tM; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6zSy1tM"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so6156308eec.0
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2026 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776644040; x=1777248840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQb96jxVBSn1C0UL8YusHfEi4afe/T/8UPw4t0TEFHI=;
        b=o6zSy1tM1wbRw+6bcSBnRybTMGq7xiM2L1J2hlwOWlnURCk/LW3J8037WeKj3aw+vq
         1EnmlP8vgoynuessjLkCNFsve7J69YaGZhgmW2HrgRW6wSUFK/6hIQrqruumnZLPxp1x
         QzvNMm2KbqO5Pe7XjKwn+9gtXF7fP4wDbjuXFPsy4nI2uoX2K2lACziYCRNMb5vKUrBW
         afvMMDrbPcyvwpOxcUF8OoOGaPXgIKpMFV9bAEF3HhPPLqvlqRjXB4qwJtNiEtlJm5EE
         95uxaFvw0rFjI+I/1A8gQaKruleXqQv6njGs8vxcFRHsjK5wszENXQ6NTA3RbQwJwH3c
         9flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776644040; x=1777248840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQb96jxVBSn1C0UL8YusHfEi4afe/T/8UPw4t0TEFHI=;
        b=j9GprA3/Dj7mKCBwJfvPJBHT2OVxcDZEuIkdCcSr1hY5h7eqTL07a2Va5xRjEQZFDC
         bGm2wc47Ue/1GJsZ+FglTiiXWPN2orJop5LO6/WDFlDccuEIFnaJyqHi1BncnerNDzIT
         SUIl8wx/NDuhZyaVIkpAOPO+7FL8xdCnBLMmUGoD03MdDfqWFaoOxBYuOo6uZCKIH54F
         R4vtXkLFhl8uNtn8ocnGF0LZOO4yKjjIpR/pg3y7qkhxoaICQ569FjXbRL6oYKYw0xwe
         4qFx2ozeDauJh+d3u3fwALT1zg2zDs+VeYpft8AwfL7bIEq5nidzQIJ/xgg6zSSrJfeH
         qHjg==
X-Forwarded-Encrypted: i=1; AFNElJ9xnRdW7YefNUcEY+sHiWtS31cAoKdZwag/KZZbnJnT83QDBPKvcV+8UxYU9XDiShSjq1LUeaq3i9YP@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDzCugVN2ZblXwfLyMviHyLnamaxszxUEyxTEXiTlJ0JGfz/M
	PcP2gt1zL/irfWk1RVCdd/GROzp7vaoK1ZTz9ZKhAEf5y66u4pZ2Axop
X-Gm-Gg: AeBDietvgjs8grWwEuSoklNcIimlX4H9RSBwvLq7wAL2fY1U1reIFETuK332xwdiKO3
	p7pPoTacSWjdm655RVSJardbAwn+Rd62n4+vCt9VdMDjZgatwqD+lst7EmiRJ8Y46SwnQYmBySD
	ocF63w6OtAKzzAkzr34Jiz3y/Ktl+aZD9tcxeiDEe4KC1uAHgWFcU5Ncwr4Yqwh19GwSevSTbkJ
	hN2jMUD1Hq1jvMc8ysSSLhoP7NTU0I8daa+YTPnl5ZprodDAtl2vyHlbeek9SNb8kEAOQaY2Kqt
	NWpz0DkzsqQd7n0hvhhIrJcd8df5iJfxSf1+zr9kBGM2MZ979TqBOTGMAVg+aCcMT4KNIOy6RO7
	KKXte91Ep4qRijOJ0Uez6PaQYv+w+8IYz0+62akCtxSKOpraINUFk9zuIObEDDGVvcB3fOR1XoP
	j9gFDjSmbAGhpQkLT/pGZlfDU9v/DnmRsRBi3a7BAfRs8yiHHmFT4YFf5xed5SsFF7QIGSyBZ57
	Ps=
X-Received: by 2002:a05:7301:4586:b0:2c8:7172:3b7b with SMTP id 5a478bee46e88-2e478646190mr6601303eec.18.1776644039839;
        Sun, 19 Apr 2026 17:13:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1a4e:4965:5dff:cdee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm11587954eec.14.2026.04.19.17.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 17:13:59 -0700 (PDT)
Date: Sun, 19 Apr 2026 17:13:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: ads7846 - restore half-duplex support
Message-ID: <aeVu2-zlzl-fn1dN@google.com>
References: <20260419161848.825831-1-aaro.koskinen@iki.fi>
 <20260419161848.825831-2-aaro.koskinen@iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419161848.825831-2-aaro.koskinen@iki.fi>

Hi Aaro,

On Sun, Apr 19, 2026 at 07:18:47PM +0300, Aaro Koskinen wrote:
 
> +static void ads7846_halfd_read_state(struct ads7846 *ts)
> +{
> +	struct ads7846_packet *packet = ts->packet;
> +	int msg_idx = 0;
> +
> +	packet->ignore = false;
> +
> +	while (msg_idx < ts->msg_count) {
> +		int error;
> +
> +		ads7846_wait_for_hsync(ts);
> +
> +		error = spi_sync(ts->spi, &ts->msg[msg_idx]);
> +		if (error) {
> +			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n",
> +					    error);
> +			packet->ignore = true;
> +			return;

Sashiko recommends trying to power down ADC on errors, what do you
think?


Thanks.

-- 
Dmitry
