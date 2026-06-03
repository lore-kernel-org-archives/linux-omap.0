Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D2306744;
	Wed,  3 Jun 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493677; cv=none; b=k9mjSj5p2bdZebClMYVs+2SFyfq1Lf5rdgkPVCGZL/d2L2rPiwpP45dKMI/uD8QkK5L4mFkXl3hfTIijzE1uB6x0efnKUH96AOZbnWU83Qgv11MPrli0ekKnY9y8RYK38V+qy6Z6mKZV/vGRWHSZeG+ytc9adDd6YGGOSMA7T90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493677; c=relaxed/simple;
	bh=avqvudIqSkK/Q/c6DOR0nLqnalkTkVHk1AlrO2yMyq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqWbwhvvGPAY294W74AIsLXieucqhOfxb4ddEnY5sgOTkUWV3rO2yQ0q1AVTMKW79kcYAndOdehRfD6Vvr3ER1wUvhFtl4bIH67KCYi6R4RXefXcFKd7gzegtyGR8NLMGsvmmH83+Wl9kaxu+MZSL9PVFS14Wg5DZd6Pshiy2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Ip+otY4d; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Ip+otY4d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QkQvsIWLhCcvCdk2i3BR5GEaMcum9rnMsVTYfewZTa4=; b=Ip+otY4dxoktc0cyviac18xysT
	/ZHHu0qtjXy1chjgAhoCsmQYJtdds6dp7Y0UVnwFnLctweA/++XwmDmOxa/hcAfn/pO0UI5gW1cJ8
	MFcGNVhu/cVEox3coHMnffNXuTmpbTIZZsnzXtrUU9r4ZbxOjzk9i5Yxxh0g4drLl58T/dPI9IWfj
	OE4N6pYbuVbZ/3DT1LmLAfOdwNLhaPSMrg3vPVE2wFU31g62ve5MkGZX5UcW5fL7YpW9cMNGwufig
	oEG44glnh6Rfb6TOWxqtynTjomEBAy3kdoYpbF4VzWDKw9PzHE8sZy7HYJzz0iipoEoTimsOGfqS6
	iARtib1g==;
Date: Wed, 3 Jun 2026 14:58:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Lee Jones <lee@kernel.org>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl4030-power: drop dead machine_is_*() macros
Message-ID: <20260603145844.3d8ee4f7@kemnade.info>
In-Reply-To: <20260603-mfd-remove-mach-types-h-v1-1-751e119167da@pengutronix.de>
References: <20260603-mfd-remove-mach-types-h-v1-1-751e119167da@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jun 2026 14:52:34 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> OMAP LDP and 3430SDP are converted to dt in [1] and [2], the
> corresponding machine_is_*() macros always expand to 0. Drop them and
> with it the now unnecessary inclusion of mach-types.h.
> 
> [1] e92fc4f04a34a ("ARM: OMAP2+: Drop legacy board file for LDP")
> [2] 1b383f44aabc8 ("ARM: OMAP2+: Drop board file for 3430sdp")
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

already in -next

Regards
Andreas
