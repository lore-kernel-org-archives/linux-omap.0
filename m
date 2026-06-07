Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DB4071DA;
	Sun,  7 Jun 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811625; cv=none; b=DOiullaEaJgcY3ARAc1WntEX5/8bv6BnqeULLAsVma9fjEgeahwfE0t4WhOHZZBhUzXlLZxuehAQ9iKfmIXxOXDZLQG6lwbjNJi0iDBEg/Jx1mUewQbHbQ0CQs1u60JJtBshWJVGewtPjtpvIn4AIQMkm5tEGw9JAx4brWADH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811625; c=relaxed/simple;
	bh=XUa4u/55rTxTlWAEfW5I5q+h4aAg6Unbg/RB7j4CCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNAyo33RsFDhOmSm/fK3SHTJvoPJgM7Wkve2KGUNyVu7YL4VVfssF893EAGkoifVKX1U579lOkgN9gr4cnuTzwJIpMnJDcC5VMQMcFvFeD/w80f5hUKuy/Uo1eBqmEVSyb6QMDxXGSLobxO5zjDc837NblqAAbd5MEB3EjTpKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=YPQEdc9r; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YPQEdc9r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kmvxFLI4fafNJPsciPGiO4KBdNeRmX5zokI6/2cCmOY=; b=YPQEdc9rBqciC+1C7hKnMmBDQz
	KxOaNDdNMerpsHZSL2S0x00aj9ZC0AUVFgo58E9nrV8tNXA2IP2+lHhmf018rWz6FaPzdMNrXe9f/
	gf4cPlJsWHt43XJaBPAAPhAk2dkYRnRUV8R+H0NrxZuzhyki55DKtk0SNDi3/oajeUVd7cSbu2f5n
	BxWxbMX6puE9GqskolaygZiEhUT45fNnSi4j53E9BEMsXysTELvCtu86/tqVFyO8trnjMbnU31DiN
	oPslOTDfXgwBVncvS5uImc1SeUFQEqtlDA0n8oz2hJhnLWsXdywkJbjm7Smih7YLdfdkQmfr0A1r9
	Pi9J6D6w==;
Date: Sun, 7 Jun 2026 07:52:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: OMAP2+: Fix OF node reference leaks in
 omap_hwmod
Message-ID: <20260607075225.7568cf53@kemnade.info>
In-Reply-To: <20260504164711.2854116-1-dbgh9129@gmail.com>
References: <20260504164711.2854116-1-dbgh9129@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 12:47:11 -0400
Yuho Choi <dbgh9129@gmail.com> wrote:

> The OF helpers that return device nodes acquire references that must be
> released by the caller.
> 
> _init() leaks the "ocp" bus node returned by of_find_node_by_name() on
> all paths after lookup, and also leaks the child returned by
> of_get_next_child() when parsing module flags. Route the post-lookup
> returns through a common cleanup path and release the child after use.
> 
> omap_hwmod_setup_earlycon_flags() leaks the /chosen node and the UART
> node resolved from stdout-path. Track them separately and drop both
> references after use.
> 
> Fixes: 1aa8f0cb19e5 ("ARM: OMAP2+: Remove unused legacy code for interconnects")
> Fixes: 4f2122473363 ("ARM: OMAP2+: Check also the first dts child for hwmod flags")
> Fixes: 8dd6666f4937 ("ARM: OMAP2+: omap_hwmod: Add support for earlycon")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
