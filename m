Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795733544;
	b=JdL7OEW4GJ018dMbjC9Z1x1Gd8iuwktUDpGMqRKZGZS+NAOfyvxgv/20dFfIzdkgZmK2
	 6CbHihXnQvCZkQKJ6PB7oHM3+UGghmqZR/uOBNxGZ3ZA5e7UWbUpE4Mo1Ln9DgrS0F2d1
	 ybdmDBeYXii4sXjCT0CafNApV/Bpr87R23MtXMQzcYSdYO3+PeSNbtQwJAeDZfaNOMUZ8
	 Pu5ZDWtFmgxiU5OXcnJR9uTxq2Ig/tnHplZsp6o+mBffZA19fqB8iMuUnS4/Lp6WtK3pu
	 DlENA0+HtvDMyDLONjwhShe9ob8OPQB18lXeqlx8LW501PKYR+xONhIDb5rfH9W2n7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795733544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Lrrh4IpVo00PMu0ymIa0cKalNMWNhJhQo6ethoRDu5E=;
	b=SuRAmVX2+qGkMDe+Z6qevPMTUiL7uqBSTt+CLREvh0PYyKrGOcO0X/7hpwI+ZDmguJNS
	 fs9t54gQ+AUcHDm5EZHYJwcf1MbBMFmtaj51ezV4ofRRq/TXq1kbXFh8mJCIEfjhP3sAC
	 Ag76UsLuDl5eGVsx0tpxWlkTnAiFS+nd2UHZjus9lXSBWl2yGUM7oXtxr/2fW8+eNdnFA
	 qZizZeDQuAt8t+vi98YDxlT8jpEBtHa3zB1i7Id+jW0z68WN9L2V1OYUcbjuosMW56DC3
	 Bx/TasOcPMttlPd0l0d7rIXRa+QKPwk7qWnQJPnzthP70N1XqXC+C00FdROzbLDy2Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP9sJ2C5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD34606A31C;
	Thu, 26 Nov 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP9sJ2C5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C991F000C1;
	Thu, 26 Nov 2026 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795733543;
	bh=Lrrh4IpVo00PMu0ymIa0cKalNMWNhJhQo6ethoRDu5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BP9sJ2C5phhmgTr+VxneDjYy3fWVQxQSONNKyfyIcRunONtEOUp9mnjiF6/FA8FZK
	 f08jc0ycYyhXsorJH9ClIo89+Cj8dnTKWCso1TYQ3uPG5cDA4oU+fSUWZD6XJBKZ72
	 MGdkGhmByo+X+t5sZ3czXKjyCXM4hXI3/uh3fHJNaRX+JdL9NyifI0pw7ePIt0E1dH
	 cW8f9Zhm2g+oWnsSODXhyCHutFA15YmfLEpQvkscce9w16NlLdv4nu2CVaPCApojdh
	 GZoHvkiX+A4VMqPhnv819NLkU6xqipC11/SHIaq3AMDrCqFs+MpktHOgt4pbVwiOud
	 vNnTxcuUHiS/w==
Date: Thu, 26 Nov 2026 23:52:19 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Josua Mayer <josua@solid-run.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: omap: do not deselect the mux-state twice in
 remove()
Message-ID: <awi4D5ObQrLZ-sHc@zenone.zhora.eu>
References: <20261124092202.3766910-1-congnt264@gmail.com>
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
In-Reply-To: <20261124092202.3766910-1-congnt264@gmail.com>

Hi Cong,

On Tue, Nov 24, 2026 at 04:22:02PM +0700, Cong Nguyen wrote:
> omap_i2c_probe() gets the mux-state with
> devm_mux_state_get_optional_selected(). The helper selects the mux and
> deselects it again when the device is released.
> 
> omap_i2c_remove() also calls mux_state_deselect(), so the mux is
> deselected twice for one select. Drop the call from remove().
> 
> This issue was found by auditing the driver with an LLM coding assistant.
> 
> Fixes: 43c00f2bcff7 ("i2c: omap: switch to new generic helper for getting selected mux-state")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

pushed to i2c/i2c-fixes.

Thanks,
Andi
