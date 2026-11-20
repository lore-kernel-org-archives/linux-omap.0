Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138852;
	b=vYtstct3WP8Azf6T9LgyobeYCFB9I3Uico3RTZVwuCKaVPuaexlGSOckXDt5feJXgIxe
	 gfvF9wUy1prS9HhgLYsYBRL7dhOg1x7G/l1Kf0KyFBKk4ugwT20tZ+Nwj+KQ3/29CNZTd
	 6BXo7UBs2YUwHRz3tmap+qU+FAUhHCz1C5SGF/FvErhzzsAHgeo6Y0UY5KAayy37PNhAm
	 1nILFWctn8FZXRYFOCFGnnXiSL5fUPt2+1+EAyuih/J8agTjIXcyJfTzPDxi1bp75S+dq
	 Kz2TVrmAYNdKCFKJkM3CBRKguP5P84jWv0D84xh8ot0I6HVKQimu/Yd+DlBJ+Q8vPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138852;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vcKPQHmf9gWTDq0nbpcIRDBqyotp3mpevFZSMkbKrMc=;
	b=IXqMpBuAOw0/l99yD8OUe8Hdu1YOfvhCLAWtGHbAzonCSzpt1uvHh+KnLmGeFrfPugtb
	 Nsx1i/3xRAq43ld3hCkpz/IZq55klXKuq3PwaYnczsMxAJ+S96QV58Ly3GkFLLh09qcoX
	 1lFe1q4zPLFGqn/gMV4dt7NP99WirpxkKcB1oMxZKztQgXMJiKVAKQlv9rIBWG22xZtYT
	 ++MAnSSp72mGbjVkUiJ7niww9qQ7nQojoTiPTBxeBZAH0KxYXi9wfmetUbhegYms+UtNr
	 c9U8d1MNMPh3skkGy5d2Pat+1W1xxVxQ5slbfyWmYIT0u9APi5SywIs0fuBhSq7TZCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXjgZ5nu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE79606A320;
	Fri, 20 Nov 2026 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXjgZ5nu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739831F000D2;
	Fri, 20 Nov 2026 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138852;
	bh=vcKPQHmf9gWTDq0nbpcIRDBqyotp3mpevFZSMkbKrMc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OXjgZ5nuBCosE1FlnEJeoifb7O714az6f2IdsuWkNJ89tkZTpKfNTf4OhnTdcW4bK
	 5cUNPpLYp9ANhTfaKetlX2fEmRAInxL6aB/OnhqXraqqJakMuZsr/j/s9YH6ib5mVg
	 UZnzcRM6v9yQiO2+kJv4ddJYpDu4kRHTBK0vXugWiLdvCcrkRhxohYpJ3LH0gA1TFg
	 zdxcVxVq1kfrmX2NxboDhSwpvHnaj8CsxJwT0DKAdAqbuIdA6e5o44xQt+/stDFon1
	 2a9qVnjIXeBIINOvm9NNi3XRmDcG0T1rdHK2IFfRjn1r0M67yC7CM99EGL2gR85rjJ
	 eOLlW3zKvsJog==
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
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882273.284394.16014881415515819933.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=470; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=agOkKy6rfsDuf/v2Uk7yRPZKM78mXjUOoAKPNIJkhCE=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+LxUJkxVluuylry9x6uWzQ++lGcU2O7r9UJ+fk//G+
 xG3nu3njlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACay4ALD/9wj5notbPd46naL
 HP950JH7Tr5VWltQya0zRnEPk6JuX2X4n8GcvNHHbdnP3JqL0dpbBKcEGzS1Ldzk+TjuheKLV7s
 YGQE=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

> OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> used for power management, so the latter show up as "deviceless" in the
> consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
