Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEA33A032;
	Thu, 30 Jul 2026 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399262; cv=none; b=VQJCsOH96/Wk5tGUhE5F0O/SeugD74xgHxYY5R49jqUanC5FOWtkLLVUj4rTdWvzLyg8lgkpQOiusFE/cCQ2aSSbc8TQ6aKZSLw1yYEvKaHfAkidDSoFCCkrUGCLyF/6ApPv7V2yyePi6YPsqPLO6ripx7QfZpJQffdnqhNrKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399262; c=relaxed/simple;
	bh=Z+ualrgtL7tZuL/3mk12jtK9F17j9SWjQ3K9uF4xcNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdUrXg93pOjtj7dpWvo8s2+ryG7yTklx1YosVrTQhlij5IQRQVcexyxAfdAEe7PUDvZwZd6/T6R6uWU+ZMRVKwHTl/qmpdi4IPxaY++zx7+3j5WXAJEZgFZTuQbmHIbMMKd1KAJAi7iboU0Qj+db8ZMSgLHI3YXMtA/uetxGSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtfpqxMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtfpqxMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FC51F00A3A;
	Thu, 30 Jul 2026 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399261;
	bh=z5CSwG55YADucmpwN1DahTYwaTO0UaQN77qVWu7jJdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtfpqxMO3QFI6FhUxbO7MgZno07408HCX2BJ13cnCuh3ST+y4ee4fOVozzS1/seAh
	 QPqyySyPTKLuQTJs27mRwDqh7kMkdTuCFGdyY0VS5igbyXZhp2ggaAIEKJ5VpslOv5
	 tKVz7WuBlUau1LGTw3U5i/HJcOXqYIpKlSOgEv9wPwcjyaJUpZpmPHAFj2r0yIcfYE
	 puphLa9ipeR8KVzGq+JLk7re19uPRuPOQFq6uEj1/kexkaAw6FLNSynRLxMLSPlKzm
	 2DBfZ+TCexWh2rOM3B2+ANpXosCD+gwfVJE37cKKdmIo+J/hJTzfRDt1wDSGF4I9Qw
	 x8fgGgMRdsxbg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kees Cook <kees@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Pan Chuang <panchuang@vivo.com>
Cc: Christophe Leroy <chleroy@kernel.org>
Subject: Re: (subset) [PATCH 0/2] bus: Remove redundant error messages on IRQ request failure
Date: Thu, 30 Jul 2026 10:14:04 +0200
Message-ID: <178539922194.574381.11201940278716774894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710110930.462109-1-panchuang@vivo.com>
References: <20260710110930.462109-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=chleroy@kernel.org; h=from:subject:message-id; bh=oet0d/75qkhExnrQA65w4zG1pGl8gFrf327e7raz+Go=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRls1/4FTg9MmSmW90GaflLi9Rf2n3MfDlhZ2+RoYrtt XsBV2d86ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATmV/C8D8jZU7FqhQO9cXr JJR7mR8o9JySPL1IN6BDyUb2Ys3cuY8Y/rsFR/dVZyr252o9WX/zJrvmFLcHRwpyJR/eyg5a2a+ 9lhUA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 10 Jul 2026 19:09:25 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

Applied, thanks!

[1/2] bus: fsl-mc: Remove redundant dev_err()
      commit: 1831c3b0fb726221671ace9b10c760b80dcce597

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>
