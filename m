Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064656;
	b=tvkW+eKolgEA7ctzUGoQYsCGIFWsp/1zvBOVsG+FEXGR4bpLzJMMerXPewM6JHlQixDS
	 nqYwyI4falIc1ftklu4+6+rCt6CrV+BlBT4QRcN3GXb+xPi4Trt0vUB1U1EncZeKGWz2t
	 ZvdPbBYquF0vbelL6e6gEUuZWV6ZgMCObkq/ahFLzGOJFMqUUITFfCqA+kwTrrpEJMuOY
	 +1Due8PB51B++XUcmnOafHftgeGreVW1rQ5fkgWVn+MRNtu/CS1/zIUR7kjWfh/JhTuI/
	 Qk/yhHWn9FpxQDNmGrVK7OT3yI0QVAADT8OTqg7Sx/2cVwqCKJUN0zjgnVkQa1TQ+Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064656;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=B1bW9CMw+Dzr1ZLzwD9wcsTuwAnVAPoXAK65EcaP0mc=;
	b=FL4+KWzmFowl3+i1UUB4P5zAYwcKa7ueWu98erpg2aN+NWSsec583qLVoumHNQz/V3ut
	 2cMnf5v37opQBUKN8DYmVvGBFZAYLbHR1FQv8PD8NjL30kiRbRpzcAIQvXq50QJdsGHzl
	 yNG5IYgSqwtLpG/69qovxhhwz8ruWvMgpZme5nfX8iIEe2lllnDGvZP55NCX0mX4AAvP6
	 lVROWqbQqP6N7NShvS9X/VXQAlSDJ6IBakmVGE2cpmvEya/nj+wu7IQ2vWFKi7RGaDxzf
	 L4vW83cTMMxHXHVdGBrUNyc1sJeVQ/lw9zP0uSkWV+VrF+Y/IMQCRwEuwJW6otnn+Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYi2WVoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1E606B88A;
	Sat,  7 Nov 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VYi2WVoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495A91F0089F;
	Sat,  7 Nov 2026 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064655;
	bh=B1bW9CMw+Dzr1ZLzwD9wcsTuwAnVAPoXAK65EcaP0mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VYi2WVoQlAinQO6kz5qb2UPxeAPJw+27WutJ4M2Ujli/KKPEmaR0TaZ59fbHo7IGs
	 Gsd1NWGH+xt/9noZCbrVgEau7YySYbGIWrq7S02jzv8X+fZd52gMarHSlZdiRSRR+v
	 wIuNGzMu5RWduHCeXY0IfuHJEbVTYkbYykQP+rcwBiWsCyhNhGWbD9eXtEMk4UW7Sn
	 VVwqjMtAg8p1U9hPArwc22kYq+lU0og1mQQ5GY4xBdrdnzWi7vtCiHQMYHCTpvRIbn
	 l8WupsGFGDLIPbxa8uPVw6pbncUrQyNO0b69M+kr25xgvEs+zZxmOAUUxMqW3aL4DW
	 rIV3icmol4nUA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 558F72AB3141;
	Sat, 07 Nov 2026 15:17:33 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20261104113352.1634237-1-peng.fan@oss.nxp.com>
References: <20261104113352.1634237-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] regulator: Convert to subsys_platform_driver()
Message-Id: <179406111958.3424803.12810208024336912202.b4-ty@b4>
Date: Sat, 07 Nov 2026 14:18:39 +0000
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q6cAsV4W7X68n/oGP4buAMIcus1GeKzbibFsF46mRZE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO/LKOWT38bFvynedUrjR49GjkG9fEv/lOyQlvjrq+
 9Ojp9W1o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABOJFWf478K5aeX7rCVR1df3
 iv3I0DaQcZkzjeHF3iv601wO+LqWZTP8Zt9eF6MoGn+qrLDyEs+sH1vVb3QoezNd5nGpkn1gdZe
 NCwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 19:33:52 +0800, Peng Fan (OSS) wrote:
> regulator: Convert to subsys_platform_driver()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/1] regulator: Convert to subsys_platform_driver()
      https://git.kernel.org/broonie/regulator/c/2a1984b30e9c

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

