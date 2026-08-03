Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87330E82B;
	Mon,  3 Aug 2026 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727463; cv=none; b=YHo9G+8XiaAHp4hynFuS9u4vMAe0UykaOde8JzVx5jP8uoaZxs4c/zjr3VOu8XQAMKFut/dEfHHra5JwDeqZ50WQVoO/cZ33+/7EROBEnqLN71+R8WPy4KqY5Tqe26ioLQ8SQZG7TEguLaDkqPKjLkthj4XZYzXEpVny+GLb62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727463; c=relaxed/simple;
	bh=ELiRrWC0aGY/YuKTYb6/9jhQa1rBp705Yvy4UFzgSpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rc0C5o3QE/fq45wC+8TvHEoynRoFSqLaB+tmPycWKmpB3xN5QovdyqneFmiu2m/kr0xxzCxcH4awmNah0VQEBkNl66DWlgo0DWEu27yGpIH6qYyXyiBMNkFWHojJnKm1XsYBVmsN4t/WlMzV7CHiMPaKG19mXrwkU334lIvTDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/SGy//2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/SGy//2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596AD1F00A3A;
	Mon,  3 Aug 2026 03:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785727461;
	bh=1VF3rSJQm12kqGGHiDeGNuTAOGjDmvP08pZJHw58mJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/SGy//29lzafn44QnvWv0AfUr95ec4GVuf3r7r4CeL4arb6a62DZJOwJF/Gl2tlr
	 UamD9ImnOcSydXNxsMHoAVPAG2/Fwc6sCafHYQVjBhazCc9/LR6qLsX9bpEm7N67tQ
	 dNr23j0aDMcmVrjGv/GWVCJqbWZjj8M88qr59HlzrY5zGp6M/5IlD5kOhItdI8NY8j
	 NsPgNvO2aSShJg9fE1Z+LRLkwOkCsYf6gCYNep/ZWk46mN7otrVs0dwjwjmuNKIpVt
	 3AIC1h5/UNfLp0UrMzhRizirBSsDyufhR4hp+PgnRjtFVnZL/B2mEj370AEB/T9Jl3
	 m+MlScpmZUzBQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Tero Kristo <kristo@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] clk: clean-up simple provider misuse of the consumer API
Date: Sun,  2 Aug 2026 22:23:59 -0500
Message-ID: <178572744545.408250.6189990473373785394.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
References: <20260724-clk-provider-simple-clean-v2-0-56f306156d25@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 24 Jul 2026 11:03:51 +0200, Jerome Brunet wrote:
> Clock provider should not be using the consumer interface.
> In other words, a provider should not be dealing with struct clk.
> 
> This change targets occurrences for which the provider uses the
> consumer interface and corresponding clk_hw interface exist:
> * __clk_get_name() -> clk_hw_get_name()
> * __clk_is_enabled() -> clk_hw_is_enabled()
> * clk_get_rate() -> clk_hw_get_rate()
> 
> [...]

Applied, thanks!

[2/7] clk: qcom: clean-up simple provider misuse of the consumer API
      commit: 470bd66370ecbf22c2dc27249315b9d39914c479

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
