Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244A26A1A4;
	Wed, 12 Aug 2026 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514983; cv=none; b=fohcwjOLXhDLgoMEWNGsUsRy8RHn4UJ9Xv+LLWBK7mTI/7KC0q4ceGbq9vRwXe7O/Izx3aarEHXJ3wIoZV2CUf+ut98G5/F0hiMzucHkHdtcle+tni17bPsALEUpBRbaNHu6XTQqTP1FHu58dI8SWSVgUFf26+rcN81SfHbclQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514983; c=relaxed/simple;
	bh=GTeocMD5aThArfBGkgbGH1brwDyU8x4A2twWvpWNfko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHyUvyNsjsbYciI/LtGcVK6FZWezWSzhfRZzJlJ6+Axf0SXfRhpUV2kUR09Pq552Nf+P7JlmOeJab1BXp4y/xddZe9KBGFxhzQBa+l6K43U1z3rdt2IUnjWf71WLW07lbTyHbr5dos7lE9qlCuFIK7D894HCgutfCmT4475dQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gOhWGpmS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gOhWGpmS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=kQ4IpwgirzrGHvI3yw1vjcK1qfskYE4d7Negmtbn1QQ=; t=1786514981; x=1787724581; 
	b=gOhWGpmSkt7LPnPwctB3MFqwcPKz0DczdMCe9KoeC6TRt+vANH1furK6jkucgNQWbEZSk0fSkVc
	rcvNcTCAKPmZFuSME4dt+fcoh86VSP0uEPQ4Z9qIXPdoH5DrDRLOkuC2eAiMoeqdwewH5Cjyy84vp
	4aFh9h2GlLZ3hAZCkNj2OJmHewKwKLp5mnu9ZR8XfTKNy2BIHx8hLgLqX9Ao6VinWUzC++arfGl19
	AVL+T65/wFmuRVnYzQhL/u6mrF1A9PbwdfpY4XWdRdpMggQwkERKE5dDdUOkvmGnWZUitGcdi18aZ
	UPAIFS0pWkB9WpAO7goZRT3SzR2IC7l3Odsw==;
Date: Wed, 12 Aug 2026 08:09:28 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com,
 goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/2] ARM: dts: ti: omap: Disable keypad and enable it
 on the boards that use it
Message-ID: <20260812080928.3c9645ae@kemnade.info>
In-Reply-To: <20260719133730.3551691-3-egbostina@gmail.com>
References: <20260719133730.3551691-1-egbostina@gmail.com>
	<20260719133730.3551691-3-egbostina@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 13:37:30 +0000
Eduard Bostina <egbostina@gmail.com> wrote:

> The keypad node in omap4-l4.dtsi and omap5-l4.dtsi lacks the matrix keymap,
> which is board specific. The binding requires the matrix properties, so the
> incomplete template nodes fail dtbs_check.
> 
> Mark the keypad disabled in the SoC files and enable it on the boards
> that actually complete the node with a keymap.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

the ti-sysc stuff will properly disable these things. While a bit anti-pattern
in the OMAP world, it is a more common pattern overall and for the sake
of correct bindings, it is fine. So

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
