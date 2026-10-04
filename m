Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233641B8E6;
	Sun,  4 Oct 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112536; cv=none; b=HeinmmMmqxh0jIQ5lUqgeaoSW4fHUlGHmz6WOoSQkEPM+V5b5F/KY7MjLewxQ6I/0GxOcHR1IILT/AODXiLeVm5ezIb7rxh4OQtfRXiPOeyFjSeRGPwtBfESpw3joFGpLitlnoP3DxRFEbxzVAiU/+KJg2Y6wiVHaxWGMjoX2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112536; c=relaxed/simple;
	bh=HYsO8sl47/cbxbkEW9uJZYxQJz/N2jBmYjqx3pkGRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmYgLRx9o3KewXiFl0lFXmyOGRaEwcP81pQtnvTC1en7Fwm05VtI4zd61nWqy7UDN0QNpysWZMY4+1XkW9UaN/b74rWI5ufOis9sGMNj0t4yya7ttwrELJEzT0iVW54YMswQM6Zp6T8CA8r4sWMPxlce8tNBefmIzGsSo34wZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsSUnbjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsSUnbjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6191F00893;
	Sun,  4 Oct 2026 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791112535;
	bh=fijvjhapfoEhEf+4wD4kYLOXf7zvrs6V5pFZuPl92ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RsSUnbjW1qWUpBj3emsjmBAQhKGCkFahGHCMAUEwLF5wcB/p/NAaOvsqFioFEUjht
	 TZ2AAIMk7DWIpVelszsYsFsxDXpnnSYhJwDESSlSOYv77Ac97Fv2go/m04vVlcKvy1
	 zpmP50o5HW5Gz1a3v1kx9zyI8QA5lvuxwlpMXhcmso0Zz2Jdcj/A7cTDC6i3dOVkmr
	 JlVN4YOOEmS5OBrgMVWXFR8/hArTxTYsN2CqxbMC3Bz4+zlqpafYxACHIj2J6p9YUA
	 WNWAGUXcFhY+/qw9e5yILWOXX8oDit6cy2SaieN/4S0GCQjykkDib40KbXlo5tGrQq
	 mXfz/skjmJl3A==
Date: Sun, 4 Oct 2026 13:15:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: soc@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] ARM: dts: OMAP updates for v7.4
Message-ID: <20261004-illustrious-bipedal-weasel-5ce5db@quoll>
References: <7ha4p1b7lw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ha4p1b7lw.fsf@baylibre.com>

On Mon, Sep 28, 2026 at 10:36:59AM -0700, Kevin Hilman wrote:
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git tags/omap-for-v7.4/dt-signed
> 
> for you to fetch changes up to c3037b5c7c38bdf78c214e7dbe513a553ce8f47b:
> 
>   ARM: dts: am335x-bonegreen-eco: Enable 1GHz OPP by increasing vdd_mpu voltage (2026-09-21 09:02:20 -0700)
> 
> ----------------------------------------------------------------
> ARM: dts: OMAP updates for v7.4
> - am335x-bonegreen-eco: Enable 1GHz OPP
> - clock fixes for camera sensors
> - misc cleanups, DT fallbacks, schema updates
> 

Thanks, applied

Best regards,
Krzysztof

