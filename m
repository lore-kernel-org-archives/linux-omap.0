Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F48379ED4;
	Tue,  3 Mar 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572632; cv=none; b=t2+Cyv+zpW67hwLIl+cRfCiadh1Al7w8x+xBIx27pXbbCwGkjEfRuqrtDbvdgH7WTbNE4pGjEw7vwsdz3cBMat7NGleNpgrFJuTWAzM1fbbLvPMLkEEK+RZmZePk5ot/jmH2amWZ2hd/yfF/S25Wuja7FxIuDJQiwTIqxQQgnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572632; c=relaxed/simple;
	bh=lCEK15bdHI9zxdNysceLI/Y88V6t8Cqv/1VawZh1BwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDygGUnX5cRoA3GD9m2utUuFJqYRB+A9TwvjGdo3fKHaBjaYYphPBZyYXPjKRUfimngHz7jHVrenwcWKwb9511sx/PEzyiKp3ARRlc1k7a/ibZHm7pVfq0yj25MSCKZT7JWgY7jT1OKEozgfyeYbVDBRk3Iw5zML8jqcPN/ljuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=CK+/Or3G; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CK+/Or3G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8uxHoA4udYmOqfBzfnqwuebgmU8ChPJkLjjapRfLZJs=; b=CK+/Or3GDlxTfXDlLltKhjjUC2
	WodY4q6xliJD05JC2omRzZD+/vRw4GnnK1JrV11iG7KKgCH/hlugXQeHFySdyZTY+Vnb5hIjMkz6p
	ZpvKiW6S5pvrQw/jAfMHPlbpPtQYyTUDTYNeN678dN3ybg/Y7XDecLwtU84OAyiSLTPwtQRtxAn7Q
	GAnf1wNV1tFUhXwCFLRScxHCWN22JCEIY6s/kGHV46JIB9UDMAOVLeCHsJMhx8l7MIz0fMDKQ841x
	Y8OL/8VBU7DvRvUxqY0K67UFCDOosDULjEuHPJNEQJG7VWNmP7yiCqwVI23JTMVyIqQe08QYfIuuH
	dWj0cgLg==;
Date: Tue, 3 Mar 2026 22:17:02 +0100
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
Subject: Re: [PATCH v9 8/8] ARM: dts: ti: omap: samsung-espresso10: Add
 initial support for Galaxy Tab 2 10.1
Message-ID: <20260303221702.69c10364@kemnade.info>
In-Reply-To: <20260303203017.511-9-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
	<20260303203017.511-9-bavishimithil@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 15:30:17 -0500
Mithil Bavishi <bavishimithil@gmail.com> wrote:

> Create a device tree for the 10 inch variants (P5100, P5110, P5113)
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
