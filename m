Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53C2BE057;
	Mon,  2 Mar 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481525; cv=none; b=qxW+a/VTtl//xbSANlKDtcT7zYkqqySJ4221M0Bdi0H4YBYZowdQ/T3bB/+jnDrpxLYgMIdXereEvPdu8z5tJVUg49IjUiRi4BPv+8jK1SGP+JHVyraSNSbEI3R7KzK7YMEpkOk+4wFsjA3LH0gQg/Bm3aE9Xti6zT0HSqgvtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481525; c=relaxed/simple;
	bh=ibZ9MV9EEnwpYZtBCfhTUTAgvHhjhWkZAMO8DGteMow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsfUR7zJ6aXy2NdNtCPE1cuKcVRny7smihqgLAd08vfBZLXq/LmXF3uJ+cyMZTYzx41jYzgi9oFeawZ8ktaFXyjIbALo2mjOR8DL/J+ieHiGC+kdzDfdfz6KoO6sgFxUu1whgad3UM6+xYrEKFWfJj9Y63BxPtu/je3P35GjXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=O0FWWqU3; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="O0FWWqU3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YY178crJaRnUypIvjrB+crFieYO0nYPbiVYpEpanLbg=; b=O0FWWqU3+f7Ezt+TT3Xd3Mos1P
	dEbKQJ4+6ZtMErPh7+1+CAEK/slrjWqp1yAva1b1iPwn5prLblE2m2MaDOII4cP2zcJi5Nof9slna
	PvqoKf+UfV8WsxMw1OOpHgRNLHgYzNBZid52qU6WMvMIq+mPLCSFybA+SkSYvtwN6DkORgwSnLo62
	qVCHUM/REu3xziTabNjc6hEghEnhqx+ZbNjRT5ExQ+UZMvm/8FIea6gfpCg4jClphH8dZUyjfAWNa
	PSuOCBCSjFTSeW98tHiQ2+av9c8ew67BacwknD1Os97C1g8yNOMyezb6h2ozxlqadi9LNhQv676V+
	l+zDJItQ==;
Date: Mon, 2 Mar 2026 20:58:31 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Mithil Bavishi <bavishimithil@gmail.com>
Cc: aaro.koskinen@iki.fi, airlied@gmail.com, conor+dt@kernel.org,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, khilman@baylibre.com,
 krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jesszhan0024@gmail.com, rfoss@kernel.org, robh@kernel.org,
 rogerq@kernel.org, simona@ffwll.ch, thierry.reding@gmail.com,
 tony@atomide.com, tzimmermann@suse.de, andrzej.hajda@intel.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v8 5/8] ARM: dts: ti: omap: espresso-common: Add common
 device tree for Samsung Galaxy Tab 2 series
Message-ID: <20260302205831.5a54b142@kemnade.info>
In-Reply-To: <20260223134941.427-6-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
	<20260223134941.427-6-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 08:49:37 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Create common device tree for Samsung Espresso series devices
> 
> Create a shared device tree for all variants first.
> Device-specific trees will be added later based on screen size.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>



[...]
> +&omap4_pmx_wkup {
> +	gpio_keys: gpio-keys-pins {
> +		pinctrl-single,pins = <
> +			OMAP4_IOPAD(0x046, PIN_INPUT | MUX_MODE3)
> +			/* sim_cd.gpio_wk3 - EXT_WAKEUP */
> +			OMAP4_IOPAD(0x056, | PIN_INPUT | MUX_MODE3)
> +			/* fref_clk3_req.gpio_wk30 - VOL_UP */
> +			OMAP4_IOPAD(0x05C, | PIN_INPUT | MUX_MODE3)

syntax error. stray | in these two lines. even for small cosmetic
changes, at the very least build it.

Regards,
Andreas
