Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E0282F2F;
	Tue,  5 May 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987402; cv=none; b=mX0MdUa1yrrgHcXHtp++GWGuFln8RIS4S3ioBRPKCRKYsQQHU9FVSNaJQ42CNr8zdlIoD3jloYalMt0Y+xGtxnYFgycV6E0pWW9FiFTqSBb3IN0Gzeao9C++2PjbJaptGWy9ebUGEyHaGBHcz8lThBahgCbB/ltTI6Gq3Gxhhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987402; c=relaxed/simple;
	bh=M2350oeD/DFylPr89/QWKpGkITCJZDj5efANJbLdKO4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulRXHE30DaTSUwbRs7LUXM7h18KmsP667ePQ02FbcreRsJ559Oc3J/A6Ut5UCHDGudxJSM9as+2EpQ8XgHv9J433uhknG/2E7LkcAlCzHVODYYwX2VC3k6sJMtYb9ZyBjXh9uRx/yjKdUOC7U1Bt+g+/F87kp5GnLTmiGY/W0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBBmE0Um; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBBmE0Um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E6AC2BCB4;
	Tue,  5 May 2026 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987401;
	bh=M2350oeD/DFylPr89/QWKpGkITCJZDj5efANJbLdKO4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=aBBmE0Um28NAtCWLdAzB44bgjJ2umzrWHglgxNqvCvRy8WTuj9o6pBu98AfYsoPDH
	 Suq0e3gWDGA4Hivmq953puU7TZBAuYtm2n+YShN5unav+MGw1OQx03AdZhQ6b5VvNB
	 yRZvhm9wFSTTbbeLr0VuV17nFqMjFEFmdc+NYPSrk9Qv+vOsuK24LqnhHIZEktz6OX
	 4Mn+jNCS0WUGklWw6gJye0bUayvSnEm5UQfimUQ2vxdbOwtbkbtqyEbxbhUOvrw5+k
	 Xby+LfarLLh9FeAomRXJsncFOL4nbqmki0s160jmdLPTtCbIdcf7xwiVeTynesla+X
	 n8D1S4aPtBykg==
From: Mark Brown <broonie@kernel.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260505102734.180464-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260505102734.180464-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] regulator: palmas: Move MODULE_DEVICE_TABLE next to
 the table itself
Message-Id: <177798300691.568329.18233548368419022138.b4-ty@b4>
Date: Tue, 05 May 2026 21:10:06 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=broonie@kernel.org;
 h=from:subject:message-id; bh=M2350oeD/DFylPr89/QWKpGkITCJZDj5efANJbLdKO4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+e9G19KiC4LXsmQFtZhXfDh2DcxO4nd+Jf5I9
 5PlykRs7xmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafnvRgAKCRAk1otyXVSH
 0Pd3CACBgfsusyG7irrh5/RydklfbHcfzTgii2jbWEe6EnAjmvpf4rHLLTDtYmSvCGxjqEPnv9I
 MotDyjLHokw8h9hkRDZqyJ0AjG5R7lJ0QSTT7COVFSERQqDp1nmYOCeJc6Fai16nPJfNQ4NFBKT
 3diULGVd11xjq6Iq52Py0/d6lM7AehhxnJpXbIj6SP7euKAQI4ZDAJwIKwG2sYDdHxUOhc0m/ap
 hvEQupI6yP9x6mGF59myOsT1xsILE+IXDydW+DdqYskTXDz/rXyuxuxwreJ6T7sfNQQGY1mKAoy
 7Gu5ZRgyYXlpHwxXlqeBywYzzznUUJ+BWe+uvKcWYymd20bO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 05 May 2026 12:27:35 +0200, Krzysztof Kozlowski wrote:
> regulator: palmas: Move MODULE_DEVICE_TABLE next to the table itself

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.2

Thanks!

[1/1] regulator: palmas: Move MODULE_DEVICE_TABLE next to the table itself
      https://git.kernel.org/broonie/regulator/c/c6bd6642c649

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

