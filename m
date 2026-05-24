Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113430566F;
	Sun, 24 May 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779648214; cv=none; b=qcCKsln6Y9LG8uKcqxhpDAt+vxx2niyuPamg7mXRrDkaG04sNgY5tW/5Gyydit9YqR2iqCDKcxIzcG7cWIyUYW0ocHk09j3bU41o8zkKvh8ibOcgYCjQVnhzP1HFCxYZtBg4UqP6bfpJwJdS5pAZv26yi+vigdixlEkjunUoXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779648214; c=relaxed/simple;
	bh=h3fhhHjq1Urb+xOi6hdz5mWYMhc3TDjDqTm+FaKmzrQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ikYSxkoa2IHGJcSBlMqa13/bpP8x0HWc78CprVcT7ldtnzD28uMqCbD6ADArSrV/w8c57mLdksQjRjZiamjj8Wl/bFvlgnZ94baSF/FyrJjBQdroyHl49S+WLZypLzsM40vzgpfgCETRTJamw3PyzYhHLf9QdDEQ7hhk5Eqg5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjesJ7mP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjesJ7mP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E31F000E9;
	Sun, 24 May 2026 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779648213;
	bh=93LfK6VNYSDzQm7Uw0qdefA4fJbShzhy1ZhDPzH2M3U=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=IjesJ7mPhTax3jwDU8YT009egSr7m5kuuyilf1FuEwfn9eAC78xg6eS3zOcOUlRxZ
	 3avLEx9DFhdo+VGekSiv18xIoBvoCRM1pmjzR8/ZqVEGiS61sWVk0FxvMqgBscsxtz
	 +RuHm8nCPLVJydeidMU/sjhM7hK9uW4ZTDi0efICxpNTw6AyINgUTDqZYFuJIO4LbP
	 9UYLw2WBxZ+tBMhLkX2YV3OAL57cwC0mfAjbom67mwI2WFE+E499e6F+jvKHGnqQ+o
	 a4G6/hZiJkrA43ZJe+cn1FMvO+zC3zCY3uVsHqT5B517VclgeZe8fBWkFCM3mz9Tye
	 uuZoqKZg+LyKQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260520111630.89365-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260520111630.89365-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] memory: omap-gpmc: Silence W=1 kerneldoc warnings
Message-Id: <177964821108.15661.530728047035567405.b4-ty@b4>
Date: Sun, 24 May 2026 20:43:31 +0200
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 20 May 2026 13:16:31 +0200, Krzysztof Kozlowski wrote:
> Recent W=1 builds print kerneldoc warnings, even though a correct
> kerneldoc is there:
> 
>   Warning: drivers/memory/omap-gpmc.c:441 Excess function parameter 'cs' description in 'get_gpmc_timing_reg'
> 
> Drop additional inline comments for arguments to fix that.  They are
> anyway not that useful.
> 
> [...]

Applied, thanks!

[1/1] memory: omap-gpmc: Silence W=1 kerneldoc warnings
      https://git.kernel.org/krzk/linux-mem-ctrl/c/83c1d176fbac3c3ffbeaddbc37e11e083f19cebc

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

