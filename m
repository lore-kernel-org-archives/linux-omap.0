Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B5423172;
	Mon,  2 Mar 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471466; cv=none; b=FUHPHdkm+EqJfrzAvVI2a+3MpEs6mKBuiFmJBa4vWkm6sPhNQZZBk+29r0awdaOJeVZbeathXHdT0JFmKCg8if3Yl2hdbuZQ09x+yBvaObZ+jM8ZRcSYg52xsa1KNY8/A3CzKwZYCUAQgMzaINxYi03sJ7/ZSMD2kys4MFYtrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471466; c=relaxed/simple;
	bh=+z9mbKGTZFW063NZMX+qvX9VGFGuApKWlDZC8PlDa0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipO4Ye7AJ/ekUSxdS9pvUAXl8/lKCYYbxkVFxCIVsQHrroahD1qDnsRQFpis2sX6qDBC8BjrtzKeaDO4qeRzIz6f2uDOdbuyOtp/oGVpGYmrPKEnYNadz7bEqxFAjlh68gTycLbelkY+u8+ERXK/pBru2SwvaKKwA3zdGlDW6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=qYXzYyqm; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="qYXzYyqm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=B7BMzIGTcR03oDr/GwRJGVOgBesWNokBNrI/PUfzkFw=; b=qYXzYyqmfH30IMThpWbOFzFsB0
	c2MAyOfzzHy64IeZo01QOyCLkjF+1lRimCjRjsSM/4bn3uvbSicYBa1CTRxS6toklyQWKpTlKGkeM
	pSsUEVbakjiBsGxEDgqwKdE0+2hZcCHWq77tiPBR8gJ9VUXVGqw5FDcWX3Dqi79VNpsOQIXYpyhUw
	CD/lfnnmsUWwQtaFTdi1u6krFjhlbKjcLL7YTog8FTSXb9OoEk1xez39GyC52E17R2IS9T7tjpVBa
	yNaTiIfCzR0lWzoa/tiHFg7wPvkDVcWJ0ml7ByeQ6A631VC8kIos5E0/oodtFvN8mwKxfcKUy1mqi
	o9qxxQMA==;
Date: Mon, 2 Mar 2026 18:10:54 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: omap2: Replace scnprintf with strscpy in
 omap3_cpuinfo
Message-ID: <20260302181054.06aed925@kemnade.info>
In-Reply-To: <20260224144552.585272-1-thorsten.blum@linux.dev>
References: <20260224144552.585272-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 15:45:51 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Replace scnprintf("%s", ...) with the faster and more direct strscpy().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
