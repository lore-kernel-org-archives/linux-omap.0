Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4499E438FE2;
	Tue, 20 Jan 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921805; cv=none; b=gkrfYlVNGHcyIQ//vysp2SyoHHVZKRQx7O5QHT13Yia42yle5HlzQAJ19fYHI5a0rzUF3Bdt0CTBq4YzcwAtQzdg/lwRfKs+yW0iM94xbmRpYccze1uIV9YlDz7LfIOm89nUJ7LTw14bTfpgJBR2OiE/ajjZcdeJJnwZ1jE2aQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921805; c=relaxed/simple;
	bh=TC4meEjdm9Y60dfiMt79KUxqrb2NqckocoqdNM6v9Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f3oMjjG3+aZy07jU+VEhI6CEamjt3G5yRhQSk22h7H8pL9SVOlejURjfm6mEVzoRX1yEeorOLqQvjP77LSBErcGkTU6QsZ5AsneLB9IRSkhhWwtou3VXu2O3W8/n1DuQxHxJT6yHzQFqTYNwjsGh1svGL2iJ5aCL634x3onjJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne191idI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne191idI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF09C19422;
	Tue, 20 Jan 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768921804;
	bh=TC4meEjdm9Y60dfiMt79KUxqrb2NqckocoqdNM6v9Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ne191idIRw4oR7RjtJ8sJcF60mBYBAUhnRfpTjBOdHE9SoAgtPuP3QBm6sU5Pavvz
	 Nsk54N3g5SG1h2yjzLapAYzyynbVTC0EfCU9jzrvF9D1UiY4ea+Y9pbfA66fgghK8e
	 RScoPlYxLtOSNGn7nJWIJ+Z4eJNx8U+8mPHk8k7xOTfokveH6SbETJn4oa4kUVrp2F
	 dhPEKqQlw1u2g318HJz5/FRXDlhX3OJO5P3dGLt2OgOh5EA1TxrA/XAuy157BwKxp9
	 WnRm1aIyFRAvnwlUOZvvHRMZ9ADRefcUw3Cl+Irhhq7B8gNFvC+MCc8BC9Bwlkwtkf
	 qDeFGk92NqsoQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251219110714.23919-1-johan@kernel.org>
References: <20251219110714.23919-1-johan@kernel.org>
Subject: Re: (subset) [PATCH] mfd: omap-usb-host: fix OF populate on driver
 rebind
Message-Id: <176892180186.2267608.14679796695892465448.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 15:10:01 +0000
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Fri, 19 Dec 2025 12:07:14 +0100, Johan Hovold wrote:
> Since commit c6e126de43e7 ("of: Keep track of populated platform
> devices") child devices will not be created by of_platform_populate()
> if the devices had previously been deregistered individually so that the
> OF_POPULATED flag is still set in the corresponding OF nodes.
> 
> Switch to using of_platform_depopulate() instead of open coding so that
> the child devices are created if the driver is rebound.
> 
> [...]

Applied, thanks!

[1/1] mfd: omap-usb-host: fix OF populate on driver rebind
      commit: 74283e1c49dd2d56e83bca070c163c56375c057d

--
Lee Jones [李琼斯]

