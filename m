Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445967;
	b=ioGpKc9crArFF7WW5bCuChWOxo+2OCNCUbzx9Kj4lfMQ9JVLn3E2j3VECbC5EIRbgw0F
	 5fRNEhvQlTqCoAnHGcA0ZyPoZojQaVuX7NbJDc2wpd/m2cgr8SbkoEHdPvRCeHjUxgkRU
	 V0alhfTEnnpNcMVXR+04dQM5uAhFwK6UEErlUtJWnKsqmBsht+GHhfXDeCXpHZMC6ugXx
	 ixVPLSPSJlbL0rstviTAaMCiLphouJugKH5y9NUEymW6kq6ZioKkHk2WswQkFi1VPd7zC
	 4bIUxo9yNPcXfxuRr1tMZrfDchOxlv7MZvE9cYZYH/hiRee4mtyu222TqSvX1xGLkyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445967;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UxlV4a3M30q0vAHXDvaMQA3mY8eqASGH3vqh2XF8R/Q=;
	b=qhUcWP9vDT35Rwah/DtsocSqw9itHgb3mGAVg7mOWEYhkrH+/pM5X/Ha6d7TfNt+F0Hh
	 jxXyKPKH9//AMp9wnGrm0ESohYw6PyMUPuZgqdQyz4mEqe3V+7pPJx1UL3eDhpwYmDFVz
	 aWMiXRi/Q771T8KlZZyh/cUnPKamc3rc8rYjtKnQzHL8HjESHPL30Zl2mHrd72gqlDsr1
	 Nbt2E8qAXv54sp/DMlxKctfLmY9tGu93O79oGviw1UsjXYVPD6VM+ylzvMhebfICSecM1
	 lRdXVwUZ8BG4SSRMbQZ+8GQ5nzL3Fr+OpwC5YTuFJDykfPOry3QAfIOjp/05+478l2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9pvUdri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC4606A331;
	Thu, 12 Nov 2026 01:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9pvUdri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0031F00A0E;
	Thu, 12 Nov 2026 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445967;
	bh=UxlV4a3M30q0vAHXDvaMQA3mY8eqASGH3vqh2XF8R/Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S9pvUdriOhbYLyHxIBTeNni47sNic5kBZR4fxbotM5tMvlI4HVnXb/fqvtQKemASX
	 ZTlbH/kvl/GOsCAlMA98p8SBFI20Q/RLP5acO7GABwy2+gYC2r6bp9wh4xkR0oIcud
	 8zSLInxCUvp+A8LNNqqthFoKY4O9mfPyZ0VEcNJ+y3u//7dRed5U7k7bnScC/QvcjY
	 /7byhuR8JsNaaZ4OVpyRwbFu89PMuGvFDqnih87l6B1HObBspbkCx3IwGwCeG95RPh
	 j6z4itGBS7+OYNHlLkd3Qc/V7v87ktD+L4ePuZsPMIYEBG9QmqunbiXR5JYOpyLayB
	 k61rd2JoSeH1A==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] clk: ti: fapll: remove ti_dt_clk_name helper
From: Brian Masney <masneyb@kernel.org>
To: Ettore Chimenti <ettore.chimenti@linaro.org>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Tony Lindgren <tony@atomide.com>, 
 Michael Turquette <mturquette@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>, 
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <20261028-patch-ektor5-dm8168-clk-v2-1-dc6bf0fabae4@linaro.org>
References: <20261028-patch-ektor5-dm8168-clk-v2-0-dc6bf0fabae4@linaro.org>
 <20261028-patch-ektor5-dm8168-clk-v2-1-dc6bf0fabae4@linaro.org>
Date: Wed, 11 Nov 2026 20:12:39 -0500
Message-Id: <179444595968.1126566.13848954974182834412.b4-review@b4>
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=DEnXSMsETh+lUsRQKmnyTu+nLmcTo8kUNcm4UVk8TNU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK+CnVaPPH9OLHNMurRZVfezRzn1xZrfGHhLJQV09m50
 NxVUbi8o5SFQYyLQVZMkWVJrlFBROoq23t3NFlg5rAygQxh4OIUgIlYJjEyrPhlfeNA5jsOWx75
 /5d/Zn9mWct42ub142iVA4n2kx37Whj+e93sUzyrcqnfr0qrcq72sXe+K6+++vOpQytrX8JNO/M
 EXgA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

> The fapll driver uses multiple `clock-output-names`, so we cannot use the
> DT helper in this driver because that would assign the first clock
> output name as the parent name. This change do not affect other SoCs as
> the only consumer is DM816x.
> 
> Fixes: 9e56a7d4263c ("clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()")
> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

I see what you are doing here but can you give a more detailed commit
message / argument here in favor of the change to make it easier on
others that will evaluate this about whether or not it should be
backported to a different kernel.

Brian

-- 
Brian Masney <masneyb@kernel.org>
