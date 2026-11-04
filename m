Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805408;
	b=gaOylCn4LCdJySuKmlfBASJ6cSPjRMTf9BYd/STVsmB+2V2jyhu0lsXWbM4VoMVlqPRQ
	 hUbaBYHBHWt5zY/9Wbo2E7jlBOcfK8WhDfIPy8rOAJLjaZ1owsrNrfEY+3B1SRdxGlTO1
	 PMNt/BdUeyYi7M8Kgdyj+S9aiIgiRC36M152eNWtUbROHqbgUUSTzIB1YNXgQDHAHzA6f
	 A0JxprUq0k7e4Lc53Hmbrx9tuHrAzXJatwNRHdsaB/DPg5xT2El7Dwoe98emoML+x7vY+
	 SpytgaODx9F0MEhyUWIKsr+DPxCEwiGTeo5aO4/DqYDMl8nxIRsuIwCQELqq+2Vkb5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805408;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1VTaFjPBiDhjXVq+z9mq2lWMiswrahJow/QHzMvYA4k=;
	b=Yb0Qp5o3BuWIDu/428PnH5U4a2zZnFQffoeZbAsPuaUczxLHR9drrzo8yzRuuZRJ4wYU
	 ekmTLpGYSng9RaB+jmjvGm9dR/Czc1whzScfLBKYfKvZX8KbqCV8g3MIvmdJIGVM1cmHU
	 F+/l4s4HYgNcFHXSVtdFBmmEVOat07jkp33JPacqJCEd7C8qTpboe2UVDM8PdExeNXGnu
	 FXyVeTN6s0NZqQ/N4OUDkxYcvN5wvsFNGekHdF3nOKgRBl0OVEI7KgzdTNckYNB6BZxNc
	 RUneCRzEI30KCclGPR7WZiYDi2syx3Ke5vzMl3JeZzMgrRsCCjy0C1OIYnvwhuaboLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3VVBg6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3460A6F7B;
	Wed,  4 Nov 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3VVBg6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA51F000C1;
	Wed,  4 Nov 2026 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805408;
	bh=1VTaFjPBiDhjXVq+z9mq2lWMiswrahJow/QHzMvYA4k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=K3VVBg6NjdDtKRtWB9cfvtH/FteizduHQWiRWREVbTQTuTA8NIkR6mfKCDq5tU9NA
	 iOgfbQbbJzY3OX0N89l6jvmgr+bboJS0P51OLE9o7RbAI+73vCwYEjwSrS2tBnHPyd
	 UB2L4BCpSuGjNci6k5rhrD1hqQW5p/HxMA/JrrpPGAvq8OPDCgH6zvtu498RLRtBTl
	 lbf/TkhpoS5b/GSvnw6CEiunIkKzGknsodfyUOF9NIKxi5t6jmlV9b8S3Y3HcHuNpl
	 Nw1KOJMKjCGU9Y3b6IY28vwgs/K/re3ZgGbydJHA1TRfdGwtsVUn2oD/67SrBmoWMo
	 4lFSlcuG6TQHA==
From: Brian Masney <masneyb@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 Brian Masney <bmasney+clk@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-omap@vger.kernel.org
In-Reply-To: <20261104101732.4043372-1-dario.binacchi@amarulasolutions.com>
References: <20261104101732.4043372-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4 0/3] clk: ti: dpll: switch spread spectrum to the
 generic framework
Message-Id: <179380540063.620564.14085497880404861333.b4-ty@b4>
Date: Wed, 04 Nov 2026 10:16:40 -0500
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
X-Mailer: b4 0.17-dev-7ca47
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=fPWgrL9fqWnEFQzArF4nDk6nAKC/WY5Bs3uZUIE1E5E=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJe+0Q9N1U9r3t//nduL9P/00Ml5k12/luzjNvI14zf4
 c2W2BffOkpZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZiI5R9GhuaX3XoB+ucqNzu8
 nhilzzOFddUzVqV6VamfW2d7xnkHrWNk+LBl8mYJg4gFZfyJB//mHv8UeqFYxuGCx4FPaRPfBkd
 yMQMA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Wed, 04 Nov 2026 11:16:54 +0100, Dario Binacchi wrote:
> clk: ti: dpll: switch spread spectrum to the generic framework
> 
> The am33xx/am43xx DPLL spread spectrum clocking (SSC) is configured
> through vendor specific DT properties. Since 7.3 the clock framework
> provides a generic API and the assigned-clock-sscs DT property for it,
> so the series moves the TI DPLL to the generic configuration and
> deprecates the vendor specific properties.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: ti: dpll: deprecate the ti,ssc-* properties
      https://git.kernel.org/clk/linux/c/73e328f8775a
[2/3] clk: ti: dpll: use the generic spread spectrum configuration
      https://git.kernel.org/clk/linux/c/4d15810115f0
[3/3] clk: ti: dpll: apply the spread spectrum configuration right away
      https://git.kernel.org/clk/linux/c/f337f0361adc

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

