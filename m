Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9838C2CA;
	Tue,  3 Mar 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571767; cv=none; b=LhdWYlFLQCyoLV75wnA5IKLJVqxa376dG8e5YY7HHagXWpQUiINkdPUo7VvHHJNho6ARlzXj2k3cZdo1aR3g6nYNpmdKOLZMXm09l+GfdDEOxlohIMkU3vrfgUJmts1fwHXDrydSMCRvD8EnqO5NhfOFNUQH8qZczjv4knqyIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571767; c=relaxed/simple;
	bh=NpZUI/br3ccdKNxtJ2S2wXd5/HamnqwRJi5GSZmoDlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsrN2yU1eWHYfKTWWPlM1dECNEGh5TYSRVdCqbeHtf/ixtbHun46LXZeK3wNtLr55YjQyPvp82yiUW1hB9Efftfn6Wq/3EMCLcrJhGJM3ukBwbUlF5WdTaJci7Gf95HH29iJ2FxzW6SgzpZwa8hIJdT1PKM6RsnjxQHOsSB7jso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3US9Fp1q; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3US9Fp1q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aO5loOc82Hx9Yhy0HSwylKT9He+BRGzIrwcyvaXEBGI=; b=3US9Fp1qGqe5V2g1Usgm2YyM3N
	/wj84tZdJZyh2mJf6BqBf1Wp0s2GZ5MputUQmzRegilg7rZw4xPYDDm4S+wclPqa8B4w/GW07MEfS
	jq+e9LhMCmrOi4tp4KX+DORAbR3q9mv5cRI3Btxl7CQWRUyMn51a9VbYuFsHn01rrEhFvuA1jrvCj
	n3CRCfCut/gBClxu63fnhywJ/sBo4FqclLf4cHIac3ZvF1/C0FozueH24gkmHdAVWhHRTYMWX9TOl
	GHA1o0SNzPe8OD+3q+tpYRU4QJwJwCN0hWNxjJrqXeR0GzMNFwR+RZq+iW8M41EIScHWAA9pOYYlE
	1s8e5ijg==;
Date: Tue, 3 Mar 2026 22:02:25 +0100
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
Subject: Re: [PATCH v9 1/8] ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
Message-ID: <20260303220225.085ab093@kemnade.info>
In-Reply-To: <20260303203017.511-2-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
	<20260303203017.511-2-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:30:10 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Add a dedicated DTS file for the TWL6032 PMIC (Phoenix Lite). Already
> has driver support with TWL6030 (Phoenix) since both of them are so
> similar, some nodes can be reused from TWL6030 as well
> 
> This can be included in the board files like twl6030
> Example:
> ...
> &i2c1 {
>     twl: twl@48 {
>         reg = <0x48>;
>         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-controller;
>         interrupt-parent = <&gic>;
>     };
> };
> 
> /include/ "twl6032.dtsi"
> ...
> 
> Used in devices like samsung-espresso, amazon-jem, epson-embt2ws etc
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>


The best answer no that design antipattern in the twl driver
implementation. So

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
