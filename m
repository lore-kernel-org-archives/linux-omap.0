Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814840;
	b=Lu5h1TvNL/rxHd/x1VvAKvxvZQ5+NZVt98WP+CwiAxMjAHlEJs4LOVfu9ttKztY6qZGE
	 BIMpatgV8lVj9gpMdWKATF51ngWRXzjaJxukmAcU14Ni6zpmK7odqgQ59YMx2/kd5MJcR
	 Xnqz25jGVl0uUgTtolbmPa8XpRijpUdf/8NJUeUnSe6kNRy9XVc1Gy83pGyuc1KRm686e
	 T6zWLbPx0W1vQYDsvlMLlrmAtWCX5GiRDZ1lAFndyTmuxa5lucos2/7sxZPJZoh9IkPJ0
	 qTZr0KFym9Q2L3taY3GfhK62oOYOQoV0E/sgc1JP/4Fl2DqgdvqXAQ2srFSOwvglTGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814840;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=QH1iAaOBjpLuI0K+Mlpa1z2hsnJFLSynt0iZqyaJU2k=;
	b=jSfAY3utEu/NfgUeR4wxPZ4SV/RIwEv/9rzNsdc7+3eCwppNRGiDf71qNXHCm40tA+EZ
	 3JZ0JzsuVxcQSxUYTwqZ8MD1b1H6disWI0dDJHrhyMoq49waw8+ghd32YRDmc0+hCAlFK
	 oen/jKS9RGZj+oMXyA+tydrc4c6ZLAOC6NK7JnRPBJk1HI43Z2+xn9iCXeqjWpj73qojy
	 CWIY/r/y6nlZ/Si1p2iSc8CWXydGtOkCC6AR2tDXy7ZjkXYj2XNal7KUPFE4Ygdct4BGa
	 N8l5ZZw0I+etUonbHetun+8b11y6nJ11c3eXw2MMRiLH20X47nz3KuYEgEUocjsj5AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e34dXqtm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02660756C6;
	Wed,  4 Nov 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e34dXqtm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127A31F00919;
	Wed,  4 Nov 2026 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814839;
	bh=QH1iAaOBjpLuI0K+Mlpa1z2hsnJFLSynt0iZqyaJU2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e34dXqtmHA/K4nz/O4eHEAVirPUs/I2BngTKyTTTjXsEidXlhuG7ZCR5Ywobx65yT
	 f+gkiu9Kb0xcP0UsTz0ccLSpBG3mhYbRA7FfX2qbowCLNtmYxlmdiLQDEnuTY9L2Y/
	 OwTZzE0+7M5lKI4CWEmJsgDNFqACzC+/EqU0T/iBcJgLa72TADpv+VQlCFnLFeS5yf
	 cWakWWpxIUtaRBKiCOT3kfEhE0yzlkGHSat5qLgEfqvz7I9SgzT1ca0ytQo+Nb7IyO
	 7gMBXKngCvny7vYEVFzQtIEk3egzmQmcDHokA/3UcFzE8z1Sczz95wRzrIxPmgCrzj
	 moAjgSaQKVMQg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Dmitry Osipenko <digetx@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261027152423.194794-1-clamor95@gmail.com>
References: <20261027152423.194794-1-clamor95@gmail.com>
Subject: Re: [PATCH v2 0/2] mfd: tps65910: Use modern API for poweroff and
 restart
Message-Id: <179381483784.1911266.2843818793572166119.b4-ty@b4>
Date: Wed, 04 Nov 2026 17:53:57 +0000
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Tue, 27 Oct 2026 17:24:20 +0200, Svyatoslav Ryhel wrote:
> Switch to modern way of registering poweroff call and add restart call.

Applied, thanks!

[1/2] mfd: tps65910: Use devm_register_power_off_handler()
      commit: a8650da947d4c96a808a61dbf41ef5301b6220b2
[2/2] mfd: tps65910: Add restart handler
      commit: 9a6eabd8d51c0af489ffa6333624b6fbe7d07e88

--
Lee Jones [李琼斯]

