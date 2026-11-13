Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578768;
	b=n6zHt7z4fqfxUfgNhIBWMZujHBzSF8eNhvet0c6csAva2d+lswg2/OYXiBQz7zX+j+sT
	 JBLIaAGeCZz4n9xBLpP89PE/ihwcvLG0l51xvPtm9ju7K9oGv10shcIp7qIfcmwHQX6Be
	 JGPv7G27Sd7C49Vy3UGLfwPRN4MH2Kewsx3sllySIcu00Zs++H9RpholXN68ZpVumzKOz
	 jxGIBuH/vOqfuUy4z7B+UK2gAfY2XcpnPq4ZZXV6UMIPLBnQFo5AS5xSnwwixMh9qHBzH
	 Ld9CmNiXO/NOJ0W9hXnNxC5M8brBixNKWbzpD08SBiGvdkcmGbjjXyItlPVMZcSQjkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578768;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=uOLxAE8UpwveT9Vb046h/+v+ZBvoRBoYnk4ZAFK6wgI=;
	b=m6HLeexjWGFSxKqz41KckhYK4sG6VW4SFlZNU9YGaLbtYG28AhNp/NSx8YthWJlHKKkb
	 k8EVxMnBDU3Jw2en4lXC/QFut2V+Vq/bsWZARaDqGbYteLh17UA1IU61ub2ttF0TQGLnc
	 ZhJ5XMGeNF4vk0NaBUQbnrmBFe5ktXZ9o+kBORtX+pV3/H6ZZJJy4TedTQBSe2Ytlwy1v
	 hHT1lZBK0vLYdMuagjaFXuDsBtbHMiLA4KPvrzU8nmN2mr73HfhltJtuGfvc8iRc2/icP
	 aU/lZc4Og38ttIwVxSGAu7pjfBkMDb74IPHdtyX0WWY3rXXmzakf/scNDaMNhmHR8Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJDlC0WP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DD606A32D;
	Fri, 13 Nov 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJDlC0WP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3501F000C5;
	Fri, 13 Nov 2026 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578768;
	bh=uOLxAE8UpwveT9Vb046h/+v+ZBvoRBoYnk4ZAFK6wgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QJDlC0WPT2BDwWoKDtYgDcMV4xy5wu1QPk/1sy7FBzRWy0JnC+5L1dpxbUygfitRH
	 DEJ+7IWgRSov5AlWtf4bH1pu1V5UnEkZ23ZBFehQVulmNUGJ6kdmbFJWEPGiMeR/Yh
	 DUrGwLzKhAuFgz8+HVjfLQd4WxrQ8/UJ13nozQVAO+Uui3hqr36ZrNEeup8gYFx1Ya
	 g4pUB47QMPJjHxQOequlh8kNaQPy3q/6R97yVZt45wJFwI0Zt03xNgZFYCPpyOTxyN
	 MLuA5XRAybko6c+dC7Prl73a/2paQDP0edBpJmc95ZN9/5KDpw3kAbi3rXS4GD5Ji6
	 lET+RJpeE75pQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Support Opensource <support.opensource@diasemi.com>, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, 
 linux-actions@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com
In-Reply-To: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
References: <cover.1793377422.mfd.git.liguangshuo@mail.sdu.edu.cn>
Subject: Re: (subset) [PATCH 0/6] mfd: Fix potential cleanup ordering and
 lifetime bugs
Message-Id: <179457876458.61698.7594247052314866900.b4-ty@b4>
Date: Fri, 13 Nov 2026 14:06:04 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sat, 31 Oct 2026 00:54:23 +0800, Guangshuo Li wrote:
> Remove child devices while their IRQ providers are still available, and
> avoid deleting a managed IRQ chip twice.
> 
> The changed driver objects were build-tested. No hardware testing was
> performed.
> 
> Guangshuo Li (6):
>   mfd: da9055: Fix potential use-after-free during removal
>   mfd: atc260x: Fix potential use-after-free on probe failure
>   mfd: palmas: Fix potential IRQ action leaks on removal
>   mfd: stmpe: Fix potential use-after-free during removal
>   mfd: stmfx: Fix potential IRQ action leaks on removal
>   mfd: wm8994: Fix potential use-after-free during removal
> 
> [...]

Applied, thanks!

[1/6] mfd: da9055: Fix potential use-after-free during removal
      commit: e8fe9e8397a935554eb61504934c76f9f7c32fc8
[2/6] mfd: atc260x: Fix potential use-after-free on probe failure
      commit: dc3431a385007486413d1194d36ebe9d83790b78
[4/6] mfd: stmpe: Fix potential use-after-free during removal
      commit: 259e272733575dbb4946829ad06eef6782ae91be
[5/6] mfd: stmfx: Fix potential IRQ action leaks on removal
      commit: 1235c2932f71553486eab2b76dbf40806cd2d345
[6/6] mfd: wm8994: Fix potential use-after-free during removal
      commit: 4c46825cdb45520f3a25f760e5c95f7b08191221

--
Lee Jones [李琼斯]

