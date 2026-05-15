Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3609392C5A;
	Fri, 15 May 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863197; cv=none; b=ZKLpBcDz0vgnf/INwM6yRzJntanaTDeoLQ+BYxtcEWNmMLDVbHO/DsqQTlHgSKyjCxXXt0pc+qqZmoOnYKK6lHZyV1pFaFLSCVq078T0ofVXNJRq+XQrNl9Dkmkv7VFedhfsW0PWTzSDaSiU+QCrsXKow8+Wc7OJ9t4hVbT8m/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863197; c=relaxed/simple;
	bh=ZKhOds++Lg2nhUOVlc6r3yVlvnr5ZWV3FOrsx3N+2xI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h3QO9sDezr5EzUYcSJZYRc7AF+gz6D3eZRMxCdPf0AlcTV8+PgwDXpoGqTQz5aGPA/dxmEEsA0qpqIVAMjyRL8gKw1NjYiefvTBZ6SFOLxFY3NKsNJAXH40R0EguPNsvXvhwrN4ujNtvaRsS/52ynYJIjltvm51H0+cDhym8US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srW7FKzz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srW7FKzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CABC2BCB0;
	Fri, 15 May 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863196;
	bh=ZKhOds++Lg2nhUOVlc6r3yVlvnr5ZWV3FOrsx3N+2xI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=srW7FKzz4TnQQ9fziOMAUhtmwzy1YbMVw4jg2QA9jaomu3NBbiAgJQE2Wfrq4mYU8
	 XqrqLv/h+3EZXQMv1+ycl6bxsEmWCUCxWSjx0uHqgjic/8wMuhNSuWvMVfLHE3JkTm
	 k6Dr6huMW6Ro9h6z3NvJMOadG+R10xeZBnLW0YPladmmmeDXDh+DbP+2YeWVe+xzg8
	 YyiVbSri9cEdlq/N8lEtN1aVpGsBE/Zq+/cO8KIh+oEofLbZZiEBC0g786AQD9hXjv
	 GVkCLYIHwRTIUGtuiJFARZs5MlPqv1VzRlzR6h/nfCpR6ejNatvgb32Flhbvf1MZKu
	 Xx7BA13lJADUQ==
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org
In-Reply-To: <20260514110602.30480-1-phucduc.bui@gmail.com>
References: <20260514110602.30480-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH] ASoC: ti: omap-mcbsp: Remove mixed goto/scoped cleanup
 handling
Message-Id: <177880901138.1136679.13981077900193633493.b4-ty@b4>
Date: Fri, 15 May 2026 10:36:51 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZKhOds++Lg2nhUOVlc6r3yVlvnr5ZWV3FOrsx3N+2xI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB0xZWgxbji0lNS7rg6X+QQR9ottzWZpiq9LRh
 suDkYHBaRyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagdMWQAKCRAk1otyXVSH
 0CHBB/0eOhI5Z4hmKWvWuQRSGu6byv3OdDOB9scvpuz5bBjzmvm9uGJq6SoDCPwFx2AMZGzxYDu
 q9cx5ZGopkwRI/4yAOFTtkT29AigIVBnNMIA95MSo5IUcmJ6hHV0DPu+RsJdLHIvas0C+L0vq3a
 b2li84+WK/IVHl1md4KXqdMjTUsJ4aqOCrI3QpqwR929LA+yVRCOxVJ/0sr4AbhYRdTgt+lAGJS
 HUfIqrdXTpiEuZibNJcHJZtyLhOoLY+uZDmNc4p78LaPDigol4V7zXw3QI/Ftt+PBSQmPJAGR96
 KQvACFtejxvvYwsHivEQNbpJCCA7sd0D/j/r72RvdR9mFmeZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 14 May 2026 18:06:02 +0700, phucduc.bui@gmail.com wrote:
> ASoC: ti: omap-mcbsp: Remove mixed goto/scoped cleanup handling

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: ti: omap-mcbsp: Remove mixed goto/scoped cleanup handling
      https://git.kernel.org/broonie/sound/c/7c0acb8f766a

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

