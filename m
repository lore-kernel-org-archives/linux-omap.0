Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275096;
	b=W5zPuKkEMicCmdx7S58DOqdmEKYZabXLgBS8hFwct3coqE9tGMqixA+dm2ca2x4gVd0Q
	 UrYsyHjvBed7eR+Pez84lEr5ooJAzjwn1u6IwZLX47j9TCDOAPF4fqqCi7jG0G6tlTcdR
	 6fR0/fdRFtYsCc54RIo2Ed9rTJe0LTyHiZhM4zICuwCwy5p5M0paGOeTGZHqgs5l9ClT5
	 BRBd6dVsnmq3GD0Waj/MrRX9xHWIHLd7Vs1Blc3lKWJo1RI8nk3r37EYjAlLgLn6ZO6Z7
	 skMgRtyaukWE07/eoaGP1D1ZMYJBqMD6Ydw7RPUUL7n9n+0rQSkfm50pqoLV9u8zT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275096;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=z+4EY+8KKxK3cbzz2wjy14lYgyq1UFQ1PnavJMZdtnY=;
	b=FFc5ZigVueiCFit14abjSUnY+hwG/KqdkVMzHuKcezUdm4E9dregTeFLZFsFuKYdQLNJ
	 p9UY42JcNhdcaxyBD8PRhLtl+yLWSP7w/GeIJstn2PFXJBVJMEkP7F9Ju0pjYQVYI1t/T
	 KKRFrEIt8FzQkvMGl06fPBoCuRLoFO/uF88MVqZV+EMlzFBQpqzNpk190IoRZrNl64G3/
	 rLBPLCBgQr1SxydTOjZ1raBwp5xJCnaeyXyxEQ0lnaFEo4fGGoHJrJuC6s8C+cEglULpU
	 pAC70p9soul/Ra12HQSxnzuLjANUUkayf+TAlMi3+7iFsh3WsotiC0DSewgaubYJMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MPg/2vL6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A7606A321;
	Tue, 10 Nov 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPg/2vL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41D41F0089F;
	Tue, 10 Nov 2026 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275096;
	bh=z+4EY+8KKxK3cbzz2wjy14lYgyq1UFQ1PnavJMZdtnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MPg/2vL6JzdB3cjQ10UHXJVIDFvIwvy9wyubTR9zqq0p9LYJIDD4/foW9tN/+sPWK
	 /kTLrB6X/orky8QFfBd7sp6raJdjMz9pkzFfWS3jwyTKakOw0SKRkxW8uYnLfJdyhw
	 XXLzuLl8top8E/y4UAaZuk8IryYJJu9dLzDTySSTPlYILI1LJ0mNUZdMFn1ZXqhITV
	 FtJjOM9GExcahyn9zeeeG+aoAD8rHCaDcz/ZlJmOPh46isthDt2jja1+m6R60wXuW4
	 ziApxigCbHMjNxSqnKkQKZY+yUsMkLvDG/kUWl8K+IZOPeh4XIxmSkQSnw5Q9fY+8y
	 A9+rGDE7+PxrQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D39DD310B0D7;
	Tue, 10 Nov 2026 01:44:52 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Brian Masney <bmasney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261109-regulator-subsys-v2-1-370edc01ee9c@redhat.com>
References: <20261109-regulator-subsys-v2-1-370edc01ee9c@redhat.com>
Subject: Re: [PATCH v2] regulator: convert to subsys_platform_driver()
Message-Id: <179426493952.3711751.3118760089270754666.b4-ty@b4>
Date: Mon, 09 Nov 2026 22:55:39 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xu2NjFsborPmWZXavBEW+5G8t7Z/Jy94NrhatdekAPo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+lYskv/GoYHSOTw8UyX3gkP77N/PxBxu1nf6l5B2ym
 PhiqZhiRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbycg7Df2/NuAzXt0Uz/l1d
 +qx7nWfxBG+VSVfaNiuf9G/d9PD9GQ6G/1kv3q6oqA/8MCd61oWt//4afog+tfnTn3/rOM49YWK
 5Jc8MAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 16:26:45 -0500, Brian Masney wrote:
> regulator: convert to subsys_platform_driver()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/1] regulator: convert to subsys_platform_driver()
      https://git.kernel.org/broonie/regulator/c/b526cfdf5d3b

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

