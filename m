Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524492;
	b=tjaEpNJGoPhdcEuu5/cTiYXWOM6Wr7Hq+LMFJjVSvDK7pkkkA8feBbB9Mk05ePzGhJUO
	 JeW9niRLsFuAyjgmSyWNwemVWgJkjYqCGQPE/rJFT2DXUVzfp4JXozMJt/kwsMU5sqUKn
	 MIoaxqc9KGtIjqK85So3ZM0jcOhTBq3RNe6PBDLtHvfqx5STCIcxUCGHzHip8PY2IhxjJ
	 gcwDrwjXeateObaUTIwYVF08xCEHV0eiRO6b1nUUJ/4e0Utc6ZJBlYQzm+qeyQjWM0ydU
	 9UCfrxy5RVkGavesEaDAtxGZSyfP+9r3NSzvyCZnvETxY3co+Qm1b2UbgKBbFTnqUUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gf9lj1/pxwS/cN9al5eMO+akIVJlLABNg8dS2X0TvPA=;
	b=oCVbsNjljKQzfLXJTz5KFbpySyXDXlT3RoKObgu1D35cfhkETzwtiMs6hgvY38h7lG+8
	 oktse6WQBgVP0f1HExs3un/Rlp6oYuKxNh2Hm71/mtWJ8RdRFwEf8fraCqbICcEV8Eb51
	 FymrE6lcYHj53Y7lRnxOeQsFKI0jBDcIubsN0XdBsoPLoj/F1m3UXjmTTkpNXYLblWtPB
	 WC6iOaWqxDaRQKOtKRfBDfoC0A45mKAyFVPn/q3i0jsEqJ6psOkHwC8UeL+vu7CPpPkA9
	 l+rtXaKTXBjKzpg3+THB+iBSPCiXAwtHE01h0J5bNkGzXnD756kC1FDjHtMi6r2XC7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIx6Md1m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7C0C2606A31E;
	Tue, 24 Nov 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIx6Md1m
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E99011F000C4;
	Tue, 24 Nov 2026 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524491;
	bh=Gf9lj1/pxwS/cN9al5eMO+akIVJlLABNg8dS2X0TvPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIx6Md1mKloTAqKYcmRVy7SCKJ2sgMEIDtCntjGBZHFkf4l1593PvfkvMILiaz9Gt
	 s1HjaW3piKf0bmr8E7ZsIOD6XeGoDXghSUu2/6qjZP84WapuofuvcY/m/QjehCKjQX
	 bOOrTCH7IHCM/Tj08FG2qtGlSSXU0GQMrDeK5HjhJ48wVF4Www9+9iP6UBHtBi0JWs
	 +ObHJkigE3pYa+VlQ9DhG3KIKIbe7VGOBWso2CUZn3vK9Ow51PGR+ZdWJ1dZrgxNR0
	 H1V3sCnpNB5pYdjd8dKtaU0Ey1lTJoe2znBiqwIrTxOzqmZtGjnPap8c8xQ03Hez/n
	 AlRQFcx6T4ocA==
Date: Tue, 24 Nov 2026 13:48:08 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
	Jiawen Liu <1298662399@qq.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: omap: do not unprepare the debounce clock twice on
 probe failure
Message-ID: <as66clxa7bxsxtq32xsuoq25bnq4ba5s2wkgo5brrgvusoujh4@dr3l4ejpojol>
References: <20261124085231.3696739-1-congnt264@gmail.com>
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
In-Reply-To: <20261124085231.3696739-1-congnt264@gmail.com>

On Tue, Nov 24, 2026 at 03:52:31PM +0700, Cong Nguyen wrote:
> The debounce clock is now obtained with devm_clk_get_prepared(), so
> devres unprepares it when probe fails or the device is unbound. The error
> path added for a failing pm_runtime_resume_and_get() still calls
> clk_unprepare() on the same clock by hand.
> 
> When pm_runtime_resume_and_get() fails and a debounce clock is present,
> the clock is unprepared twice. The second clk_unprepare() warns that the
> clock is already unprepared.
> 
> Drop the manual clk_unprepare().
> 
> This issue was found by auditing the driver with an LLM coding assistant.
>

I queued it but don't add things like this in the commit message. I
don't care who found the issue and the consensus is the wider kernel
community should not care either.

Bart
