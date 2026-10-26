Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055833;
	b=3ThcLs7IpHKG1dbnYLS9t5NDGmAavNTdzFClOpmlqHQRzujKg0lPBzOKulWdzgOBhUDB
	 8+SmGmKWgO/Go/z42YvGLv9pC+dAg9kmS7AHVuW730A4517k5QptAJUvXY3Mm/1uXMiT3
	 cDPaPXjBb/8nwSMdgb4u4oitntbUD4ODc2LcvvAYSNsTx0B+7xgpOW131/ukiddcdozQv
	 T5sBu5jbBI6vx1WdtlwP43PGxJjlIQTO5hwX8aO/59h2ewREIAnTxitMAL7SZl/CJvE32
	 bhqMrvFdBuBm7C1AvRFku+PijKS/2AC3lSUGOjgyJGq+PXyozbfhlgEgxyg0aX4NUhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GcQl36lfqpWZya3eiDaL/UWKqhcCRT7NdMDhezXL31w=;
	b=OK/HOxzK1WeQHPgYOf7NMChAjH8SixnWychKGd5QiC1V93U+J5SMudkzWEzQMLt33qWF
	 srrSTc/Dhewfa+MR9JG8ywRoxpohXjC1xC9YeiqNCYDnY91eM/VqFW4VIMm/wmBLeOhRX
	 +gqxidJseiXKJvm2NLbzO6skx4Ryd4jnUDVkUjkan15UIP1ZNfQlHGBU8pMKZE76y5Hvd
	 0dut6sG1o9ADHpDLihx2Ga7wtKm56HdinI/cT9+t9Jp9neEtajaQ4rgRszkFR2FPrX1BQ
	 +4va6Gy4ZH1itOlySjSUqJ8KatS+w+tCOD4ZGSQRhLSuUgtygfadwxxVd8zlhPgqFDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ug/nHAs6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AE606A31B;
	Mon, 26 Oct 2026 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ug/nHAs6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A2D1F01825;
	Mon, 26 Oct 2026 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055833;
	bh=GcQl36lfqpWZya3eiDaL/UWKqhcCRT7NdMDhezXL31w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ug/nHAs6rQujqbmWysueue5nwzacXgzWoqvGQ0jhNjKSKuVliBOuBYd/vWoWrGcio
	 MiLhG3XpPEMeLb+GU1/o8aU+QoRvMa7J/So0xtzLwOcP1tta/hp4Nx8hqO3bxAn2xX
	 ZKgbH5w1WwEu+rH6eOjAWtTxEm9GjlIK6FsSxQCsL424WGi01zRcjUfOXhJ9iM9NlM
	 jLsNZiS9BSyUSuF9ZIj7mVfmcof6F9zaZ/vKpV8MC2+rlMdI0JFROCEVmAZYmdDw32
	 nwQ3AKsWry8zEdBj36uCLGBMRSPxHu0h0GFmqFV/rj4yhGOS+XuniS3jqiaNV+u81+
	 VyRO/eaW9kA3A==
Date: Tue, 27 Oct 2026 00:03:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: aaro.koskinen@iki.fi, khilman@baylibre.com, rogerq@kernel.org, 
	tony@atomide.com, vigneshr@ti.com, jmkrzyszt@gmail.com, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: omap: fix hw version parsing
Message-ID: <at_cHUpN3KJ_uux8@zenone.zhora.eu>
References: <20261021155140.243337-1-andreas@kemnade.info>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155140.243337-1-andreas@kemnade.info>

Hi Andreas,

On Wed, Oct 21, 2026 at 05:51:40PM +0200, Andreas Kemnade wrote:
> Fix a simple typo to avoid showing confusing chip version.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

pushed to i2c/i2c.

Thanks,
Andi
